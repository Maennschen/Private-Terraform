variable "resource_group_name" {
  description = "Name der zugehörigen Resourcen Gruppe"
  type        = string
}

variable "location" {
  description = "Datacenterlocation der VM"
  type        = string
}

variable "vmname" {
  description = "Name der Virtuellen Maschine"
  type        = string
}

variable "subnet_id" {
  description = "Azure Subnet resource ID for the VM NIC (not the VNet ID), e.g. module.vnet.subnet_ids[\"v00s02vms\"]"
  type        = string
}
