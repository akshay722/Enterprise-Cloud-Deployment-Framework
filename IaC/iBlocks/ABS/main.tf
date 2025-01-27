terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.6.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features        {}
}

# Resource Group
resource "azurerm_resource_group" "rg-abs" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Virtual Network
resource "azurerm_virtual_network" "vnet-abs" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-abs.name
}

# Subnet
resource "azurerm_subnet" "subnet-abs" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg-abs.name
  virtual_network_name = azurerm_virtual_network.vnet-abs.name
  address_prefixes     = [var.subnet_address_prefix]
  service_endpoints    = var.subnet_service_endpoints
}

# Storage Account
resource "azurerm_storage_account" "saabs" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg-abs.name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication
  min_tls_version          = var.storage_account_tls_version
  access_tier              = var.storage_account_access_tier
  
  blob_properties {
    delete_retention_policy {
      days = var.blob_delete_retention_days
    }
    versioning_enabled = var.blob_versioning_enabled
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Private Endpoint
resource "azurerm_private_endpoint" "pe-abs" {
  name                = "pe-abs"
  location            = azurerm_resource_group.rg-abs.location
  resource_group_name = azurerm_resource_group.rg-abs.name
  subnet_id           = azurerm_subnet.subnet-abs.id

  private_service_connection {
    name                           = "blob-privatelink"
    private_connection_resource_id = azurerm_storage_account.saabs.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

# Network Rules for Storage Account
resource "azurerm_storage_account_network_rules" "network_rules-abs" {
  storage_account_id         = azurerm_storage_account.saabs.id
  default_action             = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.subnet-abs.id]
  bypass                     = ["AzureServices"]
}

# Blob Container
resource "azurerm_storage_container" "container-abs" {
  name                  = "container-abs"
  storage_account_name  = azurerm_storage_account.saabs.name
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.saabs
  ]
}
