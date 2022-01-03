resource "azurerm_resource_group" "aks_cluster_rg" {
  name = var.rgname
  location = var.rglocation
}