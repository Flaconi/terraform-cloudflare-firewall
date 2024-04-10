data "cloudflare_zones" "domain" {
  filter {
    name = var.domain
  }
}
