# frozen_string_literal: true

module Magicka
  module Helper
    # @api private
    #
    # Builds methods for {Magicka::Helper}
    class MethodBuilder < Sinclair
      # Build aggregator helper method
      #
      # @return [Array<MethodDefinition>]
      def build_aggregator
        opts = options

        add_method("magicka_#{opts.type}") do |model, &block|
          block.call(opts.configured_aggregator.new(self, model))
        end
      end
    end
  end
end
