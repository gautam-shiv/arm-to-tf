variable "projectName"{
  type        = string
  description = "Name for the project"
}

variable "environmentName"{
  type            = string
  description     = "Name for the environment"
  default         = "dev"
  validation {
    condition     = contains(["lab", "dev", "qa", "pro"], var.environmentName)
    error_message = "Argument \"environmentName\" must be either \"lab\", \"dev\", \"qa\" or \"pro\"."
  }
}

variable "location"{
  type        = string
  description = "Specifies the Azure location where the key vault should be created."
  default     = azurerm_resource_group.myrg.location
}

variable enabledForDeployment{
  type = bool
  default = false
  description = "Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  
}