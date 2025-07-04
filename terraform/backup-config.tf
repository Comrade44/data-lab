resource "azurerm_role_assignment" "vault-contributor" {
  scope                = azurerm_storage_account.lab-stg.id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = azurerm_data_protection_backup_vault.backup-vault.identity[0].principal_id
}

resource "azurerm_role_assignment" "vault-contributor" {
  scope                = azurerm_storage_account.lab-stg.id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = azurerm_recovery_services_vault.files-vault.identity[0].principal_id
}

resource "azurerm_data_protection_backup_policy_blob_storage" "blob-backup-policy" {
  name     = "blob-backup-policy"
  vault_id = azurerm_data_protection_backup_vault.backup-vault.id
  #  operational_default_retention_duration = "P1D"
  time_zone                        = "Coordinated Universal Time"
  vault_default_retention_duration = "P90D"
  backup_repeating_time_intervals  = ["R/${timestamp()}/PT5M"]

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

resource "azurerm_backup_protected_file_share" "container-2" {
  resource_group_name       = azurerm_resource_group.rg-backup.name
  recovery_vault_name       = azurerm_recovery_services_vault.files-vault.name
  source_storage_account_id = azurerm_storage_account.lab-stg.id
  source_file_share_name    = azurerm_storage_share.container-2.name
  backup_policy_id          = azurerm_backup_policy_file_share.container-2-snapshot.id
}