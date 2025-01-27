
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}


resource "azurerm_data_factory" "adf" {
  name                = "adf-container-copy-${random_string.suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "source" {
  principal_id         = azurerm_data_factory.adf.identity[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = var.storage_source_id

  
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "source_blob" {
  name              = "sourceBlobLinkedService"
  data_factory_id   = azurerm_data_factory.adf.id
  connection_string = var.source_blob_connection_string
}

// SQL Link
resource "azurerm_data_factory_linked_service_azure_sql_database" "sql_linked_service" {
  name            = "AzureSqlDatabaseLinkedService"
  data_factory_id = azurerm_data_factory.adf.id

  connection_string = <<-EOF
    Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.sql_database_name};User ID=${var.sql_admin_login};Password=${var.sql_admin_password};Encrypt=true;Connection Timeout=30;
  EOF
}