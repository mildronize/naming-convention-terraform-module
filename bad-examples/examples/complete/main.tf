

module "bad_naming_convention" {
  source      = "../../"
  project     = "demo"
  org         = "thadaw"
  environment = "prod"
  scopes      = ["customer_a", "customer_b"]
  resources = [
    { type = "resource_group", scope = "customer_a", name = "" },
    { type = "app_service", scope = "customer_a", name = "" },
    { type = "app_service", scope = "customer_a", name = "api" },
    { type = "app_service", scope = "customer_b", name = "api" },
  ]
}

output "name" {
  value = module.bad_naming_convention.name
}

output "customer_a_main" {
  value = module.bad_naming_convention.name.customer_a.app_service[0].main
}