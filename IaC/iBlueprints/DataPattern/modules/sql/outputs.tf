output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_database_id" {
  description = "ID of the SQL Database"
  value       = azurerm_mssql_database.sql_database.id
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = azurerm_mssql_database.sql_database.name
}
