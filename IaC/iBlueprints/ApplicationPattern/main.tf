
resource "random_string" "unique_suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  project_name  = "testproject"
  environment   = "dev"
  unique_suffix = random_string.unique_suffix.result
}

# Resource Group Module
module "resource_group" {
  source      = "./modules/resource_group"
  location    = var.location
  environment = var.environment
  cost_center = var.cost_center
}

# Virtual Network Module
module "vnet" {
  source                  = "./modules/vnet"
  vnet_name               = "${local.project_name}-vnet-${local.unique_suffix}"
  address_space           = var.vnet_address_space
  subnet_name             = "${local.project_name}-subnet-${local.unique_suffix}"
  subnet_address_prefixes = var.subnet_address_prefixes
  subnet_service_endpoints = var.subnet_service_endpoints
  location                = module.resource_group.location
  resource_group_name     = module.resource_group.name
  tags                    = var.tags
}

# Log Analytics Workspace Module
module "log_analytics" {
  source                       = "./modules/log_analytics"
  log_analytics_workspace_name = "${local.project_name}-law-${local.unique_suffix}"
  location                     = module.resource_group.location
  resource_group_name          = module.resource_group.name
  sku                          = "PerGB2018"
  retention_in_days            = 30
  tags                         = var.tags
}

# AKS Module
module "aks" {
  source                      = "./modules/aks"
  cluster_name                = "${local.project_name}-aks-${local.unique_suffix}"
  kubernetes_version          = var.aks_kubernetes_version
  location                    = module.resource_group.location
  resource_group_name         = module.resource_group.name
  dns_prefix                  = "${local.project_name}-dns-${local.unique_suffix}"
  default_node_pool_name      = "systempool"
  default_node_pool_vm_size   = var.aks_node_pool_vm_size
  auto_scaling_enabled        = var.auto_scaling_enabled
  default_node_pool_min_count = var.default_node_pool_min_count
  default_node_pool_max_count = var.default_node_pool_max_count
  default_node_pool_zones     = var.default_node_pool_zones
  network_plugin              = var.network_plugin
  load_balancer_sku           = var.load_balancer_sku
  subnet_id                   = module.vnet.subnet_id
  ssh_public_key              = tls_private_key.ssh_key.public_key_openssh
  log_analytics_workspace_id  = module.log_analytics.workspace_id
  tags                        = var.tags
}

# SQL Module
module "sql" {
  source               = "./modules/sql"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  sql_server_name      = "${local.project_name}-sql-${local.unique_suffix}"
  sql_server_version   = var.sql_server_version
  admin_username       = var.sql_admin_username
  admin_password       = var.sql_admin_password
  minimum_tls_version  = "1.2"
  sql_database_name    = "${local.project_name}-sqldb-${local.unique_suffix}"
  sku_name             = var.sku_name
  tags                 = var.tags
  tenant_id            = var.tenant_id
  subnet_id            = module.vnet.subnet_id
  unique_suffix        = local.unique_suffix  # Pass the unique_suffix here
}

# Storage Module
module "storage" {
  source              = "./modules/storage"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.vnet.subnet_id
  unique_suffix       = local.unique_suffix
}

# Role Assignment for AKS to Access Blob Storage
resource "azurerm_role_assignment" "aks_blob_access" {
  scope                = module.storage.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.aks.managed_identity_principal_id
}

# Role Assignment for AKS to Access SQL Database (if using Managed Identity)
resource "azurerm_role_assignment" "aks_sql_access" {
  scope                = module.sql.sql_database_id
  role_definition_name = "Contributor" # Adjust role as needed
  principal_id         = module.aks.managed_identity_principal_id
}
