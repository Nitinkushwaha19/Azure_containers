resource "azurerm_container_group" "container_group" {

  name                = var.container_group_name
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_address_type     = "Public"
  os_type             = "Linux"
  dns_name_label      = var.dns_name_label
  sku                 = var.container_group_sku

  dynamic "container" {
    for_each = var.containers_config
    content {
      name   = container.value.name
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      ports {
        port     = container.value.port
        protocol = "TCP"
      }

      environment_variables        = container.value.environment_variables
      secure_environment_variables = container.value.secure_environment_variables
    }
  }

  image_registry_credential {
    server   = var.container_registry_server
    username = var.container_registry_username
    password = var.container_registry_password
  }

  tags = var.tags
}
