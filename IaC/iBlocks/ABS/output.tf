output "resource_group_name" {
  value = azurerm_resource_group.rg-abs.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet-abs.name
}

output "storage_account_name" {
  value = azurerm_storage_account.saabs.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet-abs.id
}
