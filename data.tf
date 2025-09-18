data "cloudflare_zones" "this" {
  name = var.domain
}
