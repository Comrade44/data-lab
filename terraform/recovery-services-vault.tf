resource "azurerm_recovery_services_vault" "files-vault" {
  name                = "files-vault"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.rg-backup.name
  sku                 = "Standard"
  soft_delete_enabled = false
  identity {
    type = "SystemAssigned"
  }
}