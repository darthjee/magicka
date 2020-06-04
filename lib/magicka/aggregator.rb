# frozen_string_literal: true

module Magicka
  class Aggregator
    class << self
      def with_element(element_klass, method_name=element_klass.name.underscore.gsub(/.*\//, ''))
        Sinclair.new(self).tap do |builder|
          builder.add_method(method_name) do |field, model: self.model, **args|
            element_klass.render(
              renderer: renderer, field: field, model: model, **args
            )
          end
        end.build
      end
    end
  end
end
