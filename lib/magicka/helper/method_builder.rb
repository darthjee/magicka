# frozen_string_literal: true

module Magicka
  module Helper
    # Builds methods for {Magicka::Helper}
    class MethodBuilder < Sinclair
      # (see Magicka::Helper.with)
      def build_aggregator(aggregator_class, type = aggregator_class.type)
        add_method("magicka_#{type}") do |model, &block|
          block.call(aggregator_class.new(self, model))
        end

        build
      end
    end
  end
end
