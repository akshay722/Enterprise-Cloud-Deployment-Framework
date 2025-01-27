resource "azurerm_resource_group" "main" {
  name     = "RG-ECDF-App-Infra"
  location = var.location
  tags = {
    environment = var.environment
    CostCenter  = var.cost_center
  }
}
