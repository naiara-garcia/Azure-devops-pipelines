## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.22.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_image_name"></a> [image\_name](#module\_image\_name) | git@ssh.dev.azure.com:v3/ecl-ado-factory/ecl-ado-prj-iac/nm-factory-inf-mod-naming | n/a |
| <a name="module_nic_name"></a> [nic\_name](#module\_nic\_name) | git@ssh.dev.azure.com:v3/ecl-ado-factory/ecl-ado-prj-iac/nm-factory-inf-mod-naming | n/a |
| <a name="module_vm_name"></a> [vm\_name](#module\_vm\_name) | git@ssh.dev.azure.com:v3/ecl-ado-factory/ecl-ado-prj-iac/nm-factory-inf-mod-naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_image.jenkins_agent](https://registry.terraform.io/providers/hashicorp/azurerm/3.22.0/docs/resources/image) | resource |
| [azurerm_network_interface.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.22.0/docs/resources/network_interface) | resource |
| [azurerm_role_assignment.vm_admin_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.22.0/docs/resources/role_assignment) | resource |
| [azurerm_virtual_machine.jenkins_agent](https://registry.terraform.io/providers/hashicorp/azurerm/3.22.0/docs/resources/virtual_machine) | resource |
| [null_resource.deallocated_vm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.generalized_vm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_key_vault_secret.az_agents_admin_passwd](https://registry.terraform.io/providers/hashicorp/azurerm/3.22.0/docs/data-sources/key_vault_secret) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.rsg](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iac_keyvault_id"></a> [iac\_keyvault\_id](#input\_iac\_keyvault\_id) | IaC Keyvault ID | `string` | n/a | yes |
| <a name="input_naming_area"></a> [naming\_area](#input\_naming\_area) | Nomenclature convention area abbreviation | `string` | n/a | yes |
| <a name="input_naming_client"></a> [naming\_client](#input\_naming\_client) | Nomenclature convention customer abbreviation | `string` | n/a | yes |
| <a name="input_naming_environment"></a> [naming\_environment](#input\_naming\_environment) | Nomenclature convention enviroment abbreviation | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags | `map(string)` | `{}` | no |
| <a name="input_vm_admin_user"></a> [vm\_admin\_user](#input\_vm\_admin\_user) | VM Admin user. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Vm size. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_name"></a> [image\_name](#output\_image\_name) | n/a |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | n/a |
