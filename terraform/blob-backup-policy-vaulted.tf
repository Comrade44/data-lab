
resource "azurerm_data_protection_backup_policy_blob_storage" "blob-backup-policy-vaulted" {
  name     = "blob-backup-policy"
  vault_id = azurerm_data_protection_backup_vault.backup-vault.id
  time_zone                        = "Coordinated Universal Time"
  vault_default_retention_duration = "P90D"
  backup_repeating_time_intervals  = ["R/${timestamp()}/PT55M"]

  lifecycle {
    ignore_changes = [backup_repeating_time_intervals]
  }
}

resource "azurerm_data_protection_backup_instance_blob_storage" "lab-stg-blob-policy-assignment" {
  name                            = "lab-stg-blob-backup"
  location                        = azurerm_resource_group.rg-backup.location
  vault_id                        = azurerm_data_protection_backup_vault.backup-vault.id
  storage_account_id              = azurerm_storage_account.lab-stg.id
  backup_policy_id                = azurerm_data_protection_backup_policy_blob_storage.blob-backup-policy.id
  storage_account_container_names = [azurerm_storage_container.container-1.name]
}