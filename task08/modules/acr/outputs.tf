output "container_registry" {
  value = {
    id             = azurerm_container_registry.ACR.id
    login_server   = azurerm_container_registry.ACR.login_server
    admin_username = azurerm_container_registry.ACR.admin_username
    admin_password = azurerm_container_registry.ACR.admin_password
  }
}
