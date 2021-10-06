# -------------------------------------------------------------------------------------------------
# Rule transformations
# -------------------------------------------------------------------------------------------------

locals {
  # Transforn from:
  #
  #
  # rules = [
  #   {
  #     priority    = <priority>
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     products    = []
  #   },
  #   {
  #     priority    = <priority>
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     products    = []
  #   },
  # ]
  #
  # Into the following format:
  #
  #
  # rules = {
  #   <expression> = {
  #     priority    = <priority>
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     products    = []
  #   },
  #   <expression> = {
  #     priority    = <priority>
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     products    = []
  #   },
  # }
  rules = { for i, v in var.rules : var.rules[i]["expression"] => v }
}
