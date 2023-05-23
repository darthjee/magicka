# frozen_string_literal: true

module Magicka
  module Helper
    # Builds methods for {Magicka::Helper}
    class MethodBuilder < Sinclair
      def initialize(klass, aggregator_class, type = aggregator_class.type)
        @aggregator_class = aggregator_class
        @type             = type

        super(klass)
      end

      # (see Magicka::Helper.with)
      def build_aggregator
        builder = self

        add_method("magicka_#{type}") do |model, &block|
          block.call(builder.aggregator_class.new(self, model))
        end
      end

      attr_reader :aggregator_class, :type
    end
  end
end
