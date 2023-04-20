naming_client      = "ecl"
naming_area        = "az"
naming_environment = "fact"

tags = {
  costcenter = "eurocontrol"
  owner      = "terraform"
}

vm_admin_user   = "azureuser"
vm_size         = "Standard_DS3_v2"
iac_keyvault_id = "/subscriptions/45152bab-ec81-45e0-af27-13f57a380423/resourceGroups/ecl-az-fact-rgp-01-global/providers/Microsoft.KeyVault/vaults/ecl-az-fact-kvt-01-main"
