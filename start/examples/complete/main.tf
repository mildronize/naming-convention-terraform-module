# Azure Provider configuration
provider "azurerm" {
  features {}
}

locals {
  common_resource_attributes = {
    org         = "thadaw"
    project     = "demo"
    environment = "prod"
    scope_short = "cat"
    scope       = "super_cat"
  }
  resource_names = {
    super_cat_api = {
      name = "api"
      type = "app_service"

    }
    super_cat = {
      name = ""
      type = "resource_group"
    }
  }

}

module "naming_convention" {
  source     = "../../"
  for_each   = tomap(local.resource_names)
  attributes = merge(local.common_resource_attributes, each.value)
}


output "output" {
  value = module.naming_convention
}

output "usage" {
  value = module.naming_convention["super_cat_api"].name
}