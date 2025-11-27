terraform {
  required_version = ">= 1.11.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.52.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "ntier"
    storage_account_name = "tfstatebackendfordemo"
    container_name       = "tfstate"
    key                  = "projects/multiregion/azure"
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id
}
