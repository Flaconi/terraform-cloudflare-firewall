variable "domain" {
  description = "Cloudflare domain to apply rules for."
  type        = string
}

variable "rules" {
  description = "List of Cloudflare firewall rule objects."
  type = list(object({
    description = string
    enabled     = bool
    action      = string
    expression  = string
    products    = list(string)
  }))
  default = []

  # Ensure we specify only allows action values
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule#action
  validation {
    condition     = can([for rule in var.rules : contains(["block", "challenge", "js_challenge", "log", "managed_challenge", "skip"], rule.action)])
    error_message = "Only the following action elements are allowed: block, challenge, js_challenge, log, managed_challenge, skip."
  }

  # Ensure we specify only allowed products values
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule#products
  validation {
    condition     = can([for rule in var.rules : [for product in rule.products : contains(["bic", "hot", "ratelimit", "securityLevel", "uablock", "waf", "zonelockdown"], product)]])
    error_message = "Only the following product elements are allowed: bic, hot, ratelimit, securityLevel, uablock, waf, zonelockdown."
  }
}
