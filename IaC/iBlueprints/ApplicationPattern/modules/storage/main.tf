# Storage Account
resource "azurerm_storage_account" "main" {
  name                     = "storage${var.unique_suffix}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = 7
    }
    versioning_enabled = true
  }

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.subnet_id]
    bypass                     = ["AzureServices"]
  }
}

# Private Endpoint for Storage Account
resource "azurerm_private_endpoint" "storage" {
  name                = "pe-storage-${var.unique_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "storage-privatelink"
    private_connection_resource_id = azurerm_storage_account.main.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

