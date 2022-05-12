locals {
  seperator      = "-"
  resource_types = ["resource_group", "app_service"]

  resource_group_names = [
    for resource in var.resources :
    merge(resource, {
      generated_name = resource.type == "resource_group" ? join(local.seperator, ["rg", var.project, var.environment, replace(resource.scope, "_", "-")]) : ""
    })
    if resource.type == "resource_group"
  ]

  app_services_names = [
    for resource in var.resources :
    merge(resource, {
      generated_name = resource.type == "app_service" ? trimsuffix(join(local.seperator, [var.org, var.project, var.environment, replace(resource.scope, "_", "-"), resource.name]), "-") : ""
    })
    if resource.type == "app_service"
  ]

  resources = concat(local.resource_group_names, local.app_services_names)

  outputs = {
    for scope in var.scopes :
    scope => {
      for type in local.resource_types : type => [
        for resource in local.resources :
        { resource.name == "" ? "main": resource.name : resource.generated_name}
        if resource.scope == scope && resource.type == type
      ]
    }
  }

}
