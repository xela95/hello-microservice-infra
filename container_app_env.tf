# -----------------------------------------------------
# LOG ANALYTICS WORKSPACE
# -----------------------------------------------------
resource "azurerm_log_analytics_workspace" "law_01" {
  name                = "${var.rg_01_name}-logs"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_01.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = merge(var.tags, {
    Component = "LogAnalytics"
  })
}

# -----------------------------------------------------
# CONTAINER APPS ENVIRONMENT (CAE)
# -----------------------------------------------------
resource "azurerm_container_app_environment" "cae_01" {
  name                       = var.cae_01_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg_01.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law_01.id

  tags = merge(var.tags, {
    Workload = "Transversal"
  })
}

# -----------------------------------------------------
# CONTAINER APP (your Spring Boot microservice)
# -----------------------------------------------------
resource "azurerm_container_app" "aca_01" {
  name                         = var.aca_01_name
  container_app_environment_id = azurerm_container_app_environment.cae_01.id
  resource_group_name          = azurerm_resource_group.rg_01.name

  revision_mode         = "Single"

  template {
    min_replicas = 1

    container {
      name   = "hello-container"
      image  = var.docker_image    # <--- your DockerHub image
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled           = true
    target_port                = 8080         # Spring Boot port
    allow_insecure_connections = false

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].container[0].volume_mounts,
      template[0].volume,
      secret,
      template[0].container[0].env
    ]
  }

  tags = merge(var.tags, {
    Component = "HelloMicroservice"
  })
}
