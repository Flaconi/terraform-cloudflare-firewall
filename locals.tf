locals {
  zone_id = lookup(data.cloudflare_zones.this.result[0], "id")
  rules = [for rule in var.rules :
    {
      action = rule.action
      action_parameters = rule.action == "skip" ? {
        ruleset  = length(rule.products) == 0 ? "current" : null
        products = length(rule.products) > 0 ? rule.products : null
      } : null
      description = rule.description
      enabled     = rule.enabled
      expression  = rule.expression
      logging = rule.action == "skip" ? {
        enabled = true
      } : null
    }
  ]
}
