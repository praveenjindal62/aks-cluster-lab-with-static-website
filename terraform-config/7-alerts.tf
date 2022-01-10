resource "azurerm_monitor_scheduled_query_rules_alert" "example" {
  name                = "AppErrorAlert"
  location            = azurerm_resource_group.aks_cluster_rg.location
  resource_group_name = azurerm_resource_group.aks_cluster_rg.name

  action {
    action_group           = [azurerm_monitor_action_group.actiongroup1.id]
    email_subject          = "Critical App Error"
  }
  data_source_id = azurerm_log_analytics_workspace.lawspace.id
  description    = "Alert when total results cross threshold"
  enabled        = true
  # Count all errors in container logs in 30 min time window
  query       = <<-QUERY
  ContainerLog
  | join kind= leftouter ( 
  ContainerInventory
  | where Image == "static-website-image" or Image == "static-website-image-db"
  | distinct ContainerID, ContainerHostname
  ) on $left.ContainerID == $right.ContainerID
  | where LogEntry contains "error"
  | project TimeGenerated, ContainerID, LogEntry, LogEntrySource, ContainerHostname
  | order by TimeGenerated desc
  QUERY
  severity    = 1
  frequency   = 10
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 3
  }
}