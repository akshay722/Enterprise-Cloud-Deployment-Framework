variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "default_node_pool_name" {
  description = "The name of the default node pool"
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "The VM size for the default node pool"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the AKS cluster"
  type        = string
}

variable "auto_scaling_enabled" {
  description = "Enable autoscaling for the node pool"
  type        = bool
}

variable "default_node_pool_min_count" {
  description = "Minimum node count for autoscaling"
  type        = number
}

variable "default_node_pool_max_count" {
  description = "Maximum node count for autoscaling"
  type        = number
}

variable "default_node_pool_zones" {
  description = "Availability zones for the node pool"
  type        = list(string)
}

variable "network_plugin" {
  description = "Network plugin for AKS"
  type        = string
}

variable "load_balancer_sku" {
  description = "Load balancer SKU for AKS"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for the AKS nodes"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the AKS cluster"
  type        = map(string)
}
