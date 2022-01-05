resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aksname
  location            = azurerm_resource_group.aks_cluster_rg.location
  resource_group_name = azurerm_resource_group.aks_cluster_rg.name
  dns_prefix          = "${var.aksname}-dns"
  kubernetes_version  = "1.22.4" 

  network_profile {
    network_plugin      = "azure"
  }
  default_node_pool {
    name                = "default"
    node_count          = var.aksnodecount
    vm_size             = var.aksnodesku
    vnet_subnet_id      = azurerm_subnet.subnet2.id
    enable_auto_scaling = true
    type                = "VirtualMachineScaleSets"
    min_count           = 1
    max_count           = 3
    os_disk_size_gb     = 30
    os_sku              = "Ubuntu"
    max_pods            = 30
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }

}

resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
