# frozen_string_literal: true

module Magicka
  # @api public
  #
  # Class representing an element agregator, representing a model
  class Aggregator
    autoload :MethodBuilder, 'magicka/aggregator/method_builder'

    class << self
      def with_element(element_class, method_name = nil, template: nil)
        MethodBuilder
          .new(self, element_class, method_name, template: template)
          .prepare
          .build
      end
    end

    attr_reader :model

    def initialize(renderer, model)
      @renderer = renderer
      @model    = model
    end

    def with_model(model, base: self.model)
      new_model = [base, model].compact.join('.')

      yield self.class.new(renderer, new_model)
    end

    def equal?(other)
      return unless other.class == self.class

      other.renderer == renderer &&
        other.model == model
    end

    alias == equal?

    protected

    attr_reader :renderer

    delegate :render, to: :renderer
  end
end
