# frozen_string_literal: true

module Magicka
  # Select element representing an HTML +<select/>+
  class Select < FormElement
    with_attribute_locals :options
  end
end
