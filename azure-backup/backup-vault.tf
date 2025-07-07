resource "azurerm_resource_group" "rg-backup" {
  name     = "rg-backup"
  location = "uksouth"
}

resource "azurerm_data_protection_backup_vault" "backup-vault" {
  name                = "backup-vault"
  resource_group_name = azurerm_resource_group.rg-backup.name
  location            = azurerm_resource_group.rg-backup.location
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"
  soft_delete         = "Off"
  identity {
    type = "SystemAssigned"
  }
}
