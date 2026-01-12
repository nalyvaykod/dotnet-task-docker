resource "azurerm_service_plan" "plan" {
  name                = "plan-${var.name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "app-${var.name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      docker_image_name   = "bestrong-api:latest"
      docker_registry_url = "https://${azurerm_container_registry.registry.login_server}"
      docker_registry_username = azurerm_container_registry.registry.admin_username
      docker_registry_password = azurerm_container_registry.registry.admin_password
    }
  }

storage_account {
    name         = "db_mount"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.storage.name
    share_name   = azurerm_storage_share.share.name
    access_key   = azurerm_storage_account.storage.primary_access_key
    mount_path   = "/app/data"
  }

  app_settings = {
    "ConnectionStrings__MovieContext" = "Data Source=/app/data/App.db"
    "ASPNETCORE_ENVIRONMENT"          = "Development"
    "WEBSITES_PORT"                   = "8080"
  }
}