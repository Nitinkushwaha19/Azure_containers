# Variables for Azure Redis Cache instance
variable "redis_cache_name" {
  description = "Name of the Azure Redis Cache instance"
  type        = string
}

variable "redis_cache_capacity" {
  description = "Capacity of the Azure Redis Cache instance (e.g., 0, 1, 2, 3, 4, 5)"
  type        = number
}

variable "redis_cache_family" {
  description = "Family of the Azure Redis Cache instance (e.g., C, P)"
  type        = string
}

variable "redis_cache_sku_name" {
  description = "SKU name of the Azure Redis Cache instance (e.g., Basic, Standard, Premium)"
  type        = string
}

# Variables for Azure Key Vault
variable "key_vault_id" {
  description = "ID of the Azure Key Vault where secrets will be stored"
  type        = string
}

variable "key_vault_secret" {
  description = "Name of the Key Vault secret for Redis host name"
  type        = string
}



# Resource Group variables
variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "rg_location" {
  description = "Location of the resource group"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
