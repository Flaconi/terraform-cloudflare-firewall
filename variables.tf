variable "api_token" {
  description = "The Cloudflare API token."
  type        = string
}

variable "domain" {
  description = "Cloudflare domain to apply rules for."
  type        = string
}

variable "rules" {
  description = "List of Cloudflare firewall rule objects."
  type = list(object({
    priority    = number
    description = string
    paused      = bool
    action      = string
    expression  = string
    bypass      = list(string)
  }))
  default = []

  # Ensure we specify only allows action values
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule#action
  validation {
    condition     = can([for rule in var.rules : contains(["block", "challenge", "allow", "js_challenge", "bypass", "log"], rule.action)])
    error_message = "Only the following action elements are allows: block, challenge, allow, js_challenge, bypass, log."
  }

  # Ensure we specify only allowed bypass values
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule#products
  validation {
    condition     = can([for rule in var.rules : [for product in rule.bypass : contains(["zoneLockdown", "uaBlock", "bic", "hot", "securityLevel", "rateLimit", "waf"], product)]])
    error_message = "Only the following bypass elements are allows: zoneLockdown, uaBlock, bic, hot, securityLevel, rateLimit, waf."
  }
}
