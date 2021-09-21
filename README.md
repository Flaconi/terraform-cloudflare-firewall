# Terraform module: Cloudflare Firewall rules

This Terraform module manages Cloudflare Firewall rules to its full extend (even for Enterprise customers).


## Behaviour

When deleting Cloudflare firewall rules and recreating them with the same expression, Terraform is too fast for the Cloudflare API and will fail with an error, that the rule already exists.

To overcome this limitation, all rules in this module are indexed by their corresponding firewall expression (see [locals.tf](locals.tf)). Firewall expressions must be unique in Cloudflare anyway, so the index will never duplicate.
This also means that whenever the expression changes, the rule will be recreated. Changes in all other values will not trigger a recreated.
