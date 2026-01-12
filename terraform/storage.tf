resource "azurerm_storage_account" "storage" {
  name = "sa${var.name}${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "share" {
  name = "sql"
  storage_account_name = azurerm_storage_account.storage.name
  quota = 1
}

