variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace"
  type        = string
}

variable "location" {
  description = "The Azure region where the workspace will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku" {
  description = "The SKU of the workspace"
  type        = string
}

variable "retention_in_days" {
  description = "The retention period in days"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the workspace"
  type        = map(string)
}
