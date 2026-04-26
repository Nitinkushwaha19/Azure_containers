resource "azurerm_redis_cache" "redis" {
  name                = var.redis_cache_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  capacity            = var.redis_cache_capacity
  family              = var.redis_cache_family
  sku_name            = var.redis_cache_sku_name

  tags = var.tags
}


resource "azurerm_key_vault_secret" "redis_host" {
  name         = "${var.key_vault_secret}-hostname"
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "redis_pwd" {
  name         = "${var.key_vault_secret}-primary-key"
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.key_vault_id
}
