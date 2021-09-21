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
  #     bypass      = []
  #   },
  #   {
  #     priority    = <priority>
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     bypass      = []
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
  #     bypass      = []
  #   },
  #   <expression> = {
  #     priority    = <priority>
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     bypass      = []
  #   },
  # }
  rules = { for i, v in var.rules : var.rules[i]["expression"] => v }
}
