resource "cloudflare_ruleset" "http_request_firewall_custom" {
  zone_id = local.zone_id
  name    = "default"
  kind    = "zone"
  phase   = "http_request_firewall_custom"

  rules = local.rules
}
