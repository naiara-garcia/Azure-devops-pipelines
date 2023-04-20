############### Virtual Machine ###############
resource "azurerm_virtual_machine" "jenkins_agent" {
  name                  = module.vm_name.name
  resource_group_name   = data.terraform_remote_state.rsg.outputs.global_resource_group.name
  location              = data.terraform_remote_state.rsg.outputs.global_resource_group.location
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = module.vm_name.name
    caching           = "ReadOnly"
    disk_size_gb      = 80
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = module.vm_name.name
    admin_username = var.vm_admin_user
    admin_password = data.azurerm_key_vault_secret.az_agents_admin_passwd.value
    custom_data    = base64encode(templatefile("cloud-init/cloudinit.conf", {}))
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = merge(var.tags)
}

resource "azurerm_network_interface" "main" {
  name                = module.nic_name.name
  resource_group_name = data.terraform_remote_state.rsg.outputs.global_resource_group.name
  location            = data.terraform_remote_state.rsg.outputs.global_resource_group.location

  ip_configuration {
    name                          = "internal"
    primary                       = true
    subnet_id                     = data.terraform_remote_state.network.outputs.vpnp2s_subnet_ids.natout
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_role_assignment" "vm_admin_access" {
  scope                = azurerm_virtual_machine.jenkins_agent.id
  role_definition_name = "Virtual Machine Administrator Login"
  principal_id         = "4f3d3433-b453-49dd-a22a-9bf3d86de065" # ECTL DPLT Group
}

resource "time_sleep" "wait" {
  create_duration = "5m"

  depends_on = [
    azurerm_virtual_machine.jenkins_agent
  ]
}

resource "null_resource" "deallocated_vm" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "az vm deallocate -g ${data.terraform_remote_state.rsg.outputs.global_resource_group.name} -n ${azurerm_virtual_machine.jenkins_agent.name}"
  }

  depends_on = [
    time_sleep.wait
  ]
}

resource "null_resource" "generalized_vm" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "az vm generalize -g ${data.terraform_remote_state.rsg.outputs.global_resource_group.name} -n ${azurerm_virtual_machine.jenkins_agent.name}"
  }

  depends_on = [
    null_resource.deallocated_vm
  ]
}

resource "azurerm_image" "jenkins_agent" {
  name                = module.image_name.name
  resource_group_name = data.terraform_remote_state.rsg.outputs.global_resource_group.name
  location            = data.terraform_remote_state.rsg.outputs.global_resource_group.location

  source_virtual_machine_id = azurerm_virtual_machine.jenkins_agent.id

  depends_on = [
    null_resource.generalized_vm
  ]
}
