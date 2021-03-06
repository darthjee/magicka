# frozen_string_literal: true

module Magicka
  # Helper module to be used on rails
  module Helper
    def magicka_form(model)
      yield Form.new(self, model)
    end

    def magicka_display(model)
      yield Display.new(self, model)
    end
  end
end
