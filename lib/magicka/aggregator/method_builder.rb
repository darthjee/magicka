# frozen_string_literal: true

module Magicka
  class Aggregator
    class MethodBuilder < Sinclair
      def initialize(klass, element_class, method_name=nil)
        super(klass)

        @element_class = element_class
        @method_name = method_name
      end

      def prepare
        element_klass = element_class

        add_method(method_name) do |field, model: self.model, **args|
          element_klass.render(
            renderer: renderer, field: field, model: model, **args
          )
        end

        self
      end

      private

      attr_reader :element_class

      def method_name
        @method_name ||= element_class
          .name
          .underscore
          .gsub(%r{.*/}, '')
      end
    end
  end
end
