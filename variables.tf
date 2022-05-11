variable "hostname_protocol" {
  default = "https"
  type    = string
  validation {
    condition     = var.hostname_protocol == "https" || var.hostname_protocol == "http"
    error_message = "Unsupport protocol."
  }
}

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
    condition     = var.attributes.type == "resource_group" || var.attributes.type == "app_service" || var.attributes.type == "app_service_plan"  || var.attributes.type == "mssql_server" || var.attributes.type == "storage_account"  || var.attributes.type == "log_analytics_workspace"  || var.attributes.type == "static"  || var.attributes.type == "static_app_service"  || var.attributes.type == "static_mssql_server"    
    error_message = "Unsupport resource types."
  }
}
