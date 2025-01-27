# AKS Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.dns_prefix

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                 = var.default_node_pool_name
    vm_size              = var.default_node_pool_vm_size
    vnet_subnet_id       = var.subnet_id
    auto_scaling_enabled  = var.auto_scaling_enabled
    min_count            = var.default_node_pool_min_count
    max_count            = var.default_node_pool_max_count
    zones                = var.default_node_pool_zones
  }

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = var.load_balancer_sku
    service_cidr      = "10.1.0.0/16"  
    dns_service_ip    = "10.1.0.10"     
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  tags = var.tags
}

