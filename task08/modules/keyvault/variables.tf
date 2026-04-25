variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "key_vault_sku" {
  description = "The SKU of the Key Vault."
  type        = string
  default     = "standard"
}

variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}

variable "rg_location" {
  description = "The location of the resource group."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

