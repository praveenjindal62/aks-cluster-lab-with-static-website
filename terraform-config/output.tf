output "acr-admin-username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr-admin-password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "acr-login-server" {
  value = azurerm_container_registry.acr.login_server
}

output "aks-cluster-name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "rgname" {
  value = azurerm_kubernetes_cluster.aks_cluster_rg.name
}