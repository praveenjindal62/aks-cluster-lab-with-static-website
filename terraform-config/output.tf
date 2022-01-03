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

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}