# frozen_string_literal: true

module Magicka
  class Aggregator
    module ClassMethods
      def with_element(element_class, method_name = nil, template: nil)
        MethodBuilder
          .new(self, element_class, method_name, template: template)
          .prepare
          .build
      end

      def type(*args)
        return @type ||= default_type if args.empty?

        @type = args.first.to_sym
      end

      def default_type
        name&.demodulize&.underscore&.to_sym
      end
    end
  end
end
