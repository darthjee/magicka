# frozen_string_literal: true

module Magicka
  # @api private
  #
  # class responsible for building methods on {Magicka::Element}
  class MethodBuilder < Sinclair
    # adds a mehtod +#template+
    #
    # The method will always return the template given in the params
    #
    # @param template [String] path to template file
    #
    # @return [Array<Sinclair::MethodDefinition>]
    def add_template(template)
      add_method(:template) do
        template
      end

      build
    end
  end
end
