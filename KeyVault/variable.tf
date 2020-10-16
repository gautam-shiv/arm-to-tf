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
  default     = "centralindia"
}

variable "enabledForDeployment"{
  type            = bool
  default         = false
  description     = "Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  validation {
    condition     = contains([true, false], var.enabledForDeployment)
    error_message = "Argument \"enabledForDeployment\" must be either \"true\", or \"false\"."
  }
}

variable "enabledForDiskEncryption"{
  type            = bool
  description     = "Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default         = false
  validation {
    condition     = contains([true, false], var.enabledForDiskEncryption)
    error_message = "Argument \"enabledForDeployment\" must be either \"true\", or \"false\"."
  }
}

variable "enabledForTemplateDeployment"{
  type            = bool
  description     = "Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  default         = false
  validation {
    condition     = contains([true, false], var.enabledForTemplateDeployment)
    error_message = "Argument \"enabledForDeployment\" must be either \"true\", or \"false\"."
  }
}

variable "tenantId"{
  type        = string
  description = "Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet."
}

variable "objectId"{
  type        = string
  description = "Specifies the object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. Get it by using Get-AzADUser or Get-AzADServicePrincipal cmdlets."
}

variable "keysPermissions"{
  type        = list(string)
  description = "Specifies the permissions to keys in the vault. Valid values are: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover, and purge."
  default     = ["List"]
}

variable "secretsPermissions"{
  type        = list(string)
  description = "Specifies the permissions to secrets in the vault. Valid values are: all, get, list, set, delete, backup, restore, recover, and purge."
  default     = ["List"]
}

variable "skuName"{
  type            = string
  default         = "standard"
  description     = "Specifies whether the key vault is a standard vault or a premium vault."
  validation {
    condition     = contains(["standard", "premium"], var.skuName)
    error_message = "Argument \"enabledForDeployment\" must be either \"Standard\", or \"Premium\"."
  }
}

variable "zone"{
  type        = string
  default     = ""
  description = "Describes the performance level for Edition"
}

