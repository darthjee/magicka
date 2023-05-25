# frozen_string_literal: true

module Magicka
  module Helper
    # @api private
    #
    # Options when generating {Helper} aggregator methods
    #
    # This is used when calling {Helper.with Helper.with}
    class AggregatorOptions < Sinclair::Options
      with_options :aggregator, :type, :config_block

      # @method config_block
      # @api private
      #
      # Block to be used when configuring a new aggregator class
      #
      # @return [Proc]

      # Returns the ready to use aggregator class
      #
      # @return [Class<Aggregator>]
      def configured_aggregator
        @configured_aggregator ||= configure_aggregator
      end

      # Type of the aggregator
      #
      # Type of aggregator will be used when defining the helper method
      #
      # @return [Symbol]
      def type
        @type ||= aggregator.type
      end

      private

      # @private
      # Configure the aggregator class by running {#config_block}
      #
      # @return [Class<Aggregator>]
      def configure_aggregator
        klass = aggregator_class
        return klass unless config_block

        klass.instance_eval(&config_block)
        klass
      end

      # @private
      # Return the aggregator class
      #
      # When aggregator class is defined as a String, this is then used to
      # return the correct class
      #
      # @return [Class<Aggregator>]
      def aggregator_class
        return aggregator if aggregator.is_a?(Class)

        aggregator.constantize
      end
    end
  end
end
