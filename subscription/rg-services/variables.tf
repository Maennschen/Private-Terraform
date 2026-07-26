variable "tenant_id" {
  default = "00000000-0000-0000-0000-000000000000"
  type    = string
}

variable "global_admin_object_id" {
  default = "00000000-0000-0000-0000-000000000000"
  type    = string
}

variable "security_features" {
  description = "Toggle security features for Checkov compliance vs operational access"
  type = object({
    enable_public_network_access = bool # true = Zugriff möglich, false = Checkov compliant
    enable_network_restrictions  = bool # true = Firewall-Regeln aktiv
    enable_private_endpoints     = bool # true = Private Endpoints (kostet Geld!)
    enable_cmk_encryption        = bool # true = Customer Managed Keys
    # false = nur Entra ID / RBAC (empfohlen, CKV2_AZURE_40); true = Account-Keys + Key-SAS erlaubt
    enable_shared_access_key = bool
    # Logging — implemented in modules but default off (log storage / optional LA cost)
    enable_blob_diagnostic_logs = bool
  })
  default = {
    enable_public_network_access = true  # Standard: Zugriff erlauben (dynamische Home-IP, kein PE)
    enable_network_restrictions  = false # Standard: Keine Firewall
    enable_private_endpoints     = false # Standard: Keine PE (Kosten)
    enable_cmk_encryption        = false # Standard: Microsoft Managed Keys
    enable_shared_access_key     = false # Standard: Keys aus — Entra ID + RBAC (Lernziel)
    enable_blob_diagnostic_logs  = false # Standard: Blob-Diag aus (Speicher-/Log-Kosten vermeiden)
  }
}

variable "compliance_mode" {
  description = "Shortcut: Set to true for Checkov scan, false for daily operations"
  type        = bool
  default     = false
}
