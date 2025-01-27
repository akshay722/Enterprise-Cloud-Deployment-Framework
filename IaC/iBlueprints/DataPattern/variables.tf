variable "subscription_id" {
  description = "Azure Subscription ID"
}

variable "client_id" {
  description = "Azure Client ID"
}

variable "client_secret" {
  description = "Azure Client Secret"
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
}

variable "location" {
  description = "Azure region for resources"
  default     = "East US"
}

variable "environment" {
  description = "Environment tag for resources"
  default     = "dev"
}

variable "cost_center" {
  description = "Cost center for resources"
  default     = "Capstone"
}




variable "sql_version" {
  description = "SQL server version"
  type        = string
  default     = "12.0"
}

variable "admin_login" {
  description = "SQL server admin username"
  type        = string
}

variable "admin_password" {
  description = "SQL server admin password"
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "sql_sku_name" {
  description = "SQL database SKU name"
  type        = string
  default     = "Basic"
}

variable "security_alert_retention_days" {
  description = "Retention period for SQL security alerts"
  type        = number
  default     = 7
}

variable "sql_alert_name" {
  description = "Name of the SQL CPU usage alert"
  type        = string
}

variable "alert_severity" {
  description = "Severity level of the SQL alert"
  type        = number
  default     = 3
}

variable "alert_frequency" {
  description = "Frequency of the SQL alert checks"
  type        = string
  default     = "PT5M"
}

variable "alert_window_size" {
  description = "Window size for SQL alert checks"
  type        = string
  default     = "PT5M"
}

variable "cpu_threshold" {
  description = "Threshold for CPU usage alert"
  type        = number
  default     = 80
}

variable "action_group_name" {
  description = "Name of the action group for SQL alerts"
  type        = string
}

variable "email_receiver_name" {
  description = "Name of the email receiver for SQL alerts"
  type        = string
}

variable "email_receiver_address" {
  description = "Email address for SQL alerts"
  type        = string
}
