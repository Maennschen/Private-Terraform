variable "enable_vnet_flow_logs" {
  description = "Create Network Watcher VNet flow logs. Default false (free lab — storage cost when on)."
  type        = bool
  default     = false
}

variable "flow_log_storage_account_id" {
  description = "Storage account for flow logs. Required when enable_vnet_flow_logs is true (typically sa00services)."
  type        = string
  default     = null
}
