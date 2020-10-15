provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name     = "dd-test-sample-rg-pasv"
  location = "centralindia"
  tags     = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_eventhub" "example" {
  name                = "acceptanceTestEventHub"
  namespace_name      = azurerm_eventhub_namespace.example.name
  resource_group_name = azurerm_resource_group.example.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub" "example" {
  name                = "${toLower(var.projectName)}-{toLower(var.zone)}-{toLower(var.environmentName)}-ehc"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  sku                 = "Dedicated"
  capacity            = 1
}