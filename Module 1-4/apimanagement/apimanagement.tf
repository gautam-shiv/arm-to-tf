resource "azurerm_api_management" "myapim" {
    name                = "${lower(var.projectname)}${lower(var.zone)}-${lower(var.environmentName)}apim"
    location            = var.rglocation
    resource_group_name = var.rgname
    sku_name            = var.skuname
    publisher_name      = var.pubname
    publisher_email     = var.pubmail
}