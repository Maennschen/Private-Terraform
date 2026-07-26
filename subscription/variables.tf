variable "global_admin_object_id" {
  description = "Entra object ID (user or group) for storage data-plane RBAC and Key Vault access policy. No default — pass from root / tfvars."
  type        = string
}
