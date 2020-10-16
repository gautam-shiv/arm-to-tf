variable "projectName"{
  type        = string
  description = "Name for the project"
}

variable "domainName"{
    type        = string
    description = "Name for the domain"
}

variable "zone"{
  type        = string
  default     = ""
  description = "Describes the performance level for Edition"
}

variable "location"{
  type        = string
  description = "Specifies the Azure location for all the resources."
  default     = "centralindia"
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

variable "storageAccountType" {
  type         =  string
  description  =  "Storage Account type"
  default      =  "Standard_LRS"

  validation {
    condition     = contains(["Standard_LRS", "Standard_GRS", "Standard_RAGRS"], var.storageAccountType)
    error_message = "Argument \"storageAccountType\" must be either \"Standard_LRS\", \"Standard_GRS\"or \"Standard_RAGRS\"."
  }
}

variable "endpointSuffix"{
  type        = string
  default     = ""
  description = "Defaults to Azure (core.windows.net). Override this to use the China cloud (core.chinacloudapi.cn)."
  validation {
    condition     = contains([ "", ";EndpointSuffix=core.chinacloudapi.cn" ], var.endpointSuffix)
    error_message = "Argument \"endpointSuffix\" must be either empty string, or \";EndpointSuffix=core.chinacloudapi.cn\"."
  }
}

variable "runtime"{
  type            = string
  default         = "dotnet"
  description     = "The language worker runtime to load in the function app."
  validation {
    condition     = contains(["node", "dotnet", "java"], var.runtime)
    error_message = "Argument \"runtime\" must be either \"node\", \"dotnet\"or \"java\"."
  }
}
