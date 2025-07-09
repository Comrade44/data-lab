
resource "azurerm_backup_policy_file_share" "container-2-snapshot" {
  name                = "container-2-snapshot"
  resource_group_name = azurerm_resource_group.rg-backup.name
  recovery_vault_name = azurerm_recovery_services_vault.files-vault.name
  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 10
  }
}

resource "azurerm_backup_container_storage_account" "lab-stg" {
  resource_group_name = azurerm_resource_group.rg-backup.name
  recovery_vault_name = azurerm_recovery_services_vault.files-vault.name
  storage_account_id  = azurerm_storage_account.lab-stg.id
}

resource "azurerm_backup_protected_file_share" "container-2" {
  depends_on                = [azurerm_backup_container_storage_account.lab-stg]
  resource_group_name       = azurerm_resource_group.rg-backup.name
  recovery_vault_name       = azurerm_recovery_services_vault.files-vault.name
  source_storage_account_id = azurerm_storage_account.lab-stg.id
  source_file_share_name    = azurerm_storage_share.container-2.name
  backup_policy_id          = azurerm_backup_policy_file_share.container-2-snapshot.id
}