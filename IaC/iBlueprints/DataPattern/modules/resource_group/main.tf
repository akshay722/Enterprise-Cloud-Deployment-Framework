resource "azurerm_resource_group" "rg" {
  name     = "RG-ECDF-Data-Infra"
  location = var.location
  tags = {
    environment = var.environment
    CostCenter  = var.cost_center
  }
}
