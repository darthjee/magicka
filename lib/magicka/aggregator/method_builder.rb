# frozen_string_literal: true

module Magicka
  class Aggregator
    # @api private
    #
    # Class responsible for building an {Aggregator} method
    class MethodBuilder < Sinclair
      # @overload initialize(klass, element_class, method_name = nil, template: nil)
      #   @param element_class [Class<Magicka::Element>]
      #     Class of the element to be rendered
      #   @param klass [Class<Aggregator>]
      #     Aggragator class to receive the method
      #   @param method_name [String,Symbol]
      #     Name of the method that will render the element
      #   @param template [String] custom template file to be used
      #
      # @overload initialize(klass, element_class_name, method_name = nil, template: nil)
      #   @param element_class_name [String]
      #     String name of Class of the element to be rendered
      #   @param klass [Class<Aggregator>]
      #     Aggragator class to receive the method
      #   @param method_name [String,Symbol]
      #     Name of the method that will render the element
      #   @param template [String] custom template file to be used
      def initialize(klass, element_class, method_name = nil, template: nil)
        super(klass)

        @element_class = element_class
        @method_name = method_name
        @template = template
      end

      # Prepare methods to be built
      #
      # @return [Aggregator::MethodBuilder] return self
      def prepare
        tap do |builder|
          add_method(method_name) do |field, model: self.model, **args|
            builder.element_class.render(
              renderer: renderer, field: field,
              model: model, template: builder.template,
              **args
            )
          end
        end
      end

      # Class of the element to be rendered by the method
      #
      # @return [Class<Magicka::Element>]
      def element_class
        return @element_class if @element_class.is_a?(Class)

        @element_class = @element_class.constantize
      end

      # @method template
      # @api private
      #
      # Template file
      #
      # @return [String]
      attr_reader :template

      private

      # name of the method to be generated
      #
      # When the method name was not supplied in the constructor,
      # it is infered from {#element_class}
      #
      # @return [String,Symbol]
      def method_name
        @method_name ||= element_class
                         .to_s
                         .underscore
                         .gsub(%r{.*/}, '')
      end
    end
  end
end
