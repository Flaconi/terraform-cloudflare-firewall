# Terraform module: Cloudflare Firewall rules

[![lint](https://github.com/flaconi/terraform-cloudflare-firewall/workflows/lint/badge.svg)](https://github.com/flaconi/terraform-cloudflare-firewall/actions?query=workflow%3Alint)
[![test](https://github.com/flaconi/terraform-cloudflare-firewall/workflows/test/badge.svg)](https://github.com/flaconi/terraform-cloudflare-firewall/actions?query=workflow%3Atest)
[![Tag](https://img.shields.io/github/tag/flaconi/terraform-cloudflare-firewall.svg)](https://github.com/flaconi/terraform-cloudflare-firewall/releases)
[![Terraform](https://img.shields.io/badge/Terraform--registry-cloudflare--firewall-brightgreen.svg)](https://registry.terraform.io/modules/flaconi/firewall/cloudflare/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

This Terraform module manages Cloudflare Firewall rules to its full extend (even for Enterprise customers).


## Behaviour

When deleting Cloudflare firewall rules and recreating them with the same expression, Terraform is too fast for the Cloudflare API and will fail with an error, that the rule already exists.

To overcome this limitation, all rules in this module are indexed by their corresponding firewall expression (see [locals.tf](locals.tf)). Firewall expressions must be unique in Cloudflare anyway, so the index will never duplicate.
This also means that whenever the expression changes, the rule will be recreated. Changes in all other values will not trigger a recreated.


## Example

`terraform.tfvars`:
```hcl
domain = "domain.tld"

rules = [
  {
    priority    = 1
    description = "Test (WAF Bypass)"
    paused      = false
    action      = "bypass"
    expression  = "(http.user_agent contains \"UA-TEST/\" and ip.src eq 1.2.3.4 and http.request.uri.path eq \"/api/endpoint\")"
    bypass      = ["waf"]
  },
  {
    priority    = 2
    description = "Test"
    paused      = false
    action      = "allow"
    expression  = "(http.user_agent contains \"UA-TEST1\" and ip.src eq 1.2.3.4 and http.request.uri.path eq \"/api/endpoint\")"
    bypass      = []
  },
]
```


<!-- TFDOCS_INPUTS_START -->
## Required Inputs

The following input variables are required:

### api\_token

Description: The Cloudflare API token.

Type: `string`

### domain

Description: Cloudflare domain to apply rules for.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### rules

Description: List of Cloudflare firewall rule objects.

Type:

```hcl
list(object({
    priority    = number
    description = string
    paused      = bool
    action      = string
    expression  = string
    bypass      = list(string)
  }))
```

Default: `[]`

<!-- TFDOCS_INPUTS_END -->

<!-- TFDOCS_OUTPUTS_START -->
## Outputs

| Name | Description |
|------|-------------|
| domain | Current zone information. |
| filters | Created Cloudflare filters for the current zone. |
| rules | Created Cloudflare rules for the current zone. |

<!-- TFDOCS_OUTPUTS_END -->


## License

**[MIT License](LICENSE)**

Copyright (c) 2021 **[flaconi](https://github.com/flaconi)**
