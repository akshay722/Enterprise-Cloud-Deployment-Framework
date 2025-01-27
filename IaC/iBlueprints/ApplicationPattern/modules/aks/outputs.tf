output "managed_identity_principal_id" {
  value = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}
