# frozen_string_literal: true

module Magicka
  # Class responsible for controlling one object form
  class Form < Aggregator
    with_element(Input)
    with_element(Select)

    # Renders a button
    #
    # @return (see Magicka::Element#render)
    def button(**args)
      Button.render(renderer: renderer, **args)
    end

    # @method input(field, model: self.model, **options)
    # @api public
    #
    # @param field [String,Symbol] field to be shown
    # @param model [String] model being rendered
    #   (when omited, use the aggregator model)
    # @param options [Hash]
    #
    # @see Magicka::Input
    #
    # @return (see Magicka::Element#render)

    # @method select(field, model: self.model, **options)
    # @api public
    #
    # @param field [String,Symbol] field to be shown
    # @param model [String] model being rendered
    #   (when omited, use the aggregator model)
    # @param options [Hash]
    #
    # @see Magicka::Select
    #
    # @return (see Magicka::Element#render)
  end
end
