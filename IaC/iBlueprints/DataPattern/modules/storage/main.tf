resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false

  keepers = {
    timestamp = timestamp()
  }
}

resource "azurerm_storage_account" "source" {
  name                     = "sourcestorageacct${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
    min_tls_version = "TLS1_2"
  blob_properties {
    delete_retention_policy {
      days=7
    }
    versioning_enabled = true
  }
}
