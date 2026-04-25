resource "azurerm_container_registry" "ACR" {

  name                = var.container_registry_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = var.container_registry_sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "ACR-task" {

  name                  = "${var.container_registry_name}-task"
  container_registry_id = azurerm_container_registry.ACR.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.repo_url
    context_access_token = var.git_pat
    image_names          = ["${var.image_name}:latest"]
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "run" {
  container_registry_task_id = azurerm_container_registry_task.ACR-task.id
}
