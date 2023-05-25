# frozen_string_literal: true

module Magicka
  module Helper
    # Class methods for {Magicka::Helper}
    module ClassMethods
      # (see Magicka::Helper.with)
      def with(aggregator_class, type = nil, &block)
        options = AggregatorOptions.new({
          aggregator_class: aggregator_class,
          type: type,
          config_block: block
        })

        MethodBuilder.build(self, options) do
          build_aggregator
        end
      end
    end
  end
end
