resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "log-analytics-workspace-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
