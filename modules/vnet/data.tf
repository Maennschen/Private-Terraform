data "azurerm_network_watcher" "this" {
  count = var.enable_flow_logs ? 1 : 0

  name                = "NetworkWatcher_${local.network_watcher_location}"
  resource_group_name = "NetworkWatcherRG"
}
