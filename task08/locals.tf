locals {

  rg_name       = "${var.name_prefix}-rg"
  aci_name      = "${var.name_prefix}-ci"
  acr_name      = "cmtr2ehw6cykmod8cr"
  aks_name      = "${var.name_prefix}-aks"
  keyvault_name = "${var.name_prefix}-kv"
  redis_name    = "${var.name_prefix}-redis"
  image_name    = "${var.name_prefix}-app"

  # ACI Module locals
  container_group_name     = "${var.name_prefix}-cg"
  container_dns_name_label = "${var.name_prefix}-dns"

  # containers_config defined here because it references module outputs (cannot be in tfvars)
  containers_config = [
    {
      name   = "myapp"
      image  = "${module.ACR.container_registry.login_server}/${local.image_name}:latest"
      cpu    = 0.5
      memory = 1.0
      port   = 80
      environment_variables = {
        "CREATOR"        = "ACI"
        "REDIS_PORT"     = "6380"
        "REDIS_SSL_MODE" = "true"
      }
      secure_environment_variables = {
        "REDIS_URL" = module.redis.redis_host_name
        "REDIS_PWD" = module.redis.redis_key
      }
    }
  ]
}
