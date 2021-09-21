provider "cloudflare" {
  api_token = var.api_token
}

data "cloudflare_zones" "domain" {
  filter {
    name = var.domain
  }
}

resource "cloudflare_filter" "filters" {
  for_each = local.rules

  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")

  description = each.value.description
  expression  = each.value.expression
}

resource "cloudflare_firewall_rule" "rules" {
  for_each = local.rules

  zone_id   = lookup(data.cloudflare_zones.domain.zones[0], "id")
  filter_id = cloudflare_filter.filters[each.value.expression].id

  priority    = each.value.priority
  description = each.value.description
  paused      = each.value.paused
  action      = each.value.action
  products    = each.value.bypass
}
