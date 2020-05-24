# frozen_string_literal: true

module Magicka
  # Input element representing an HTML +<input/>+
  class Input < InputElement
    with_attribute_locals :placeholder

    template 'templates/forms/input'
  end
end
