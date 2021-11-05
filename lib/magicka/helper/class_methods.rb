# frozen_string_literal: true

module Magicka
  module Helper
    module ClassMethods
      def with(aggregator_class, type = aggregator_class.type)
        MethodBuilder.new(self).build_aggregator(aggregator_class, type)
      end
    end
  end
end
