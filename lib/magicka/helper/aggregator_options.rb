# frozen_string_literal: true

module Magicka
  module Helper
    # @api private
    #
    # Options when generating {Helper} aggregator methods
    #
    # This is used when calling {Helper.with Helper.with}
    class AggregatorOptions < Sinclair::Options
      with_options :aggregator_class, :type, :config_block

      def built_aggregator_class
        @built_aggregator_class ||= build_aggregator_class
      end

      def type
        @type ||= aggregator_class.type
      end

      private

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
