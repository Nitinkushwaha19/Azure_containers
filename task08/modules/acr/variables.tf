# Variables for ACR Module
variable "container_registry_name" {
  description = "The name of the container registry"
  type        = string
}

variable "container_registry_sku" {
  description = "The SKU of the container registry"
  type        = string
  default     = "Standard"
}

variable "repo_url" {
  description = "The URL of the Git repository containing the Dockerfile"
  type        = string
}

variable "git_pat" {
  description = "The Personal Access Token (PAT) for accessing the Git repository"
  type        = string
  sensitive   = true
}

variable "image_name" {
  description = "The name of the Docker image to be built and pushed to ACR"
  type        = string
}


# Resource Group variables
variable "rg_name" {}
variable "rg_location" {}

# Tags variable
variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources"
}
