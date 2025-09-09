variable "resource_group_name" {
  description = "Name der Resource Group, in der der Storage Account erstellt wird."
  type        = string
}

variable "location" {
  description = "Azure Region, in der der Storage Account erstellt wird."
  type        = string
}

variable "storage_account_name" {
  description = "Name des Storage Accounts (global eindeutig, nur Kleinbuchstaben und Zahlen)."
  type        = string
}

variable "account_tier" {
  description = "Performance-Tier des Storage Accounts (Standard oder Premium)."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replikationstyp des Storage Accounts (z. B. LRS, GRS, ZRS)."
  type        = string
  default     = "LRS"
}

variable "file_shares" {
  description = "Liste der zu erstellenden File Shares."
  type = list(object({
    name        = string
    quota       = number
    access_tier = optional(string, "Hot")
  }))
  default = []
}

variable "storage_containers" {
  description = "Liste der zu erstellenden Storage Container."
  type = list(object({
    name                  = string
    container_access_type = optional(string, "private")
  }))
  default = []
}

variable "tags" {
  description = "Tags für die Ressourcen."
  type        = map(string)
  default     = {}
}
