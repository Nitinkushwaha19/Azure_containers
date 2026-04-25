output "redis_host_name" {
  value       = azurerm_redis_cache.redis.hostname
  description = "Output of the redis cache hostname"
}

output "redis_key" {
  value       = azurerm_redis_cache.redis.primary_access_key
  description = "Output of the redis cache primary access key"
}
