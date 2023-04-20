module "vm_name" {
  source      = "git@ssh.dev.azure.com:v3/ecl-ado-factory/ecl-ado-prj-iac/nm-factory-inf-mod-naming"
  client      = var.naming_client
  area        = var.naming_area
  environment = var.naming_environment
  resource    = "vms"
  sequence    = "01"
  purpose     = "jenkinsagentvms"
}

module "nic_name" {
  source      = "git@ssh.dev.azure.com:v3/ecl-ado-factory/ecl-ado-prj-iac/nm-factory-inf-mod-naming"
  client      = var.naming_client
  area        = var.naming_area
  environment = var.naming_environment
  resource    = "nic"
  sequence    = "01"
  purpose     = "jenkinsagentvms"
}

module "image_name" {
  source      = "git@ssh.dev.azure.com:v3/ecl-ado-factory/ecl-ado-prj-iac/nm-factory-inf-mod-naming"
  client      = var.naming_client
  area        = var.naming_area
  environment = var.naming_environment
  resource    = "img"
  sequence    = "01"
  purpose     = "jenkinsagentvms"
}
