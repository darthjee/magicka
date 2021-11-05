# frozen_string_literal: true

module Magicka
  class Aggregator
    # @api private
    #
    # Class responsible for building an {Aggregator} method
    class MethodBuilder < Sinclair
      # @param (see Aggregator::ClassMethods#with_element)
      def initialize(klass, element_class, method_name = nil, template: nil)
        super(klass)

        @element_class = element_class
        @method_name = method_name
        @template = template
      end

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

      attr_reader :element_class, :template

      def method_name
        @method_name ||= element_class
                         .name
                         .underscore
                         .gsub(%r{.*/}, '')
      end
    end
  end
end
