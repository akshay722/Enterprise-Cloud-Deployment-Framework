resource "random_string" "unique_suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = "sqlserver${random_string.unique_suffix.result}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_mssql_database" "sql_database" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = var.sql_sku_name

  tags = {
    environment = var.environment
  }
}

resource "azurerm_mssql_server_security_alert_policy" "security_alert_policy" {
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.sql_server.name
  state               = "Enabled"
  retention_days      = var.security_alert_retention_days
}


resource "azurerm_monitor_metric_alert" "sql_cpu_alert" {
  name                = var.sql_alert_name
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.sql_database.id]
  description         = "Alert when CPU usage exceeds ${var.cpu_threshold}%."
  severity            = var.alert_severity
  frequency           = var.alert_frequency
  window_size         = var.alert_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "cpu_percent"
    operator         = "GreaterThan"
    threshold        = var.cpu_threshold
    aggregation      = "Average"
  }
}

resource "azurerm_monitor_action_group" "action_group" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = "sqlalerts"

  email_receiver {
    name          = var.email_receiver_name
    email_address = var.email_receiver_address
  }
}
