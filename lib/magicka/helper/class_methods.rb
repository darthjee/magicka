# frozen_string_literal: true

module Magicka
  module Helper
    # Class methods for {Magicka::Helper}
    module ClassMethods
      # (see Magicka::Helper.with)
      def with(aggregator_class, type = aggregator_class.type)
        MethodBuilder.build(self, aggregator_class, type) do
          build_aggregator
        end
      end
    end
  end
end
