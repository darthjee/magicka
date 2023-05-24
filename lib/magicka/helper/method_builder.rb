# frozen_string_literal: true

module Magicka
  module Helper
    # @api private
    #
    # Builds methods for {Magicka::Helper}
    class MethodBuilder < Sinclair
      def initialize(klass, aggregator_class, type = nil, config_block = nil)
        @aggregator_class = aggregator_class
        @type             = type
        @config_block     = config_block

        super(klass)
      end

      # (see Magicka::Helper.with)
      def build_aggregator
        builder = self

        add_method("magicka_#{type}") do |model, &block|
          block.call(builder.built_aggregator_class.new(self, model))
        end
      end

      def built_aggregator_class
        @built_aggregator_class ||= build_aggregator_class
      end

      private

      attr_reader :config_block

      def type
        @type || @aggregator_class.type
      end

      def build_aggregator_class
        return aggregator_class unless config_block

        aggregator_class.instance_eval(&config_block)
        aggregator_class
      end

      def aggregator_class
        return @aggregator_class if @aggregator_class.is_a?(Class)

        @aggregator_class = @aggregator_class.constantize
      end
    end
  end
end
