# Complete

```terraform
module "name_super_cat_resource_group" {
  source = "../../"
  attributes = {
    name        = ""
    type        = "resource_group"
    org         = "thadaw"
    project     = "demo"
    environment = "prod"
    scope       = "super_cat"
    scope_short = "cat"
  }
}

module "name_super_cat_app_service" {
  source   = "../../"
  for_each = toset(["", "api", "api_staging"])
  attributes = {
    name        = each.key
    type        = "app_service"
    org         = "thadaw"
    project     = "demo"
    environment = "prod"
    scope       = "super_cat"
    scope_short = "cat"
  }
}
```
