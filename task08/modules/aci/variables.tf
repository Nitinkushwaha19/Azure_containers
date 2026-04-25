# Resource Group Variables
variable "resource_group_name" {
  description = "The name of the resource group in which to create the container group."
  type        = string
}

variable "location" {
  description = "The Azure region where the container group will be created."
  type        = string
}

# Container Group Variables
variable "container_group_name" {
  description = "The name of the container group."
  type        = string
}

variable "dns_name_label" {
  description = "The DNS name label for the container group. Must be unique within the Azure region."
  type        = string
}

variable "container_group_sku" {
  description = "The SKU of the container group. Possible values are 'Standard' and 'Premium'."
  type        = string
  default     = "Standard"
}

# Container Configuration Variables
variable "containers_config" {
  description = "A list of container configurations for the container group."
  type = list(object({
    name                         = string
    image                        = string
    cpu                          = number
    memory                       = number
    port                         = number
    environment_variables        = map(string)
    secure_environment_variables = map(string)
  }))
}

# Container Registry Variables
variable "container_registry_server" {
  description = "The server URL of the container registry where the container image is stored."
  type        = string
}

variable "container_registry_username" {
  description = "The username for authenticating with the container registry."
  type        = string
}

variable "container_registry_password" {
  description = "The password for authenticating with the container registry."
  type        = string
  sensitive   = true
}


# Tags Variable
variable "tags" {
  description = "A map of tags to assign to the container group."
  type        = map(string)
  default     = {}
}
