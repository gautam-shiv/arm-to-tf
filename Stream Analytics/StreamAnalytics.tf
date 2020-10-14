provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name = "dd-test-sample-rg-pasv"
  location = "centralindia"
  tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_stream_analytics_job" "mytfsajob" {
  name                                     = "${toLower(var.projectname)}-${toLower(var.zone)}-${toLower(var.stream_analytics_name)}-${toLower(var.environmentName)}-asa"
  resource_group_name                      = azurerm_resource_group.myrg.name
  location                                 = azurerm_resource_group.myrg.location
  compatibility_level                      = "1.1"
  events_late_arrival_max_delay_in_seconds = 5
  events_out_of_order_max_delay_in_seconds = 0
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Stop"
  streaming_units                          = ${var.num_streaming_units}

  tags = {
    environment = "Terraform Demo"
  }

  transformation_query = <<QUERY
    ${var.stream_query}
QUERY

}

resource "azurerm_template_deployment" "mydeploy" {
  name                = "loopInput-0"
  resource_group_name = azurerm_resource_group.myrg.name

  template_body = <<DEPLOY
{
          "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
          "contentVersion": "1.0.0.0",
          "parameters": {},
          "variables": {},
          "resources": [],
          "outputs": {}
}
DEPLOY
  
  # these key-value pairs are passed into the ARM Template's `parameters` block
  deployment_mode = "Incremental"
}

resource "azurerm_template_deployment" "mydeploy" {
  name                = "${loopInput-copyIndex(1)}"
  resource_group_name = azurerm_resource_group.myrg.name

  template_body = <<DEPLOY
{
          "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
          "contentVersion": "1.0.0.0",
          "parameters": {},
          "variables": {},
          "resources": [
            {
              "name": "[concat(variables('streamAnalyticsJobName'), '/',parameters('streamAnalyticsInputs')[copyIndex()],'-controlling')]",
              "type": "Microsoft.StreamAnalytics/streamingjobs/inputs",
              "apiVersion": "2016-03-01",
              "properties": {
                "type": "Stream",
                "datasource": {
                  "type": "Microsoft.ServiceBus/EventHub",
                  "properties": {
                    "eventHubName": "controlling-request-eh",
                    "serviceBusNamespace": "[toLower(concat(parameters('projectName'), parameters('zone'), '-', parameters('streamAnalyticsInputs')[copyIndex()], '-', parameters('environmentName'), 'ehn'))]",
                    "sharedAccessPolicyName": "[variables('sharedAccessPolicyName')]",
                    "sharedAccessPolicykey": "default"
                  }
                },
                "serialization": {
                  "type": "Json",
                  "properties": {
                    "encoding": "UTF8"
                  }
                }
              }
            }
          ],
          "outputs": {}
}
DEPLOY
  
  # these key-value pairs are passed into the ARM Template's `parameters` block
  deployment_mode = "Incremental"
}
