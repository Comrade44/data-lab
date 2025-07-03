resource "azurerm_role_assignment" "vault-contributor" {
  scope                = azurerm_storage_account.lab-stg.id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = azurerm_recovery_services_vault.backup-vault.identity.principal_id
}