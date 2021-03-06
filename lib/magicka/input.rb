# frozen_string_literal: true

module Magicka
  # Input element representing an HTML +<input/>+
  class Input < FormElement
    with_attribute_locals :placeholder
  end
end
