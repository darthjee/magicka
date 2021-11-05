# frozen_string_literal: true

module Magicka
  # Helper module to be used on rails
  module Helper
    class << self
      def with(aggregator_class, type = aggregator_class.type)
        Sinclair.new(self).tap do |builder|
          builder.add_method("magicka_#{type}") do |model, &block|
            block.call(aggregator_class.new(self, model))
          end
        end.build
      end
    end

    with Form
    with Display
  end
end
