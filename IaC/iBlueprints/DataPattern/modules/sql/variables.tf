variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "sql_version" {
  description = "SQL Server version"
  type        = string
  default     = "12.0"
}

variable "admin_login" {
  description = "Administrator login for SQL Server"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for SQL Server"
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sql_sku_name" {
  description = "SKU name for the SQL Database"
  type        = string
  default     = "Basic"
}

variable "security_alert_retention_days" {
  description = "Retention days for security alerts"
  type        = number
  default     = 30
}

variable "sql_alert_name" {
  description = "Name of the SQL CPU usage alert"
  type        = string
}

variable "alert_severity" {
  description = "Severity of the alert"
  type        = number
  default     = 2
}

variable "alert_frequency" {
  description = "Frequency of the alert evaluation (e.g., 'PT5M' for every 5 minutes)"
  type        = string
  default     = "PT5M"
}

variable "alert_window_size" {
  description = "Window size for alert evaluation (e.g., 'PT5M' for last 5 minutes)"
  type        = string
  default     = "PT5M"
}

variable "cpu_threshold" {
  description = "CPU usage threshold percentage"
  type        = number
  default     = 80
}

variable "action_group_name" {
  description = "Name of the action group for alerts"
  type        = string
}

variable "email_receiver_name" {
  description = "Name of the email receiver for alerts"
  type        = string
}

variable "email_receiver_address" {
  description = "Email address of the receiver for alerts"
  type        = string
}
