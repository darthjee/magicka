# frozen_string_literal: true

module Magicka
  module Helper
    # Class methods for {Magicka::Helper}
    module ClassMethods
      # (see Magicka::Helper.with)
      def with(aggregator, type = nil, &block)
        options = AggregatorOptions.new(
          aggregator: aggregator,
          type: type,
          config_block: block
        )

        MethodBuilder.build(self, options) do
          build_aggregator
        end
      end
    end
  end
end
