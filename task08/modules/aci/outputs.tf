output "container_group" {
  value = {
    id   = azurerm_container_group.container_group.id
    fqdn = azurerm_container_group.container_group.fqdn
  }
}
