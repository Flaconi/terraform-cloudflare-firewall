# https://github.com/cloudflare/terraform-provider-cloudflare
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.1.0"
    }
  }
  required_version = ">= 0.13"
}
