variable "subscription_id" {
  description = "Azure subscription ID. Set via terraform.tfvars (gitignored) or TF_VAR_subscription_id / ARM_SUBSCRIPTION_ID."
  type        = string
  default     = null
}

variable "global_admin_object_id" {
  description = "Entra object ID (user or group) for storage data-plane RBAC and Key Vault access. Set via terraform.tfvars (gitignored) or TF_VAR_global_admin_object_id."
  type        = string
}
