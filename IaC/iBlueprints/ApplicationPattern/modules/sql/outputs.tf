# Output the SQL Database ID
output "sql_database_id" {
  value = azurerm_mssql_database.main.id
}
