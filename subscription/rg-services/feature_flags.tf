variable "security_features" {
  description = "Toggle security features for Checkov compliance vs operational access"
  type = object({
    enable_public_network_access = bool # true = Zugriff möglich, false = Checkov compliant
    enable_network_restrictions  = bool # true = Firewall-Regeln aktiv
    enable_private_endpoints     = bool # true = Private Endpoints (kostet Geld!)
    enable_cmk_encryption        = bool # true = Customer Managed Keys
    # false = nur Entra ID / RBAC (empfohlen, CKV2_AZURE_40); true = Account-Keys + Key-SAS erlaubt
    enable_shared_access_key = bool
  })
  default = {
    enable_public_network_access = true  # Standard: Zugriff erlauben (dynamische Home-IP, kein PE)
    enable_network_restrictions  = false # Standard: Keine Firewall
    enable_private_endpoints     = false # Standard: Keine PE (Kosten)
    enable_cmk_encryption        = false # Standard: Microsoft Managed Keys
    enable_shared_access_key     = false # Standard: Keys aus — Entra ID + RBAC (Lernziel)
  }
}

variable "compliance_mode" {
  description = "Shortcut: Set to true for Checkov scan, false for daily operations"
  type        = bool
  default     = false
}

locals {
  # Wenn compliance_mode = true, aktiviere alle Security-Features
  # Ansonsten nutze individuelle Flags
  security_config = var.compliance_mode ? {
    enable_public_network_access = false
    enable_network_restrictions  = true
    enable_private_endpoints     = true
    enable_cmk_encryption        = true
    enable_shared_access_key     = false
  } : var.security_features
}
