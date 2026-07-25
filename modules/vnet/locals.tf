# Optional VNet flow logs (Network Watcher). Default off — storage cost when enabled; no Traffic Analytics (extra cost).
# Azure usually auto-provisions NetworkWatcher_<region> in NetworkWatcherRG for the subscription.
locals {
  network_watcher_location = lower(replace(var.location, " ", ""))
}
