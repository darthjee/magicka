# frozen_string_literal: true

module Magicka
  # Class responsible for controlling one object display
  class Display < Aggregator
    with_element(Text, :input)
    with_element(Text, :select)

    def button(**args); end
  end
end
