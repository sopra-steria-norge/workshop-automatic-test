terraform {
    
    backend "azurerm" {
        resource_group_name  = "rg-tfstate-uptime"
        storage_account_name = "tfstateuptime"
        container_name       = "tfstateuptime"
        key                  = "infra.tfstate"
    }

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "3.0.2"
        }
    }
}