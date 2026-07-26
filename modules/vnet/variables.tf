variable "resource_group_name" {
  description = "Ressourcen Gruppe für Virtual Network"
  type        = string
}

variable "vnet_name" {
  description = "Name für das Virtuelle Netzwerk"
  type        = string
}

variable "location" {
  description = "Datacenter Standort für das Virtuelle Netzwerk"
  type        = string
}

variable "vnet_address_space" {
  description = "Adressraum des VNet (z. B. ['10.0.0.0/16'])"
  type        = list(string)
}

variable "subnets" {
  description = "Liste der Subnetze mit Namen und Adressräumen"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {}
}

variable "enable_flow_logs" {
  description = "When true, create VNet flow logs via Network Watcher (needs flow_log_storage_account_id; incurs storage cost). Default off for free lab."
  type        = bool
  default     = false
}

variable "flow_log_storage_account_id" {
  description = "Storage account ID for flow log retention. Required when enable_flow_logs is true."
  type        = string
  default     = null

  validation {
    condition     = !var.enable_flow_logs || (var.flow_log_storage_account_id != null && var.flow_log_storage_account_id != "")
    error_message = "flow_log_storage_account_id must be set when enable_flow_logs is true."
  }
}

variable "flow_log_retention_days" {
  description = "Retention days for VNet flow logs when enabled."
  type        = number
  default     = 7
}
