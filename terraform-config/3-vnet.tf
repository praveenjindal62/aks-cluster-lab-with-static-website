resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = azurerm_resource_group.aks_cluster_rg.location
  resource_group_name = azurerm_resource_group.aks_cluster_rg.name
  address_space       = var.vnetcidr
}



resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2_name
  resource_group_name  = azurerm_resource_group.aks_cluster_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet2_prefix
}