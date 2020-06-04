# Example: Setup Azure Dashboard and Alerts with Terraform
This is an example to show how Infrastructure as Code (IaC) can be used to create Azure Dashboards and Alerts.

The full example contains a azure pipeline definition so it can be executed as a pipeline in Azure DevOps. If used, a Service Connection in Azure DevOps needs to be created with the name **MySubscription**.

## Complete flow of execution
### azure-pipelines
1. Create Resource Group and Storage Account to save Terraform State file.
2. Install Terraform on build agent
3. Initialize Terraform with backend in Azure
4. Set some environment variables
5. Do Terraform Plan
6. Do Terraform Apply

### Terraform
1. Create an App Service and a SQL Database to have something to show in the Dashboard.
2. Create the Dashboard (more info below)
3. Create an Action Group that we be used to send Alerts to
4. Create an Alert (more info below)

## Dashboard
Terraform resource [azurerm_dashboard](https://www.terraform.io/docs/providers/azurerm/r/dashboard.html) is used to define a dashboard. Because the definition of a dashboard is done in json and can be rather large, a template file is used, *dashboard-template.tpl*, to store the dashboard definition.

Variables can be injected from the Terraform resource into the template file.
```
main.tf
resource "azurerm_dashboard" "dashboard" {
    ...
  dashboard_properties = templatefile("dashboard-template.tpl",
    {
      appservice_name  = azurerm_app_service.app_service.name
      ...
  })
}

dashboard-template.tpl
"metrics": [
    {
    "resourceMetadata": {
        "id": "${appservice_id}"
    },
    "name": "BytesReceived",
    "aggregationType": 1,
    "metricVisualization": {
        "displayName": "Data In",
        "resourceDisplayName": "${appservice_name}"
    }
    }
],
       
```
More information how the Dashboard Json in structured can be found here: [Programmatically create Azure Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards-create-programmatically).


## Alerts
Terraform resource [azurerm_monitor_metric_alert](https://www.terraform.io/docs/providers/azurerm/r/monitor_metric_alert.html) is used to define an alert.

TIP: Create the alert in the Azure Portal and export the ARM Template. Look into that template to find the right values that should be set in the Terraform resource.

Then create a monitor action group [azurerm_monitor_action_group](https://www.terraform.io/docs/providers/azurerm/r/monitor_action_group.html) where the definition how the alert, if triggered, should be broadcasted.
