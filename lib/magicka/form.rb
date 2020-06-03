# frozen_string_literal: true

module Magicka
  class Form
    attr_reader :model

    def initialize(renderer, model)
      @renderer = renderer
      @model    = model
    end

    def input(field, model: self.model, **args)
      Input.render(renderer: renderer, field: field, model: model, **args)
    end
    private

    attr_reader :renderer

    delegate :render, to: :renderer
  end
end
