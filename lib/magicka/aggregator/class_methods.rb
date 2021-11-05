# frozen_string_literal: true

module Magicka
  class Aggregator
    # Class methods for {Magicka::Aggregator}
    module ClassMethods

      # Configure an {Aggregator} adding a method to render an element
      #
      # @param element_class [Class<Magicka::ELement>]
      #   Class of the element to be rendered
      # @param method_name [String,Symbol]
      #   Name of the method that will render the element
      # @param template [String] custom template file to be used
      def with_element(element_class, method_name = nil, template: nil)
        MethodBuilder
          .new(self, element_class, method_name, template: template)
          .prepare
          .build
      end

      # Set and return the type of the aggregator
      def type(*args)
        return @type ||= default_type if args.empty?

        @type = args.first.to_sym
      end

      private

      def default_type
        name&.demodulize&.underscore&.to_sym
      end
    end
  end
end
