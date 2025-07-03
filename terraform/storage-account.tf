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
  blob_properties {
    container_delete_retention_policy {
      days = 7
    }
    delete_retention_policy {
      days = 7
    }
    versioning_enabled = true
    restore_policy {
      days = 6
    }
  }
}

resource "azurerm_storage_container" "container-1" {
  name               = "container-1"
  storage_account_id = azurerm_storage_account.lab-stg.id
}

resource "azurerm_storage_blob" "blob-backup-test" {
  name                   = "blob-backup-test"
  storage_container_name = azurerm_storage_container.container-1.name
  storage_account_name   = azurerm_storage_account.lab-stg.name
  type                   = "Block"
  source_content         = <<EOF
    Hello, world
  EOF
}

resource "azurerm_storage_share" "container-2" {
  name               = "container-2"
  quota              = 2
  storage_account_id = azurerm_storage_account.lab-stg.id
}
