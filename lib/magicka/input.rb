# frozen_string_literal: true

module Magicka
  class Input < Element
    with_attribute_locals :field, :placeholder, :label
    with_attributes :model
    with_locals :ng_errors, :ng_model

    template 'templates/forms/input'

    private

    def label
      @label ||= field.to_s.capitalize.gsub(/_/, ' ')
    end

    def ng_model
      [model, field].join('.')
    end

    def ng_errors
      [model, :errors, field].join('.')
    end
  end
end
