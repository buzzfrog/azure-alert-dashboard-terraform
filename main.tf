provider "azurerm" {
    version = "=2.3.0"
    features {}
}

terraform {
    backend "azurerm" { }
}

data "azurerm_resource_group" "rg" {
    name = var.rg_name
}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "sql-server-${var.name}"
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = "12.0"
  # Never use this login and password in real code
  # It's only set in this example to make it easier to run
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = random_password.password.result
}

resource "azurerm_sql_database" "sql_database" {
  name                = "sql-${var.name}"
  resource_group_name = var.rg_name
  location            = var.rg_location
  server_name         = azurerm_sql_server.sql_server.name
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "appservice-plan-${var.name}"
  location            = var.rg_location
  resource_group_name = var.rg_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "appservice-${var.name}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.name

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}

data "azurerm_subscription" "subscription" {
}

resource "azurerm_dashboard" "dashboard" {
  name                = "${var.name}-dashboard"
  resource_group_name = var.rg_name
  location            = var.rg_location
  dashboard_properties = templatefile("dashboard-template.tpl",
    {
      title            = "${var.name} Dashboard"
      appservice_id    = "/subscriptions/${data.azurerm_subscription.subscription.subscription_id}/resourceGroups/${var.rg_name}/providers/Microsoft.Web/sites/${azurerm_app_service.app_service.name}"
      appservice_name  = azurerm_app_service.app_service.name
      sqldatabase_id   =  "/subscriptions/${data.azurerm_subscription.subscription.subscription_id}/resourceGroups/${var.rg_name}/providers/Microsoft.Sql/servers/${azurerm_sql_server.sql_server.name}/databases/${azurerm_sql_database.sql_database.name}"
      sqldatabase_name = azurerm_sql_database.sql_database.name
  })
}

data "azurerm_role_definition" "builtin" {
  name = "Owner"
}

resource "azurerm_monitor_action_group" "main" {
  name                = "actiongroup_send_email"
  resource_group_name = var.rg_name
  short_name          = "sendemail"

 arm_role_receiver {
    name                    = "armroleaction"
    role_id                 = split("/",data.azurerm_role_definition.builtin.id)[length(split("/",data.azurerm_role_definition.builtin.id))-1]
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_metric_alert" "alert_5xx_http" {
  name                = "alert_5xx_http"
  resource_group_name = var.rg_name
  scopes              = [azurerm_app_service.app_service.id]
  description         = "Alert when 5xx http errors occur"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 5

  dimension {
      name     = "Instance"
      operator = "Include"
      values   = ["*"]
    }
  }

  frequency = "PT1M"
  window_size = "PT5M"
  severity = 3

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}