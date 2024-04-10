resource "cloudflare_ruleset" "http_request_firewall_custom" {
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  name    = "default"
  kind    = "zone"
  phase   = "http_request_firewall_custom"

  dynamic "rules" {
    for_each = local.rules

    content {
      action = rules.value.action
      dynamic "action_parameters" {
        for_each = rules.value.action_parameters[*]
        content {
          ruleset  = action_parameters.value.ruleset
          products = action_parameters.value.products
        }
      }
      description = rules.value.description
      enabled     = rules.value.enabled
      expression  = rules.value.expression
      dynamic "logging" {
        for_each = rules.value.logging[*]
        content {
          enabled = logging.value.enabled
        }
      }
    }
  }

}
