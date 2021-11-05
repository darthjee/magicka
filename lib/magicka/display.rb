# frozen_string_literal: true

module Magicka
  # @api public
  #
  # Class responsible for controlling one object display
  class Display < Aggregator
    with_element(Text, :input)
    with_element(Text, :select)

    # Noop
    #
    # Used to not render a button when using
    # display and not form
    def button(**_args); end

    # @method input(field, model: self.model, **options)
    # @api public
    #
    # @param field [String,Symbol] field to be shown
    # @param model [String] model being rendered
    #   (when omited, use the aggregator model)
    # @param options [Hash]
    #
    # @see Magicka::Text
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
    # @see Magicka::Text
    #
    # @return (see Magicka::Element#render)
  end
end
