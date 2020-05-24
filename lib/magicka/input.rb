# frozen_string_literal: true

module Magicka
  class Input < Element
    with_options :placeholder, :field, :label, :model

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

    def locals
      {
        label: label,
        ng_errors: ng_errors,
        ng_model: [model, field].join('.'),
        field: field,
        placeholder: placeholder
      }
    end
  end
end
