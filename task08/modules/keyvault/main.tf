data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "KV" {
  name                = var.key_vault_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku
  tags                = var.tags

}

resource "azurerm_key_vault_access_policy" "policy" {
  key_vault_id = azurerm_key_vault.KV.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = ["Get", "Set", "List"]
}
