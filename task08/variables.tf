variable "name_prefix" {
  description = "A prefix to use for naming all resources. This helps to ensure that resource names are unique and easily identifiable."
  type        = string
}

# Resource Group variables
variable "rg_location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}


#  Azure Container Registry (ACR) Module Variables 
variable "container_registry_sku" {
  description = "The SKU of the Azure Container Registry. Possible values are 'Basic', 'Standard', and 'Premium'."
  type        = string
}

# Variables for ACR Task
variable "repo_url" {
  description = "The URL of the Git repository containing the Dockerfile and application code."
  type        = string
}

variable "git_pat" {
  description = "The Personal Access Token (PAT) for accessing the Git repository. This is required if the repository is private."
  type        = string
  sensitive   = true
}


#  Azure Key Vault Module Variables 
variable "key_vault_sku" {
  description = "The SKU of the Azure Key Vault. Possible values are 'standard' and 'premium'."
  type        = string
}



#  Azure Redis Cache Module Variables 
variable "redis_cache_capacity" {
  description = "The capacity of the Redis Cache. The value depends on the SKU."
  type        = number
}

variable "redis_cache_family" {
  description = "The family of the Redis Cache. The value depends on the SKU."
  type        = string
}

variable "redis_cache_sku_name" {
  description = "The SKU name of the Redis Cache. Possible values are 'Basic', 'Standard', and 'Premium' followed by the capacity (e.g., 'Standard_1')."
  type        = string
}



#  ACI Module Variables 

# Container group variables
variable "container_group_sku" {
  description = "The SKU of the container group. Possible values are 'Standard' and 'Premium'."
  type        = string
}


# Tags variable
variable "tags" {
  description = "A map of tags to assign to the resources. Tags are key-value pairs that help to organize and categorize resources in Azure."
  type        = map(string)
}
