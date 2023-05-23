# frozen_string_literal: true

module Magicka
  class Aggregator
    # @api private
    #
    # Class responsible for building an {Aggregator} method
    class MethodBuilder < Sinclair
      # @overload initialize(klass, element_class, method_name = nil, template: nil)
      #   @param element_class [Class<Magicka::ELement>]
      #     Class of the element to be rendered
      #
      # @overload initialize(klass, element_class_name, method_name = nil, template: nil)
      #   @param element_class_name [String]
      #     String name of Class of the element to be rendered
      #
      # @param klass [Class<Aggregator>]
      #   Aggragator class to receive the method
      # @param method_name [String,Symbol]
      #   Name of the method that will render the element
      # @param template [String] custom template file to be used
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
        element_klass = element_class
        template_file = template

        add_method(method_name) do |field, model: self.model, **args|
          element_klass.render(
            renderer: renderer, field: field,
            model: model, template: template_file,
            **args
          )
        end

        self
      end

      private

      # @private
      #
      # Class of the element to be rendered by the method
      #
      # @return [Class<Magicka::Element>]
      def element_class
        return @element_class if @element_class.is_a?(Class)

        @element_class = @element_class.constantize
      end

      attr_reader :template
      # @method template
      # @api private
      # @private
      #
      # template file
      #
      # @return [String]

      # name of the method to be generated
      #
      # When the method name was not supplied in the constructor,
      # it is infered from {#element_class}
      #
      # @return [String,Symbol]
      def method_name
        @method_name ||= element_class
                         .name
                         .underscore
                         .gsub(%r{.*/}, '')
      end
    end
  end
end
