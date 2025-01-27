output "data_factory_url" {
  value = module.data_factory.adf_url
}

output "sql_server_name" {
  value = module.sql.sql_server_name
}

output "sql_database_name" {
  value = module.sql.sql_database_name
}