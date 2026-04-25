#  Global variables 
name_prefix = "cmtr-2ehw6cyk-mod8"

#  Resource Group variables 
rg_location = "eastus"

# Azure Container Registry (ACR) Module Variables
container_registry_sku = "Standard"

repo_url = "https://github.com/Nitinkushwaha19/Azure_containers.git"

#  Azure Key Vault variables 
key_vault_sku = "standard"

# Azure Redis Cache variables
redis_cache_capacity = 2
redis_cache_family   = "C"
redis_cache_sku_name = "Basic"

#  ACI Module variables 
container_group_sku = "Standard"

# Tags variable
tags = {
  "Creator" = "nitin_ajaykushwaha@epam.com"
}
