# frozen_string_literal: true

module Magicka
  # Class responsible for controlling one object form
  class Form < Aggregator
    attr_reader :model

    def initialize(renderer, model)
      @renderer = renderer
      @model    = model
    end

    with_element(Input, :input)
    with_element(Select, :select)

    def button(**args)
      Button.render(renderer: renderer, **args)
    end

    def with_model(model)
      new_model = [self.model, model].join('.')

      yield Form.new(renderer, new_model)
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
