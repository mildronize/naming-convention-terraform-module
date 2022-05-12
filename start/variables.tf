variable "seperator" {
  default = "-"
}

variable "seperator_short" {
  default = ""
}

# Multiple Validation: https://learn.hashicorp.com/tutorials/terraform/variables#validate-variables

variable "attributes" {
  type = object({
    name        = string
    type        = string
    org         = string
    project     = string
    environment = string
    scope       = string
    scope_short = string
  })
  validation {
    condition     = var.attributes.type == "resource_group" || var.attributes.type == "app_service"
    error_message = "Unsupport resource types."
  }
}
