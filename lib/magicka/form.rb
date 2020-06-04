# frozen_string_literal: true

module Magicka
  # Class responsible for controlling one object form
  class Form
    attr_reader :model

    def initialize(renderer, model)
      @renderer = renderer
      @model    = model
    end

    def input(field, model: self.model, **args)
      Input.render(renderer: renderer, field: field, model: model, **args)
    end

    def select(field, model: self.model, **args)
      Select.render(renderer: renderer, field: field, model: model, **args)
    end

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
