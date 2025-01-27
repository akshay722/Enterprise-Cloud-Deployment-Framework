variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "location" {
  description = "Azure Region"
  default     = "East US"
}

variable "tags" {
  description = "Resource Tags"
  type        = map(string)
  default     = {
    Environment = "Development"
    Project     = "Test Project"
  }
}
variable "environment" {
  description = "Environment tag for resources"
  default     = "dev"
}


variable "cost_center" {
  description = "Cost center for resources"
  default     = "Capstone"
}

variable "sql_admin_username" {
  description = "SQL Admin Username"
  type        = string
  default     = "adminuser"
}

variable "sql_admin_password" {
  description = "SQL Admin Password"
  type        = string
}

variable "aks_kubernetes_version" {
  description = "AKS Kubernetes Version"
  type        = string
  default     = "1.29.9"
}

variable "aks_node_pool_vm_size" {
  description = "AKS Node Pool VM Size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "sql_server_version" {
  description = "SQL Server Version"
  type        = string
  default     = "12.0"
}

variable "vnet_address_space" {
  description = "VNet Address Space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Subnet Address Prefixes"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_service_endpoints" {
  description = "Subnet Service Endpoints"
  type        = list(string)
  default     = ["Microsoft.Storage", "Microsoft.Sql"]
}

variable "auto_scaling_enabled" {
  description = "Enable Autoscaling"
  type        = bool
  default     = true
}

variable "default_node_pool_min_count" {
  description = "Minimum Node Count"
  type        = number
  default     = 1
}

variable "default_node_pool_max_count" {
  description = "Maximum Node Count"
  type        = number
  default     = 3
}

variable "default_node_pool_zones" {
  description = "Node Pool Zones"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "network_plugin" {
  description = "AKS Network Plugin"
  type        = string
  default     = "azure"
}

variable "load_balancer_sku" {
  description = "Load Balancer SKU"
  type        = string
  default     = "standard"
}

variable "sku_name" {
  description = "The SKU of the workspace"
  type        = string
}
