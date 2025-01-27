variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "subnet_service_endpoints" {
  description = "Service endpoints for the subnet"
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the virtual network will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the virtual network"
  type        = map(string)
}
