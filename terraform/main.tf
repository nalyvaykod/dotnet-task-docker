resource "random_string" "suffix" {
  length = 6
  special = false
  upper = false
}

resource "azurerm_resource_group" "rg" {
  name = "rg-${var.name}-${random_string.suffix.result}"
  location = var.location
}