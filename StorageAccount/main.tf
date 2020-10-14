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

# create storage account
resource "azurerm_storage_account" "mytfstorage" {
    name                     = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-st"
    resource_group_name      = azurerm_resource_group.myrg.name
    location                 = azurerm_resource_group.myrg.location
    account_type             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "${var.account_replication_type}"
    access_tier              = "Hot"

    tags {
        environment = "Terraform Demo"
    }

}

# create storage container
resource "azurerm_storage_container" "mytfstcontainer" {
    name                     = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-default-${var.container_name}"
    container_access_type    = "private"

    tags {
        environment = "Terraform Demo"
    }

    depends_on               = [azurerm_storage_account.mytfstorage.id]
}

# create key vault
resource "azurerm_key_vault_secret" "mykeyvault" {
    name                     = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-default-${var.container_name}"
    value                    =

    depends_on               = [azurerm_storage_account.mytfstorage.id]
}