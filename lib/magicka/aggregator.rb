# frozen_string_literal: true

module Magicka
  class Aggregator
    autoload :MethodBuilder, 'magicka/aggregator/method_builder'

    class << self
      def with_element(element_class, method_name = nil)
        MethodBuilder
          .new(self, element_class, method_name)
          .prepare
          .build
      end
    end
  end
end
