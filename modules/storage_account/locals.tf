# Data-plane access when account keys are disabled (Entra ID + RBAC).
# Control-plane (managing the SA resource) still uses subscription/RG Owner|Contributor.
locals {
  data_plane_roles = var.shared_access_key_enabled || var.data_plane_principal_id == null ? toset([]) : toset([
    "Storage Blob Data Contributor",
    "Storage File Data Privileged Contributor",
    "Storage Queue Data Contributor",
  ])
}
