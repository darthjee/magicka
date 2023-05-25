# frozen_string_literal: true

module Magicka
  class CustomAggregator < Aggregator
    with_element(Input)
    with_element(Select)

    def button(**args)
      Button.render(renderer: renderer, **args)
    end
  end
end
