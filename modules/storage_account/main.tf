# Free / learning lab (Azure Free, DE dynamic home IP, no PE budget).
# Intentional Checkov exclusions — do not "fix" with PE/CMK/GRS just for green checks.
# Shared keys: prefer false + Entra RBAC (CKV2_AZURE_40). State backend uses a different SA.
resource "azurerm_storage_account" "this" {
  # checkov:skip=CKV2_AZURE_33: Free learning lab — private endpoints cost money; not in scope
  # checkov:skip=CKV2_AZURE_1: Free learning lab — Microsoft-managed encryption sufficient; no CMK
  # checkov:skip=CKV_AZURE_206: LRS intentional for free tier; GRS/ZRS not worth the cost for a lab
  # checkov:skip=CKV_AZURE_59: Public network access kept for home access; DE residential IP is dynamic (no stable ip_rules without PE/VPN)
  # checkov:skip=CKV_AZURE_33: Queue logging is configured via azurerm_storage_account_queue_properties (Checkov often misses sibling resources)
  # checkov:skip=CKV2_AZURE_41: sas_policy is set below; graph/policy false positive on this resource shape
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = var.allow_blob_public_access
  shared_access_key_enabled       = var.shared_access_key_enabled
  default_to_oauth_authentication = var.default_to_oauth_authentication
  min_tls_version                 = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  sas_policy {
    expiration_period = "90.00:00:00"
    expiration_action = "Log"
  }

  tags = var.tags
}

# Data-plane access when account keys are disabled (Entra ID + RBAC).
# Control-plane (managing the SA resource) still uses subscription/RG Owner|Contributor.
locals {
  data_plane_roles = var.shared_access_key_enabled || var.data_plane_principal_id == null ? toset([]) : toset([
    "Storage Blob Data Contributor",
    "Storage File Data Privileged Contributor",
    "Storage Queue Data Contributor",
  ])
}

resource "azurerm_role_assignment" "data_plane" {
  for_each = local.data_plane_roles

  scope                = azurerm_storage_account.this.id
  role_definition_name = each.value
  principal_id         = var.data_plane_principal_id
}

resource "azurerm_storage_account_queue_properties" "this" {
  storage_account_id = azurerm_storage_account.this.id

  logging {
    delete                = true
    read                  = true
    write                 = true
    version               = "1.0"
    retention_policy_days = 7
  }
}

resource "azurerm_storage_share" "this" {
  for_each = {
    for share in var.file_shares : share.name => share
  }

  name               = each.value.name
  storage_account_id = azurerm_storage_account.this.id
  quota              = each.value.quota
  access_tier        = each.value.access_tier
}

resource "azurerm_storage_container" "this" {
  for_each = {
    for container in var.storage_containers : container.name => container
  }

  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
