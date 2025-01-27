variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the storage account will be created"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the private endpoint"
  type        = string
}

variable "unique_suffix" {
  description = "A unique suffix for naming resources"
  type        = string
}
