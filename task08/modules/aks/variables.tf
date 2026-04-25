variable "name" {
  type        = string
  description = "AKS cluster name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for AKS"
}

variable "default_node_pool_name" {
  type        = string
  default     = "system"
  description = "Default node pool name"
}

variable "default_node_pool_count" {
  type        = number
  default     = 1
  description = "Default node pool node count"
}

variable "default_node_pool_vm_size" {
  type        = string
  default     = "Standard_D2ads_v6"
  description = "Default node pool VM size"
}

variable "default_node_pool_os_disk_type" {
  type        = string
  default     = "Ephemeral"
  description = "Default node pool OS disk type"
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID"
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault ID for AKS access"
}

variable "acr_id" {
  type        = string
  description = "ACR ID for image pulling"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply"
}
