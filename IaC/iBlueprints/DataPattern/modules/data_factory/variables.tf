variable "resource_group_name" {}
variable "location" {}
variable "storage_source_id" {}
variable "storage_dest_id" {}
variable "source_blob_connection_string" {
  description = "Connection string for the source storage account"
  type        = string
}

// SQL variables
variable "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sql_admin_login" {
  description = "Administrator login for SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "Administrator password for SQL Server"
  type        = string
  sensitive   = true
}
