# Provider variables
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

# Resource Group
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}

# Common Tags
variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cost_center" {
  description = "Cost center for tagging resources"
  type        = string
}

# SQL Server
variable "sql_version" {
  description = "Version of the SQL Server"
  type        = string
}

variable "admin_login" {
  description = "Administrator username for SQL Server"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for SQL Server"
  type        = string
}

# SQL Database
variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "sql_sku_name" {
  description = "SKU name for SQL database"
  type        = string
}

# Security Alert Policy
variable "security_alert_retention_days" {
  description = "Retention period for security alerts"
  type        = number
}

# Log Analytics
variable "log_analytics_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "log_retention_days" {
  description = "Retention period for Log Analytics logs"
  type        = number
}

# Alerts
variable "sql_alert_name" {
  description = "Name of the SQL alert"
  type        = string
}

variable "alert_severity" {
  description = "Severity level of the alert"
  type        = number
}

variable "alert_frequency" {
  description = "Frequency of alert evaluation"
  type        = string
}

variable "alert_window_size" {
  description = "Window size for alert evaluation"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU usage threshold for alerts"
  type        = number
}

# Action Group
variable "action_group_name" {
  description = "Name of the action group"
  type        = string
}

variable "email_receiver_name" {
  description = "Name of the email receiver for alerts"
  type        = string
}

variable "email_receiver_address" {
  description = "Email address of the alert receiver"
  type        = string
}
