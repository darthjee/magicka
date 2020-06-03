# frozen_string_literal: true

module Magicka
  class Button < Element
    with_attribute_locals :ng_click, :ng_disabled, :classes, :text
    template_folder 'templates/forms'
  end
end
