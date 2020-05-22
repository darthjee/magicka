# frozen_string_literal: true

module Magicka
  class MethodBuilder < Sinclair
    def add_template(template)
      add_method(:template) do
        template
      end
      build
    end
  end
end
