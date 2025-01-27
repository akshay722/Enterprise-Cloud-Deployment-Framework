variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "resource_group_name" {
  default = "rg-abs"
}

variable "location" {
  default = "East US"
}

variable "tags" {
  type = map(string)
  default = {
    "CostCenter" = "Capstone"
  }
}

variable "vnet_name" {
  default = "vnet-abs"
}

variable "vnet_address_space" {
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  default = "subnet-abs"
}

variable "subnet_address_prefix" {
  default = "10.0.1.0/24"
}

variable "subnet_service_endpoints" {
  default = ["Microsoft.Storage", "Microsoft.Sql"]
}

variable "storage_account_name" {
  default = "saabs"
}

variable "storage_account_tier" {
  default = "Standard"
}

variable "storage_account_replication" {
  default = "LRS"
}

variable "storage_account_access_tier" {
  default = "Hot"
  
}

variable "storage_account_tls_version" {
  default = "TLS1_2"
}

variable "blob_delete_retention_days" {
  default = 7
}

variable "blob_versioning_enabled" {
  default = true
}
