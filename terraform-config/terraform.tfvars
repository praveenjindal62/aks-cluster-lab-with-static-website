# Resource group details
rgname = "terraform-labs-aks-cluster"
rglocation = "eastus"  

# ACR Details
acrname = "pj62acrepam01"
acrsku = "Basic"

#VNET Details
vnetname = "acrvnet"
vnetcidr = ["10.0.0.0/16","10.1.0.0/16"]

subnet1_name = "default"
subnet1_prefix = ["10.0.1.0/24"]

subnet2_name = "akssubnet"
subnet2_prefix = ["10.1.0.0/22"]

#AKS Cluster
aksname = "labakscluster"
aksnodecount = 1
aksnodesku = "Standard_D2_v3"
