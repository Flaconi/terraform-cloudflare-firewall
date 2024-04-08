# https://github.com/cloudflare/terraform-provider-cloudflare
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.29.0"
    }
  }
  required_version = ">= 1.5"
}
