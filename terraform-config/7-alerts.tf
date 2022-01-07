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
  | join ( 
    ContainerInventory
    | where Image contains "static-website-image" 
    ) on ContainerID
  | where LogEntry contains "error"
  | distinct TimeGenerated, ContainerID, LogEntry, LogEntrySource
  QUERY
  severity    = 1
  frequency   = 5
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 3
  }
}