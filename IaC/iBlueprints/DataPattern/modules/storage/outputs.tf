output "source_account_id" {
  value = azurerm_storage_account.source.id
}
output "source_storage_connection_string" {
  value = azurerm_storage_account.source.primary_blob_connection_string
}
