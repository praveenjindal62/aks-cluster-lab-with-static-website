output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "rgname" {
  value = azurerm_resource_group.aks_cluster_rg.name
}