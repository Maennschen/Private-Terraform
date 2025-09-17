variable "key_vault_name" {
  description = "The name of the key vault."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the key vault."
  type        = string
}

variable "location" {
  description = "The location/region where the key vault is created."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
}

variable "global_admin_object_id" {
  description = "The object ID of the Global Admin who should have access to the key vault."
  type        = string
}

variable "ip" {
  description = "My Private IP for Key Vault access policy."
  type        = string
  default     = null
}