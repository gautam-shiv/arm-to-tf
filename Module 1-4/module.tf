provider "azurerm" {
    version = "~>2.0"
    features {}
}

resource "azurerm_resource_group" "myrg" {
    name     = "myrg01"
    location = "centralindia"
}

module "APImanagement" {
    source = "./apimanagement"
    rgname = azurerm_resource_group.myrg.name
    rglocation = azurerm_resource_group.myrg.location
}

module "AppInsight" {
    source = "./appinsights"
    rgname = azurerm_resource_group.myrg.name
    rglocation = azurerm_resource_group.myrg.location
}

module "AppServicePlan" {
    source = "./appserviceplan"
    rgname = azurerm_resource_group.myrg.name
    rglocation = azurerm_resource_group.myrg.location
}

module "SQLserver" {
    source = "./database"
    rgname = azurerm_resource_group.myrg.name
    rglocation = azurerm_resource_group.myrg.location
}
