resource "azurerm_resource_group" "rg-backup" {
  name     = "rg-backup"
  location = "uksouth"
}

resource "azurerm_recovery_services_vault" "backup-vault" {
  name                = "backup-vault"
  resource_group_name = azurerm_resource_group.rg-backup.name
  location            = azurerm_resource_group.rg-backup.location
  sku                 = "Standard"
  identity {
    type = "SystemAssigned"
  }
}