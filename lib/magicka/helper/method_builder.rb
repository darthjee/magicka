# frozen_string_literal: true

module Magicka
  module Helper
    # Builds methods for {Magicka::Helper}
    class MethodBuilder < Sinclair
      def initialize(klass, aggregator_class, type = nil)
        @aggregator_class = aggregator_class
        @type             = type || aggregator_class.type

        super(klass)
      end

      # (see Magicka::Helper.with)
      def build_aggregator
        builder = self

        add_method("magicka_#{type}") do |model, &block|
          block.call(builder.aggregator_class.new(self, model))
        end
      end

      def aggregator_class
        return @aggregator_class if @aggregator_class.is_a?(Class)

        @aggregator_class = @aggregator_class.constantize
      end

      attr_reader :type
    end
  end
end
