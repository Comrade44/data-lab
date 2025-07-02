resource "azurerm_resource_group" "rg-storage" {
  name     = "rg-storage"
  location = "uksouth"
}

resource "random_string" "storage-name" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "lab-stg" {
  name                     = "stglab${random_string.storage-name.result}"
  location                 = azurerm_resource_group.rg-storage.location
  resource_group_name      = azurerm_resource_group.rg-storage.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}