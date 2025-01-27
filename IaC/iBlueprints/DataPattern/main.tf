module "resource_group" {
  source      = "./modules/resource_group"
  location    = var.location
  environment = var.environment
  cost_center = var.cost_center
}

module "network" {
  source               = "./modules/network"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
}

module "storage" {
  source               = "./modules/storage"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  subnet_id            = module.network.subnet_id
}

module "data_factory" {
  source               = "./modules/data_factory"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  storage_source_id    = module.storage.source_account_id
  storage_dest_id      = module.storage.source_account_id
  

  source_blob_connection_string = module.storage.source_storage_connection_string


  # Pass SQL outputs
  sql_server_fqdn              = module.sql.sql_server_fqdn
  sql_database_name            = module.sql.sql_database_name
  sql_admin_login              = var.admin_login
  sql_admin_password           = var.admin_password
}

module "log_analytics" {
  source              = "./modules/log_analytics"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "sql" {
  source                       = "./modules/sql"
  resource_group_name          = module.resource_group.name
  location                     = module.resource_group.location
  environment                  = var.environment
  sql_version                  = var.sql_version
  admin_login                  = var.admin_login
  admin_password               = var.admin_password
  sql_database_name            = var.sql_database_name
  sql_sku_name                 = var.sql_sku_name
  security_alert_retention_days = var.security_alert_retention_days
  sql_alert_name               = var.sql_alert_name
  alert_severity               = var.alert_severity
  alert_frequency              = var.alert_frequency
  alert_window_size            = var.alert_window_size
  cpu_threshold                = var.cpu_threshold
  action_group_name            = var.action_group_name
  email_receiver_name          = var.email_receiver_name
  email_receiver_address       = var.email_receiver_address
}
