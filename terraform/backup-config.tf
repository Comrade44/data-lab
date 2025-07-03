resource "azurerm_role_assignment" "vault-contributor" {
  scope                = azurerm_storage_account.lab-stg.id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = azurerm_data_protection_backup_vault.backup-vault.identity[0].principal_id
}

resource "azurerm_data_protection_backup_policy_blob_storage" "blob-backup-policy" {
  name                             = "blob-backup-policy"
  vault_id                         = azurerm_data_protection_backup_vault.backup-vault.id
  vault_default_retention_duration = "P2D"
  backup_repeating_time_intervals  = ["R/PT1D/2025-07-04T01:30:00"]
}