# -------------------------------------------------------------------------------------------------
# Rule transformations
# -------------------------------------------------------------------------------------------------

locals {
  # Transforn from:
  #
  #
  # rules = [
  #   {
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     products    = []
  #   },
  #   {
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
  #     priority    = <auto-calculated>
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     products    = []
  #   },
  #   <expression> = {
  #     priority    = <auto-calculated>
  #     description = <description>
  #     paused      = <paused>
  #     action      = <action>
  #     expression  = <expression>
  #     products    = []
  #   },
  # }
  rules = { for idx, item in var.rules : var.rules[idx]["expression"] => merge(
    item,
    {
      priority = idx + 1
    }
    )
  }
}
