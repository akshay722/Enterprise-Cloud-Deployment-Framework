# modules/sql/variables.tf

variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the SQL server will be created"
  type        = string
}

variable "sql_server_version" {
  description = "The version of the SQL server"
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the SQL server"
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the SQL server"
  type        = string
}

variable "minimum_tls_version" {
  description = "The minimum TLS version for the SQL server"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL database"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the SQL database"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the SQL resources"
  type        = map(string)
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the private endpoint"
  type        = string
}

variable "unique_suffix" {
  description = "A unique suffix for resource names"
  type        = string
}
