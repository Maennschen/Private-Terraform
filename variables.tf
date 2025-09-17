variable "subscription_id" {
  default = null
}

variable "tenant_id" {
  default = null
}

variable "global_admin_object_id" {
  default = null
}

variable "ip" {
  description = "My Private IP for Key Vault access policy."
  type        = string
  default     = null
}