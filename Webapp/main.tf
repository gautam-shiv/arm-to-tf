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

resource "azurerm_app_service_plan" "mywebapp" {
  name                = "${toLower(var.projectName)}-${toLower(var.zone)}-${toLower(var.webSiteName)}-${toLower(var.environmentName)}-plan"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  sku {
    tier = var.skuname
    size = var.skusize
  }
}

resource "azurerm_app_service" "mywebservice" {
  name                = "${toLower(var.projectName)}-${toLower(var.zone)}-${toLower(var.webSiteName)}-${toLower(var.environmentName)}-app"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  app_service_plan_id = azurerm_app_service_plan.mywebapp.id

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = ""
  }

  tags = {
        "hidden-related: ${azurerm_app_service_plan.mywebapp.id}" = "empty"
        displayName                                               = "Website"
   }
}
