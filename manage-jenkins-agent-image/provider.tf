terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.22.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "45152bab-ec81-45e0-af27-13f57a380423"
    resource_group_name  = "ecl-az-seed-rgp-01-seed"
    storage_account_name = "eclazseedsta01"
    container_name       = "ecl-az-seed-stc-01-tfstates"
    key                  = "factory/operations/manage-jenkins-agent-image.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "45152bab-ec81-45e0-af27-13f57a380423"
}
