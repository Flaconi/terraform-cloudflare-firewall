output "domain" {
  description = "Current zone information."
  value       = data.cloudflare_zones.domain.zones
}

output "rules" {
  description = "Created Cloudflare rules for the current zone."
  value       = cloudflare_ruleset.http_request_firewall_custom.rules
}
