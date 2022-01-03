
resource "azurerm_container_registry" "acr" {
  name                = var.acrname
  resource_group_name = azurerm_resource_group.aks_cluster_rg.name
  location            = azurerm_resource_group.aks_cluster_rg.location
  sku                 = var.acrsku
  admin_enabled       = true
}