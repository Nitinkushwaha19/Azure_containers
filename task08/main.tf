data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "RG" {
  name     = local.rg_name
  location = var.rg_location
}

# ACR Module
module "ACR" {
  source = "./modules/acr"

  rg_name                 = azurerm_resource_group.RG.name
  rg_location             = azurerm_resource_group.RG.location
  container_registry_name = local.acr_name
  container_registry_sku  = var.container_registry_sku

  # container registry task variables
  repo_url   = "${var.repo_url}#main:task08/application"
  git_pat    = var.git_pat
  image_name = local.image_name

  tags = var.tags

}

# Key Vault module
module "keyvault" {
  source = "./modules/keyvault"

  rg_name        = azurerm_resource_group.RG.name
  rg_location    = azurerm_resource_group.RG.location
  key_vault_name = local.keyvault_name
  key_vault_sku  = var.key_vault_sku

  tags = var.tags
}

# Redis Cache module
module "redis" {
  source = "./modules/redis"

  rg_name              = azurerm_resource_group.RG.name
  rg_location          = azurerm_resource_group.RG.location
  redis_cache_name     = local.redis_name
  redis_cache_capacity = var.redis_cache_capacity
  redis_cache_family   = var.redis_cache_family
  redis_cache_sku_name = var.redis_cache_sku_name

  key_vault_secret = "redis"
  key_vault_id     = module.keyvault.key_vault_id

  tags = var.tags

  depends_on = [module.keyvault]
}

# ACI Module
module "ACI" {
  source = "./modules/aci"

  resource_group_name  = azurerm_resource_group.RG.name
  location             = azurerm_resource_group.RG.location
  container_group_name = local.container_group_name
  dns_name_label       = local.container_dns_name_label
  container_group_sku  = var.container_group_sku

  # Container configuration
  containers_config = local.containers_config

  # Container registry credentials
  container_registry_server   = module.ACR.container_registry.login_server
  container_registry_username = module.ACR.container_registry.admin_username
  container_registry_password = module.ACR.container_registry.admin_password

  tags = var.tags

  depends_on = [module.ACR]
}


# AKS Module
module "aks" {
  source              = "./modules/aks"
  name                = local.aks_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  dns_prefix          = local.aks_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  key_vault_id        = module.keyvault.key_vault_id
  acr_id              = module.ACR.container_registry.id
  tags                = var.tags

  depends_on = [module.ACR, module.keyvault]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.kv_identity_client_id
    kv_name                    = module.keyvault.key_vault_name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-primary-key"
  })

  depends_on = [module.aks, module.redis]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.ACR.container_registry.login_server
    app_image_name   = local.image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider, module.ACR]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service" "app" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.service]
}
