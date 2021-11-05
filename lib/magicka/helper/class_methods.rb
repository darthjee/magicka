# frozen_string_literal: true

module Magicka
  module Helper
    module ClassMethods
      def with(aggregator_class, type = aggregator_class.type)
        Sinclair.new(self).tap do |builder|
          builder.add_method("magicka_#{type}") do |model, &block|
            block.call(aggregator_class.new(self, model))
          end
        end.build
      end
    end
  end
end
