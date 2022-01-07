resource "azurerm_monitor_action_group" "actiongroup1" {
  name                = "CriticalAlertsActionGroup"
  resource_group_name = azurerm_resource_group.aks_cluster_rg.name
  short_name          = "OpsTeam"

  email_receiver {
    name                    = "OpsTeam"
    email_address           = "praveen_jindal@epam.com"
    use_common_alert_schema = true
  }
  azure_app_push_receiver {
    name                    = "OpsTeamAppPush"
    email_address           = "praveenjindal62@gmail.com"
  }
}