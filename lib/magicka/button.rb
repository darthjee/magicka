# frozen_string_literal: true

module Magicka
  # Button element representing an HTML +<button/>+
  class Button < Element
    with_attribute_locals :ng_click, :ng_disabled, :classes, :text
    template_folder 'templates/forms'
  end
end
