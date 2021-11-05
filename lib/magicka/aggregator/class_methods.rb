# frozen_string_literal: true

module Magicka
  class Aggregator
    # Class methods for {Magicka::Aggregator}
    module ClassMethods
      # (see Aggregator.with_element)
      def with_element(element_class, method_name = nil, template: nil)
        MethodBuilder
          .new(self, element_class, method_name, template: template)
          .prepare
          .build
      end

      # Set and return the type of the aggregator
      #
      # When new_type is ommited, returns the last value
      #
      # @param new_type [Symbol,String] The value to be set
      #
      # @return [Symbol] the type of the aggregator
      def type(new_type = nil)
        return @type ||= default_type unless new_type

        @type = new_type.to_sym
      end

      private

      # @private
      # @api private
      #
      # Default type when type is not defined
      #
      # Default type is extracted from class name
      #
      # @return [Symbol]
      def default_type
        name&.demodulize&.underscore&.to_sym
      end
    end
  end
end
