resource "azurerm_container_registry" "registry" {
  name = "acr${var.name}${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  sku = "Basic"
  admin_enabled = true
}