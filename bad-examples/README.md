# Bad Example

## Expected Input

```
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
```

## Define Expected Output

```
outputs = {
  customer_a = {
    resource_group = { main = "rg-demo-prod-customer-a" }
    app_service = {
      main = "thadawdemo-prod-customer-a"
      api  = "thadawdemo-prod-customer-a-api"
    }
  }
  customer_b = {
    app_service = {
      api = "thadawdemo-prod-customer-b-api"
    }
  }
}
```