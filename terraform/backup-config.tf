resource "azurerm_role_assignment" "vault-contributor" {
  scope                = azurerm_storage_account.lab-stg.id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = azurerm_data_protection_backup_vault.backup-vault.identity[0].principal_id
}

resource "azurerm_data_protection_backup_policy_blob_storage" "blob-backup-policy" {
  name                                   = "blob-backup-policy"
  vault_id                               = azurerm_data_protection_backup_vault.backup-vault.id
  operational_default_retention_duration = "P1D"
  time_zone = "Coordinated Universal Time"
  vault_default_retention_duration = "P90D"
  backup_repeating_time_intervals = [ "R/${formatdate("YYYY-MM-DD", timestamp())}T19:00:00+00:00/P5M" ]

  lifecycle {
    ignore_changes = [ backup_repeating_time_intervals ]
  }
}