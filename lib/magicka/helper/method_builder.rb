# frozen_string_literal: true

module Magicka
  module Helper
    class MethodBuilder < Sinclair
      def build_aggregator(aggregator_class, type = aggregator_class.type)
        add_method("magicka_#{type}") do |model, &block|
          block.call(aggregator_class.new(self, model))
        end

        build
      end
    end
  end
end
