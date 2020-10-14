variable "projectname" {
  type         =  string
  description  =  "Name for the project"
}

variable "zone" {
  type         =  string
  description  =  "Describes the performance level for Edition"
}

variable "environmentName" {
  type         =  string
  description  =  "Name for the environment"

  validation {
    condition     = contains(["lab", "dev", "pro", "qa"], var.environmentName)
    error_message = "Argument \"environmentName\" must be either \"lab\", \"dev\", \"qa\" or \"pro\"."
  }
}

variable "account_replication_type" {
  type         =  string
  description  =  "Name for the environment"
  default      =  "Standard_LRS"

  validation {
    condition     = contains(["Standard_LRS", "Standard_GRS", "Standard_RAGRS"], var.account_replication_type)
    error_message = "Argument \"account_replication_type\" must be either \"Standard_LRS\", \"Standard_GRS\"or \"Standard_RAGRS\"."
  }
}

variable "admin_name" {
  type         =  string
  description  =  "Username for the Virtual Machine."
}

variable "admin_password" {
  type         =  securestring
  description  =  "Password for the Virtual Machine

  validation {
    condition     = length(var.admin_password) > 11
    error_message = "Password should have at least 12 characters"
  }
}

variable "dnslabelprefix" {
  type         =  string
  description  =  "Unique DNS Name for the Public IP used to access the Virtual Machine"
  default      =  "${toLower(var.vmName)}-${toLower{uniqueString(azurerm_resource_group.myrg.id, var.vmName)}"
}

variable "publicip_sku" {
  type         =  string
  description  =  "SKU for the Public IP used to access the Virtual Machine"
  default      =  "Basic"

  validation {
    condition     = contains(["Basic", "Standard"], var.publicip_sku)
    error_message = "Argument \"publicip_sku\" must be either \"Basic\" or \"Standard\"."
  }
}

variable "public_allocation_method" {
  type         =  string
  description  =  "SKU for the Public IP used to access the Virtual Machine"
  default      =  "Dynamic"

  validation {
    condition     = contains(["Dynamic", "Static"], var.public_allocation_method)
    error_message = "Argument \"public_allocation_method\" must be either \"Dynamic\" or \"Static\"."
  }
}

variable "vmname" {
  type         =  string
  description  =  "Name of the virtual machine."
  default      =  "simplevm"
}

variable "vm_size" {
  type         =  string
  description  =  "Size of the virtual machine."
  default      =  "Standard_D2_v3"
}

variable "os_disk_type" {
  type         =  string
  description  =  "Disk sku name"
  default      =  "Standard_LRS"

  validation {
    condition     = contains([ "Standard_LRS", "Premium_LRS", "StandardSSD_LRS", "UltraSSD_LRS" ], var.os_disk_type)
    error_message = "Argument \"os_disk_type\" must be either \"Standard_LRS\", \"Premium_LRS\", \"StandardSSD_LRS\" or \"UltraSSD_LRS\"."
  }
}

variable "os_version" {
  type         =  string
  description  =  "The Windows version for the VM. This will pick a fully patched image of this given Windows version."
  default      =  "2019-Datacenter"

  validation {
    condition  = contains([ 
        "2008-R2-SP1",
        "2012-Datacenter",
        "2012-R2-Datacenter",
        "2016-Nano-Server",
        "2016-Datacenter-with-Containers",
        "2016-Datacenter",
        "2019-Datacenter",
        "2019-Datacenter-Core",
        "2019-Datacenter-Core-smalldisk",
        "2019-Datacenter-Core-with-Containers",
        "2019-Datacenter-Core-with-Containers-smalldisk",
        "2019-Datacenter-smalldisk",
        "2019-Datacenter-with-Containers",
        "2019-Datacenter-with-Containers-smalldisk"], var.os_version)
    error_message = "Argument \"os_version\" must be either \"2008-R2-SP1\", \"2012-Datacenter\", \"2012-R2-Datacenter\"or \"2016-Nano-Server\"."
  }
}
