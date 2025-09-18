variable "token" {
  description = "Cloudflare API token"
  type        = string
}

provider "cloudflare" {
  api_token = var.token
}
module "example" {
  source = "../../"

  domain = "example.com"
  rules = [
    {
      description = "Test (WAF Bypass)"
      action      = "bypass"
      expression  = "(http.user_agent contains \"UA-TEST/\" and ip.src eq 1.2.3.4 and http.request.uri.path eq \"/api/endpoint\")"
      products    = ["waf"]
    },
  ]
}

output "rules" {
  value = module.example.rules
}
