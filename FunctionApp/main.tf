provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "random_uuid" "test" { }

resource "azurerm_resource_group" "myrg" {
  name     = "dd-test-sample-rg-pasv"
  location = "centralindia"
#   id       = "${random_uuid.test.result}-rg-pasv"
  tags     = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_storage_account" "dd-fa-sa" {
  name                     = "st-${lower(var.zone)}-${azurerm_resource_group.myrg.id}-${lower(var.environmentName)}-fa-sa"
  resource_group_name      = azurerm_resource_group.myrg.name
  location                 = azurerm_resource_group.myrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "dd-fa-asp" {
  name                = "azure-functions-test-service-plan"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "dd-fa" {
  name                       = "${lower(var.projectName)}-${lower(var.zone)}-${lower(var.domainName)}-${lower(var.environmentName)}-fa"
  location                   = azurerm_resource_group.myrg.location
  resource_group_name        = azurerm_resource_group.myrg.name
  app_service_plan_id        = azurerm_app_service_plan.dd-fa-asp.id
  storage_account_name       = azurerm_storage_account.dd-fa-sa.name
  storage_account_access_key = azurerm_storage_account.dd-fa-sa.primary_access_key
}