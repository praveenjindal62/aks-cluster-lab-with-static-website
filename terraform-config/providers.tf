terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 2.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
  
  backend "azurerm" {
      resource_group_name  = "terraform-global"
      storage_account_name = "terraformstatepjepam"
      container_name       = "terraformstate"
      key                  = "aks/terraform.tfstate"
  }
}
provider "azurerm" {
  features {
    
  }
}

