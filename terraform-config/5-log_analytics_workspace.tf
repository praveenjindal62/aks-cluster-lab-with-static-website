resource "azurerm_log_analytics_workspace" "lawspace" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.aks_cluster_rg.location
  resource_group_name = azurerm_resource_group.aks_cluster_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_workspace_name_retention_days
}