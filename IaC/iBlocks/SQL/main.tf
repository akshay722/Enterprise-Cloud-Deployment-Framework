# Provider Configuration
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    CostCenter  = var.cost_center
  }
}

# Unique Suffix for Naming
resource "random_string" "unique_suffix" {
  length  = 6
  upper   = false
  special = false
}

# SQL Server 
resource "azurerm_mssql_server" "sql_server" {
  name                         = "sqlserver${random_string.unique_suffix.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = var.sql_version
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"

  tags = {
    environment = var.environment
  }
}

# SQL Database
resource "azurerm_mssql_database" "sql_database" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = var.sql_sku_name

  tags = {
    environment = var.environment
  }
}

# Security Alert Policy
resource "azurerm_mssql_server_security_alert_policy" "security_alert_policy" {
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.sql_server.name
  state               = "Enabled"
  retention_days      = var.security_alert_retention_days
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days

  tags = {
    environment = var.environment
  }
}

# Monitor Metric Alert for SQL CPU Usage 
resource "azurerm_monitor_metric_alert" "sql_cpu_alert" {
  name                = var.sql_alert_name
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_mssql_database.sql_database.id]
  description         = "Alert when CPU usage exceeds 80%."
  severity            = var.alert_severity
  frequency           = var.alert_frequency
  window_size         = var.alert_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "cpu_percent"
    operator         = "GreaterThan"
    threshold        = var.cpu_threshold
    aggregation      = "Average"

    skip_metric_validation = true
  }
}

# Action Group for Alerts
resource "azurerm_monitor_action_group" "action_group" {
  name                = var.action_group_name
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "sqlalerts"

  email_receiver {
    name          = var.email_receiver_name
    email_address = var.email_receiver_address
  }
}
