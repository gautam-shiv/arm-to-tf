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
  description = "Specifies the Azure location for all resources."
  default     = "centralindia"
}

variable "zone"{
  type        = string
  default     = ""
  description = "Describes the performance level for Edition"
}

