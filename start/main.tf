locals {

  parsed_scope       = replace(var.attributes.scope, "_", "-")                                                          # For URL support
  parsed_name        = replace(var.attributes.name, "_", "-")                                                           # For URL support
  org_with_project   = format("%s%s", var.attributes.org, var.attributes.project)

  resource_types = {
    resource_group = trimsuffix(join(var.seperator, ["rg", var.attributes.project, var.attributes.environment, local.parsed_scope]), var.seperator)
    app_service    = trimsuffix(join(var.seperator, [local.org_with_project, var.attributes.environment, local.parsed_scope, local.parsed_name]), var.seperator)
  }

  # Output 
  name = lookup(local.resource_types, var.attributes.type, "something-wrong??")
}
