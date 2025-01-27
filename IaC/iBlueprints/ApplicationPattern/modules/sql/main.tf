# modules/sql/main.tf

# SQL Server
resource "azurerm_mssql_server" "main" {
  name                          = var.sql_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.sql_server_version
  administrator_login           = var.admin_username
  administrator_login_password  = var.admin_password
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = false

  tags = var.tags
}

# SQL Database
resource "azurerm_mssql_database" "main" {
  name       = var.sql_database_name
  server_id  = azurerm_mssql_server.main.id
  sku_name   = var.sku_name

  tags = var.tags
}

# Private Endpoint for SQL Server
resource "azurerm_private_endpoint" "sql" {
  name                = "pe-sql-server-${var.unique_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "sqlserver-privatelink"
    private_connection_resource_id = azurerm_mssql_server.main.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}
