# frozen_string_literal: true

module Magicka
  module Helper
    # @api private
    #
    # Builds methods for {Magicka::Helper}
    class MethodBuilder < Sinclair
      # (see Magicka::Helper.with)
      def build_aggregator
        opts = options

        add_method("magicka_#{opts.type}") do |model, &block|
          block.call(opts.built_aggregator_class.new(self, model))
        end
      end
    end
  end
end
