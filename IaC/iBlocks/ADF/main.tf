provider "azurerm" {
  features {}
  subscription_id = "SUB_ID"
  tenant_id       = "ID"
}

# Creating a Resource Group (Name: RG_ADF_Terraform)
resource "azurerm_resource_group" "rg" {
  name     = "RG_ADF_Terraform"
  location = "East US"

  tags = {
    environment = "dev"
    CostCenter  = "default-value" 
  }

  lifecycle {
    ignore_changes = [tags]  # adding this line to avoid conflict with Azure policies
  }
}

# Creating a Storage Account for Source and Destination with unique names
resource "azurerm_storage_account" "storage_source" {
  name                     = "sourcestorageacct${random_string.unique_suffix.result}" 
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  min_tls_version           = "TLS1_2"

  tags = {
    environment = "dev"
  }
  
  lifecycle {
    ignore_changes = [tags] 
  }
}

resource "azurerm_storage_account" "storage_dest" {
  name                     = "deststorageacct${random_string.unique_suffix.result}"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  min_tls_version           = "TLS1_2"

  tags = {
    environment = "dev"
  }
}

# Creating a Private Blob Containers for Source and Destination 
resource "azurerm_storage_container" "source_container" {
  name                  = "sourcecontainer"
  storage_account_name  = azurerm_storage_account.storage_source.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "dest_container" {
  name                  = "destcontainer"
  storage_account_name  = azurerm_storage_account.storage_dest.name
  container_access_type = "private"
}

# Creating a random string to append to storage account names for uniqueness
resource "random_string" "unique_suffix" {
  length  = 6
  upper   = false
  special = false
}

# Creating a  Azure Data Factory
resource "azurerm_data_factory" "adf" {
  name                = "adf-container-copy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  identity {
    type = "SystemAssigned"
  }
}

# Grant ADF Managed Identity access to both Storage Accounts
resource "azurerm_role_assignment" "source_storage_contributor" {
  principal_id         = azurerm_data_factory.adf.identity[0].principal_id  
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.storage_source.id
}

resource "azurerm_role_assignment" "dest_storage_contributor" {
  principal_id         = azurerm_data_factory.adf.identity[0].principal_id  
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.storage_dest.id
}

# Data Factory Linked Services (Source and Destination)
resource "azurerm_data_factory_linked_service_azure_blob_storage" "source_blob" {
  name              = "sourceBlobLinkedService"
  data_factory_id   = azurerm_data_factory.adf.id
  connection_string = azurerm_storage_account.storage_source.primary_connection_string
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "dest_blob" {
  name              = "destBlobLinkedService"
  data_factory_id   = azurerm_data_factory.adf.id
  connection_string = azurerm_storage_account.storage_dest.primary_connection_string
}

# Creating a Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-analytics-workspace"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Outputs 
output "adf_url" {
  value = azurerm_data_factory.adf.id
}