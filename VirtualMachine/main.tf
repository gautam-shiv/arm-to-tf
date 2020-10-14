provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name     = "dd-test-sample-rg-pasv"
  location = "centralindia"
  
  tags {
        environment = "Terraform Demo"
    }
}

# create storage account
resource "azurerm_storage_account" "mytfstorage" {
    name                            = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-st"
    resource_group_name             = azurerm_resource_group.myrg.name
    location                        = azurerm_resource_group.myrg.location
    account_replication_type        = "${var.account_replication_type}"
    account_tier                    = "Standard"
    account_kind                    = "Storage"

    tags {
        environment = "Terraform Demo"
    }
}

# create Public_IP_address
resource "azurerm_public_ip" "tfpublicip" {
    name                         = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-snet"
    location                     = azurerm_resource_group.myrg.location
    resource_group_name          = azurerm_resource_group.myrg.name
    sku_name                     = ${var.publicip_sku}
    public_ip_address_allocation = ${var.public_allocation_method}
}

# create NSG
resource "azurerm_network_security_group" "mytfnsg" {
    name                = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-nsg"
    location            = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name

    security_rule {
        name                       = "default-allow-3389"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags {
        environment = "Terraform Demo"
    }
}

# create a virtual network
resource "azurerm_virtual_network" "mytfvnet" {
    name                = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name

    depends_on = [azurerm_network_security_group.mynsg.id]
}

# create subnet
resource "azurerm_subnet" "mytfsubnet" {
    name                 = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-snet"
    resource_group_name  = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_resource_group.myrg.location
    address_prefix       = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "mytfnic" {
    name                      = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-nic"
    location                  = azurerm_resource_group.myrg.location
    resource_group_name       = azurerm_resource_group.myrg.name

    ip_configuration {
        name                          = "ipconfig1"
        subnet_id                     = azurerm_subnet.mytfsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.tfpublicip.id
    }

    tags {
        environment = "Terraform Demo"
    }

    depends_on = [azurerm_public_ip.tfpublicip.id, azurerm_virtual_network.mytfvnet.id]
}

# create virtual machine
resource "azurerm_virtual_machine" "myvm" {

 #for_each = { for each_vm in "${var.vm_details_mapping}" : each_vm["name"] => each_vm }
  location              = azurerm_resource_group.myrg.location
  name                  = "${toLower(var.projectname)}-${toLower(var.zone)}-${var.environmentName}-vm"
  network_interface_id  = azurerm_network_interface.mytfnic.id
  resource_group_name   = azurerm_resource_group.myrg.name
  vm_size               = "${var.vm_size}"

  storage_image_reference {
        publisher       = "MicrosoftWindowsServer"
        offer           = "WindowsServer"
        sku             = ${var.os_version}
        version         = "latest"
    }

    storage_os_disk {
        name              = "myosdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = ${var.os_disk_type}
    }

    os_profile {
        computer_name  =   ${var.vmname}
        admin_username =  ${var.admin_name}
        admin_password =  ${var.admin_password}
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mytfstorage.id.primaryEndpoints.blob
    }

    tags {
        environment = "Terraform Demo"
    }

    depends_on      = [azurerm_storage_account.mytfstorage.id, azurerm_network_interface.mytfnic.id]
}
