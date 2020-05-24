# frozen_string_literal: true

module Magicka
  # Input element representing an HTML +<input/>+
  class Input < Element
    with_attribute_locals :field, :placeholder, :label
    with_attributes :model
    with_locals :ng_errors, :ng_model

    template 'templates/forms/input'

    private

    # @api private
    # @private
    #
    # Label to be shon near the input
    #
    # when no label is provided, the name of
    # the field is used
    #
    # @return [String]
    def label
      @label ||= field.to_s.capitalize.gsub(/_/, ' ')
    end

    # @api private
    # @private
    #
    # ng model to be represented with the input
    #
    # @return [String]
    def ng_model
      [model, field].join('.')
    end

    # @api private
    # @private
    #
    # ng errors to be exposed with the input
    #
    # @return [String]
    def ng_errors
      [model, :errors, field].join('.')
    end
  end
end
