data "terraform_remote_state" "rsg" {
  backend = "azurerm"
  config = {
    subscription_id      = "45152bab-ec81-45e0-af27-13f57a380423"
    resource_group_name  = "ecl-az-seed-rgp-01-seed"
    storage_account_name = "eclazseedsta01"
    container_name       = "ecl-az-seed-stc-01-tfstates"
    key                  = "factory/001-rsg.tfstate"
  }
}

# Data Sources
data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    subscription_id      = "45152bab-ec81-45e0-af27-13f57a380423"
    resource_group_name  = "ecl-az-seed-rgp-01-seed"
    storage_account_name = "eclazseedsta01"
    container_name       = "ecl-az-seed-stc-01-tfstates"
    key                  = "factory/100-vnets.tfstate"
  }
}

data "azurerm_key_vault_secret" "az_agents_admin_passwd" {
  name         = "docker-instances-admin-password"
  key_vault_id = var.iac_keyvault_id
}
