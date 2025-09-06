variable "storage_containers" {
  type = map(object({
#    storage_account_name = string
    container_access_type = string
    role_assignments = map(object({
      role_definition_name = string
      principal_id         = string
    }))
  }))
  description = "A map of storage containers with their configurations and role assignments."
}

variable "file_shares" {
  type = map(object({
 #   storage_account_name = string
    fileshare_name = string
    quota = number
 #   role_assignments = map(object({
 #     role_definition_name = string
 #     principal_id         = string
 #   }))
  }))
  description = "A map of file shares with their configurations and role assignments."
}

variable "storage_account_name" {
  description = "Name des Storage Accounts"
  type        = string
}

variable "resource_group_name" {
  description = "Der Name der Ressourcengruppe"
  type        = string
}

variable "location" {
  description = "Die Region, in der der Storage Account erstellt wird"
  type        = string
}

variable "account_tier" {
  description = "Die Leistungsebene des Storage Accounts"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Der Replikationstyp des Storage Accounts"
  type        = string
  default     = "LRS"
}

variable "create_storage_container" {
  description = "Gibt an, ob ein Storage Container erstellt werden soll"
  type        = bool
  default     = false
}

variable "container_name" {
  description = "Der Name des Storage Containers"
  type        = string
  default     = null
}

variable "container_access_type" {
  description = "Der Zugriffstyp des Storage Containers"
  type        = string
  default     = "private"
}

variable "group_object_id" {
  description = "Die Objekt-ID der Gruppe, der die Rolle zugewiesen werden soll"
  type        = string
  default     = null
}

variable "create_file_share" {
  description = "Gibt an, ob ein File Share erstellt werden soll"
  type        = bool
  default     = false
}

variable "fileshare_name" {
  description = "Der Name des File Shares"
  type        = string
  default     = null
}

variable "quota" {
  description = "Die Quota in GB für den File Share"
  type        = number
  default     = null
}

variable "user_object_id" {
  description = "Die Objekt-ID des Benutzers, dem die Rolle zugewiesen werden soll"
  type        = string
  default     = null
}