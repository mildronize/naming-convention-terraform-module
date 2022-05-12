locals {

  parsed_scope       = replace(var.attributes.scope, "_", "-")                                                          # For URL support
  parsed_scope_short = replace(replace(var.attributes.scope_short, "_", var.seperator_short), "-", var.seperator_short) # For URL support
  parsed_name        = replace(var.attributes.name, "_", "-")                                                           # For URL support
  org_with_project   = format("%s%s", var.attributes.org, var.attributes.project)
  
  resource_types = {
    static                  = local.parsed_name
    static_app_service      = local.parsed_name
    static_mssql_server     = local.parsed_name
    resource_group          = trimsuffix(join(var.seperator, ["rg", var.attributes.project, var.attributes.environment, local.parsed_scope]), var.seperator)
    app_service             = trimsuffix(join(var.seperator, [local.org_with_project, var.attributes.environment, local.parsed_scope, local.parsed_name]), var.seperator)
    app_service_plan        = trimsuffix(join(var.seperator, ["ap", var.attributes.project, var.attributes.environment, local.parsed_scope, local.parsed_name]), var.seperator)
    mssql_server            = trimsuffix(join(var.seperator, [local.org_with_project, var.attributes.environment, local.parsed_scope, local.parsed_name]), var.seperator)
    storage_account         = trimsuffix(join(var.seperator_short, [local.org_with_project, var.attributes.environment, local.parsed_scope_short, local.parsed_name]), var.seperator_short)
    log_analytics_workspace = trimsuffix(join(var.seperator, [local.org_with_project, "loganalyticsworkspace", var.attributes.environment, local.parsed_scope, local.parsed_name]), var.seperator_short)
  }

  hostnames = {
    app_service  = "${local.resource_types.app_service}.azurewebsites.net"
    mssql_server = "${local.resource_types.mssql_server}.database.windows.net"

    static_app_service  = "${local.resource_types.static_app_service}.azurewebsites.net"
    static_mssql_server = "${local.resource_types.static_mssql_server}.azurewebsites.net"
  }

  urls = {
    app_service        = "${var.hostname_protocol}://${local.hostnames.app_service}"
    static_app_service = "${var.hostname_protocol}://${local.hostnames.static_app_service}"
  }

  # Output 
  name             = lookup(local.resource_types, var.attributes.type, "something-wrong??")
  default_hostname = lookup(local.hostnames, var.attributes.type, "")
  url              = lookup(local.urls, var.attributes.type, "")
}
