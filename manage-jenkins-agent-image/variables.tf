variable "naming_client" {
  type        = string
  description = "Nomenclature convention customer abbreviation"
}

variable "naming_area" {
  type        = string
  description = "Nomenclature convention area abbreviation"
}

variable "naming_environment" {
  type        = string
  description = "Nomenclature convention enviroment abbreviation"
}

variable "tags" {
  description = "Map of tags"
  type        = map(string)
  default     = {}
}

variable "iac_keyvault_id" {
  description = "IaC Keyvault ID"
  type        = string
}

variable "vm_admin_user" {
  description = "VM Admin user."
  type        = string
}

variable "vm_size" {
  description = "Vm size."
  type        = string
}
